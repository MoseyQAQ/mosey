---
name: coding-style
description: Use when Codex writes, edits, or reviews Mosey's research code, especially one-off scientific Python scripts, computational condensed-matter analysis scripts, NumPy/ASE trajectory processing, plotting/data extraction scripts, or small reusable helpers. Guides agents to prioritize readable and physically faithful research code over business-style defensive engineering.
---

# Coding Style

Use this skill for research code, not production services. The priority is readable, physically faithful code that Mosey can quickly inspect and modify.

## Core Philosophy

- Prefer clarity and compactness over generality.
- Treat most scripts as local research artifacts with known inputs.
- Avoid excessive validation, defensive branching, framework-like abstractions, and reusable-package ceremony unless the user asks for a package.
- Keep the main flow visible from top to bottom.
- Use helper functions only when they remove real repetition or isolate a physically meaningful operation.

## Physical Correctness

Running without errors is not the same as producing the intended result. Be conservative around choices that change physical meaning:

- frame selection
- units and conversion factors
- sign conventions
- coordinate systems and component selection
- normalization, averaging, smoothing, fitting, and masking
- minimum-image convention and periodic wrapping
- neighbor ordering and chemical-site assumptions

If a choice is unclear, ask the user instead of guessing. If the choice is made in code, make it visible with a short variable name, comment, or saved metadata.

## Output Defaults

- Save simple scalar or small table-like results to `.txt`.
- Save complex results to `.npz` with clear key/value names.
- Do not use CSV by default.
- Save plots only when the task naturally asks for a figure or when a quick visual check is useful.
- Include enough metadata in text headers or `.npz` keys to make units, selected frames, and major assumptions recoverable.

## Script Structure

For one-off scripts, prefer a direct structure:

```python
# Hard-coded variables

# Load data

# Compute derived quantities

# Save output
```

Place easily edited values near the top: paths, selected frames, selected columns, atom/site selections, units, conversion constants, component names, fitting ranges, and output filenames.

For multiple related scripts in the same conversation, put shared helpers in `conf.py` and import them from side scripts. Do this only when it reduces duplicated logic.

## Naming

- Prefer clear filenames over imitation of package naming styles.
- Prefer concise filenames over long descriptive sentences.
- Use names that reveal the result or operation, for example `calc_displacement.py`, `plot_polarization.py`, or `avg_structure.py`.

## Python Style

- Prefer NumPy arrays for numerical work.
- Use ASE idioms when working with atomic structures or trajectories.
- Use `tqdm` for loops that may take noticeable time; skip progress bars for tiny loops.
- Use simple `assert` statements or warnings for known scientific invariants when they protect interpretation.
- Use comments for shapes and physical assumptions, not for obvious Python syntax.
- Keep docstrings short in scripts; make units and returned shapes explicit for helpers.

## References

Read `references/research-code-style.md` for detailed style guidance.
