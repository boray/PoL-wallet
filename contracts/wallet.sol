//SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

contract ProofOfLivenessWallet {

        address public owner; // owner of the contract therefore the wallet
        address public inheritor; // inheritor of the funds in this wallet
        uint256 public limitTimestamp; // timestamp of last hearbeat tx sent by owner
        uint256 public timeUntilRelease = 90000; // time until funds are released (inheritor can withdraw) 
        uint256 public balance; // balance of the wallet

        modifier onlyOwner() {
            require(owner == msg.sender, "YOU ARE NOT THE OWNER");
             _;
        }

        event Deposit(address _sender, uint amount); // event for deposits
        event Withdraw(address _to, uint amount);  // event for withdraws
        event Heartbeat(uint _timestamp); // event for heartbeats
        event InheritorWithdrawal(uint _timestamp, uint amount, address _to); // event for inheritor withdrawal after release

        
        constructor() {
            owner = msg.sender;  // set the owner as soon as the wallet is created
        }

        
        receive() external payable {
            balance += msg.value;
            emit Deposit(msg.sender, msg.value);
        }

    
        function sendFunds(uint amount, address receiver) public onlyOwner {
            payable(receiver).transfer(amount);
            balance -= amount;
            emit Withdraw(receiver,amount);
        }

        function inheritorWithdrawal() external {
            require(block.timestamp>limitTimestamp,"WALLET OWNER IS ALIVE");
            payable(inheritor).transfer(balance);
            emit InheritorWithdrawal(block.timestamp, balance, inheritor);
            balance = 0;

        }

        function heartbeat() external onlyOwner {
            limitTimestamp = block.timestamp;
            emit Heartbeat(limitTimestamp);
        }


}



