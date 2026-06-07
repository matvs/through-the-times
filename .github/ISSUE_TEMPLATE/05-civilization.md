---
name: "Module: TTT.Civilization"
about: "Civilization model and operations (Track A)"
title: "[civilization] TTT.Civilization — model & operations"
labels: "enhancement"
assignees: ''
---

> **Track A — economy & content.** Depends on: #foundation, #resources, #buildings, #technology.

## Context

The `Civilization` record and `createCivilization` / `production` live in
`MyLib`. Move them into their own module and give the civ a real operational API.

## Scope

Implement `TTT.Civilization`, exporting:

- `data Civilization = Civilization { name, buildings, technologies, resources }`
- `createCivilization :: String -> Civilization`
- `production :: Civilization -> Resources` — sum of `produce` over buildings
  (composition: `addAll . map produce . buildings`).
- `build :: Building -> Civilization -> Civilization` — append building (later:
  spend its `cost`).
- `research :: Technology -> Civilization -> Civilization` — add tech if
  prerequisites met and affordable.
- `applyProduction :: Civilization -> Civilization` — fold `production` into resources.

## Files

- `src/TTT/Civilization.hs`

## Acceptance criteria

- [ ] `production` matches current behavior for the default civ (3 Mines → 3 Ore).
- [ ] `build`/`research` update the record without mutating others.
- [ ] `research` rejects techs whose prerequisites are unmet.
- [ ] Explicit export list; no dependency on Phase/Engine/UI.
- [ ] Tests cover production sum and a build/research round-trip.
