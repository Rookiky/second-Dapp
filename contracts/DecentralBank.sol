pragma solidity ^0.8.0;
// SPDX-License-Identifier: MIT

import './Tether.sol';
import './Coin.sol';
import './RWD.sol';

contract DecentralBank {
    string public name = "Decentral Bank";
    address public owner;
    Tether public tether;
    RWD public rwd;

    address[] public stakers;

    mapping(address => uint256) public stakingBalance; 
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaked;

     
    constructor(RWD _rwd, Tether _tether) {
        rwd =  _rwd;
        tether =  _tether;
        owner = msg.sender;
    }

    function depositTokens(uint _amount) public {
        require( _amount> 0, 'amount must be higher than 0');

        tether.transferFrom(msg.sender, address(this), _amount);
        stakingBalance[msg.sender] += _amount;
        if(!hasStaked[msg.sender]) {
            stakers.push(msg.sender);
        }
        isStaked[msg.sender] = true;
        hasStaked[msg.sender] = true;
    }

    function issueTokens() public {
        require(msg.sender == owner, 'not allowed to do this');

        for(uint staker = 0; staker < stakers.length - 1; staker++) {
            address recipient = stakers[staker];
            uint256 balance = stakingBalance[recipient] / 9;
            if(balance > 0) {
                rwd.transfer(recipient, balance);
            }
        }
    }

    function unstakeTokens(uint _amount) public {
        require(_amount > 0);
        uint balance = stakingBalance[msg.sender];
        tether.transfer(msg.sender, balance);
        stakingBalance[msg.sender] = 0;
        isStaked[msg.sender] = false;

    }

}