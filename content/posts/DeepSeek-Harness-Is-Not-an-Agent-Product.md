---
title: "Frankly, DeepSeek Harness Is Not an Agent Product at All"
date: "2026-08-12T09:22:00+08:00"
author: "Nick Yam"
toc: true
categories:
  - "Tech"
tags:
  - "AI"
  - "DeepSeek"
  - "Agent"
  - "Plugin"
url: "/Tech/DeepSeek-Harness-Is-Not-an-Agent-Product.html"
---

Last week, right after the official release of DeepSeek V4 Pro, they threw out something else called DeepSeek Harness. Its GitHub stars shot to 37,000 in three days. My first reaction was: DeepSeek is finally shipping its own Agent? I installed the developer preview immediately.

Once it was installed, I was lost — this was nothing like what I imagined an Agent to be. There is no chat box where you say "write me a crawler." Instead there is an empty workspace and a long list of plugins I could not make sense of. For a moment I suspected I had installed the wrong thing.

So I went through the official site, the developer docs, and that 88-page paper, then spent three days installing five or six plugins and poking at it. Only then did I understand what DeepSeek is actually after. In one sentence: what they built is not an Agent product at all — it is a **chassis** that lets an Agent plug capabilities in and out by itself. Here is how I came to see it.

## I. First, the Formula: Agent = Model + Harness

To understand DeepSeek Harness, you have to accept one formula: Agent = Model + Harness.

Model is easy — it is the large model itself. Harness is everything wrapped around it: tool calling, Skills, session management, sandboxing, storage, the agent loop, sub-agents, workflows. Every Agent product you have used is essentially a Harness wearing a shell.

Historically, vendors sealed those shells shut. Use Codex and what tools you get, what you cannot change — all decided for you. At best you install a few MCP servers and Skills; the rest you cannot touch.

DeepSeek Harness runs the other way: it takes the shell apart and turns everything inside into plugins. Even the WebUI itself is just a UI plugin — think it is ugly, swap it out whenever you like. Some users have already published skin plugins for it.

The official phrase for this "everything is pluggable" philosophy is five words: *everything is a plugin*.

My first hands-on impression was that it felt exactly like the modular phones I played with as a kid, where you could pop out the battery, camera and speaker and swap in your own. DeepSeek Harness has moved that game onto Agents.

The only genuinely irreplaceable core in the whole system is a kernel called **Cordis**, responsible for nothing but loading, unloading and dependency management of plugins. Its author has joined DeepSeek, and this release also ships an 88-page paper[2].

Two properties of the kernel are particularly well thought out:

**Temporal composability** — after a plugin is unloaded, can the side effects it produced be fully undone? If not, the Agent's state gets dirty as it runs.

**Spatial composability** — plugins depend on each other; when another plugin appears, disappears or is replaced, can a plugin dynamically re-resolve its own dependencies?

Only with these two properties can an Agent keep installing, uninstalling and even writing new plugins for itself while running, creating something like self-evolution. The headroom in that mechanism is, honestly, pretty wild.

## II. Four Modes — My Advice Is Not to Overthink Them

This is where ordinary users get lost most easily. Open the home page and four modes are staring at you: Standard, PTC, Minimal, Creative. At first I assumed these were four capability tiers and agonized over which to pick.

Then it clicked: they are just four template presets, there to get you running out of the box. Once you understand the kernel, this layer barely matters.

- **Standard:** full code-agent capability — file read/write, shell, search, Skills, planning, sub-agents, all of it, ready to go. If it is your first time, pick this one without thinking.
- **PTC:** this one is interesting. It hands the model an SDK and lets the model write TypeScript directly, packing multiple tool operations into a single `run_code` execution. What used to take five model round-trips of reading, searching, filtering and parallel calls gets done in one program execution, saving tokens. The cost is that debugging gets harder and it demands solid code-planning ability from the model.

  I got burned here once. Eagerly, I had the model write a batch file-processing program in PTC mode; it hardcoded the paths in TypeScript and the thing errored halfway through. I spent ages fixing it before realizing it was a path-concatenation bug — nothing to do with the mode, just my own overconfidence. Beginners really should not touch this; Standard is enough.

- **Minimal:** only two tools — a persistent Bash and a file editor — with a system prompt fixed to the single line "You are a helpful software engineering assistant." This mode is not for daily use; it exists to run bare-Agent capability benchmarks. Want to compare the true level of two models? Use it. Use it daily and you will lose your mind.
- **Creative:** the most distinctive part of the whole product. It lets the Agent inspect the Cordis environment running inside itself, experiment with plugins in memory, then build plugins and install them onto itself.

  I told it: "Make me a mode that is read-only for code, cannot modify files, and is dedicated to security auditing." It checked what it was missing, wrote a plugin on the spot, installed it — and then genuinely went read-only.

  It is like an Agent that, halfway through a job, discovers it has no wrench, forges one on the spot, and plugs it into its own hand to keep working. That moment of bootstrapping is, to me, the most valuable thing about DeepSeek Harness.

## III. An Official Product That Does Not Lock You to Its Own Model

Modes aside, let us talk price. This is probably the first thing that scares ordinary users off.

DeepSeek announced a price increase, and the increase is steep. V4 Pro's cache-hit price went up 12x, and peak output pricing came to ¥27. I had predicted roughly a 2x rise; instead peak starts at 3x and cache hits are a flat 12x. Compared against GLM and Qwen 3.8 Max, the gap has all but closed — and with GLM-5.3 about to launch, likely another open-source SOTA at unchanged price, V4 Pro may genuinely lose on API cost-performance[3].

But here is the interesting part: DeepSeek Harness does not lock you into DeepSeek models. It supports adding model providers from a directory, and also custom providers with your own Base URL, protocol and model list. In other words, you can run GLM — or any other vendor's model — inside DeepSeek Harness.

An official Agent product that openly lets you plug in someone else's model is a counterintuitive design. But it fits their "building infrastructure" positioning: the model is a plugin, tools are plugins, anything can be a plugin. The model itself is only one link in the ecosystem.

## IV. An Underappreciated Design: Sessions as Append-Only Event Logs

One more point that is easy to overlook but that I think matters a lot: a DeepSeek Harness session is an append-only event log.

The system prompt the model sees, user messages, reasoning traces, tool calls and their results, permission changes, context compression, sub-agent dispatch — all of it is written into the log as events. The history the model sees on the next turn is re-derived from that log.

What does that mean in practice? When an Agent crashes, you used to get four words — "task failed" — with no clue which step it went off the rails. In Harness, the trajectory view lets you replay each run by source: observable, auditable, reproducible. For anyone doing Agent research, that is close to essential.

## V. Plugins Worth Installing

The community plugin directory went live alongside it. I installed a few and these are the ones I think are worth it:

- **dsh-at-file:** type `@` in the input box to reference a file. Saves a lot of hassle.
- **dsh-genui:** lets the model render charts, tables, diffs and Mermaid diagrams directly in its replies.
- **dsh-automation:** adds automation capabilities. Needed, though the interaction is a bit rough.
- **DSH-better-sidebar:** a VS Code–style workbench — file management, terminal, Git and diff all packed into the sidebar.
- **ModLens:** gives text-only models vision; paste an image and it can read it.

Installing takes one command:

```
npx @deepseek-ai/dsh web
```

If none of that means anything to you, just hand the command to any local Agent you have and let it install things for you. Once it is done, open the local address in your browser, drop in your DeepSeek API key, and you are running. Official site: https://www.deepseek.com/harness/[1]

## Closing Thoughts

DeepSeek Harness is a very unusual system. I like the "everything is a plugin" philosophy, I read the Cordis paper, and the design is genuinely considered. But as a product, it is deeply unfriendly to ordinary users — too much developer jargon, too high a barrier, too few features, too rough an experience. Every step pushes normal people away.

But DeepSeek probably never built it for "normal people." What they want is developers worldwide coming in, writing plugins for this chassis, turning it into an ecosystem. Much like their slogan: explore the unknown.

My recommendation: if you just want an Agent that gets work done, use Standard mode and stop fiddling. If you are someone who likes to tinker, install it and play — you will see a very different Agent world.

As for whether it is the future or just a curiosity — use it once and you will have your answer.

## References

- **[1]** DeepSeek Harness official site — https://www.deepseek.com/harness/ — and the one-line install `npx @deepseek-ai/dsh web`, which serves a local web UI that runs once a DeepSeek API key is supplied.
- **[2]** The **Cordis** kernel — the sole irreplaceable core of the system, handling only plugin load/unload and dependency management; its author has joined DeepSeek. The accompanying 88-page paper covers the kernel's two key properties, temporal composability (fully undoing a plugin's side effects on unload) and spatial composability (dynamically re-resolving dependencies as other plugins appear, disappear or are swapped).
- **[3]** DeepSeek V4 Pro API pricing referenced in the article — cache-hit price up 12x and peak output at ¥27 — compared against GLM, Qwen 3.8 Max, and the upcoming GLM-5.3; and the fact that Harness does not lock users to DeepSeek models, supporting directory providers plus custom Base URL, protocol and model list.
- **[4]** Community plugins cited in the article: `dsh-at-file`, `dsh-genui`, `dsh-automation`, `DSH-better-sidebar` and `ModLens`; and the product's four preset modes — Standard, PTC, Minimal and Creative.
