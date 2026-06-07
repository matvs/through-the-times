---
name: "Module: CLI front-end"
about: "Interactive CLI on top of the engine (Track B)"
title: "[ui] CLI front-end — app/Main on top of TTT.Engine"
labels: "enhancement"
assignees: ''
---

> **Track B — flow & IO.** Depends on: #engine.

## Context

`app/Main.hs` currently hard-codes the loop and pattern-matches `GameState`
directly. Once `TTT.Engine` exists, the CLI should be a thin presenter over the
engine API — all rules live in the engine, all IO lives here.

## Scope

- Rework `app/Main.hs` to import `TTT.Engine` (+ `TTT.Civilization`) and drive
  the loop via `handleGameState` / `step`.
- Render the current player, phase, and their resources each turn.
- Input handling: start a game, advance phase, `EXIT` to quit (keep current UX).
- Keep all game logic out of `Main` — no rule decisions in the IO layer.

## Files

- `app/Main.hs`

## Acceptance criteria

- [ ] `cabal run through-the-times` plays the existing flow end to end.
- [ ] Resources are displayed and visibly change after a Production phase.
- [ ] `Main` contains no rule logic — only IO + calls into `TTT.*`.
- [ ] No direct construction of internal `GameState` data beyond the start state.
