//SPDX-License-Identifier: MIT


/*
TODO Support ERC20, ERC721 and ERC1155 token transfer should be added
TODO Support for arbitrary transactions should be added
*/
pragma solidity ^0.8.1;

contract ProofOfLivenessWallet {

        address public owner; // owner of the contract therefore the wallet
        address public inheritor; // inheritor of the funds in this wallet
        uint256 public limitTimestamp; // timestamp of last hearbeat tx sent by owner
        uint256 public timeUntilRelease = 90000; // time until funds are released (inheritor can withdraw) 
        uint256 public balance; // balance of the wallet
        uint256 public claimed;
        uint256[] public shares;
        address[] public shareHolders;

        mapping(address => uint256) public addressToInheritorId;

        modifier onlyOwner() {
            require(owner == msg.sender, "YOU ARE NOT THE OWNER");
             _;
        }

        event Deposit(address _sender, uint amount); // event for deposits
        event Withdraw(address _to, uint amount);  // event for withdraws
        event Heartbeat(uint _timestamp); // event for heartbeats
        event InheritorWithdrawal(uint _timestamp, uint claimedAmount, uint latestBalance, address _to); // event for inheritor withdrawal after release
        event SetShares(uint[] shares, address[] addresses); // event for shares setting


        
        constructor() {
            owner = msg.sender;  // set the owner as soon as the wallet is created
        }

        
        receive() external payable {
            require(!(block.timestamp>limitTimestamp),"WALLET OWNER IS DEAD, NO DEPOSITS ALLOWED!");
            balance += msg.value;
            emit Deposit(msg.sender, msg.value);
        }

        function setShares(uint[] memory _shares, address[] memory _addresses) public onlyOwner {
            shares = _shares;
            shareHolders = _addresses;
            emit SetShares(shares, shareHolders);
        }

        function sendFunds(uint amount, address receiver) public onlyOwner {
            payable(receiver).transfer(amount);
            balance -= amount;
            emit Withdraw(receiver,amount);
        }

        function inheritorWithdrawal() external {
            require(block.timestamp>limitTimestamp,"WALLET OWNER IS ALIVE");
            require(addressToInheritorId[msg.sender] != 0,"YOU ARE NOT AN INHERITOR");
            uint256 claim = (balance+claimed) * (shares[addressToInheritorId[msg.sender]] / 10000);
            payable(msg.sender).transfer(claim);
            claimed += claim;
            balance -= claim;
            emit InheritorWithdrawal(block.timestamp, claimed, balance, msg.sender);

        }

        function heartbeat() external onlyOwner {
            limitTimestamp = block.timestamp;
            emit Heartbeat(limitTimestamp);
        }


}



