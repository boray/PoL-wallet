//SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

contract ProofOfLivelinessWallet {

        address public owner;
        address public beneficiary;
        uint256 public limitTimestamp; 
        uint256 public epoch = 90000;
        uint256 public balance;

        modifier onlyOwner() {
            require(owner == msg.sender, "Ownable: caller is not the owner");
             _;
        }

        event Deposit(address _sender, uint amount); 
        event Withdraw(address _to, uint amount); 

        
        constructor() {
            owner = msg.sender;  
        }

        
        receive() external payable {
            balance += msg.value;
            emit Deposit(msg.sender, msg.value);
        }

    
        function sendFunds(uint amount, address receiver) public onlyOwner {
            payable(receiver).transfer(amount);
            emit Withdraw(receiver,amount);
        }

        function beneficiaryWithdrawal() external {
            require(block.timestamp>limitTimestamp,"funds are not withdrawable for beneficiary");
            payable(beneficiary).transfer(balance);

        }



}



