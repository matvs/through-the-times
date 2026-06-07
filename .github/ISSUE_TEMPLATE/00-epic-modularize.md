---
name: "Epic: Modularize the game engine"
about: "Tracking epic for splitting MyLib into independent modules"
title: "[epic] Modularize the game engine for parallel development"
labels: "enhancement, documentation"
assignees: ''
---

## Goal

Today the whole engine lives in a single file (`src/MyLib.hs`). To let **two
people work independently** without constant merge conflicts, we split it into
small modules with clear, one-directional dependencies and a stable interface
between them.

## Proposed module layout

```
src/TTT/
  Core/Types.hs     -- ResourceType, ActionType, scalar/shared types   (no deps)
  Resources.hs      -- Resources map alias + operations                (Core.Types)
  Building.hs       -- Building data, catalog, produce, bonus          (Core.Types, Resources)
  Technology.hs     -- Technology data, tech tree, effects             (Core.Types, Resources)
  Civilization.hs   -- Civilization model + operations                 (Resources, Building, Technology)
  Phase.hs          -- Phase enum + per-phase execution                (Civilization, Resources)
  Engine.hs         -- GameState, turn/round loop, handleGameState     (Phase, Civilization)
app/Main.hs         -- CLI / UI front-end                              (Engine)
test/               -- per-module test modules
```

## Dependency graph (one-directional, so work doesn't collide)

```
Core.Types
   |__ Resources
          |__ Building ----+
          |__ Technology --+
                           +-- Civilization -- Phase -- Engine -- UI/Main
```

## Parallelization plan

1. **#foundation must merge first** — it lays down the directory layout,
   `Core.Types`, the `.cabal` `exposed-modules`, and stub modules with type
   signatures so everything compiles. Both people branch off this.
2. After that, work splits into two tracks that touch disjoint files:
   - **Track A — economy & content:** Resources → Building, Technology, Civilization
   - **Track B — flow & IO:** Phase, Engine, UI/CLI
3. Testing scaffolding can be picked up by either person early.

## Sub-tasks

- [ ] Foundation: module layout & `TTT.Core.Types`
- [ ] (A) `TTT.Resources`
- [ ] (A) `TTT.Building`
- [ ] (A) `TTT.Technology`
- [ ] (A) `TTT.Civilization`
- [ ] (B) `TTT.Phase` + `TTT.Engine`
- [ ] (B) CLI front-end (`app/Main`)
- [ ] Test-suite scaffolding + per-module tests

## Conventions

- One module = one file = one owner per ticket.
- Modules expose explicit export lists; cross-module access goes through exports only.
- Keep `MyLib` as a thin re-export shim during migration if convenient, then delete it.
