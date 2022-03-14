// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";


contract NFT is ERC721URIStorage {
    // state variable that keeps track of the number of tokens, this will act as an ID.
    uint public tokenCount;

    constructor() ERC721("Ginette NFT", "DAPP") {}

    // _tokenURI is the NFT metadata
    function mint(string memory _tokenURI) external returns(uint) {
        tokenCount++;
        _safeMint(msg.sender, tokenCount);
        _setTokenURI(tokenCount, _tokenURI);
        return (tokenCount);
    }
} 