#!/usr/bin/env python3
"""Pack the vanilla Overworld's ordered climate search tree for the Novus sampler."""
import json
import math
import struct
import sys
from pathlib import Path


class Node:
    def __init__(self, *, bounds=None, biome=-1, children=()):
        self.children = children
        self.biome = biome
        self.bounds = bounds or tuple(
            (min(child.bounds[axis][0] for child in children),
             max(child.bounds[axis][1] for child in children))
            for axis in range(7)
        )
        self.center = tuple(math.trunc((low + high) / 2) for low, high in self.bounds)

    def write(self, data, index):
        offset = len(data)
        data.extend(struct.pack(">Hh14h", 0, self.biome, *(v for pair in self.bounds for v in pair)))
        end = index + 1
        for child in self.children:
            end = child.write(data, end)
        struct.pack_into(">H", data, offset, end)
        return end


def ordered_tree(nodes):
    if len(nodes) == 1:
        return nodes[0]
    if len(nodes) <= 6:
        return Node(children=sorted(nodes, key=lambda node: sum(map(abs, node.center))))
    size = 1
    while size * 6 < len(nodes):
        size *= 6

    def key(node, axis, transform):
        return tuple(transform(node.center[(axis + step) % 7]) for step in range(7))

    best_cost = math.inf
    for axis in range(7):
        nodes.sort(key=lambda node: key(node, axis, int))
        buckets = [Node(children=nodes[start:start + size]) for start in range(0, len(nodes), size)]
        cost = sum(high - low for bucket in buckets for low, high in bucket.bounds)
        if cost < best_cost:
            best_cost, best_buckets, best_axis = cost, buckets, axis
    best_buckets.sort(key=lambda node: key(node, best_axis, abs))
    return Node(children=[ordered_tree(bucket.children) for bucket in best_buckets])


def compile_biomes(source, registry, output):
    biomes = dict((name, int(index)) for name, index in
                  (line.split() for line in registry.read_text().splitlines()))
    def quantize(value):
        def float32(number):
            return struct.unpack(">f", struct.pack(">f", number))[0]

        return int(float32(float32(value) * 10000))

    axes = ("temperature", "humidity", "continentalness", "erosion", "depth", "weirdness", "offset")
    leaves = []
    for entry in json.loads(source.read_text())["biomes"]:
        bounds = []
        for axis in axes:
            span = entry["parameters"][axis]
            low, high = span if isinstance(span, list) else (span, span)
            bounds.append((quantize(low), quantize(high)))
        leaves.append(Node(bounds=tuple(bounds), biome=biomes[entry["biome"]]))
    tree = bytearray(b"GB01")
    ordered_tree(leaves).write(tree, 0)
    output.write_bytes(tree)


if __name__ == "__main__":
    if len(sys.argv) != 4:
        raise SystemExit("Usage: compile-biomes.py BIOME_PARAMETERS_REPORT BIOME_REGISTRY OUTPUT")
    compile_biomes(*map(Path, sys.argv[1:]))
