# Plot Examples

Apply the fixed style, palette, and export rules in the [main skill](../SKILL.md). When running outside the skill directory, replace the style filename below with the single known bundled style path.

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

# Use the recommended palette from SKILL.md when needed.


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
