# ferrodispcalc API Reference

This summary is based on `MoseyQAQ/ferrodispcalc` inspected at commit `b21ad1cb1203b960dde8e2160f7407490d5632b4`.

Official links:

- https://github.com/MoseyQAQ/ferrodispcalc
- https://moseyqaq.github.io/ferrodispcalc/

## Import Style

Do not import APIs from the package top level. Use submodules:

```python
from ferrodispcalc.neighborlist import build_neighbor_list, save_neighbor_list
from ferrodispcalc.compute import calculate_displacement
```

## Neighbor Lists

```python
from ferrodispcalc.neighborlist import build_neighbor_list, save_neighbor_list


nl_bo = build_neighbor_list(
    atoms,
    center_elements=["Ti"],
    neighbor_elements=["O"],
    cutoff=4.0,
    neighbor_num=6,
)
```

Rules:

- `build_neighbor_list` returns a 1-based integer array.
- Shape is `(n_centers, neighbor_num + 1)`.
- First column is the center atom index; remaining columns are neighbor indices.
- Use `save_neighbor_list(nl, "nl-bo.dat", zero_based=False)` for text output.
- Set `defect=True` only when missing neighbors are physically intended.

## Ferroelectric Descriptors

```python
from ferrodispcalc.compute import (
    calculate_averaged_structure,
    calculate_dielectric_constant,
    calculate_displacement,
    calculate_octahedral_tilt,
    calculate_polarization,
)
from ferrodispcalc.config import BEC
```

Displacement:

```python
disp = calculate_displacement(traj, nl_bo, select=slice(None, None, 1))
```

- Single structure output: `(n_centers, 3)`.
- Trajectory output: `(n_frames, n_centers, 3)`.
- Units: Angstrom.
- `select=None` defaults to the last 50 percent of frames in the current implementation.

Local polarization:

```python
P = calculate_polarization(
    traj,
    nl_ba=nl_ba,
    nl_bx=nl_bo,
    born_effective_charge=BEC["PTO"],
    select=slice(None, None, 1),
)
```

- Requires B-A and B-X neighbor lists with matching B-site centers.
- Output units: C/m^2.
- For mixed systems, define the Born effective charge dict explicitly.

Octahedral tilt:

```python
tilt = calculate_octahedral_tilt(traj, nl_bo)
```

- Expects six neighbors around each center.
- Output columns are x, y, z tilt angles in degrees.

Dielectric tensor:

```python
eps = calculate_dielectric_constant(
    P,
    volume=avg_atoms.cell.volume,
    temperature=300.0,
    atomic=False,
)
```

- Uses the ionic polarization-fluctuation contribution.
- Returned keys include `eps_xx`, `eps_yy`, `eps_zz`, `eps_xy`, `eps_xz`, `eps_yz`.
- No internal error analysis is performed; use block averaging if uncertainty matters.

Averaged structure:

```python
avg_atoms = calculate_averaged_structure(traj, select=slice(None, None, 1))
```

## LAMMPS I/O

```python
from ferrodispcalc.io import read_lammps_data, read_lammps_dump, read_lammps_log
```

LAMMPS dump:

```python
traj = read_lammps_dump(
    "dump.lammpstrj",
    type_map=["Pb", "Ti", "O"],
    select=slice(None, None, 1),
)
```

- Returns `list[ase.Atoms]` unless `select` is an integer.
- `type_map` maps LAMMPS numeric atom types to element symbols.
- Caches a sidecar frame index for faster repeat reads.

LAMMPS data:

```python
atoms = read_lammps_data("structure.data", type_map=["Pb", "Ti", "O"])
```

LAMMPS log:

```python
log = read_lammps_log("log.lammps")
temperature = log["Temp"]
steps = log["Step"]
```

`read_xyz` exists in `ferrodispcalc.io` but is a stub in the inspected source. Do not recommend it.

## Grid Data

```python
from ferrodispcalc.vis import grid_data


grid = grid_data(
    atoms,
    data,
    element=["Ti"],
    target_size=(nx, ny, nz),
)
```

- Accepts data shaped `(n_atoms, n_features)` or `(n_frames, n_atoms, n_features)`.
- Returns grid-shaped data with dimensions `(nx, ny, nz, n_features)` or `(n_frames, nx, ny, nz, n_features)`.
- Use `return_coord=True` when grid coordinates are needed.

## SED Workflow

SED details live in reference because they are specialized. Import from `ferrodispcalc.sed`:

```python
from ferrodispcalc.sed import (
    calculate_sed,
    extract_eigen_vector,
    generate_commensurate_qpath,
    load_eigen_vector,
    load_sed,
    plot_sed,
    plot_sed_1d,
    save_eigen_vector,
    save_sed,
)
```

Basic pattern:

```python
grid_shape = tuple(int(v) for v in field.shape[1:4])
primitive_shape = (1, 1, 1)
cell_shape = tuple(g // p for g, p in zip(grid_shape, primitive_shape))

q_path = np.array(
    [
        [0.0, 0.0, 0.0],
        [0.0, 0.0, 0.5],
    ],
    dtype=float,
)
qpoints, q_distances = generate_commensurate_qpath(q_path, cell_shape)

result = calculate_sed(
    field=field,
    dt_ps=dt_ps,
    qpoints=qpoints,
    primitive_shape=primitive_shape,
    num_splits=5,
    remove_mean=True,
    n_jobs=4,
)
save_sed(result, "sed-result.npz")
```

Conventions and cautions:

- Input `field` shape is `(n_frames, nx, ny, nz, 3)` for vector local modes.
- `dt_ps` is in ps; FFT frequency is numerically THz.
- q-points are reduced coordinates.
- Allowed q-points satisfy `q * cell_shape` being integer-valued.
- `result.sed` shape is `(nfreq, nq, 4)` with components x, y, z, total.
- Use `remove_mean=True` for displacement-like fields to remove static local distortion and DC component.
- Use `remove_mean=False` for velocity-like fields.
- No mass weighting is applied.

Recent SED contract notes from prior work:

- `phase_convention` should not be reintroduced as a public API concept.
- Spatial phase uses the full local-mode position, including basis offsets.
- `extract_eigen_vector` exposes both `mode_movie` and `primitive_mode_movie`.
- Saved mode files include `mode_movie`, `primitive_mode_movie`, `phases`, `evec_basis`, `amplitude_basis`, `qpoint`, frequency metadata, `primitive_shape`, `cell_shape`, `freq_method`, `gauge`, `normalize`, and `remove_mean`.
