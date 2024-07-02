[![Update Status](https://github.com/lanlords/builds/actions/workflows/update.yml/badge.svg)](https://github.com/lanlords/games/actions)
[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

# Builds

Monitor (steam-based) game server updates. Every 15 minutes a workflow (pipeline)
runs that checks the [SteamCMD API](https://www.steamcmd.net) for an updated
build id. When a change is detected the corresponding workflow in the
[lanlords/games](https://github.com/lanlords/games) repository is triggered.
This workflow will then build new container images on Docker Hub.

The latest build id is stored in separate json files in the `/state` directory.
If the retrieved build id does not match with the stored one a new json file is
generated and committed to this repository.

## Containers

The list of containers below are currently periodically checked for changes:

| Game                | Build ID       | Last Updated    |
|:--------------------|:---------------|:----------------|
| [Chivalry: Medieval Warfare](https://hub.docker.com/r/lanlords/cmw) | ![Build ID](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fapi.steamcmd.net%2Fv1%2Finfo%2F220070&query=%24.data.220070.depots.branches.public.buildid&label=build%20id) | ![Last Updated](https://img.shields.io/badge/dynamic/json?url=https://raw.githubusercontent.com/lanlords/builds/main/state/cmw.json&query=%24.updated&label=updated)
| [Counter-Strike 2](https://hub.docker.com/r/lanlords/cs2) | ![Build ID](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fapi.steamcmd.net%2Fv1%2Finfo%2F740&query=%24.data.730.depots.branches.public.buildid&label=build%20id) | ![Last Updated](https://img.shields.io/badge/dynamic/json?url=https://raw.githubusercontent.com/lanlords/builds/main/state/cs2.json&query=%24.updated&label=updated)
| [Team Fortress 2](https://hub.docker.com/r/lanlords/tf2) | ![Build ID](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fapi.steamcmd.net%2Fv1%2Finfo%2F232250&query=%24.data.232250.depots.branches.public.buildid&label=build%20id) | ![Last Updated](https://img.shields.io/badge/dynamic/json?url=https://raw.githubusercontent.com/lanlords/builds/main/state/tf2.json&query=%24.updated&label=updated)

To add a game, first make sure there is corresponding configuration for it in
the [lanlords/games](https://github.com/lanlords/games) repository and Docker
Hub repository.

If that is done, add the game to the [update.yml](.github/workflows/update.yml)
workflow file. The only place you will need to add it is in the
`jobs.check-for-updates.strategy.matrix.game` list. Add an object with `id `
and `name` that corresponds with the Steam ID of the game and the shortname we
have given the name. Example for CSGO:
```yaml
- id: "730"
  name: "cs2"
```
After pushing this change to the **main** branch the GitHub Action will start
checking periodically for changes on this game as well.