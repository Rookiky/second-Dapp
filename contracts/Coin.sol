pragma solidity ^0.8.0;
// SPDX-License-Identifier: MIT

contract coin {
      address owner;
      address public minter;
      mapping(address => uint) public balances;
      event Sent(address from, address to, uint amount);

       constructor() {
        minter = msg.sender;

       }

       function mint(address payable receiver, uint256 amount) public {
            require(msg.sender == minter);
            balances[receiver] += amount;
            receiver.transfer(amount);
       }
      
      error insufficientBalance(uint requested, uint available);

       function send(address receiver, uint amount) public {
            // require(balances[msg.sender] >= amount);
            if(amount > balances[msg.sender])
            revert insufficientBalance({
                  requested: amount,
                  available: balances[msg.sender]
            });
            balances[msg.sender] -= amount;
            balances[receiver] += amount;
            emit Sent(msg.sender, receiver, amount);
       }

       
}