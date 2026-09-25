---
title: 'Out of Disk Space? Turn Telegram into a Mountable "Unlimited Cloud Drive" with CyDrive'
date: "2026-09-13T22:45:00+08:00"
author: "Nick Yam"
toc: true
categories:
  - "Tech"
tags:
  - "Telegram"
  - "Cloud Storage"
  - "WebDAV"
url: "/Tech/CyDrive-Telegram-Cloud-Drive"
---

![CyDrive — mount Telegram as a cloud drive](https://img.nickyam.com/file/AgACAgUAAyEGAASS2zT1AAEBgdJqprhpoU4zpwABmG2HdTfPT7k724EAAroWaxu4lTFVZ-2LQE8oMz0BAAMCAAN5AAM9BA.png)

A while back I was sorting through photos and videos from my camera, and my C: drive immediately turned red. Digging out an external hard drive felt like a chore, and every cloud-storage option either throttles your speed or bills you by the year. Finding a home for tens or hundreds of gigabytes always stings.

Then I remembered a fact most people overlook: Telegram itself gives you practically unlimited cloud space, for free. The catch is that it's hidden inside a chat app — you can't just drag files into it the way you would a hard drive.

That's where I ran into **CyDrive**. What it does is straightforward: it wraps Telegram's servers into a network drive you can see right inside Windows File Explorer (default letter Y:). Drop a file into the Y: drive and it uploads silently in the background; double-click to open it and it pulls the file back from the cloud. Your local disk only acts as a courier stop for a few seconds, then clears itself out.

In plain terms, it borrows Telegram's free servers as your personal cloud drive, leaving almost no footprint on your machine.

## How it reaches "zero local footprint"

The mechanism isn't complicated. CyDrive runs a local service that maps Telegram's cloud as a WebDAV network drive.

- **On write:** when you drop a file into Y:, it caches locally for a moment, pushes it to the cloud through a Telegram bot right away, then deletes the local copy once the upload finishes. So the bytes your disk holds long-term stay close to zero.
- **On read:** double-click a file and it fetches it on demand from Telegram — streaming as it goes, rather than pulling the whole package back first.
- **On send-back:** message a file to the bot from your phone and, within seconds, it shows up in the Y: drive on your computer and in the web panel.

One thing to flag: Telegram is blocked in mainland China, so this whole setup depends on your network — you need a way to reach Telegram for any of it to work. More on that below.

## What made me keep it

**1. Mounts as a real drive, no driver to install**
It uses the standard WebDAV protocol, so File Explorer simply gains an extra Y: drive. No kernel-level driver is touched, and removing it is clean. Linux and macOS are supported as well.

**2. Uploads and downloads feel invisible**
Sync is built on watchdog event listening rather than naive polling, so idle CPU usage is nearly unnoticeable. It also runs an `is_file_ready` stability check to stop you from opening a file before its upload has finished.

**3. A web panel that plays your media directly**
It serves a local admin dashboard (default port 8088, cyberpunk-style UI) with drag-and-drop upload, live search, and in-browser streaming for MP4 / MP3 / FLAC / images — no need to download first.

**4. Hundreds of thousands of files without lag**
Metadata lives in SQLite with WAL mode, recording the folder structure, each file's SHA-256 hash, and the matching Telegram message ID in a hierarchy. The project claims millisecond-level search across hundreds of thousands of files.

**5. Large files are chunked automatically**
Files over 2GB are split into smaller pieces on upload and merged seamlessly on download, so in theory there's no upper limit on single-file size.

**6. Encrypt if you're worried about exposure**
It supports AES-256-GCM zero-knowledge encryption, so files are encrypted before they ever leave your machine — Telegram only ever stores ciphertext.

**7. Grab files remotely from your phone**
Send commands to the linked bot to drive it: `/stats` for usage, `/search <filename>` to look things up, `/get <filename>` to push the file straight to your phone.

## How to get it running

Prerequisites (all inside Telegram, all free):

1. Find `@BotFather`, create a bot, and copy the **Token**.
2. Find `@userinfobot` to get your **Chat ID**.
3. Open the new bot's chat and tap **Start**.

Then clone and run it:

```bash
git clone https://github.com/thecynetx/CyDrive.git
cd CyDrive
pip install -r requirements.txt
python main.py
```

On first launch it walks you through the Token, Chat ID, and the drive letter you want. If you're running it as a persistent service on a Linux server, set up a `venv` first.

## A few gotchas, up front

- **Single-file cap:** Telegram's Bot API limits a single file to 2GB by default (4GB with Premium). Oversized files get around this via the chunking above, but under the hood it's still sliced uploads.
- **Windows' built-in 50MB wall:** Windows' WebClient service caps WebDAV single files at 50MB by default. Run the project's `fix-reg` to patch the registry before transferring large files.
- **Terms and risk:** Telegram's ToS isn't really about using chats as storage, and bulk-stuffing lots of non-chat files risks throttling or even a ban. Encrypt anything sensitive, and don't treat it as the only safe copy of data you can't afford to lose.
- **Network prerequisite:** again, Telegram isn't reachable directly from mainland China — solve "being able to connect" first, or the whole approach is moot.
- **Where it lives:** files ultimately sit on Telegram's servers, so availability depends on Telegram itself. If you're offline or your account hiccups, you can't get them back.

## Who it's for

If you're fighting local disk capacity but don't want to keep paying for cloud-storage subscriptions — and you already have an environment that reaches Telegram normally — CyDrive is a neat trick: repurpose a chat app as an on-demand cloud drive that doesn't eat your local space.

But treat it as elastic staging or cold backup, not your sole data safe. The project is built by the Cynet Security Team under the MIT license; the source is at `https://github.com/thecynetx/CyDrive`.

## References

- **[1]** CyDrive — source repository on GitHub: https://github.com/thecynetx/CyDrive
