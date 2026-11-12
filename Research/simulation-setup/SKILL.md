---
name: simulation-setup
description: "Prepare or modify LAMMPS and VASP calculation inputs, or select familiar starting structures for Mosey's simulations. Prefer relevant existing project or nearby calculation files; when context is absent, start from the bundled reference inputs and structures. Use for simulation setup, not routine trajectory analysis or plotting."
---

# Simulation Setup

Use Mosey's existing calculation practice as the starting point. Preserve familiar input organization and applicable settings while adapting them to the requested physics.

## Choose the Starting Point

Priority: the user's current explicit requirements, then relevant project inputs and nearby cases, then this skill's defaults and assets.

1. Follow the user's current request and explicitly supplied inputs.
2. Inspect existing inputs in the working directory and relevant nearby cases. Prefer a case matching the material, potential or electronic method, calculation purpose, and boundary conditions; directory proximity alone does not establish relevance. Keep the search local to the project or user-provided locations.
3. If there is no suitable local context, read the relevant section of [the input index](references/inputs.md) and the closest bundled asset. An empty folder containing only a structure is a normal use case: use the structure and build from the matching reference input.

When local context covers only part of the task, retain it and use the library for the missing part. Do not replace a suitable project input with the bundled version just for consistency. If no asset fits, use the closest applicable conventions and state what requires a new choice.

## Adapt the Input

- Preserve the selected input's sections, variable names, parameter placement, and output conventions where practical. Make focused changes instead of rewriting it into a different style or framework.
- Reuse applicable numerical settings as a baseline. The VASP inputs are historical calculations that Mosey considers broadly useful starting points; they are preferred fallbacks, not mandatory settings or evidence of convergence for every system.
- Resolve task-specific paths, potential files, element/type mappings, masses, initial or restart states, and output dependencies against the actual project. Historical absolute paths and placeholders are not ready-to-run defaults.
- Make physical choices visible: units, coordinate/field directions, effective charges, ensemble, cell constraints, loading sequence, time step, and total duration. Do not silently transfer material-specific assumptions or silently change the model to make an example run.
- For structures, preserve the supplied cell, coordinates, and species order unless the task requires a transformation. Do not infer provenance, polarization direction, or a coordinate convention solely from the filename.
- Correct clear inconsistencies in the generated working input and briefly identify them. Ask only when an unresolved choice materially changes the requested physics or prevents preparing a usable input; do not ask the user to reselect every baseline parameter.
- Copy or adapt selected assets into the calculation directory. Ordinary calculation tasks should not modify this library.

## Handoff and Related Skills

Briefly identify the starting file or case and the meaningful changes, especially physical or numerical departures. Keep this in the conversation or useful input comments; do not create a separate report by default. Distinguish inspected inputs from inputs actually tested or calculations actually converged.

Use `hpc` when running or submitting calculations, and `coding-style` / `coding-api` when helper code is needed. This skill supplies calculation inputs; it does not replace those workflows.

Read only the relevant assets linked in [references/inputs.md](references/inputs.md). The library is self-contained; the original `素材/` directory is not a runtime dependency.
