# Library Preferences

## Preferred Core

- `numpy`: default for arrays, numerical data, text output, and `.npz` archives.
- `matplotlib`: default for plotting; use `$plot` for figure style.
- `ase`: default for atomic structures, trajectories, file I/O, cells, positions, and structural manipulation.
- `ferrodispcalc`: default for Mosey's ferroelectric order-parameter workflows.

## Accepted When Needed

- `pymatgen`: use for robust crystal structure tools, symmetry, neighbor finding, crystallographic format conversion, and ASE interoperability.
- `scipy`: use for fitting, interpolation, optimization, signal processing, statistics, sparse matrices, and mature numerical algorithms.
- `dpdata`: acceptable for simulation-format conversion when already used by `ferrodispcalc` or requested by the workflow.

## Avoid By Default

- Do not use `pandas` unless the user explicitly asks or an existing file/workflow already depends on it.
- Do not convert NumPy arrays to DataFrames merely to save or manipulate simple tabular data.
- Do not output CSV by default. Use `.txt` for simple results and `.npz` for structured arrays.

## Coordination With Other Skills

- Use `$coding-style` for script structure, output policy, and physical-assumption handling.
- Use `$plot` for Matplotlib figure style and plotting defaults.
- Use `$hpc` before running commands on Mosey's HPC environments.
