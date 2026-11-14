# GolemMC

A native Novus server for Minecraft Java Edition 1.21.11, protocol 774. The rewrite uses Novus classes for connections, packets, worlds and gameplay. GolemMC application code uses ordinary Novus functions. The reusable `lib/darwin` library contains the Apple Silicon syscall bindings. The socket, digest and decimal libraries use stock Novus.

## Build and run

The verified host is Apple Silicon macOS. Install the Xcode Command Line Tools and build the stock [self-hosted Novus](https://github.com/MJDaws0n/Novus/tree/self-hosted-novus) checkout. GolemMC was verified with Novus commit `65febef`.

```sh
export NOVUS_ROOT=/path/to/Novus/compiler
./tools/build.sh
./build/darwin_arm64/GolemMC
```

Set `NOVUS_BIN` to use a specific compiler binary. The build uses the compiler checkout's current `std` and `file_io` libraries. Run from the GolemMC checkout so it can find the protocol registries in `data/`. The executable also accepts a path to a properties file as its sole argument.

On first run GolemMC generates `server.properties` with a loopback listener on port 25565, creative mode, a seeded Overworld and a view distance of 3. Use `127.0.0.1:25565` in the 1.21.11 client. The server uses offline usernames, so the loopback default keeps the world private to this machine. Stop with the console command `stop` to flush saves.

| In-game | Console |
| --- | --- |
| `/help`, `/list`, `/seed`, `/spawn` | `help`, `list`, `seed`, `save`, `say <message>`, `stop` |

## World modes

- **Native Overworld.** Set `level-type=minecraft:normal` and a signed 64-bit `level-seed`. This is the default for new worlds. GolemMC generates chunks on demand in Novus, including the 1.21.11 terrain noise, aquifers, large ore veins, three-dimensional biomes, surface rules, classic cave tunnels and canyons. Vegetation, regular ore deposits, geodes, springs and structures still need implementation. Complete vanilla world parity is pending.
- **Native flat.** Set `level-type=minecraft:flat`. GolemMC generates vanilla's default Overworld flat layers from bedrock through grass. The integration suite compares 98,304 block positions, biomes, heightmaps and lighting against a chunk from Mojang's server.
- **Vanilla snapshot.** Supply `vanilla-snapshot` and the matching numeric `level-seed` to serve captured Overworld chunks without Java at runtime. An unedited chunk is sent byte for byte, preserving vanilla's blocks, biomes, structures, heightmaps, block entity data and light. Players stay inside the captured area. This mode does not generate new vanilla terrain.

### Capture a standalone snapshot

To capture a snapshot, run a private headless vanilla **1.21.11** server with a fresh world, the desired numeric `level-seed`, `online-mode=false`, `enforce-secure-profile=false` and `view-distance` at least one greater than the radius being captured. Use Docker if the host lacks Java 21. The capture tool checks the seed against the server's reported hash.

```sh
npm ci --prefix tools
mkdir -p run
node tools/capture-vanilla.cjs run/my-snapshot 25566 5241482691752223138 2
```

Set the following in GolemMC's properties file and restart. Use a fresh `level-name` when switching between seeds or world modes.

```properties
level-name=world
level-seed=5241482691752223138
vanilla-snapshot=run/my-snapshot
view-distance=2
```

GolemMC stores overlays and player saves separately. The legacy `region/blocks.dat` format used an incompatible terrain baseline and is not loaded automatically.

## What the rewrite supports

Server-list status, offline login, vanilla configuration registries, concurrent players, movement and presence updates, chat, view-based chunk streaming, day/night, creative block inventory and edits, basic timed survival mining, drop pickup and item consumption on placement, manual 2×2 inventory crafting, and persisted block edits, player location and inventory.

Placement uses block-state collision boxes for standing and crouching players. Directional blocks use their clicked face, the player's look direction and hit height where applicable. GolemMC also updates live sky and block light around edits and recomputes edited heightmaps when streaming chunks. Relighting uses block opacity and emission. It approximates vanilla's occlusion for partial shapes such as stairs and slabs.

The survival implementation is partial. Nether and End travel, authentic account login, compression, mobs, combat, movement collision and survival damage, crafting tables and recipe-book interactions, smelting, other container interactions, weather, and specialised block behaviours still need implementation. Redstone and the full command set are outside this rewrite's current scope.

## Verification

```sh
./tools/build.sh tests/socket.nov
./build/darwin_arm64/socket_tests
./tools/build.sh tests/wire.nov
./build/darwin_arm64/wire_tests
./tools/build.sh tests/terrain.nov
./build/darwin_arm64/terrain_tests
npm ci --prefix tools
npm test --prefix tools
```

The native terrain test compares full-chunk hashes with Minecraft 1.21.11 for the noise, surface and carver stages, with structures disabled. It also compares the 3D biome grid. The fixtures cover 25 chunks across four seeds, including negative coordinates, mountains, cold oceans, deserts, swamps and world-border coordinates. The integration suite uses headless protocol clients and checks native streaming, spawn and saved edits after restart. Set `GOLEM_SNAPSHOT` to a vanilla Overworld capture to compare immutable chunk payloads byte for byte. Set `GOLEM_FLAT_SNAPSHOT` to a flat vanilla capture containing chunk `0.0` to compare decoded blocks, biomes and lighting against GolemMC's native flat generator.

`data/configuration-774.bin` contains the vanilla 1.21.11 registry, tags and feature-flag frames obtained during configuration. The other protocol data files are generated by `node tools/registry-data.cjs` using the pinned [PrismarineJS Minecraft data](https://github.com/PrismarineJS/minecraft-data) package. The pinned reference client and decoder are dev dependencies.


### World generation data

The native build and server use the versioned `data/overworld-*-774.bin` tables checked into this repo. The tables contain seed-independent density functions, surface rules, biome climate ranges, and carver replacement tags. All chunk generation runs in the Novus process.

To regenerate the tables, run Mojang's [1.21.11](https://www.minecraft.net/en-us/article/minecraft-java-edition-1-21-11) data generator in a development environment to export `reports/biome_parameters/minecraft/overworld.json`. It can run headless in Docker. Use the 1.21.11 server jar as the ZIP source for the bundled data pack. Run these commands from the repository root with the two input paths set.

```sh
npm ci --prefix tools
scratch=$(mktemp -d)
node -e 'for (const b of require("./tools/node_modules/minecraft-data")("1.21.11").blocksArray) console.log("minecraft:" + b.name, b.defaultState)' > "$scratch/blocks"
node -e 'for (const b of require("./tools/node_modules/minecraft-data")("1.21.11").biomesArray) console.log("minecraft:" + b.name, b.id)' > "$scratch/biomes"
python3 tools/compile-overworld.py "$MOJANG_SERVER_JAR" "$scratch/blocks" "$scratch/biomes" data/overworld-noise-774.bin "$scratch/carver-tags"
python3 tools/compile-biomes.py "$BIOME_PARAMETERS_REPORT" "$scratch/biomes" data/overworld-biomes-774.bin
node tools/registry-data.cjs data "$scratch/carver-tags"
```

The noise and aquifer implementation was cross-checked with [Misode's Deepslate](https://github.com/misode/deepslate/tree/c33b4a65f2ad474b14aab71061fbd7766b675fad). See [the MIT notice](licenses/deepslate.txt).
