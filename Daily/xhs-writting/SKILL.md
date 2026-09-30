---
name: xhs-writting
description: "Write Chinese Xiaohongshu research posts in two modes: paper reading from PDFs, DOI/arXiv links or paper text; and academic genealogy from a scholar name. Use for 文献精读、论文分享、学术族谱、导师与学生关系、人物学术介绍及其图文制作. Produce grounded notes, concise copy and, for genealogy, relationship maps and a portrait cover. Account login and publishing belong to xhs-push."
---

# XHS 研究图文

把可靠的研究资料写成适合小红书阅读的中文图文。优先讲清科学问题、机制和证据；人物稿同时呈现研究主线与学术关系。

## 模式与职责

- **文献精读**：阅读 [paper.md](references/paper.md)，完成正文与 6 个候选标题。
- **学术族谱**：阅读 [genealogy.md](references/genealogy.md)，依次调研并写入 `note.md`、制作关系图和人物封面、写入 `xhs.md`。制图时读取 [genealogy-visuals.md](references/genealogy-visuals.md)。
- 完整写作示例见 [format-and-examples.md](references/format-and-examples.md)。只加载当前任务需要的示例和视觉参考。
- 项目 `AGENTS.md` 管目录、文件命名和论文截图。本 skill 管内容调研、写作及人物配图；`xhs-push` 管实际发布。
- 用户提供姓名且身份不明确时先辨认，必要时询问机构或领域，不把同名人物资料拼在一起。

## 通用写作约定

- 默认简体中文，保留必要的标准术语。全文不足 1000 字符，600–800 字符为理想范围；内容需要时可接近上限，不为压缩丢掉核心机制和证据边界。
- 对完整 `xhs.md` 做 Unicode 字符计数（包括标题、标点、英文、标签和换行），不要仅数汉字或字节。平台的最终输入校验由发布模块负责。
- 最终稿实际保存到工作目录的 `xhs.md`；用户指定其他输出路径时从其要求。研究细节保存在 `note.md`，不要混入待发布正文。
- 不编造人物关系、引用数、职位、论文结果和图中信息。区分直接证据与自己的研究主线归纳；不要把合作成果全部归为一个人。
- 不套用“颠覆认知”“打开新纪元”等宣传句；不强制以“最值得记住”再复述结论。
- 用户选定或提供的标题优先。文献标题必须保留 `📝文献精读 | ` 前缀；人物标题使用 `学术族谱｜{姓名}`。

## 指标的内部记录与公开呈现

- 人物指标默认优先 Google Scholar；无法可靠获取时使用已确认身份的 OpenAlex 档案（用户所称 alex）。同一套总被引、H-index 和单篇被引尽量使用同一数据库，不拼接不同库的数值，也不手算缺失的 H-index。
- `note.md` 保留数据库、档案标识或 URL、实际查询日期、原始指标及单篇对应记录，确保可追溯。
- 封面和 `xhs.md` **不写指标数据库来源和查询日期**，按发布时的当前指标呈现。若制作后隔日发布，交接时注明需要复核指标并同步笔记、封面与正文；无法刷新时说明情况，不把旧值默认为当天值。
- 未能查实的数值不得估算填空。保留已完成内容并报告缺项，不把未核实的封面交付为发布就绪。

## 完成与交接

- 检查事实、字数、标题、图文编号以及所有配图中的姓名和数字一致。
- 文献正文完成时，在聊天中同时给出 6 个完整候选标题，并保存为工作目录的 `titles.md`；正文暂用推荐项，明确标记“待用户选择”。用户已定标题时不重复生成。
- 用户选择标题后更新 `xhs.md` 首行；不能把暂用推荐项当作用户已选标题交给发布模块。若用户明确授权代选，则直接选定并说明。
- 人物图文交付 `note.md`、`xhs.md`、`cover.png`、`fig1.png`、`fig2.png` 和可编辑关系图源文件；图片顺序为 cover → fig1（下游）→ fig2（上游）。
- 向项目流程交接文案、图片顺序、标题选择状态和未完成项。本 skill 不自行登录、上传或发布。
