# 常用计算输入与结构

这些文件原样收录自仓库的 `素材/`，供新计算参考和修改。下列说明用于选取起点；参数以文件内容为准，不把历史案例视为已验证适用于当前体系的完整作业。

## LAMMPS

| 文件 | 用途与背景 | 适配时关注 |
| --- | --- | --- |
| [eq.in](../assets/LAMMPS/eq.in) | 从结构开始的 NPT 平衡起点；包含 DeePMD、DPA4C、MACE 的候选写法 | 选择所需势函数块，填入模型、元素映射及质量；按任务确定晶胞自由度、温压和步长 |
| [input.lammps](../assets/LAMMPS/input.lammps) | 使用 DeePMD 的具体项目平衡实例 | 模型绝对路径属于原项目；质量需结合 `conf.lmp` 检查；已有相近项目时优先继承项目输入 |
| [heating.in](../assets/LAMMPS/heating.in) | 从 restart 出发，逐温度点运行 NPT 的连续升温实例 | Pt/Pb/Ti/O 映射和 MACE 路径属于原体系；明确起始状态、步长、温度序列及每点时长；文件没有显式 `timestep` 命令 |
| [pe-loop.in](../assets/LAMMPS/pe-loop.in) | 使用标量有效电荷与 `addforce` 的分段电场扫描续算实例 | 索引从 12 开始，依赖已有状态；有效电荷和 type 分组属于原体系；确认场方向、扫描历史和 restart 衔接 |
| [thz.in](../assets/LAMMPS/thz.in) | 高斯包络余弦脉冲，沿 z 加场的 NVT 实例 | Pt/Pb/Ti/O 映射、有效电荷和受力原子净力修正需匹配模型；确认脉冲参数、初态、系综和输出名 |

保留原文件中的案例细节，以下问题在生成工作输入时处理：

- `eq.in` 中的 `PLACE-HOLDER` 是有意保留的待填项。
- `pe-loop.in` 读取 `restart/restart.${prev}`，却将新 restart 写到当前目录的 `restart.${i}`；独立连续运行时需统一读写位置或确认项目已有的衔接方式。它不是从零开始的完整回线模板。
- `thz.in` 的 `freq = 0.5e12` 与注释 `1 THz` 不一致；`Ef = 1000e-5` 与注释 `500 kV/cm` 也不一致。先依据任务确认目标场强和频率，再统一数值及注释。
- `thz.in` 对 Pb/Ti/O 施加力，并在这些原子上扣除平均力；不要未经判断把此处理推广到所有材料或金属原子。

## VASP

| 文件 | 用途 |
| --- | --- |
| [INCAR_scf](../assets/VASP/INCAR_scf) | 静态自洽计算 |
| [INCAR_rlx](../assets/VASP/INCAR_rlx) | 离子与晶胞弛豫 |
| [INCAR_md](../assets/VASP/INCAR_md) | 分子动力学 |

三份 INCAR 来自历史计算。Mosey 将其视为适用面较广的常用起点；缺少项目上下文时，优先沿用其中适用的设置，不要凭空重选一套参数。现有共同设置包括 `GGA=PS`、`ENCUT=800`、`EDIFF=1E-6`、`KSPACING=0.30`；这些值可随体系和任务调整，不代表已经完成当前体系的收敛测试。

结合实际结构和任务确定赝势、元素顺序，以及是否需要磁性、额外相互作用或其他专门设置。库内只有 INCAR 和参考结构，不含 POTCAR，也不提供完整项目所需的所有文件。

## 初始结构

Mosey 已确认这批结构的来源和优化条件一致，但尚未提供具体来源及参数记录。不要进一步声称它们来自某篇论文、某个势函数，或由本库的 INCAR 优化得到。表中的相标签沿用原文件命名，未在收录时重新验证空间群。

| 材料 | 可选结构 |
| --- | --- |
| BaTiO3 | [Pm3m](../assets/structures/POSCAR_BTO-Pm3m)、[P4mm](../assets/structures/POSCAR_BTO-P4mm)、[Amm2](../assets/structures/POSCAR_BTO-Amm2)、[R3m](../assets/structures/POSCAR_BTO-R3m) |
| PbTiO3 | [Pm3m](../assets/structures/POSCAR_PTO-Pm3m)、[P4mm](../assets/structures/POSCAR_PTO-P4mm) |
| SrTiO3 | [Pm3m](../assets/structures/POSCAR_STO-Pm3m)、[I4mcm](../assets/structures/POSCAR_STO-I4mcm) |
| PbZrO3 | [AFE40](../assets/structures/POSCAR_PZO-AFE40) |

优先使用用户当前提供的结构。需要从库中选择时，按材料和目标相取用；扩胞、旋转、应变或格式转换均以实际晶格和坐标为依据。注意 PZO 文件的元素顺序是 `Zr Pb O`，不要统一假设为 A 位、B 位、O 的顺序。
