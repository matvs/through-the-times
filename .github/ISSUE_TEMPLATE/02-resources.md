---
name: "Module: TTT.Resources"
about: "Resources map type and operations (Track A)"
title: "[resources] TTT.Resources — resource bag type & operations"
labels: "enhancement, good first issue"
assignees: ''
---

> **Track A — economy & content.** Depends on: #foundation.

## Context

Resources are currently `type Resources = M.Map ResourceType Integer` with one
helper (`produceResources`) scattered in `MyLib`. Centralize the type and give
it a small, well-tested API the rest of the engine builds on.

## Scope

Implement `TTT.Resources`, exporting at least:

- `type Resources = Map ResourceType Integer`
- `empty :: Resources`
- `singleton :: ResourceType -> Integer -> Resources` (replaces `produceResources`)
- `add :: Resources -> Resources -> Resources` (union with `+`)
- `addAll :: [Resources] -> Resources`
- `subtract :: Resources -> Resources -> Resources`
- `canAfford :: Resources -> Resources -> Bool` (does bag A cover cost B?)
- `amountOf :: ResourceType -> Resources -> Integer`

## Files

- `src/TTT/Resources.hs`

## Acceptance criteria

- [ ] Module compiles with an explicit export list.
- [ ] `canAfford` returns `False` when any required resource is short.
- [ ] `add` / `addAll` merge with summation (no overwrite).
- [ ] Unit tests cover add, subtract, canAfford (happy + short-by-one).
- [ ] `MyLib`'s `produceResources` usages updated or re-exported.

## Notes

This is a good first ticket: pure functions, no IO, easy to test.
