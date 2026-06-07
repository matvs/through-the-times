# Architecture — modularizing the engine

The engine started life in a single file (`src/MyLib.hs`). This document
describes the target module layout that lets **two people work in parallel**
with minimal merge conflicts. Each module below has a matching issue template
under `.github/ISSUE_TEMPLATE/` — open the corresponding issue to pick up the work.

## Module layout

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

## Dependency graph

Dependencies point one direction only, so two contributors editing different
modules don't collide:

```
Core.Types
   |__ Resources
          |__ Building ----+
          |__ Technology --+
                           +-- Civilization -- Phase -- Engine -- UI/Main
```

## How to split the work between two people

1. **Foundation first.** One short PR (`[foundation]`) creates the directory
   tree, `TTT.Core.Types`, compiling stubs for every module, and updates the
   `.cabal` `exposed-modules`. Everyone branches off this.
2. **Then two independent tracks**, touching disjoint files:

   | Track | Owner | Modules |
   |-------|-------|---------|
   | **A — economy & content** | Person 1 | Resources → Building, Technology, Civilization |
   | **B — flow & IO**         | Person 2 | Phase, Engine, UI/CLI |

3. **Testing scaffolding** (`[testing]`) can be grabbed by either person early —
   it unblocks testable acceptance criteria everywhere.

The single coordination seam is the **`TTT.Civilization` public API**, which
Track B's engine consumes. Agree on those signatures early (they're spelled out
in the `[civilization]` and `[engine]` tickets) and the two tracks stay decoupled.

## Conventions

- One module = one file = one owner per ticket.
- Every module ships an explicit export list; cross-module access goes through
  exports only.
- `MyLib` may stay as a thin re-export shim during migration, then be deleted.

## Creating the tickets

`Issues → New issue` shows one template per module (plus the tracking epic).
Pick a template, click *Submit* — the title, labels, and checklist are
pre-filled. Start with `[foundation]`, then fan out across the two tracks.
