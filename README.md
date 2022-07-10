# PoC of Proof-of-Liveness wallet

#### Proof of liveness wallet ensures transfer of cryptoassets to inheritors when wallet owner passes out.

The idea for this project was born in a lovely talk with Denis Sener and Yaman Can at Espumoso Café, Istanbul. The problem is that if a crypto wallet owner passes out, there is no way to inherit that funds except by using the wallet owner's private key. If we think the wallet owner is not a degen, we can expect they own a hardware wallet to store their life savings. If we assume the wallet owner doesn't share their hardware wallet's pin or private key with their inheritor to keep themself as the only custodian, there is no way to recover funds after the wallet owner's death. Proof-of-Liveness wallet enters the game at this point. PoL wallet is a smart contract wallet that requires regular heartbeat transactions by the wallet owner to keep their funds in the wallet. The wallet owner could set one or more inheritors. Also, they can determine the share of the inheritance. The inheritor can transfer the fund to their wallet if the wallet owner doesn't send a heartbeat transaction in 120 days.

An arbitrary transaction could verıfy the liveness of the wallet owner's liveness and reset the smart contract's countdown timer. A specific transaction to reset the countdown timer is called the heartbeat function. If the wallet owner does not transact for a long time, A cloud service could warn the wallet owner with a push notification, SMS or email to make a transaction that calls the heartbeat function. 

## Glossary:
 **Inheritor:** A person who receives cryptoassets from someone who has died.\
 **Hearbeat Transaction:**  A spesific function in the PoL wallet contract that creates a heartbeat when its called.\
**Smart Contract Wallet:** Smart contract wallets are wallets with unique abilities due to the power of smart contract functionality.
