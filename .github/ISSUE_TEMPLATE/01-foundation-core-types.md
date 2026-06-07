---
name: "Foundation: module layout & Core.Types"
about: "Blocker — sets up the module skeleton everyone branches off"
title: "[foundation] Establish module layout & TTT.Core.Types"
labels: "enhancement"
assignees: ''
---

> **Blocker for all other module tickets.** Merge this first; everyone branches off it.

## Context

Everything currently lives in `src/MyLib.hs`. This ticket creates the directory
skeleton and the shared foundation module so the other tickets can proceed in
parallel without editing the same file.

## Scope

- Create the `src/TTT/` tree and the `TTT.Core.Types` module.
- Move the shared, dependency-free types out of `MyLib`:
  - `data ActionType = Military | Civil` (`Show, Eq, Ord`)
  - `data ResourceType = Food | Ore | Science | Culture | Worker | Strength | Population | ActionToken ActionType` (`Show, Eq, Ord`)
- Add **stub modules** (with `module ... (..) where` headers, type signatures,
  and `undefined`/minimal bodies) for: `TTT.Resources`, `TTT.Building`,
  `TTT.Technology`, `TTT.Civilization`, `TTT.Phase`, `TTT.Engine` — just enough
  that the project compiles. Each subsequent ticket fills in its own stub.
- Update `through-the-times.cabal`:
  - `exposed-modules:` lists all new `TTT.*` modules.
  - keep `MyLib` (optionally as a re-export shim) so nothing breaks mid-migration.
- `app/Main.hs` and `test/Main.hs` must still build.

## Files

- `src/TTT/Core/Types.hs` (new)
- `src/TTT/*.hs` stubs (new)
- `through-the-times.cabal` (edit `exposed-modules`)

## Acceptance criteria

- [ ] `cabal build` succeeds with the new module tree.
- [ ] `TTT.Core.Types` exports `ResourceType` and `ActionType`.
- [ ] All `TTT.*` modules exist as compiling stubs with explicit export lists.
- [ ] No game logic changed in this PR — pure scaffolding.
