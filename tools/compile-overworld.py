#!/usr/bin/env python3
"""Compile the Minecraft 1.21.11 data-pack noise graph into GolemMC's binary format."""
import json
import struct
import sys
import zipfile
from pathlib import Path

KINDS = {
    "add": 1, "mul": 2, "min": 3, "max": 4, "abs": 5, "square": 6,
    "cube": 7, "half_negative": 8, "quarter_negative": 9, "squeeze": 10,
    "invert": 11, "clamp": 12, "y_clamped_gradient": 13, "range_choice": 14,
    "noise": 15, "shift_a": 16, "shift_b": 17, "shifted_noise": 18,
    "weird_scaled_sampler": 19, "spline": 20, "old_blended_noise": 21,
    "interpolated": 22, "flat_cache": 23, "cache_2d": 24, "cache_once": 25,
    "find_top_surface": 26,
}
ROOTS = (
    "final_density", "temperature", "vegetation", "continents", "erosion",
    "depth", "ridges", "preliminary_surface_level", "barrier",
    "fluid_level_floodedness", "fluid_level_spread", "lava", "vein_toggle",
    "vein_ridged", "vein_gap",
)
SURFACE_NOISES = (
    "surface", "surface_secondary", "badlands_pillar", "badlands_pillar_roof",
    "badlands_surface", "iceberg_pillar", "iceberg_pillar_roof", "iceberg_surface", "clay_bands_offset",
)


SURFACE_KINDS = {
    "sequence": 0, "condition": 1, "block": 2, "bandlands": 3,
    "above_preliminary_surface": 4, "stone_depth": 5, "biome": 6,
    "y_above": 7, "noise_threshold": 8, "water": 9, "not": 10,
    "hole": 11, "temperature": 12, "steep": 13, "vertical_gradient": 14,
}


class Compiler:
    def __init__(self, jar, blocks, biomes):
        self.jar = jar
        self.blocks = blocks
        self.biomes = biomes
        self.rules = []
        self.rule_indexes = {}
        self.links = []
        self.nodes = []
        self.points = []
        self.noises = []
        self.noise_ids = {}
        self.names = {}
        self.interned = {}

    def data(self, path):
        return json.loads(self.jar.read(f"data/minecraft/worldgen/{path}.json"))

    def node(self, kind, a=0, b=0, c=0, d=0, values=()):
        values = tuple(values) + (0,) * (5 - len(values))
        row = (kind, a, b, c, d, *values)
        if row not in self.interned:
            self.interned[row] = len(self.nodes)
            self.nodes.append(row)
        return self.interned[row]

    def noise(self, name):
        if name not in self.noise_ids:
            params = self.data("noise/" + name.removeprefix("minecraft:"))
            self.noise_ids[name] = len(self.noises)
            self.noises.append((name, params["firstOctave"], params["amplitudes"]))
        return self.noise_ids[name]

    def spline(self, value):
        if not isinstance(value, dict):
            return self.node(0, values=(float32(value),))
        coordinate = self.compile(value["coordinate"])
        points = [(self.spline(p["value"]), float32(p["location"]), float32(p["derivative"]))
                  for p in value["points"]]
        offset = len(self.points)
        self.points.extend(points)
        return self.node(20, coordinate, offset, len(points))

    def compile(self, value):
        if isinstance(value, (int, float)):
            return self.node(0, values=(value,))
        if isinstance(value, str):
            if value not in self.names:
                self.names[value] = self.compile(self.data("density_function/" + value.removeprefix("minecraft:")))
            return self.names[value]
        name = value["type"].removeprefix("minecraft:")
        if name in ("blend_alpha", "blend_offset"):
            return self.node(0, values=(int(name == "blend_alpha"),))
        if name == "blend_density":
            return self.compile(value["argument"])
        kind = KINDS[name]
        if kind <= 4:
            return self.node(kind, self.compile(value["argument1"]), self.compile(value["argument2"]))
        if kind <= 11 or 22 <= kind <= 25:
            return self.node(kind, self.compile(value["argument"]))
        if kind == 12:
            return self.node(kind, self.compile(value["input"]), values=(value["min"], value["max"]))
        if kind == 13:
            return self.node(kind, value["from_y"], value["to_y"], values=(value["from_value"], value["to_value"]))
        if kind == 14:
            return self.node(kind, self.compile(value["input"]), self.compile(value["when_in_range"]),
                             self.compile(value["when_out_of_range"]), values=(value["min_inclusive"], value["max_exclusive"]))
        if kind == 15:
            return self.node(kind, self.noise(value["noise"]), values=(value["xz_scale"], value["y_scale"]))
        if kind in (16, 17):
            return self.node(kind, self.noise(value["argument"]))
        if kind == 18:
            return self.node(kind, self.noise(value["noise"]), *(self.compile(value["shift_" + axis]) for axis in "xyz"),
                             values=(value["xz_scale"], value["y_scale"]))
        if kind == 19:
            return self.node(kind, self.compile(value["input"]), self.noise(value["noise"]),
                             int(value["rarity_value_mapper"] == "type_2"))
        if kind == 20:
            return self.spline(value["spline"])
        if kind == 21:
            return self.node(kind, values=tuple(value[key] for key in
                             ("xz_scale", "y_scale", "xz_factor", "y_factor", "smear_scale_multiplier")))
        if kind == 26:
            return self.node(kind, self.compile(value["density"]), self.compile(value["upper_bound"]),
                             value["lower_bound"], value["cell_height"])
        raise ValueError(name)

    def surface(self, rule):
        kind = SURFACE_KINDS[rule["type"].removeprefix("minecraft:")]
        a = b = c = d = lo = hi = 0

        def link(nodes):
            index = len(self.links)
            self.links.extend(nodes)
            return index, len(nodes)

        def anchor(key):
            value = rule[key]
            if "absolute" in value:
                return value["absolute"]
            return -64 + value["above_bottom"]

        if kind == 0:
            a, b = link([self.surface(child) for child in rule["sequence"]])
        if kind == 1:
            a, b = self.surface(rule["if_true"]), self.surface(rule["then_run"])
        if kind == 2:
            a = self.blocks[rule["result_state"]["Name"]]
        if kind == 5:
            a, b = rule["offset"], int(rule["add_surface_depth"])
            c, d = rule["secondary_depth_range"], int(rule["surface_type"] == "ceiling")
        if kind == 6:
            a, b = link([self.biomes[name] for name in rule["biome_is"]])
        if kind == 7:
            a, b, c = anchor("anchor"), rule["surface_depth_multiplier"], int(rule["add_stone_depth"])
        if kind == 8:
            a, lo, hi = self.noise(rule["noise"]), rule["min_threshold"], rule["max_threshold"]
        if kind == 9:
            a, b, c = rule["offset"], rule["surface_depth_multiplier"], int(rule["add_stone_depth"])
        if kind == 10:
            a = self.surface(rule["invert"])
        if kind == 14:
            a, b = anchor("true_at_and_below"), anchor("false_at_and_above")
            c = {"minecraft:bedrock_floor": 0, "minecraft:deepslate": 1}[rule["random_name"]]
        row = (kind, a, b, c, d, lo, hi)
        if row not in self.rule_indexes:
            self.rule_indexes[row] = len(self.rules)
            self.rules.append(row)
        return self.rule_indexes[row]

    def write(self, output, replaceable):
        settings = self.data("noise_settings/overworld")
        roots = [self.compile(settings["noise_router"][key]) for key in ROOTS]
        surface = [self.noise("minecraft:" + name) for name in SURFACE_NOISES]
        surface_root = self.surface(settings["surface_rule"])
        with output.open("wb") as handle:
            def put(fmt, *values):
                handle.write(struct.pack(">" + fmt, *values))

            handle.write(b"GN02")
            put("iii", len(self.noises), len(self.nodes), len(self.points))
            put(f"{len(roots) + len(surface)}i", *roots, *surface)
            for name, octave, amplitudes in self.noises:
                raw = name.encode("ascii")
                put("h", len(raw))
                handle.write(raw)
                put("ii", octave, len(amplitudes))
                put(f"{len(amplitudes)}d", *amplitudes)
            for row in self.nodes:
                put("5i5d", *row)
            for ii, location, derivative in self.points:
                put("idd", ii, location, derivative)
            put("iii", surface_root, len(self.rules), len(self.links))
            for rule in self.rules:
                put("5i2d", *rule)
            put(f"{len(self.links)}i", *self.links)
            temperatures = [0.0] * (max(self.biomes.values()) + 1)
            for name, index in self.biomes.items():
                climate = self.data("biome/" + name.removeprefix("minecraft:"))
                temperatures[index] = float32(climate["temperature"])
            put("i", len(temperatures))
            put(f"{len(temperatures)}d", *temperatures)

        def tag(name):
            path = "data/minecraft/tags/block/" + name + ".json"
            for value in json.loads(self.jar.read(path))["values"]:
                if value.startswith("#minecraft:"):
                    yield from tag(value.removeprefix("#minecraft:"))
                else:
                    yield value

        replaceable.write_text("\n".join(sorted(set(tag("overworld_carver_replaceables")))) + "\n")


def float32(value):
    return struct.unpack(">f", struct.pack(">f", value))[0]


def main():
    if len(sys.argv) != 6:
        raise SystemExit("Usage: compile-overworld.py MOJANG_SERVER_JAR BLOCK_REGISTRY BIOME_REGISTRY OUTPUT REPLACEABLE_TAGS")
    def registry(path):
        return {name: int(index) for name, index in
                (line.split() for line in Path(path).read_text().splitlines())}

    blocks, biomes = map(registry, sys.argv[2:4])
    output, replaceable = map(Path, sys.argv[4:])
    with zipfile.ZipFile(sys.argv[1]) as outer:
        if "META-INF/versions/1.21.11/server-1.21.11.jar" in outer.namelist():
            import io
            with zipfile.ZipFile(io.BytesIO(outer.read("META-INF/versions/1.21.11/server-1.21.11.jar"))) as jar:
                Compiler(jar, blocks, biomes).write(output, replaceable)
        else:
            Compiler(outer, blocks, biomes).write(output, replaceable)


if __name__ == "__main__":
    main()
