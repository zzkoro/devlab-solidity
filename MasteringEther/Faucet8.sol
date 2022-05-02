// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Owned {
    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }
}

contract Mortal is Owned {
    function destory() public onlyOwner {
        selfdestruct(owner);
    }
}

contract Faucet is Mortal {

    event Withdrawal(address indexed to, uint amount);
    event Deposit(address indexed from, uint amount);

    // function destroy() public {
    //     require(msg.sender == owner);
    //     selfdestruct(payable(owner));
    // }

    function withdraw(uint withdraw_amount) public {

        require(withdraw_amount <= 0.1 ether);

        require(address(this).balance >= withdraw_amount, "Insufficient balance in faucet for withdrawal request");

        payable(msg.sender).transfer(withdraw_amount);

        emit Withdrawal(msg.sender, withdraw_amount);
    }

    fallback () external {}

    receive () external payable {

        emit Deposit(msg.sender, msg.value);
        
    }

}