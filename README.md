# PoC of Proof-of-Liveness wallet

Proof of liveness wallet ensures transfer of funds to inheritors when wallet owner passes out.


The idea for this project born in a lovely talk with Denis Sener and Yaman Can. The problem is if owner of a crypto wallet passes out, there is no way to inherit that funds except using wallet owner's private key. If we think wallet owner is a wise cryptopunk, we can expect he/she owns a hardware wallet to store his/her live-savings. If we assume wallet owner doesn't share his/her hardware wallet's pin or private key with his/her inheritor to keep his/her as only custodian as it would be, there is no way to recover funds after wallet owner's death. Proof-of-Liveness wallets enters the game at this point. PoL wallet is a smart contract wallet that requiers regular hearbeat transactions by wallet owner to keep his/her funds in the wallet. One or more inheritors could be set by wallet owner. Also he/she can determine share of inheritence. If wallet owner doesn't send a heartbeat transaction in x months, inheritor will be able to transfer the fund to his/her wallet.


Liveness of the wallet owner is proved via heartbeat transactions. Heartbeat transactions can be an arbitrary transaction or a call to the spesific function that only hearbeats.

Glossary:

Inheritor: A person who receives cryptoassets from someone who has died.
Hearbeat Transaction:  A spesific function in the PoL wallet contract that creates a heartbeat when its called.
Smart Contract Wallet: Smart contract wallets are wallets with unique abilities due to the power of smart contract functionality.


