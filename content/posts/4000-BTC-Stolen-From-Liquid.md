---
title: "Fortress Guarded, Yet 4,000 BTC Stolen"
date: "2026-09-10T23:20:00+08:00"
author: "Nick Yam"
toc: true
categories:
  - "Crypto"
tags:
  - "BTC"
  - "Liquid"
  - "Security"
  - "Sidechain"
url: "/Crypto/4000-BTC-Stolen-From-Liquid"
---

Bitcoin has been pulling back lately, with macro headwinds pushing it down to around $77k. A few days ago, something quietly unsettling happened on Liquid — Bitcoin's federated sidechain.

<!--more-->

## An Afternoon of Lost Coins

At 14:06 UTC on September 6, a peg-out redemption request appeared on Liquid block 4,050,349, asking the federation to release 3,996.01834922 BTC to a brand-new Bitcoin address[2]. Twenty-two minutes later, on Bitcoin block 965,783, a transaction with 83 inputs was confirmed — signed by more than 11 of the federation's 15 nodes[2]. That morning, the federation's Bitcoin treasury held roughly 4,200 BTC; after the transaction, only 197 remained[2].

That evening, the receiving address left a message on the Bitcoin chain: "we are whitehats, contact us on chain," and sent 1,000 satoshis to the federation's address to make sure the message was seen[2]. A "white hat" usually refers to someone who finds a vulnerability and chooses to disclose it rather than exploit it maliciously. Of course, this was merely the attackers putting a halo on themselves.

The next day, the attackers returned about 3,400 BTC, but kept roughly 600. Perhaps they considered that their fee for providing "professional services"?

## Three Lines of Defense

To understand what happened, you first need a rough grasp of how Liquid is designed.

Liquid is a Bitcoin sidechain launched by Blockstream in 2018. You lock BTC into a federation address and receive L-BTC, which circulates on the sidechain — a new block every minute. To withdraw, you burn L-BTC to initiate a peg-out, and the federation sends BTC to your address.

To prevent anyone from stealing the keys, Liquid built three lines of defense: an 11-of-15 multisig, where 15 companies each hold one key and 11 are needed to move funds; a PAK whitelist — the Peg-out Authorization Key — that only pays to registered addresses, with any change taking three days; and HSM hardware modules that only sign whitelisted addresses[2].

Each line was stricter than the last. Yet this time, all three waved it through normally. The federation's PAK whitelist was not bypassed, nor were the other mechanisms — every signature was genuine[1][2].

The problem lies precisely here. Every check asked the same question: was this redemption properly authorized? No one asked whether the L-BTC that was burned was ever supposed to exist in the first place.

The answer lies further upstream. Elements, the underlying software of Liquid — an open-source fork based on Bitcoin Core — appears to have a flaw in its range-proof verification cache, which let a batch of L-BTC that should never have existed be treated as real by the chain's consensus[3]. The coins came from nothing, yet when spent, they traveled through the most legitimate channel. Even SideSwap itself stated that these L-BTC came from a bug in Elements, not from SideSwap's own system[2].

In other words, the ledger miscalculated itself, conjuring up a batch of blank notes out of thin air. On the treasury side, the seals, signatures, and addresses were all in perfect order, so it released the goods as listed. Real gold went out; what came back was a stack of tickets that had sprung from nowhere on the ledger.

As for the exact vulnerability in Elements, Blockstream has yet to disclose specific technical details[2].

## Real Gold and Blank Notes

Compare BTC to gold, and L-BTC is a blank note. It is a negotiable instrument, a warehouse receipt that, in theory, can be redeemed at any time. The risk of paper gold is that the custodian issues more certificates than it has gold. This time, the hackers breached the note system, printed fake notes, and walked off with real gold.

As has been argued before: a system built on trust principles inevitably carries a trust-chain propagation problem — ultimately, a single small betrayal at the end of the chain is enough to collapse the whole thing.

Today's incident is another validation of the trust-chain principle. Except this time, what broke was the most hidden and least suspectable link in the chain — the correctness of the code.

## The Peril of the Trust Chain

What are you actually trusting when you hold L-BTC?

You must trust that Blockstream plays by the rules; trust that none of the 15 nodes lose their keys; trust that those HSM devices never malfunction; trust that the PAK whitelist is correctly designed; trust that SideSwap's redemption service is honest; trust that the code in Elements has no bugs; trust that Liquid's consensus rules always compute correctly; trust that none of the 80-plus federation members turn rogue; trust that if something goes wrong, someone will make it right and pay up; …

A nine-link chain, each link connected to the next. If any single link collapses, you may lose everything.

And BTC? You need trust no company, no institution, no person's promise. Every node verifies independently, and a block that violates consensus is simply discarded. Satoshi said: don't trust, verify. The object of your trust is not some specific person, but mathematics. Mathematics does not require your belief — you can compute it yourself.

This is the difference between real gold and a blank note. Real gold in your pocket requires trusting no one; a blank note demands trust from link one to link nine, and if even one link fails, the vault is empty.

## When Security Collapses

Cross-chain bridges, sidechains, and wrapped assets have been hot topics in the industry for years. They let the underlying asset step out and participate in a wider world. Yet each step outward adds another link of trust. The longer the chain, the more links, the greater the probability of collapse.

This does not mean sidechains are necessarily bad. The price of convenience is trust, and that trade-off must be calculated clearly. You may opt for convenience, but you should know exactly what you are giving up. The most precious thing about BTC has never been merely its price, but the fact that you can verify it yourself, without surrendering your trust.

The length of the trust chain is the fundamental measure of an asset's security. As for whether Liquid's treasury will ever get back the remaining ~600 BTC, that depends on how the subsequent negotiations between Blockstream and the attackers unfold.

Stop staring only at bull and bear markets. First take a look at what's in your hand — real gold, or a blank note?

## References

- **[1]** Liquid Network federation model — the 11-of-15 functionary multisig, the PAK (Peg-out Authorization Key) whitelist, and HSM-signed withdrawals. Incident analyses noting that all signatures were valid and no key was compromised.
- **[2]** On-chain evidence: Liquid block 4,050,349 (peg-out request for 3,996.01834922 BTC), Bitcoin block 965,783 (83-input transaction signed by 11+ of 15 federation nodes), the "we are whitehats" message and 1,000-sat return; plus SideSwap's statement attributing the L-BTC to an Elements bug.
- **[3]** Elements — Blockstream's open-source fork of Bitcoin Core — and its range-proof verification; a suspected cache flaw; Blockstream had not published specific technical details as of the article date.
