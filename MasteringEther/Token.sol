// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "Faucet8.sol";

contract Token is Mortal {
    event Response(bool success, bytes data);

    constructor(address _faucet) {
        (bool success, bytes memory data) =  _faucet.call(abi.encodeWithSignature("withdraw(uint256)", 0.1 ether));

        emit Response(success, data);
    }
}