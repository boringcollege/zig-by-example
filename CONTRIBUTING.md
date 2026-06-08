# Contributing to Zig by Example

Thanks for your interest in contributing! This project aims to be a clear, accurate, and practical introduction to Zig through annotated examples.

## Repository Layout

- `content/NN-name.md` — the annotated prose chapter
- `examples/NN-name.zig` — the runnable source. Compile with `zig run examples/NN-name.zig`.

A chapter's `.md` and `.zig` files share the same basename. When updating one, keep the other in sync.

## What to Contribute

- **Fixes**: typos, inaccurate explanations, outdated code (target is Zig 0.16)
- **Improvements**: clearer wording, better example code, missing edge cases
- **New examples**: topics not yet covered that fit the scope of the project

## Guidelines

**Examples** should be:
- Self-contained and runnable
- Focused on one concept
- Written for Zig 0.16
- Annotated with short, precise comments that explain the *why*, not just the *what*

**Prose** should be:
- Direct and concise — no filler
- Accurate — verify behavior against the compiler before submitting

## Submitting Changes

1. Fork the repository and create a branch from `main`
2. Make your changes
3. Open a pull request with a short description of what you changed and why

For significant new examples or structural changes, open an issue first to discuss the approach.

## Code of Conduct

Be respectful and constructive. Feedback on content should focus on clarity and correctness, not personal preference.

## License

By contributing, you agree that your contributions will be licensed under [CC BY 4.0](LICENSE).
