# ASE API Reference

ASE is the default library for atomic structures and trajectories.

Official docs:

- https://ase-lib.org/
- https://ase-lib.org/ase/io/io.html

## Core Objects

- `ase.Atoms`: one atomic structure.
- `list[ase.Atoms]`: trajectory or multiple frames.

## Reading

```python
from ase.io import read


atoms = read("POSCAR")
traj = read("movie.xyz", index=":")
frame = read("movie.xyz", index=0)
```

Be explicit with `format=` when ASE inference is ambiguous:

```python
atoms = read("structure.data", format="lammps-data", style="atomic")
```

## Writing

```python
from ase.io import write


write("POSCAR_out", atoms, format="vasp")
write("movie_out.xyz", traj)
write("avg.traj", atoms)
```

## Common Structure Operations

```python
positions = atoms.get_positions()       # shape (natoms, 3), Angstrom
cell = atoms.get_cell().array           # shape (3, 3), Angstrom
volume = atoms.cell.volume              # Angstrom^3
symbols = atoms.get_chemical_symbols()
scaled = atoms.get_scaled_positions()

atoms.set_positions(positions)
atoms.set_scaled_positions(scaled)
atoms.wrap()
```

## Supercells And Strain

```python
supercell = atoms * (2, 2, 2)
```

```python
import numpy as np


strain = np.eye(3)
strain[0, 0] = 1.02
atoms.set_cell(atoms.cell.array @ strain.T, scale_atoms=True)
```

Use `scale_atoms=True` when fractional coordinates should move with the strained cell.

## Atom Selection

```python
ti_indices = [i for i, atom in enumerate(atoms) if atom.symbol == "Ti"]
ti_positions = atoms.get_positions()[ti_indices]
```

For element substitution:

```python
for atom in atoms:
    if atom.symbol == "Ti":
        atom.symbol = "Zr"
```

## Notes

- Keep track of Cartesian versus fractional coordinates.
- Preserve units in comments and output metadata.
- For periodic systems, check `atoms.pbc` and cell before assuming minimum-image behavior.
