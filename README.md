[![Update Status](https://github.com/lanlords/builds/actions/workflows/update.yml/badge.svg)](https://github.com/lanlords/games/actions)
[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

# Builds

Monitor game server updates. Every 15 minutes a workflow (pipeline) runs that
checks the [SteamCMD API](https://www.steamcmd.net) for an updated build id.
When a change is detected the corresponding workflow in the
[lanlords/games](https://github.com/lanlords/games) repository is triggered.
This workflow will then build new container images on Docker Hub.

The latest build id is stored in separate json files in the `/state` directory.
If the retrieved build id does not match with the stored one a new json file is
generated and committed to this repository.

## Containers

| Game                | Current Build ID    |
|:--------------------|:--------------------|
| [Chivalry: Medieval Warfare](https://hub.docker.com/r/lanlords/cmw) | ![Build ID](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fapi.steamcmd.net%2Fv1%2Finfo%2F220070&query=%24.data.220070.depots.branches.public.buildid&label=build%20id)
| [Counter-Strike: Global Offensive](https://hub.docker.com/r/lanlords/csgo) | ![Build ID](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fapi.steamcmd.net%2Fv1%2Finfo%2F740&query=%24.data.740.depots.branches.public.buildid&label=build%20id)
| [Team Fortress 2](https://hub.docker.com/r/lanlords/tf2) | ![Build ID](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fapi.steamcmd.net%2Fv1%2Finfo%2F232250&query=%24.data.232250.depots.branches.public.buildid&label=build%20id)
