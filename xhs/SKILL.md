---
name: xhs
description: Turn a research paper from a PDF, local file, DOI, arXiv page, journal webpage, or pasted paper text into a concise Xiaohongshu/XHS-style Chinese literature-sharing post. Use when the user asks for 小红书推文, xhs post, 文献分享, 文献精读, paper reading notes, or social-media-ready summaries of academic papers.
---

# XHS Paper Post

## Goal

Produce one publishable Xiaohongshu-style Chinese paper-sharing post from a PDF or webpage paper. The output should read like a serious literature note with a catchy but honest hook, not a promotional abstract.

## Source Handling

1. Read the supplied PDF, webpage, DOI/arXiv page, or pasted text before drafting.
2. Extract the paper title, authors or corresponding authors when visible, venue/preprint status, DOI/arXiv ID, figures, methods, central result, and limits.
3. If the source is a webpage URL and current page details matter, browse or fetch the page. If the PDF/webpage cannot be accessed, ask for the file or pasted text instead of guessing.
4. Never invent data, claims, figure content, author identities, DOI, or conclusions. Mark uncertain details as unclear or omit them.

## Output Rules

- Title format must be exactly: `文献精读|XXXX`
- Make `XXXX` short, concrete, faithful to the paper, and as eye-catching as possible without exaggeration.
- Keep the full post under 1000 Chinese characters; 600-800 Chinese characters is ideal.
- Use simplified Chinese by default. Keep technical English terms when they are standard in the field.
- Prefer the reader-facing style from `example.md`: direct, compact, figure-driven, and explanatory.
- Avoid empty hype such as "颠覆认知", "必看神作", "打开新纪元" unless the paper itself justifies it.
- Do not use fake precision. If a number, material, method, or mechanism appears, it must come from the paper.
- End with a short "most worth remembering" conclusion.

## Drafting Workflow

1. Identify the paper's one-sentence contribution: what problem it asks, what new mechanism/model/evidence it provides, and why it matters.
2. Choose a title hook from the contribution, not from vague buzzwords.
3. Build the post around 4-6 compact blocks:
   - `📖 研究背景`
   - `🔬 主要方法` when methods are central
   - `🏗️ 图1...`, `⚡ 图2-3...`, or other figure/result blocks when the paper has useful figures
   - `💡 结论`
4. Explain figures by function, not by caption translation: say what each figure proves in the story.
5. Cut secondary details until the post is below 1000 characters. Preserve the mechanism, evidence, and conclusion first.

## Style Calibration

Read `references/format-and-examples.md` when the user asks for "setup", examples, a reusable format, or when you need style calibration before writing.

Use this hierarchy when adapting:

1. User's explicit requirements for this paper.
2. The hard output rules above.
3. The general format and examples in `references/format-and-examples.md`.
4. The source paper's actual structure.
