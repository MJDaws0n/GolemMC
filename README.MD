# GolemMC

A Minecraft server. Not written in Java. Written in [Novus](https://github.com/MJDaws0n/Novus).

## implementation status

| feature | status | notes |
|---|---|---|
| server list ping (SLP) | ✅ done | shows up in MC server list with motd, version, player count |
| config file generation | ✅ done | server.properties with all the usual settings |
| world folder creation | ✅ done | creates world dir with seed file |
| console commands | ✅ done | help, stop, status, seed, version, list |
| non-blocking console I/O | ✅ done | type commands while server runs |
| debug mode (--debug) | ✅ done | extra logging for when stuff breaks |
| player login (offline mode) | ✅ done | login sequence, UUID generation from username |
| configuration phase | ✅ done | sends registry data (dimensions, biomes, chat types etc) |
| play state - join world | ✅ done | login play, spawn position, player position |
| flat world chunk generation | ✅ done | stone + grass flat world, 7x7 chunk grid |
| keep alive packets | ✅ done | keeps connection alive every ~20s |
| SIGPIPE handling | ✅ done | server doesnt crash when players disconnect |
| player join/leave messages | ✅ done | console + future chat output |
| multi-player support | ❌ todo | currently single player only |
| player movement sync | ❌ todo | broadcasting position to other players |
| chat system | ❌ todo | player-to-player messaging |
| block breaking | ❌ todo | digging packets + block updates |
| block placing | ❌ todo | placement packets + block updates |
| PvP (hitting players) | ❌ todo | damage + knockback |
| item drops | ❌ todo | entities when blocks break |
| item pickup | ❌ todo | walking over dropped items |
| inventory management | ❌ todo | proper slot tracking |
| world persistence | ❌ todo | save/load chunks to disk |
| player data persistence | ❌ todo | save position, inventory, health |
| terrain generation | ❌ todo | actual terrain instead of flat world |
| mob spawning | ❌ todo | passive + hostile mobs |
| day/night cycle | ❌ todo | time packets |
| weather | ❌ todo | rain and thunder |
| crafting | ❌ todo | crafting table + recipes |
| furnace / smelting | ❌ todo | furnace block entity |
| redstone | ❌ todo | signal propagation |
| command blocks | ❌ todo | programmable commands |
| enchanting | ❌ todo | enchantment table |
| villager trading | ❌ todo | villager AI + trades |
| the nether | ❌ todo | dimension switching |
| the end | ❌ todo | ender dragon + end dimension |
| online mode (auth) | ❌ todo | mojang authentication + encryption |
| compression | ❌ todo | zlib packet compression |
| RCON | ❌ todo | remote console |

## how to build & run

```bash
# compile it
./novus main.nov

# sign the binary (macos requirement)
codesign -s - --force build/darwin_arm64/GolemMC

# run it (default port 25565)
./build/darwin_arm64/GolemMC

# run with debug logging
./build/darwin_arm64/GolemMC --debug
```

Then add `localhost:25565` to your Minecraft server list and watch it appear.

## project structure

```
main.nov              - entry point, CLI args, main server loop
src/
  config.nov          - server.properties loading/generation
  world.nov           - world folder & seed file generation
  logger.nov          - timestamped logging (info/warn/error/debug)
  console.nov         - non-blocking console input for commands
  net/
    tcp.nov           - TCP server socket wrapper
    packet.nov        - MC VarInt encoding & packet framing
    protocol.nov      - MC protocol handler (handshake → SLP or login → config → play)
    login.nov         - login sequence (login start, success, acknowledged)
    config_phase.nov  - configuration phase (registry data, known packs, finish config)
    play.nov          - play state (join game, chunks, position, keepalive)
    writer.nov        - binary data writing helpers (integers, floats, strings, positions, UUIDs)
data/
  reg_*.bin           - pre-built MC 1.21.4 registry data (dimension types, biomes, etc)
lib/
  net.nov             - low-level networking syscalls + SIGPIPE handling
  standard_lib.nov    - core string/number utilities
  standard_lib_macos_silicon.nov - macOS ARM64 syscalls
  file_io.nov         - file operations
  memory.nov          - memory & string utilities
  maths.nov           - math helpers
```

## console commands

Once the server is running you can type these into the console:
- `help` - show available commands
- `stop` - stop the server
- `status` - show server status (port, motd, players)
- `seed` - show the world seed
- `version` - show server version
- `list` - show connected players

## config

The `server.properties` file gets auto-generated on first run. You can edit it to change:
- `server-port` - port to listen on (default 25565)
- `motd` - the message that shows in the server list
- `max-players` - max player count shown in server list
- `world-name` - name of the world folder
- `seed` - world seed (randomly generated if not set)
- `gamemode` - survival/creative/adventure/spectator
- `difficulty` - peaceful/easy/normal/hard
- `view-distance` - how far players can see (in chunks)
- `online-mode` - whether to verify players with Mojang

## requirements

- macOS on Apple Silicon (M1/M2/M3/M4)
- The [Novus compiler](https://github.com/mjdaws0n/novus) (included as `novus` binary)
- Minecraft Java Edition 1.21.4 (to actually connect)