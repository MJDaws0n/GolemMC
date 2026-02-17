# Bug Report - Login Packet Issue (FIXED)

## the issue
client was saying "Packet login/clientbound minecraft:login_finished was larger than I expected, found 1 bytes extra"

## root cause
Login Success packet was sending a "strict error handling" bool at the end which existed in MC 1.21.4 (protocol 769) but was **removed** in later versions. our client runs MC 1.21.11 (protocol 774) which doesn't expect that byte.

also the protocol version was 769 instead of 774, causing "incompatible server" in server list.

## what was fixed
1. removed the extra `write_bool(fd, false)` from Login Success packet in `src/net/login.nov`
2. changed protocol version from 769 to 774 in `src/net/protocol.nov`
3. updated ALL play state packet IDs from 1.21.4 values to 1.21.11 values
4. updated Set Default Spawn Position to include dimension name + pitch (new in 1.21.11)
5. updated all serverbound packet ID handling
6. regenerated registry data for 1.21.11 (using Known Packs negotiation)

## status: ✅ fixed