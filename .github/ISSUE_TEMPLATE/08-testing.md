---
name: "Infra: test-suite scaffolding"
about: "Set up hspec and per-module test wiring"
title: "[testing] Test-suite scaffolding (hspec) + per-module tests"
labels: "enhancement, good first issue"
assignees: ''
---

> **Either track.** Depends on: #foundation. Best picked up early.

## Context

`test/Main.hs` is the cabal-init placeholder ("Test suite not yet implemented.").
Stand up a real test harness so every module ticket can drop in specs.

## Scope

- Add `hspec` (and optionally `QuickCheck`) to the `test-suite` `build-depends`
  in `through-the-times.cabal`.
- Use `hspec-discover` (or a manual `Spec` aggregator) so `test/TTT/*Spec.hs`
  files are picked up automatically.
- Create `test/TTT/ResourcesSpec.hs` as the first example spec.
- Document `cabal test` in the README.

## Files

- `through-the-times.cabal` (test-suite deps + `hspec-discover` wiring)
- `test/Main.hs` (driver) and `test/TTT/ResourcesSpec.hs`
- `README.md` (how to run tests)

## Acceptance criteria

- [ ] `cabal test` runs and reports specs (not the placeholder string).
- [ ] At least one real spec passes.
- [ ] New `*Spec.hs` files are discovered without editing the driver.
- [ ] README documents `cabal test`.

## Notes

Good first ticket — unblocks testable acceptance criteria on every other module.
