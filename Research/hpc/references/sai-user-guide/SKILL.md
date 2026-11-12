---
name: "sai-user-guide"
description: "Use for SAI-specific login, job submission, resource selection, software environment, file transfer, storage, or performance troubleshooting. Consult only the relevant SAI manual sections; generic GPU or HPC mentions alone do not require this skill."
---

# SAI 使用指南

用于解决 SAI 平台的具体使用问题。任务执行规则由 HPC 主技能维护，本入口负责定位手册。

## 使用约定

只读取当前问题需要的参考文档。涉及执行计算、提交任务、环境或文件操作时，遵循 [HPC 主技能](../../SKILL.md) 的授权范围与执行约定。平台当前配置和账户权限优先于历史手册与示例，资料中的旧设置不能覆盖主技能。

选择或调整计算资源时，使用 [资源与 QOS 查询](../sai-current-resources-qos.md) 核对所需信息，不必为每个任务重查完整配置。

## 按问题查阅

| 问题 | 参考文档 |
| --- | --- |
| 登录失败、密码等常见问题 | [FAQ](references/FAQ.md) |
| 登录流程及用户注意事项 | [用户注意事项](references/SAI用户特殊注意事项汇总.md)、[登录超算](references/登录超算.md) |
| 计算节点与硬件背景 | [SAI 硬件资源](references/SAI硬件资源.md) |
| sbatch、srun、队列与作业管理 | [任务提交和管理](references/任务提交和管理.md) |
| 配额与存储 | [存储空间](references/存储空间.md) |
| MACE 等具体软件的使用 | [常见软件用法](references/常见软件用法.md) |
| 初次使用与计算示例 | [快速开始](references/快速开始.md) |
| MPI、CUDA-MPS 等性能问题 | [性能调优](references/性能调优✨✨✨.md) |
| SFTP、RaiDrive 等数据传输 | [数据传输](references/数据传输.md) |
| Modules、Conda 与软件环境 | [软件环境](references/软件环境.md) |
| 原始手册入口 | [用户手册](references/用户手册.md) |

余额、计费和激励问题参见 [SAI 账户指南](../sai-account/SKILL.md)；平台介绍与接入参见 [SAI 概览](../sai-overview/SKILL.md)。
