// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";






contract CountyFairCropContest is ERC721, ERC721Enumerable, Ownable, IERC721Metadata, SafeMath  {
    using SafeMath for unit256;
    address public minter;
    uint public constant maxSeeds = 5000;
    bool public saleStarted = false;
    address public constant devAddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address public constant artAddress = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    address public constant charityAddress = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    address public constant prizeAddress = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;
    uint public teamShare = 30;
    uint public charityShare = 20;
    uint public prizeShare = 20;
    uint constant totalShare = 100;
    uint public maxSeedPurchase = 20;
    uint public seedPrice = 50000000000000000;


    // 30% of sales to each team member (2 members)
    // 20% of sales to Charity
    // 20% of sales for prize pool

 
    constructor() ERC721("CountyFairCropContest","CFCC"); ERC721Enumerable() public {
        minter = msg.sender
    }

     function safeMint(address to, uint256 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
}

    function withdrawTotal() public payable onlyOwner {
        uint256 balance =  address(this).balance;

        uint devWithdraw = (balance * teamShare);
        uint artWithdraw = (balance * teamShare);
        uint charityWithdraw = (balance * charityShare);
        uint prizeWithdraw = (balance * prizeShare);

        payable(devAddress).transfer(devWithdraw);
        payable(artAddress).transfer(artWithdraw);
        payable(charityAddress).transfer(charityWithdraw);
        payable(prizeAddress).transfer(prizeWithdraw);
        
    }

    function mintCrop(uint numberOfSeeds) public payable { 
        require(saleStarted = true, "You are too early for minting seeds");
        require(numberOfCrops <= maxSeedPurchase, "You can't mint that many seeds");
        require(maxCrops < 5000, "Maximum amount of seeds have been minted");
        require(seedPrice.mul(numberOfSeeds) <= msg.value, "Incorrect value sent");
        


    }
    
}
