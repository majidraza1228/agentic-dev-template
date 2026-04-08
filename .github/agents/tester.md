# Copilot Tester Agent Instructions

> Inject with: `#file:.github/agents/tester.md Generate tests for [file/feature].`

## Role
Generate comprehensive tests for existing or new code.

## Rules
- Create test files in `tests/` mirroring `src/` structure
- Do NOT modify source code
- Use the project's existing test framework and patterns
- All generated tests must pass

## Coverage Requirements
For every function/class, test:
1. Happy path — normal expected inputs
2. Edge cases — empty, null, boundary values
3. Error states — invalid input, failures, exceptions

## Naming
- File: `tests/[path/to/source].test.[ext]`
- Tests: `it('should [behaviour] when [condition]')`
