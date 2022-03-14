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

    // itemId -> Item
    mapping(uint => Item) public items;

    constructor(uint _feePercent) {
        feeAccount = payable(msg.sender);
        feePercent = _feePercent;
    }

    // In the front end, you just need to send the contract address and solidity will
    // automatically convert this to a IERC721 contract

    // nonReentrant modifier: prevents bad guys to call this function before it has finished the first time
    function makeItem(IERC721 _nft, uint _tokenId, uint _price) external nonReentrant {
        require(_price > 0, "Price must be greater than zero");
        _nft.transferFrom(msg.sender, address(this), _tokenId);
        items[itemsCount] = Item (
            itemCount,
            _nft,
            _tokenId,
            _price,
            payable(msg.sender),
            false
        );
    }

}

