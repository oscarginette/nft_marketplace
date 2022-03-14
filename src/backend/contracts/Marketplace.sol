// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract Marketplace is ReentrancyGuard {
    //State variables
    address payable public immutable feeAcount; // the account receives fees
    uint public immutable feePercent; // the fee percentatge on sales
    uint public itemCount;

    constructor(uint _feePercent) {
        feeAcount = payable(msg.sender);
        feePercent = _feePercent;
    }
    
}

