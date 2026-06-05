---
name: plot
description: Create one-off scientific research plotting scripts with Matplotlib. Use when Codex needs to generate simple, clear, compact, physically meaningful figures from local data files, digitized data, intermediate simulation results, or manually provided arrays.
---

# Plot

Create complete runnable plotting scripts, not fragmented snippets, unless the user explicitly asks for only a function or a patch. Prefer simple local scripts over reusable plotting libraries.

## Core Approach

- Treat these as temporary research plotting scripts, not packages.
- Keep code direct, readable, and easy to edit.
- Use light helper functions only when they reduce real repetition.
- Avoid unnecessary defensive input checks for known local data.
- Do not over-explain the code. If a physical assumption is involved, briefly state it before or after the code.
- Separate scripts with structured comments:
  - `# Hard-coded variables`
  - `# Load data`
  - `# Compute derived quantities`
  - `# Plot figure`
  - `# Save output`
- Put easily modified values near the top under `# Hard-coded variables`: paths, filenames, selected columns, selected components, selected atom types, selected layers, conversion constants, fitting ranges, labels, figure size, and output filename.

## Physical Explicitness

- Numerical correctness is not the same as physical correctness.
- Make physically sensitive choices explicit: sign convention, unit conversion, normalization, mean subtraction, smoothing, fitting range, selected component, selected layer, selected atom type, selected time window, and similar choices.
- Do not silently change signs, normalize data, take absolute values, remove negative values, smooth data, or mask data.
- If a simple operation can change physical interpretation, add a short comment saying so.

## Plotting Rules

- Always use Matplotlib.
- Always load the local style before plotting:

```python
import matplotlib.pyplot as plt
plt.style.use("nature.mplstyle")
```

- Save PNG files only by default.
- Always save with `dpi=600`.
- Always save with `bbox_inches="tight"`.
- Do not save PDF, SVG, EPS, JPG, or other formats unless the user explicitly asks for that exception.
- Use `plt.tight_layout()` or an equivalent layout adjustment before saving.
- Prefer compact figures. Use larger canvases only when compact sizing makes labels, legends, multiple curves, or data unreadable.
- Prefer clear scientific plots suitable for papers and slides.
- Use high-contrast colors with clearly distinguishable curves.
- Avoid decorative plotting effects.
- Avoid unnecessary grids unless they help interpretation.
- Use inward ticks, visible top/right ticks, clear axis labels, and readable legends.
- Legends should usually be frameless.
- Axis labels should include physical symbols and units.
- Use LaTeX-style math text, for example `$T$ (K)`, `$P_z$ (C/m$^2$)`, `$\chi_{33}$`, `$C(\tau)$`, `$\tau$ (ps)`, and `$c$ ($\mathrm{\AA}$)`.
- Use `$\mathrm{\AA}$` for angstrom. Do not use `Ang`.

## Visual Defaults

- Use black axes and a black frame.
- Use a compact but readable canvas.
- Prefer clear curves.
- Use open-circle markers for discrete extracted data points.
- Use dashed lines for fits, reference lines, zero lines, or guides.
- Use gray dashed horizontal zero lines when useful.
- Keep colors minimal, but high contrast when multiple cases are shown.
- Use this recommended palette:

```python
colors = {
    "blue": "#2F6DB3",
    "red": "#C9302C",
    "black": "#000000",
    "green": "#2E8B57",
    "orange": "#E69F00",
    "purple": "#7B3294",
    "gray": "#7F7F7F",
}
```

## Expected Patterns

Single-panel default:

```python
fig, ax = plt.subplots(figsize=(3.4, 2.2))

# plotting code

plt.tight_layout()
fig.savefig("figure-name.png", dpi=600, bbox_inches="tight")
```

Larger single-panel figure when it improves readability:

```python
fig, ax = plt.subplots(figsize=(4, 2))

# plotting code

plt.tight_layout()
fig.savefig("figure-name.png", dpi=600, bbox_inches="tight")
```

Multi-panel figure:

```python
fig, axes = plt.subplots(1, 3, figsize=(6.5, 2.0))

# plotting code

plt.tight_layout()
fig.savefig("figure-name.png", dpi=600, bbox_inches="tight")
```

Panel labels:

```python
ax.text(
    0.02, 1.02, "(a)",
    transform=ax.transAxes,
    ha="left",
    va="bottom",
)
```

Open-circle data points and dashed fitting lines:

```python
ax.plot(x_fit, y_fit, "--", color="k", lw=0.8)
ax.scatter(x, y, s=18, facecolors="none", edgecolors="k", linewidths=0.6)
```

Reference line:

```python
ax.axhline(0, color="gray", ls="--", lw=0.8)
```

## Short Template

```python
import numpy as np
import matplotlib.pyplot as plt

plt.style.use("nature.mplstyle")


# Hard-coded variables
input_file = "data.dat"
output_file = "figure-name.png"
figsize = (3.4, 2.2)

colors = {
    "blue": "#2F6DB3",
    "red": "#C9302C",
    "black": "#000000",
    "green": "#2E8B57",
    "orange": "#E69F00",
    "purple": "#7B3294",
    "gray": "#7F7F7F",
}


# Load data


# Compute derived quantities
# Keep physical choices explicit: unit conversion, sign convention, normalization, averaging.


# Plot figure
fig, ax = plt.subplots(figsize=figsize)

ax.tick_params(direction="in", top=True, right=True)
ax.legend(frameon=False)

plt.tight_layout()
fig.savefig(output_file, dpi=600, bbox_inches="tight")
```
