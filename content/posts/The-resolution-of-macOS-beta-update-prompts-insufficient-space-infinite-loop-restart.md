---
title: "The resolution of macOS beta update prompts insufficient space, infinite loop restart"
date: "2019-05-10T10:00:00+08:00"
author: "Nick Yam"
toc: true
categories:
  - "Tech"
tags:
  - "Mac"
  - "Apple"
url: "/Tech/The-resolution-of-macOS-beta-update-prompts-insufficient-space-infinite-loop-restart.html"
---

Before going out this morning, I downloaded the new macOS Catalina beta system and let it update itself. When I came back in the afternoon, I found that the system update failed, indicating that the storage space was insufficient. I encountered this situation in the past, I restarted the computer and entered the old system, and then re-updated after setting some space free.

However this time things are different. On the one hand, I still have 20GB of free hard disk space before the update. According to common sense, I should not be prompted for insufficient space. On the other hand, I could not enter the old system after the update fails. I updated the system in an infinite loop, and the update fails.

<!--more-->

How to solve this problem and enter the old system?

The first step, I passed the option guidance system selection, tried to enter the old systems. But halfway through the progress bar, the screen flickered and the screen went black. Suspected hardware problems.

In the second step, I am going to check if there is any problem with the hardware. Because my computer installed `Boot Camp`, so I passed option into the Windows 10 system selection, everything is normal. In this system, I set up 35GB of space, and the remaining space is 4.65GB. Therefore, it can be determined that the hardware is basically normal.

The third step is also a more critical step. I entered the recovery system via `command` + `r`. Because of my lack of space has been identified as the primary partition, so I chose the utility disk tool, erased `Boot Campdisk` and merged it into the primary partition. In this way, I have more than 50GB of free disk space, which is enough to update.

My only worry is that after reinstalling macOS in the recovery system interface, my personal data may be completely erased. Fortunately, after nearly an hour of updating and waiting, I entered the familiar interface and new operating system.

In this way, I solved the problem mentioned in the title, but sacrificed a system that is not commonly used. It's a pity, but it's a blessing in misfortune.

Record it for your reference.