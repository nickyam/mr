---
title: "The Quantum Sword, Honed by AI"
date: "2026-09-11T11:48:00+08:00"
author: "Nick Yam"
toc: true
categories:
  - "Crypto"
tags:
  - "BTC"
  - "Quantum"
  - "Security"
  - "AI"
url: "/Crypto/The-Quantum-Sword-Honed-by-AI.html"
---

Bitcoin continues to pull back toward $76k, with the market waiting for tonight's US CPI print. The threat quantum computing poses to Bitcoin — a sword that has hung overhead for a long time — has seen some fresh movement.

<!--more-->

## A Sword Hanging Overhead

The signature security of Bitcoin and Ethereum rests on elliptic curve cryptography. The private key you use to send a transaction corresponds to a public key that is broadcast on-chain. To steal coins, an attacker must derive the private key from the public key. This problem is known as the elliptic curve discrete logarithm problem, and classical computers solve it so slowly that it is hopeless — requiring more time than the age of the universe.

In 1994, mathematician Peter Shor proposed a quantum algorithm that can solve such problems in polynomial time. In other words, once a sufficiently powerful quantum computer exists, deriving the private key from the public key, forging signatures, and emptying wallets becomes nothing more than running a program. The industry calls the day a quantum computer truly gains this capability Q-Day.

When Q-Day arrives is still undecided. But one question can be worked out clearly right now: exactly how many resources does a single run of Shor's algorithm require?

## A Public Sword-Sharpening Contest

At the end of May this year, Eigen Labs launched a public challenge called ECDSA.Fail. More than a hundred participants had one task: design quantum circuits for the secp256k1 curve — the very curve used for Bitcoin and Ethereum signatures.[1]

A quantum circuit is the gate-level implementation of Shor's algorithm. To run Shor on a real quantum computer, it must first be compiled into a circuit built from individual quantum gates. The single most resource-hungry bottleneck across the whole pipeline is the elliptic curve point-addition operation. Because Shor's attack on the discrete logarithm centers on computing point multiplication — which in turn is composed of vast amounts of point addition and doubling — these reversible arithmetic circuits consume the overwhelming majority of qubits and gate resources. Point addition is the blade of the sword.

The challenge scored every circuit with the same formula: peak logical qubit count, multiplied by the average number of Toffoli gates executed. The former is the error-corrected qubit scale; the latter is an expensive and hard-to-prepare quantum operation. Their product is a composite measure of resources.

By the data cutoff on July 26, participants had driven this score down from 1.075 billion to 149.6 million — an 86.1% reduction. The best circuit used 1,151 logical qubits with roughly 1.3 million Toffoli gates. The paper notes this result sits more than half below the point-addition threshold previously published by Google Quantum AI, while also stating that the two sides used different counting methodologies and cannot be directly compared.[1]

## AI Empowerment

One striking aspect of this challenge was the involvement of AI.

First, the sharpeners. The paper's author list includes names familiar to the crypto world — Eigen Labs, the Ethereum Foundation, StarkWare, Trail of Bits, and the Ethereum Foundation's Justin Drake.[1] Most of those honing the blade are crypto-industry insiders. The motive is simple: to know how soon the enemy's sword can be forged, the best method is to first draw the blueprint for the enemy. Only by calculating the cost of an attack clearly does a defense timeline become meaningful.

Second, the tools for honing it. The paper names this practice "open automated research": participants, together with AI agents, iteratively generate, implement, test, and share candidate improvements, with validators acting as gatekeepers and a public leaderboard driving the race.[1] AI's role here is as an accelerator of the research process, multiplying the efficiency of the search for better circuits. In other words, what shaved off those 86% was not just over a hundred people, but also a tireless army of AI assistants.

## A Bucket of Cold Water

Do not rush to excitement or to fear. Four points:

First, the challenge measured only the single link of point addition, not a complete attack. The paper additionally constructed a version compatible with windowing methods, using 1,162 qubits and roughly 1.68 million Toffoli gates, with a measured success rate of about 99.81% — but the authors themselves state this belongs to a single-call sensitivity model, not an estimate of the full Shor algorithm's success rate. A real attack requires repeated calls, at a cost far exceeding this.

Second, in the benchmark there is a summand supplied classically; the interface alignment for a complete attack is still under discussion.

Third, comparisons with Google's numbers involve differing methodologies. The paper itself is very restrained, acknowledging only that its figure is lower, without claiming a formal surpassing.

Fourth, and most important: all of this still remains at the level of algorithm and circuit resource estimation. It has not broken any private key, nor has it built a quantum computer that can actually run. Between the on-paper resources and Q-Day lies the chasm of an entire hardware-engineering effort — and even the laws of physics.

## Why Pay Attention Now

Because migration is a slow undertaking, and the timeline is already counting down.

The US National Institute of Standards and Technology's NIST IR 8547 draft proposes gradually phasing out 112-bit security-level classical public-key algorithms after 2030, and prohibiting them after 2035. Ethereum has set December 2029 as a self-imposed deadline for implementing quantum resistance at the base layer. On the Bitcoin side, discussions around BIP-360 and BIP-361 have clearly accelerated this year; the latter plans a phased migration away from ECDSA and Schnorr signatures.[3] The US Department of Commerce has just finalized grants of up to $100 million each to Rigetti, D-Wave, and Quantinuum, while taking minority stakes in all three.[3] Galaxy Digital has pledged up to $5 million for related research, and nine institutions including BlackRock, Coinbase, and Strategy have jointly committed $15 million over three years to Bitcoin security research, including post-quantum defenses.[2]

And then there is that unavoidable number: millions of bitcoins sit in addresses whose public keys are already exposed, an estimated ~1 million of them belonging to Satoshi.[3] Migrating these coins is trickier than migrating any other asset.

## Always Be Prepared

Stances toward the quantum question easily fall into two extremes. One is alarmism — declaring every drop in resource estimates to be the sword of Damocles falling tomorrow. The other is head-in-the-sand denial — assuming Q-Day is so far off it has nothing to do with us.

Both are unwise. The professional approach is to treat it as a long race: the sword is being slowly honed, and the shield must be repaired in advance. The technical pathways for post-quantum migration, the standards timeline, and ecosystem coordination — these tasks are already underway, and progressing not slowly. For holders, what is worth watching is not some scary percentage, but whether the entire ecosystem can get the new signature algorithms ready and arrange the migration of old addresses before the hardware catches up.

Those who prepare in advance can face danger without fear, and remain calm and composed.

## References

- **[1]** Eigen Labs, "ECDSA.Fail" public challenge (May–July 2026) and its associated paper; participants include Eigen Labs, the Ethereum Foundation, StarkWare, Trail of Bits, and Justin Drake.
- **[2]** Galaxy Digital's research pledge, and the joint nine-institution ($15M / three-year) Bitcoin security commitment (BlackRock, Coinbase, Strategy, et al.).
- **[3]** NIST IR 8547 draft; Bitcoin BIP-360 / BIP-361 discussions; US Department of Commerce awards to Rigetti, D-Wave, and Quantinuum.
