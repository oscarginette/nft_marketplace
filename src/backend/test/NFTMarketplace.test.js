const {expect} = require("chai");
const { ethers } = require("hardhat");

describe("NFTMarketplace", function() {
    let deployer, addr1, addr2, nft, marketplace;
    let feePercent = 1;
    let URI = "Sample URI";
    beforeEach(async function() {
        const NFT = await ethers.getContractFactory("NFT");
        const Marketplace = await ethers.getContractFactory("Marketplace");

        //Get signers (eth accounts)
        [deployer, addr1, addr2] = await ethers.getSigners();

        //Deploy contracts
        nft = await NFT.deploy();
        marketplace = await Marketplace.deploy(feePercent);
    });
    // Test if network was deployed correctly
    describe("Deployment", function(){
        it("Should track name and symbol of the nft collection", async function() {
            expect(await nft.name()).to.equal("Ginette NFT");
            expect(await nft.symbol()).to.equal("DAPP");
        })
        it("Should track feeAccount and feePercent of the marketplace", async function() {
            expect(await marketplace.feeAccount()).to.equal(deployer.address);
            expect(await marketplace.feePercent()).to.equal(feePercent);
        })
    })

    describe("Minting NFTs", function() {
        it("Should track each minted NFT", async function() {
            await nft.connect(addr1).mint(URI);
            expect(await nft.tokenCount()).to.equal(1);
            expect(await nft.balanceOf(addr1.address)).to.equal(1);
            expect(await nft.tokenURI(1)).to.equal(URI);

            await nft.connect(addr2).mint(URI);
            expect(await nft.tokenCount()).to.equal(2);
            expect(await nft.balanceOf(addr2.address)).to.equal(1);
            expect(await nft.tokenURI(2)).to.equal(URI);
        })
    })

})