// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

contract CoinTest {
    address  minter;
    mapping (address => uint256)  balances;

    event Sent(address from, address to, uint amount);

    constructor() {
        minter = msg.sender;
    }

    function mint(address receiver, uint amount) public {
        require(msg.sender == minter, "only the creator of the contract could create new tokens");
        balances[receiver] += amount;
    }

    error InsufficientBalance(uint requested, uint available);

    function transfer(address receiver, uint amount) public {
        if (amount > balances[msg.sender]){
            revert InsufficientBalance({
                requested: amount, 
                available: balances[msg.sender]});
        }
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}