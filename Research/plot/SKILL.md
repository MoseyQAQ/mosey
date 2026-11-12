---
name: plot
description: Create one-off scientific research plotting scripts with Matplotlib. Use when Codex needs to generate simple, clear, compact, physically meaningful figures from local data files, digitized data, intermediate simulation results, or manually provided arrays.
---

# Plot

Create complete runnable plotting scripts, not fragmented snippets, unless the user explicitly asks for only a function or a patch. Prefer simple local scripts over reusable plotting libraries.

## Code Organization

Use `$coding-style` for script structure, editable parameters near the top, and physical-assumption handling. Add `# Plot figure` before `# Save output`, and keep labels, figure size, and the output filename with the other editable parameters. Do not over-explain the code; briefly state physical assumptions before or after it.

The visual defaults below remain fixed unless the user explicitly requests a change; nearby plotting styles do not override them.

## Physical Explicitness

- Do not silently change signs, normalize data, take absolute values, remove negative values, smooth data, or mask data.
- If a simple operation can change physical interpretation, add a short comment saying so.

## Plotting Rules

- Always use Matplotlib.
- Always load the local style before plotting:

```python
import matplotlib.pyplot as plt
plt.style.use("nature.mplstyle")
```

- If using this skill's bundled style from outside the skill directory, use that single known style path directly. Do not add runtime discovery logic such as checking the current directory, probing user-home paths, or fallback style paths unless the user explicitly requests portable scripts.

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

## Minimal Figure Pattern

Default single-panel size: `(3.4, 2.2)` inches. Use `(4, 2)` when it improves readability, or `(6.5, 2.0)` for a three-panel row.

```python
fig, ax = plt.subplots(figsize=(3.4, 2.2))

# Plot figure

plt.tight_layout()
fig.savefig("figure-name.png", dpi=600, bbox_inches="tight")
```

Read [references/examples.md](references/examples.md) when a full script template, multi-panel layout, panel labels, or marker/fit examples are useful. The examples supplement the defaults above.
