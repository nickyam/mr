---
title: "< On-Chain Voting > A Documentation of Social Contracts"
date: "2023-05-27T18:12:41+08:00"
author: "Nick Yam"
toc: true
categories:
  - "Crypto"
tags:
  - "Voting"
url: "/Crypto/On-Chain_Voting_A_Documentation_of_Social_Contracts.html"
---

![](https://telegraph-image.pages.dev/file/5f50b3ff760d1243ef0c0.jpg)

The discussion in this article is not about using blockchain as a voting technology to fulfill certain voting requirements in the external world, such as conducting elections for a state governor in the United States on the blockchain or creating prediction markets where people can vote on whether the US will default on its debt or reach an agreement at the last moment to avoid default. These examples merely utilize blockchain to facilitate voting on external matters. The focus of this article is on the issue of decentralized organizations conducting on-chain voting themselves, which may involve a blockchain-based DAO voting on governance proposals or even governing the blockchain itself.

<!--more-->

The key distinction here is reflexivity.

In the latter scenario, voting as a means of collective governance has a feedback effect on itself.

Initially, in the Bitcoin whitepaper, Satoshi Nakamoto discussed the concept of Proof of Work, stating that the essence of Proof of Work is "one CPU, one vote." Here, "CPU" should be understood as a unit of computational power, meaning that the more computational power one possesses, the greater their voting power.

This represents a form of implicit voting or an automated process. The purpose of voting is to make decisions regarding the system itself, particularly on matters crucial to the system's consensus, which is fundamental for its survival and avoidance of collapse. It is a form of reflexive voting or, in other words, autonomous voting.

This brings up the issue of "governance attacks." In the case of Bitcoin's longest chain decision, if malicious computational power exceeds a certain proportion, meaning they have a significant voting power, there is a chance of reversing the majority consensus.

The difference here lies in the concept of a "governance attack." In the context of Bitcoin's longest chain decision, if malicious computational power controls just over 10% of the total computational power (voting power), there is a close to 0.1% chance of reversing consensus within six confirmed blocks. With the commonly accepted requirement of three confirmed blocks, there is a 5% chance of reversal. If malicious power controls over 30% of the voting power, even with six confirmed blocks, there is a significant 17.7% chance of reversal. Reversing the proof-of-work longest chain can be seen as a successful governance attack, enabling the occurrence of "double spending."

Therefore, successful on-chain voting requires a majority consensus. However, more importantly, it is essential to prevent interest groups capable of coordinating off-chain actions from controlling enough computational power to overturn the majority consensus.

Is off-chain coordination always considered a governance attack? If a severe bug were to occur in Bitcoin, necessitating the coordination and unified upgrade of all miners to resolve it, would this coordinated action constitute an attack on Bitcoin? Technically speaking, it does. Any form of coordination can be technically defined as a governance attack because it violates the rule of the longest chain. However, if this "attack" reflects a strong off-chain consensus within the entire community or society, it becomes moral and permissible.

This aligns with a famous quote in the field of law: "Law serves as the basis for condemnation, while ethics serves as the basis for exoneration." If an act that violates the law is allowed by the prevailing moral standards of society, it cannot be considered a crime.

When discussing the issue of shared governance in future organizations, we can draw insightful reflections from the exploration of Bitcoin.

While voting in an organization does not necessarily need to be conducted on-chain, voting in a decentralized organization like a DAO does require utilizing a blockchain. This is because individuals' identities, assets, and particularly the organization's capital exist on the blockchain. Through on-chain governance, the aforementioned entities can be automatically executed. Therefore, the governance voting of a DAO exhibits reflexivity. For example, if a DAO votes to divide and distribute its own capital, akin to what the character Pigsy often says in "Journey to the West" about everyone taking their share and going their separate ways, then the DAO would effectively destroy itself.

Thus, on-chain data is simply a "physicalization" of real-life existence and human nature in the off-chain world. The essence of on-chain voting is not merely about programs, logic, and rules, but rather the on-chain mapping and evidence of a social contract formed by a living community of individuals.
