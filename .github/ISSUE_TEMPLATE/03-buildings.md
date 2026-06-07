---
name: "Module: TTT.Building"
about: "Building catalog, production and bonuses (Track A)"
title: "[buildings] TTT.Building — catalog, produce & bonus"
labels: "enhancement"
assignees: ''
---

> **Track A — economy & content.** Depends on: #foundation, #resources.

## Context

Buildings today are just `data Building = Mine` plus `produce`/`bonus` functions
in `MyLib` (Mine → 1 Ore, bonus 5 Science). Grow this into a proper, extensible
building module.

## Scope

Implement `TTT.Building`, exporting:

- `data Building = ...` — start with `Mine`, add a few more (e.g. `Farm`,
  `Lab`, `Temple`) covering the existing `ResourceType`s (Food, Science, Culture).
- `produce :: Building -> Resources` — per-turn output.
- `bonus :: Building -> Resources` — one-off/static bonus.
- `allBuildings :: [Building]` — catalog for UI/menus.
- (optional) `cost :: Building -> Resources` so construction can be priced later.

## Files

- `src/TTT/Building.hs`

## Acceptance criteria

- [ ] `produce Mine == singleton Ore 1` (parity with current behavior).
- [ ] `bonus Mine == singleton Science 5` (parity).
- [ ] At least 3 additional building types with sensible `produce` values.
- [ ] Explicit export list; no dependency on Civilization/Phase/Engine.
- [ ] Tests assert `produce`/`bonus` for each building.
