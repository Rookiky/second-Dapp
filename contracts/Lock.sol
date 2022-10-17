// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Will {

    address owner;
    uint256 fortune;
    bool deceased;
    bool isDeceased;

    constructor() payable {
        owner = msg.sender;
        fortune = msg.value;
        deceased = false;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    modifier mustBeDeceased {
        require(deceased == true);
        _;
    }

    address payable[] familyWallets;

    mapping(address => uint256 ) inheritance;

    function setInheritance(address payable wallet, uint  amount) public {
       familyWallets.push(wallet);
       inheritance[wallet] = amount;
    }

    function fundThisContract() public payable{
        
    }

    function payout() private mustBeDeceased{
        for(uint256 i = 0; i < familyWallets.length; i++){
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
        }
    }

    function hasDeceased() public {
        isDeceased = true;
        payout();
       
    }
}