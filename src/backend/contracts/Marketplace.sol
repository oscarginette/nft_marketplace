// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract Marketplace is ReentrancyGuard {
    //State variables
    address payable public immutable feeAccount; // the account receives fees
    uint public immutable feePercent; // the fee percentatge on sales
    uint public itemCount;

    struct Item {
        uint itemId;
        IERC721 nft; //instance of the contract
        uint tokenId;
        uint price;
        address payable seller;
        bool sold;
    }

    constructor(uint _feePercent) {
        feeAccount = payable(msg.sender);
        feePercent = _feePercent;
    }

}

