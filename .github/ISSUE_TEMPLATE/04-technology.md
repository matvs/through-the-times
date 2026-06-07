---
name: "Module: TTT.Technology"
about: "Technology tree and effects (Track A)"
title: "[technology] TTT.Technology — tech tree & effects"
labels: "enhancement"
assignees: ''
---

> **Track A — economy & content.** Depends on: #foundation, #resources.

## Context

Tech is currently a placeholder: `data Technology = Wheel`. Flesh it out into a
small tree with prerequisites and effects.

## Scope

Implement `TTT.Technology`, exporting:

- `data Technology = ...` — expand beyond `Wheel` (e.g. `Wheel`, `Writing`,
  `Bronze`, `Philosophy`).
- `cost :: Technology -> Resources` — usually Science.
- `prerequisites :: Technology -> [Technology]` — for the tree shape.
- `effect :: Technology -> Resources` — passive bonus granted while owned.
- `allTechnologies :: [Technology]`.

## Files

- `src/TTT/Technology.hs`

## Acceptance criteria

- [ ] At least 4 technologies with costs and at least one prerequisite chain.
- [ ] `prerequisites` is acyclic (document the intended tree).
- [ ] Explicit export list; depends only on Core.Types + Resources.
- [ ] Tests cover cost lookup and prerequisite chains.
