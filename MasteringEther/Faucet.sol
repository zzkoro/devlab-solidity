// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract owner {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
}

contract mortal is owner {
    function destory() public onlyOwner {
        selfdestruct(payable(owner));
    }
}

contract Faucet is mortal {

    event Withdrawal(address indexed to, uint amount);
    event Deposit(address indexed from, uint amount);

    // function destroy() public {
    //     require(msg.sender == owner);
    //     selfdestruct(payable(owner));
    // }

    function withdraw(uint withdraw_amount) public {

        require(withdraw_amount <= 100000000000000000);

        require(address(this).balance >= withdraw_amount, "Insufficient balance in faucet for withdrawal request");

        payable(msg.sender).transfer(withdraw_amount);

        emit Withdrawal(msg.sender, withdraw_amount);
    }

    fallback () external {}

    receive () external payable {

        emit Deposit(msg.sender, msg.value);
        
    }

}