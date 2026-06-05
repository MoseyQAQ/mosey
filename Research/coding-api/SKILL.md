---
name: coding-api
description: "Use when Codex writes research Python code for Mosey that needs common scientific APIs: ASE, ferrodispcalc, NumPy, Matplotlib, pymatgen, SciPy, LAMMPS output handling, atomic structures, trajectories, neighbor lists, polarization/displacement/tilt analysis, or SED workflows. Guides agents toward preferred libraries and known API entry points while avoiding pandas by default."
---

# Coding API

Use this skill to choose familiar scientific Python APIs for Mosey's research code. Pair it with `$coding-style` for script philosophy and `$plot` for figure styling.

## Library Preferences

- Prefer `ase`, `ferrodispcalc`, `numpy`, and `matplotlib`.
- Do not use `pandas` by default.
- Use `pymatgen` when it is the natural tool for crystal structures, neighbor logic, symmetry, format conversion, or ASE interoperability.
- Use `scipy` when the task clearly needs fitting, interpolation, signal processing, optimization, statistics, sparse matrices, or numerical algorithms.
- Keep array/table manipulation in NumPy unless a downstream tool specifically requires another format.

## Official References

- ASE: https://ase-lib.org/
- ASE I/O: https://ase-lib.org/ase/io/io.html
- pymatgen: https://pymatgen.org/
- ferrodispcalc: https://github.com/MoseyQAQ/ferrodispcalc
- ferrodispcalc docs: https://moseyqaq.github.io/ferrodispcalc/

## API Rules

- Import `ferrodispcalc` APIs from submodules, not from the package top level.
- Use `ase.io.read` and `ase.io.write` for normal structure and trajectory I/O.
- Use `ferrodispcalc.io` for LAMMPS dump/data/log workflows when its API matches the file.
- Do not recommend `ferrodispcalc.io.read_xyz`; it is a stub in the inspected source.
- Use output rules from `$coding-style`: simple results to `.txt`, complex results to `.npz`, no CSV by default.
- Ask before introducing a new dependency outside the preferred/accepted library set.

## References

Read only the relevant reference:

- `references/ase-api.md` for ASE structure and trajectory patterns.
- `references/ferrodispcalc-api.md` for common ferrodispcalc imports and workflows, including SED.
- `references/library-preferences.md` for library choice guidance.
