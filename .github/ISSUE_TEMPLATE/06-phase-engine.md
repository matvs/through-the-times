---
name: "Module: TTT.Phase + TTT.Engine"
about: "Phase execution and the turn/round loop (Track B)"
title: "[engine] TTT.Phase + TTT.Engine — phases & game loop"
labels: "enhancement"
assignees: ''
---

> **Track B — flow & IO.** Depends on: #foundation, #civilization (interface only).

## Context

`Phase`, `GameState`, `executePhase` and `handleGameState` are tangled into
`MyLib`. Split the per-phase rules (`TTT.Phase`) from the game-state machine
(`TTT.Engine`).

## Scope

**`TTT.Phase`**
- `data Phase = Action | Production | CleanUp` (`Enum, Bounded, Show`)
- `executePhase :: Phase -> Civilization -> Civilization` — `Production` folds
  `production` into resources (parity with current code); others are no-ops for now.

**`TTT.Engine`**
- `data GameState = NotStarted | Finished | InProgress [Civilization] Phase`
  (rename the bare `GameState [Civilization] Phase` constructor for clarity).
- `handleGameState :: GameState -> GameState` — advance the active civ through
  phases; on `CleanUp`, rotate to the next civ and reset to `Action` (parity).
- `step :: GameState -> GameState`, `currentCivilization :: GameState -> Maybe Civilization`.
- (optional) a simple `isFinished` / win condition hook.

## Files

- `src/TTT/Phase.hs`, `src/TTT/Engine.hs`

## Acceptance criteria

- [ ] `executePhase Production` increments resources by `production` (parity).
- [ ] `handleGameState` rotates players after `CleanUp` (parity with current logic).
- [ ] Engine depends on Civilization's public API only — no UI/IO inside.
- [ ] Tests drive a full round (Action → Production → CleanUp → next player).

## Coordination note

This is the natural seam between the two people. Agree the `Civilization` public
API (#civilization) early; Track B can code against stubs until it lands.
