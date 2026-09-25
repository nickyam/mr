---
title: "BIP-110 Fork Fails: Who Has the Right to Change Bitcoin?"
date: "2026-08-11T09:00:00+08:00"
author: "Nick Yam"
toc: true
categories:
  - "Crypto"
tags:
  - "BTC"
  - "Governance"
  - "Ordinals"
  - "Softfork"
url: "/Crypto/BIP-110-Fork-Fails-Who-Can-Change-Bitcoin"
aliases:
  - "/Crypto/BIP-110-Fork-Fails-Who-Changes-Bitcoin.html"
---

**TL;DR**

- BIP-110 sought to raise the cost of writing large volumes of contiguous data — Ordinals inscriptions and the like — through a temporary consensus restriction.
- In the voluntary early-lock-in phase, the proposal drew signals from only 51 blocks — 2.53% support — far below the 55% threshold.
- Once the mandatory signaling period began, the minority chain formed by supporters produced just two blocks before stalling; BIP-110 is effectively dead as a network-wide consensus upgrade.
- The debate over on-chain data, protocol neutrality, and development governance will continue; and because the forked chain lacks replay protection, ordinary holders should not rush to move or trade related assets.

In the early hours of August 9, Beijing time, Bitcoin reached block height 961,632 and BIP-110 entered its mandatory signaling period. Nodes running BIP-110 rules began rejecting blocks without version bit 4 set, splitting off from the mainnet. Thereafter, the BIP-110 branch produced only two blocks before stalling, while the mainnet kept producing normally. Over the preceding difficulty-adjustment period, only 51 blocks had signaled support — 2.53% — far below the proposal's 55% voluntary early-lock-in threshold. BIP-110 thus never won broad miner support, and ultimately formed a minority chain with negligible hashpower.

## What BIP-110 Tries to Solve

BIP-110, short for "Reduced Data Temporary Softfork," was submitted by pseudonymous developer Dathon Ohm, with Luke Dashjr advising on an early draft. The proposal planned to add seven consensus restrictions over roughly a year, including limiting ordinary new output scripts to 34 bytes, capping new output scriptPubKeys whose first opcode is OP_RETURN at 83 bytes, restricting several categories of data pushes and witness-stack elements to 256 bytes, and constraining some Taproot features.

Its goal was not to ban on-chain data outright — the proposal itself concedes data can still be split or disguised — but to raise the cost and difficulty of writing large, contiguous data such as Ordinals inscriptions. The BIP-110 text states explicitly that it does not address "non-Bitcoin tokens," holding that such matters are better handled at the policy layer. UTXOs created before activation can still be spent under the old rules, but the proposal acknowledges that a small number of cases using pre-signed Taproot transactions or special Miniscript structures could be affected.

The immediate backdrop to this controversy was Bitcoin Core 30.0, released in October 2025, which raised the default `-datacarriersize` from 83 bytes to 100,000 bytes, substantially loosening the default OP_RETURN relay limit. Note that Core 30 changed node transaction-relay and block-template policy, not Bitcoin consensus; BIP-110, by contrast, sought to elevate the restriction to the consensus layer, so that blocks containing the relevant transactions would be judged invalid by nodes enforcing the new rules.

## Timeline: From Proposal to Fork

- **October 10, 2025:** Bitcoin Core 30.0 is released, loosening the default OP_RETURN relay policy.
- **October 24, 2025:** The first BIP-110 draft takes shape; it is formally assigned the number BIP-110 on December 3.
- **January 28, 2026:** The official activation client releases its first production version, v0.1, based on Bitcoin Knots. Several release candidates had come before it.
- **March 1, 2026:** Barefoot Mining, via OCEAN, produces the first signaling block in support of BIP-110.
- **March 10, 2026:** The official activation client v0.4.1 is released on GitHub; Dathon Ohm announces it publicly on X on March 13.
- **March 31, 2026:** Dathon Ohm posts a project update on Delving Bitcoin and announces two implementation PRs submitted to Bitcoin Core; the PRs are subsequently closed automatically, without being merged by Core.
- **June 25, 2026:** BIP-110's status is changed to Complete. That status only means the author considers the specification finished and recommends adoption — it does not mean the Bitcoin network has accepted the proposal.
- **July 2026:** Controversy erupts. Michael Saylor, Adam Back, PlanB and others publicly oppose it; OCEAN becomes the main source of signals, but overall miner support stays low throughout. OCEAN also upgrades its backend, preparing to record and settle the rewards of the two chains separately once the fork happens. Ordinals advocate Leonidas announces DOG Mode, proposing to loosen node relay rules — the opposite direction from BIP-110.
- **August 9, 2026, Beijing time (August 8 UTC):** The mandatory signaling period begins at block 961,632. A non-signaling block produced by AntPool is accepted by the mainnet and rejected by BIP-110 nodes; miners using OCEAN produce a replacement block on the minority chain. That branch stops advancing after producing the block at height 961,633.
- **August 9–10:** Roughnecks, which mined the minority chain's two blocks, announces it will stop mining under that organization's name and advises miners continuing with the existing PoW algorithm to pause participation. Some supporters begin discussing switching the branch chain to a different PoW algorithm — which would be yet another rule change beyond the original proposal. Proposals also appear in the Bitcoin BIPs repository to change BIP-110's status from `Complete` to `Deployed` and then to `Closed`. As of publication the relevant PR had not been merged, and the official BIP-110 page still showed `Complete`; however the repository labels are handled, it does not mean BIP-110 has been activated on the Bitcoin mainnet.

## What the Two Sides Are Actually Arguing About

Supporters argue that miners collect the transaction fee only once, yet every full validating node must download and verify the relevant blocks; nodes without pruning enabled must also store historical blocks long-term and may serve that data to other nodes. Large volumes of non-financial data also compete with payment transactions for block space, raising costs for ordinary transfers. Dathon Ohm and Luke Dashjr therefore contend that users and nodes have the right to define, through a user-activated softfork, the rules they accept, and that miner signaling is not the sole determinant. OCEAN's preparation to settle the two chains separately also reflects that it did not assume all participants would automatically choose the same set of rules.

Opponents' central argument is not whether Ordinals have value, but whether consensus may be changed in order to restrict a use that is unpopular yet currently rule-compliant and fee-paying. Saylor's repeated statements boil down to three points: Bitcoin cannot judge the purpose of data; the dispute should be handled by the fee market and by node and miner policy; and changing consensus to settle a short-term dispute could weaken transactional freedom and the long-term fee market, setting a precedent for excluding other legitimate uses. He compares consensus rules to a constitution, calling BIP-110's "solution more dangerous than the problem."

Adam Back calls BIP-110 an attempt to "police other people," arguing it conflicts with Bitcoin's decentralized, permissionless principles, and predicting in advance that the minority chain would stall from lack of hashpower. PlanB, reasoning from bearer assets and historical experience, argues that supporters misunderstand Bitcoin's nature as a decentralized bearer asset and have not learned the lessons of the Bitcoin Cash fork.

Leonidas's DOG Mode represents the other pole: it does not touch consensus, but plans to loosen node relay policy — raising the standard transaction limit from 400,000 WU to 3,900,000 WU and lowering the dust limit to 1 sat. The proposal aims to widen the propagation space for data transactions such as Ordinals and Runes. Because it concerns only the policy layer, it theoretically requires no network-wide upgrade; but as of the announcement, the project had not released a code repository or formal version open to public review.

## Where It Goes From Here

Judging by the current outcome, BIP-110 has effectively failed as a network-wide Bitcoin consensus upgrade. The minority chain inherited the mainnet's difficulty of roughly 127.48 T yet commands only a trickle of hashpower. Unless it suddenly wins large-scale miner support or switches its PoW rules, it will struggle to complete the next 2,016-block difficulty adjustment — let alone reach its originally planned lock-in and activation heights.

Saylor estimates that about 99.85% of Bitcoin's hashpower remains on the main chain, and says that at the minority chain's roughly 0.15% hashrate, completing its first difficulty adjustment could take about 25 years. That is Saylor's personal estimate based on hashrate ratios, not a measured result; but Roughnecks' subsequent halt further weakens the branch's prospects of continuing.

That said, BIP-110's failure does not mean the controversy is over. The likelier sequel is that the anti-on-chain-data camp shifts back to node relay policy, miner block templates, and narrower technical proposals, while the Ordinals camp keeps pushing looser relay schemes like DOG Mode. If a consensus change is attempted again, the proposers will need to demonstrate not only node counts but broad economic coordination across miners, exchanges, wallets, custodians, and users.

For ordinary holders, the near-term risk comes mainly from the minority chain's lack of built-in replay protection. Bitcoin developer Kevin Loaec and hardware-wallet maker Ledger both warn that while the two chains still accept the same signed transactions, a transaction selling or moving forked coins could be replayed onto the Bitcoin mainnet, taking the corresponding BTC with it. For users unfamiliar with splitting coins, the safest course remains not moving and not trading that branch's assets.

The dispute has also spilled into development governance. F2Pool co-founder Wang Chun made sharp criticisms of Luke Dashjr; former Kraken market head Dan Held argues BIP-110 is flawed in technical design and game mechanics, and criticizes its supporters for pushing the proposal with emotion and moral pressure.

BIP editor Murch has also proposed removing Luke Dashjr from his BIP editor role. He alleges that Luke tried to publicly assign a BIP number before the proposal had been discussed on the mailing list, and merged an update PR minutes after it was created, concluding that Luke's use of editorial privileges did not follow established process. Luke responded that the allegations were false and that he had followed BIP process consistently for years. The PR to remove him remains open and unmerged.

In the end, BIP-110 looks more like a governance stress test: nodes can of course choose to enforce their own rules, but whether a UASF can change Bitcoin depends on whether it can win sufficiently broad economic support. Without that coordination, mandatory signaling does not create consensus on its own — it merely leads supporters onto an isolated chain.

## A Closing Thought

The most interesting question here is this: who, after all, has the right to change Bitcoin?

The answer is that no one really does. Anyone can write a BIP, build their own client, and declare: "From such-and-such a block, I will only recognize blocks that comply with this new ruleset." But making that declaration does not mean Bitcoin has actually changed. A BIP being numbered does not count; code being written does not count; even a group of developers supporting it does not count. What matters is whether others follow you.

BIP-110 is a case in point. After reaching the agreed block height, supporters began rejecting blocks that did not comply with BIP-110 rules. But the overwhelming majority of miners ignored them, kept mining under the old rules, and the Bitcoin mainnet kept running normally. BIP-110's supporters could of course say, "We don't recognize the blocks you mined." The problem is that others can equally refuse to recognize yours. The result: the vast majority of hashpower, exchanges, wallets, and users stayed on the original Bitcoin, while the supporters ran off to a chain almost no one was mining and stopped after two blocks. They did not successfully change Bitcoin — they merely forked themselves off.

Of course, this does not mean miners are in charge either. If one day a large number of users, exchanges, wallets, and custodians all said, "We only recognize BTC under the new rules," then even if miners were initially unwilling, they might be forced to follow — because miners ultimately mine to make money. What truly decides Bitcoin's rules is not any single formal vote, nor any committee, but simply how many people are ultimately willing to follow along.

So BIP-110 actually illustrates, quite vividly, how Bitcoin is governed: anyone can propose a rule change, anyone can reject another's rules, but no one can command the entire network to accept their own. Whether you can truly change Bitcoin ultimately depends not on whether you have written a BIP, but on whether miners, nodes, exchanges, wallets, and users can form a sufficiently broad consensus. Absent that consensus, your so-called "changing Bitcoin" most likely just creates another chain no one uses.

## References

- **[1]** BIP-110, "Reduced Data Temporary Softfork" — submitted by pseudonymous developer Dathon Ohm, with Luke Dashjr advising on the early draft; the seven proposed consensus restrictions and the 55% voluntary early-lock-in threshold.
- **[2]** Bitcoin Core 30.0 (October 2025) — raised the default `-datacarriersize` from 83 bytes to 100,000 bytes; and the on-chain timeline: block height 961,632 entering the mandatory signaling period on August 9, 2026 (Beijing time), the 51 signaling blocks (2.53%), and the two-block minority chain at height 961,633.
- **[3]** Public statements by Michael Saylor, Adam Back, PlanB, Leonidas (DOG Mode), OCEAN and Roughnecks; and the BIPs-repository proposals to change BIP-110's status from `Complete` to `Deployed` / `Closed`.
- **[4]** Governance dispute: F2Pool co-founder Wang Chun, Dan Held, and BIP editor Murch's proposal to remove Luke Dashjr as BIP editor — and Luke's response.
- **[5]** Replay-protection warnings from Bitcoin developer Kevin Loaec and hardware-wallet maker Ledger regarding the forked chain.
