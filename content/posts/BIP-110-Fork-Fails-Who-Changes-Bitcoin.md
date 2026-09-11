---
title: "BIP-110 Fork Fails: Who Has the Right to Change Bitcoin?"
date: "2026-08-11T09:00:00+08:00"
author: "Nick Yam"
toc: true
categories:
  - "Crypto"
tags:
  - "BTC"
  - "BIP-110"
  - "Governance"
  - "Fork"
url: "/Crypto/BIP-110-Fork-Fails-Who-Changes-Bitcoin.html"
---

At 00:00 Beijing time on August 9, Bitcoin reached block height 961,632 and BIP-110 entered its mandatory signaling period. Nodes running the BIP-110 rules began rejecting any block that did not set version bit 4, and split away from the mainnet. The BIP-110 branch then produced only two blocks before stalling, while the mainnet kept producing blocks as usual. In the previous difficulty-adjustment window, only 51 blocks had carried a support signal — 2.53%, far below the 55% voluntary early-lock-in threshold the proposal required. In other words, BIP-110 never won broad miner support and ultimately became a minority chain with almost no hashrate.

## TL;DR

- BIP-110 sought to raise the cost of large, continuous on-chain data writes — such as Ordinals inscriptions — through temporary consensus limits.
- During the voluntary early-lock-in phase, it received signals on only 51 blocks (2.53% support), far below the 55% threshold.
- After entering the mandatory signaling period, the supporters' minority chain produced just two blocks before stalling; as a network-wide consensus upgrade, BIP-110 has effectively failed.
- Disputes over on-chain data, protocol neutrality, and development governance will continue; because the fork chain lacks replay protection, ordinary holders should not move or trade related assets hastily.

## What BIP-110 Set Out to Fix

BIP-110 — short for "Reduced Data Temporary Softfork" — was submitted by the pseudonymous developer Dathon Ohm, with early drafting input from Luke Dashjr[1]. The proposal planned to add seven consensus limits over roughly a year: capping ordinary new output scripts at 34 bytes, capping new output scriptPubKeys whose first opcode is OP_RETURN at 83 bytes, capping various data pushes and witness-stack elements at 256 bytes, and restricting parts of Taproot.

Its goal was not to ban on-chain data outright — the proposal itself admits data can still be split or disguised — but to raise the cost and difficulty of large, continuous writes such as Ordinals inscriptions. BIP-110's text states explicitly that it does not address "non-Bitcoin tokens," arguing such issues are better handled at the policy layer. UTXOs created before activation could still be spent under the old rules, though the proposal concedes that a very small number of cases using pre-signed Taproot transactions or special Miniscript structures could be affected.

The direct backdrop to this dispute was Bitcoin Core 30.0, released in October 2025, which raised the default `-datacarriersize` from 83 bytes to 100,000 bytes, substantially loosening the default OP_RETURN relay limit[2]. Note that Core 30 changed node transaction-relay and block-template policy, not Bitcoin consensus; BIP-110, by contrast, tried to push the limit into the consensus layer, so that blocks containing the relevant transactions would be judged invalid by nodes running the new rules.

## Timeline: From Proposal to Fork

- **Oct 10, 2025:** Bitcoin Core 30.0 released, loosening the default OP_RETURN relay policy.
- **Oct 24, 2025:** First draft of BIP-110 formed; it officially received the BIP-110 number on Dec 3.
- **Jan 28, 2026:** The official activation client's first production release, v0.1, shipped (code based on Bitcoin Knots). Several candidate versions had been released earlier.
- **Mar 1, 2026:** Barefoot Mining produced the first BIP-110 signaling block via OCEAN.
- **Mar 10, 2026:** Official activation client v0.4.1 published on GitHub; Dathon Ohm publicly announced it on X on Mar 13.
- **Mar 31, 2026:** Dathon Ohm posted a project update on Delving Bitcoin and announced two implementation PRs submitted to Bitcoin Core; the PRs were later auto-closed and never merged.
- **Jun 25, 2026:** BIP-110 status changed to Complete. This status only means the author considers the specification finished and recommends adoption — not that the Bitcoin network has accepted the proposal[3].
- **July 2026:** The dispute erupted. Michael Saylor, Adam Back, and PlanB publicly opposed it; OCEAN became the main signal source, but overall miner support stayed low. OCEAN also upgraded its backend to record and settle rewards for the two chains separately after the fork. Ordinals supporter Leonidas announced "DOG Mode," proposing to loosen node relay rules — the opposite direction from BIP-110[5].
- **Aug 9, 2026 (Beijing time; Aug 8 UTC):** The mandatory signaling period began at block 961,632. An unsignaled block mined by AntPool was accepted by the mainnet but rejected by BIP-110 nodes; miners using OCEAN produced replacement blocks on the minority chain. The branch stopped advancing after producing the block at height 961,633[4].
- **Aug 9–10:** Roughnecks, which had mined the two minority-chain blocks, announced it would stop mining under that organization's name and advised miners still using the existing PoW algorithm to pause participation. Some supporters began discussing switching the branch chain to a different PoW algorithm — another rules change beyond the original proposal. Meanwhile, in the Bitcoin BIPs repository, a proposal appeared to change BIP-110's status from `Complete` to `Deployed`, then to `Closed`. As of publication, the relevant PRs remained unmerged and the official BIP-110 page still showed `Complete`; regardless of how the repo labels it, that does not mean BIP-110 has activated on the Bitcoin mainnet.

## What the Two Sides Are Actually Fighting About

Supporters argue that miners collect a transaction fee only once, yet every fully validating node must download and verify the relevant blocks; unpruned nodes must store historical blocks long-term and may serve them to other nodes. Large non-financial data also competes with payment transactions for block space, raising the cost of ordinary transfers. Dathon Ohm and Luke Dashjr therefore contend that users and nodes have the right to define, via a user-activated soft fork, the rules they accept — and that miner signaling is not the sole deciding factor. OCEAN's preparation to settle the two chains separately also reflects that it did not assume all participants would automatically choose the same rules.

Opponents' key argument is not whether Ordinals has value, but whether consensus should be changed to restrict a usage that is unpopular yet currently consensus-compliant and fee-paying. Saylor's repeated statements boil down to three points: Bitcoin cannot judge the purpose of data; disputes should be handled by the fee market and by node and miner policy; changing consensus over a short-term dispute could weaken transaction freedom and the long-term fee market, and set a precedent that excludes other legitimate uses. He likens consensus rules to a constitution, arguing that BIP-110's "cure is more dangerous than the disease."

Adam Back called BIP-110 an attempt to "regulate others," conflicting with Bitcoin's decentralized, permissionless principles, and predicted early on that the minority chain would stall from lack of hashrate. PlanB, from the standpoint of bearer assets and historical experience, argued the supporters had not understood Bitcoin's nature as a decentralized bearer asset, nor learned the lessons of the Bitcoin Cash fork.

Leonidas's DOG Mode represents the other end: it does not modify consensus but plans to relax node relay policy, raising the standard-transaction cap from 400,000 WU to 3,900,000 WU and lowering the dust limit to 1 sat. The aim is to expand propagation space for data transactions such as Ordinals and Runes. Because it touches only the policy layer, it theoretically requires no network-wide coordinated upgrade; but as of its announcement, no public code repository or formal release was available for review.

## What Happens Next

From the current outcome, BIP-110 has effectively failed as a network-wide Bitcoin consensus upgrade. The minority chain inherited the mainnet's mining difficulty of about 127.48 T but has almost no hashrate. Unless it suddenly gains massive miner support or switches PoW rules, it will struggle to complete the next 2,016-block difficulty adjustment, let alone reach its intended lock-in and activation heights.

Saylor estimated that about 99.85% of Bitcoin's hashrate remains on the main chain, and that at the minority chain's roughly 0.15% hashrate, the first difficulty adjustment could take about 25 years[6]. This is Saylor's personal estimate based on hashrate ratios, not an actual measurement; but Roughnecks's subsequent halt further weakened the branch's prospects.

Still, BIP-110's failure does not mean the dispute is over. The more likely follow-up is that the anti-on-chain-data side returns to node relay policy, miner block templates, and narrower technical proposals, while the Ordinals camp continues pushing looser relay schemes like DOG Mode. If consensus change is attempted again, the proposers will need to demonstrate not just node counts, but the broad economic coordination formed by miners, exchanges, wallets, custodians, and users.

For ordinary holders, the short-term risk mainly comes from the minority chain's lack of built-in replay protection. Bitcoin developer Kevin Loaec and hardware-wallet maker Ledger both warned that, while both chains still accept the same signed transactions, a sale or transfer of fork coins could be replicated on the Bitcoin mainnet, causing the corresponding BTC to be sent out as well[6]. Users unfamiliar with coin-splitting are safest simply not moving or trading the branch's assets.

The dispute has also spilled into development governance. F2Pool co-founder Wang Chun sharply criticized Luke Dashjr; former Kraken market lead Dan Held argued BIP-110 was flawed in both technical design and game-theoretic mechanics, and criticized its supporters for pushing the proposal through emotion and moral pressure.

BIP editor Murch also proposed removing Luke Dashjr from his BIP editor role. He accused Luke of attempting to publicly assign a BIP number before the proposal had been discussed on the mailing list, and of merging an update PR minutes after it was created — concluding that Luke's use of editor privileges did not conform to established process. Luke responded that the accusations were untrue and said he had consistently followed BIP process for years. The PR to remove his editor role remains open and unmerged.

BIP-110 ultimately resembles a governance stress test: nodes can of course choose to enforce their own rules, but whether a UASF can change Bitcoin depends on whether it gains sufficiently broad economic support. Without such coordination, mandatory signaling does not automatically create consensus — it merely carries the supporters onto an isolated chain.

## A Thought

Actually, the most interesting question in all this is: who actually has the power to modify Bitcoin?

The answer is that no one truly holds that power. Anyone can write a BIP, or build their own client, and declare: "Starting from some block, I will only recognize blocks that comply with this new set of rules." But making that declaration does not mean Bitcoin has actually changed. A BIP getting a number does not count; the code being written does not count; even a group of developers supporting it does not count. What matters is whether others follow you.

BIP-110 is exactly this kind of case. After supporters reached the agreed block height, they began rejecting blocks that did not comply with BIP-110 rules. But the vast majority of miners simply ignored them and kept mining by the original rules, so the Bitcoin mainnet kept moving forward normally. BIP-110's supporters could of course say, "I don't recognize the blocks you mined." The problem is, others can also choose not to recognize yours. The result: the overwhelming majority of hashrate, exchanges, wallets, and users stayed on the original Bitcoin, while you ran off to a chain almost no one was mining — which produced two blocks and then basically stopped. You did not successfully modify Bitcoin; you merely forked yourself off.

Of course, this does not mean miners have the final say either. If one day a large number of users, exchanges, wallets, and custodians all say, "We only recognize BTC under the new rules," then even if miners are initially reluctant, they may be forced to follow, because miners ultimately mine to make money. What truly determines Bitcoin's rules is not any single formal vote, nor any committee, but how many people are ultimately willing to follow you.

So BIP-110 actually demonstrates, quite intuitively, how Bitcoin is governed: anyone can propose changing the rules, anyone can reject others' rules, but no one can command the entire network to accept their own rules. Whether you can truly change Bitcoin does not come down to whether you wrote a BIP, but to whether miners, nodes, exchanges, wallets, and users can form a sufficiently broad consensus. Without that consensus, your so-called "modification of Bitcoin" will most likely just create another chain that no one uses.

## References

- **[1]** BIP-110 ("Reduced Data Temporary Softfork") — authored by pseudonymous developer Dathon Ohm with early input from Luke Dashjr; seven proposed consensus limits on output size, OP_RETURN, data pushes, and Taproot; the text acknowledges it does not address "non-Bitcoin tokens."
- **[2]** Bitcoin Core 30.0 (released Oct 10, 2025) raised the default `-datacarriersize` from 83 to 100,000 bytes — a relay / mempool policy change, not a consensus change.
- **[3]** BIP-110 activation client: v0.1 production release (Jan 28, 2026, based on Bitcoin Knots) and v0.4.1 (Mar 10, 2026); Dathon Ohm's X announcement (Mar 13); Delving Bitcoin update (Mar 31) with two Bitcoin Core PRs (auto-closed, never merged); status set to Complete (Jun 25, 2026).
- **[4]** Fork event: mandatory signaling began at block 961,632 (Aug 9 Beijing / Aug 8 UTC); AntPool's unsignaled block accepted by mainnet, rejected by BIP-110 nodes; Roughnecks mined two minority-chain blocks (through height 961,633) then stopped (Aug 9–10).
- **[5]** Opposition: Michael Saylor, Adam Back, PlanB (July 2026); OCEAN as main signal source; Leonidas's "DOG Mode" (raises standard-tx cap 400k → 3.9M WU, dust to 1 sat; policy-layer only, no code released as of announcement).
- **[6]** Post-fork analysis: Saylor's estimate of ~99.85% main-chain hashrate / ~0.15% minority (≈ 25 years to first difficulty adjustment); replay warnings from Kevin Loaec and Ledger; F2Pool's Wang Chun and Dan Held criticize Luke Dashjr / BIP-110; BIP editor Murch's open PR to remove Luke Dashjr as BIP editor.
