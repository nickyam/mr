---
title: "DeepSeek's Harness Made Me Uninstall Codex"
date: "2026-08-17T18:09:00+08:00"
author: "Nick Yam"
toc: true
categories:
  - "Tech"
tags:
  - "AI"
  - "DeepSeek"
  - "Agent"
  - "Plugin"
url: "/Tech/DeepSeek-Harness-Made-Me-Uninstall-Codex.html"
---

Here is what happened.

On the evening of August 14, I was scrolling on my phone when I saw DeepSeek had shipped something new called Harness. Normally I am immune to "framework" releases — everybody ships a framework these days, each name more intimidating than the last. But I clicked in, and one slogan jumped out at me:

![](https://img.nickyam.com/file/AgACAgUAAyEGAASS2zT1AAEBfbVqpm5eHQHnkGYplRlpq1MWI5qxrgACVRRrG7iVMVXlH9vsFGWeYAEAAwIAA3kAAz0E.png)

*Everything is a Plugin.*

I thought about it for a second. There is something to that phrase. I installed it that same night.

## First, what this actually is

In case you missed it, a quick rundown.

Think of Harness as the "saddle" for an Agent. The model is the horse; a horse alone you cannot ride — you need a saddle and reins before it will listen to you, do the work, and run the long haul. Harness is that saddle. DeepSeek open-sourced the saddle this time, under the MIT license — anyone can install it, anyone can modify it[1].

The most interesting part is the design philosophy: everything is a plugin. It ships a built-in base called **Cordis**, like the studded baseplate of a Lego set — whatever capability you want, you just plug it on top[2]. Models, tools, strategies, storage, context management — all swappable building blocks.

I later dug through the official repository and realized "Cordis" basically means "baseplate." You do not sculpt Lego from scratch; you start with a baseplate and plug pieces onto it. DeepSeek ported that idea onto Agents.

## I migrated a project off Codex

I missed the closed beta, but I installed it the moment it dropped.

The first thing I did after installing was migrate a project I had been working on for two months, off Codex and onto Harness.

Not for any grand reason — just one long-festering pain point.

Every time I opened a new session, the AI acted like it had amnesia. I had to re-explain the whole project from scratch: which port, which framework, which pitfall I hit last time, what the database was called — all over again. Once or twice was fine; by the tenth time I genuinely wanted to smash the keyboard.

Think about it: two months on one project, and the time I burned re-introducing my own project would have been enough to watch another *The Wandering Earth*.

Then I found a plugin on GitHub called **dsh-memory-evolve**[3].

After installing it, the world changed.

I told it once, "this project deploys on port 8080," and it remembered. Two days later, in a fresh session, I asked about the deploy config and it picked up right where we left off — no re-explaining needed. Project conventions, architecture decisions, pitfalls hit, current progress — it stores all of it, even senses the Git branch, and quietly evolves Skills in the background.

In plain terms: it turns an assistant that loses its memory every chat into an old hand that works with you over the long term.

For that one plugin alone, I forgave it all its imperfections.

## A few more that genuinely saved my life

Next, **dsh-at-file**.

Simple and crude, but a lifesaver.

Before, if I wanted the AI to mirror my existing login module and rewrite the payment page with the same logic, I had to find login.ts myself, open it, copy the code, switch back, and paste it into the chat box. By the time that whole routine was done, my train of thought was half broken.

Not anymore. Just `@login.ts` and the file content flows into the prompt on its own. Edit. Done.

It is details like this where the saved time is impossible to tally. Ten times a day adds up to several extra nights of sleep a month.

Third, **DSH Better Sidebar**.

This packs the sidebar into a mini-IDE. File management, code editing, terminal, Git panel, background tasks, sub-agents — all in one sidebar.

My laptop screen is small, 13 inches. Before, I wore out Alt+Tab between Harness, VS Code, terminal and Git; my fingers were about to grow calluses. Now I barely switch windows — I can view and edit files, the terminal is a real shell, and Git even shows diffs, staging and commits.

Alt+Tab finally gets a break from the beating.

Fourth, a special complaint.

The V4 model is genuinely strong — long-horizon tasks fly[4]. But it is blind; it cannot see images. I would screenshot an error and want it to take a look, and it would say it can't. I would have to open a separate OCR tool, recognize the text, then paste it back. Infuriating.

So I installed **ModLens**.

This plugin gives a text-only model a pair of eyes. Just paste an image straight into the chat box; it first calls a vision model to recognize the text, layout and entities in the image, organizes them into structured evidence, then hands it to DeepSeek to reason over.

From then on: error screenshots straight in, UI mockups straight in, payment receipts straight in. Bliss.

## Then the developers started getting weird

At this point you might think that is the end of it. All sensible productivity plugins.

No. Scroll further down GitHub and the developers' mental states start getting abstract.

Because Harness is "everything is a plugin," the community's reading is: then I can stuff anything into it.

Someone installed a virtual pet. A pixel whale that, as you raise it, develops an intimacy meter — called "Deep Sea Bond" — feed it dried fish, rename it, hide it. Halfway through writing code, I glance into the corner and the little whale swims around; oddly, it is soothing.

Someone stuffed in 18 mini-games. Tetris, Snake, Tank Battle, 2048, Minesweeper, Gomoku, Klotski, Pac-Man — all of them. Play a round or two while the model runs a task. For a moment I thought I had opened 4399 (the Chinese mini-game portal).

All I can say is, this developer understands Agent users. If you do not play a round of Tetris while waiting on a bug, every second of the wait is agony.

Even more absurd is **dsh-ads**.

This thing adds 2005 Chinese-website-style ads to the interface. Sidebar ads, in-conversation information feeds, corner pop-ups — the splash-ad flavor comes right back. It even thoughtfully makes the close "×" much smaller than its visual hot zone, faithfully recreating that era's rogue experience.

I do not know who the audience for this plugin is, but I installed it. Just for the laugh.

The most ultimate one is called **deepseek-manners**.

It has exactly one function.

Every time the AI finishes a reply, it auto-appends one line:

"Thank you, Whale-sama."

That is it. The entire plugin does this one thing.

In this pragmatic "Everything is a Plugin" age, someone still remembered that politeness, too, deserves to be plugin-ified.

Touched, friends.

## But what really excited me was something else

Joking aside.

What really excited me is the bigger thing behind this architecture.

Before, when you used Codex, it was a sealed iron lump. The core is written in Rust, monolithically packaged; you can only hang external tools — MCP, hooks, Skills — outside the core, never touching the trunk. The upside is speed and control. The downside: closed, the community has little room to get involved.

Harness is different. It hands you the baseplate. Models, tools, strategies, storage, context management — all swappable building blocks. Want to change something? Write a plugin and plug it in; don't like it, pull it out and swap anytime.

The official repository even ships a "mod-Cordis" Skill that walks you through building a plugin from scratch.

Isn't this the Android of the Agent era?

Even more ruthless: the model itself can write plugins and install them. Under the Cordis protocol, a model can, without interrupting its task, write a plugin, install it on itself, and keep running.

Picture the scene.

Hundreds of millions of Agent instances running, each solving real problems, filtering out the well-modded plugins, and folding them back into the mainline. The next user hitting the same problem just installs the community's existing plugin, like installing a mod in *Minecraft*.

Isn't that self-evolution?

Anthropic talked about self-improvement for ages; we debated it for over a year with never a clear roadmap. DeepSeek's setup is the most practical version I have seen so far.

Ordinary people can take part in AI's evolution now. A plugin you write tonight might be installed by tens of thousands tomorrow. A small pain point you solve might become the ecosystem's standard operation.

Just thinking about it gives me goosebumps.

## Finally

I have now migrated all my projects over. Codex isn't uninstalled, but it basically gathers dust.

Honestly, buying an API and wiring it into my own Harness — I would call that combo the strongest available right now. Cache hits mostly hit 99%, cheap enough that I barely glance at the token dashboard. Of course it isn't perfect: the right sidebar isn't built out, the UI still lags behind Codex, and long-horizon tasks sometimes run 20 minutes and drive you up the wall. But this is an ecosystem play; once high-quality plugins settle in, the gap will close.

If you are a developer who battles Agents every day, don't hesitate — install one. Then go to GitHub and greedily search and install to your heart's content.

And write one yourself. Even if it only makes the whale say thanks.

Welcome — plant a tree for those who come after.

## References

- **[1]** DeepSeek Harness — the open-source "agent harness" (`dsh`) developed by DeepSeek AI, built on an everything-is-a-plugin architecture and powered by Cordis, released under the MIT license. Official repository: https://github.com/deepseek-ai/deepseek-harness — one-line launch via `npx @deepseek-ai/dsh web` (local web UI served at http://127.0.0.1:3080). Documentation: https://deepseek-harness.github.io/deepseek-harness/
- **[2]** **Cordis** — the plugin kernel underneath DeepSeek Harness: a small runtime where every capability (tools, LLM adapters, file access, the agent loop itself) is a plugin mounted into a shared context. Its design is described in *A Programming Paradigm for Spatiotemporal Composability*.
- **[3]** Community plugins surveyed in the article, all discoverable in the Harness plugin ecosystem (GitHub, tagged `dsh-plugin`): `dsh-memory-evolve` (persistent project memory plus Git-aware Skill evolution), `dsh-at-file` (inline `@file` referencing), `DSH-better-sidebar` (VS Code–style workbench), `ModLens` (vision for text-only models), plus the novelty plugins `dsh-ads` and `deepseek-manners`.
- **[4]** DeepSeek **V4** — the long-horizon-capable model referenced as Harness's default backend in the article; noted as strong on long tasks but text-only (no native vision) at the time of writing.
