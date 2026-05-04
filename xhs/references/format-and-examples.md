# XHS Paper Post Format And Examples

## General Format

Use this as the default setup for a Xiaohongshu literature-sharing post.

```markdown
文献精读|{短而真的标题}
{可选：DOI/arXiv/通讯作者/期刊，只放读者会关心的信息}

📖 研究背景
用 2-4 句说明这篇文章在问什么问题。先讲领域里的常见认知或痛点，再讲作者切入的新问题。

🔬 主要方法
用 2-4 句说明作者怎么证明这件事。只保留最关键的材料体系、模型、实验、计算或数据集。

🏗️ 图1：{图的功能}
不要翻译 caption。说明图1在全文论证里负责定义概念、建立体系、验证结构，还是展示核心流程。

⚡ 图2-3：{核心结果}
解释最关键的证据链：变量怎么变，结果说明什么，为什么支持作者主张。

🧩 图4/扩展结果：{可选}
只有当后续结果真的重要时才写。可以放机制深化、泛化测试、对比实验、应用案例或局限。

💡 结论
这篇文章最值得记住的是：
用 1-3 句讲清楚本文的 takeaway。避免把论文夸成解决了整个领域问题。
```

## Writing Moves

- Open with a familiar assumption, then show the paper's sharper question.
- Use "核心不是 A，而是 B" only when the paper really makes that distinction.
- Use figure blocks when figures drive the argument; use result blocks when the paper is theory/model-heavy and figures are less central.
- Keep each block short. One block usually 80-160 Chinese characters.
- Prefer verbs like "证明", "比较", "拆分", "引入", "排除", "连接" over abstract nouns.
- Preserve caveats when important: model system, limited dataset, preprint status, assumptions, or unresolved mechanism.

## Title Patterns

Good:

- `文献精读|长程偶极作用能不能省？`
- `文献精读|非极性材料也能有界面压电`
- `文献精读|把长程库仑写进机器学习哈密顿量`
- `文献精读|声子也能同时带电和带磁？`

Avoid:

- `文献精读|一篇颠覆材料学的神作`
- `文献精读|史上最强机器学习模型`
- `文献精读|Nature最新重磅突破`

## Classic Example 1: Mechanism Paper

```markdown
文献精读|非极性材料也能有界面压电
通讯作者：Ming-Min Yang and Marin Alexe

📖 研究背景
我们通常觉得：材料本身是中心对称的，就不该有压电和热释电。这篇 Nature 问的是另一个层面的问题：体相没有，不代表界面没有。如果 Schottky 界面存在内建电场，界面附近的局部对称性就可能被打破。

🏗️ 图1：先把界面物理立住
作者先从对称性说明界面电场会让局部区域变成极性对称，再用 I-V 和 C-V 证明器件确实是高质量 Schottky 结。后面的响应都建立在这个真实存在的界面内建场上。

⚡ 图2-3：界面真的有功能响应
在 Au/Nb:STO 中，周期性应力产生了交流短路电流，逆压电位移也能被 AFM 测到；换成 Ohmic contact 后信号基本消失。热释电测试进一步说明，界面极性不只是静态概念，也能转化为温度响应。

💡 结论
这篇文章最值得记住的是：压电和热释电不一定只属于天生有极性的体材料。只要界面内建电场足够强，中心对称材料也能通过界面工程表现出极性功能。
```

## Classic Example 2: Machine-Learning Model Paper

```markdown
文献精读|把长程库仑写进机器学习哈密顿量
DOI/arXiv：按原文填写

📖 研究背景
机器学习 Hamiltonian 可以绕过 DFT-SCF，直接从结构预测电子哈密顿量。但很多模型主要看局域环境，对极性晶体、slab、异质结和超晶格并不够，因为这些体系里的宏观电势会在长尺度上积累。

🔬 主要方法
文章的核心思路是：长程库仑不要让网络硬猜，而是把物理公式写进去。作者把 Hamiltonian 拆成短程学习项和长程解析修正，用 Ewald 相关结构感知长波长电荷分布。

📉 图2-3：体系越厚，短程越错
在极性 slab 和超晶格测试中，短程模型的误差会随厚度增加而放大，还会给出不连续的台阶状 onsite energy。加入长程修正后，电势和能带都更接近 DFT。

💡 结论
这篇文章最值得记住的是：极性材料里的长程电势，不适合完全交给短程 GNN 硬学。把 Ewald 长程库仑以变分一致的方式写进 Hamiltonian，才是更稳的路线。
```

## Classic Example 3: Concept Paper

```markdown
文献精读|声子也能同时带电和带磁？

📖 研究背景
我们通常把铁电和磁性分开理解：铁电看极化，磁性看磁矩。这篇文章问了一个更有意思的问题：非磁性的铁电材料里，晶格激发能不能同时携带极化和磁化？

🔬 主要方法
作者以经典铁电体为例，结合第一性原理、Landau-Devonshire 势能和受激声子动力学，比较不同光学声子模式在外场激发下产生的净极化与净磁化。

🏗️ 图1：先定义 multiferron
传统 ferron 更像是携带电极化的铁电激发。但当特定声子发生椭圆或圆周运动时，离子运动可以通过 dynamical multiferroicity 产生磁化，从而形成同时具有电偶极和磁偶极特征的激发。

⚡ 图2-3：关键在椭圆激发
线偏振主要带来净极化，圆偏振主要带来磁化，而椭圆偏振最特殊，可以同时产生净极化和净磁化。这说明它不是简单的"声子带磁矩"，而是一个动力学多铁准粒子。

💡 结论
这篇文章最值得记住的是：多铁功能不一定只来自静态基态，也可能来自被光激发出来的声子激发。它把材料功能的视角从基态结构推向了可控的动力学过程。
```
