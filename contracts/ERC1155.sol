// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/finance/PaymentSplitter.sol";

contract DappUni is ERC1155, Ownable, Pausable, ERC1155Supply, PaymentSplitter {

    uint256 public constant maxSupply=10;
    uint256 public publicPrice=0.001 ether;
    uint256 public constant allowPrice=0.0001 ether;
    mapping (address=>bool) allowList;
    mapping(address=>uint256) purchaseCount;
    uint256 public constant purchaseLimit=5;

    bool isAllow=true;
    bool isPublic=false;
    constructor(address[] memory _payees, uint256[] memory _shares)
        ERC1155("ipfs://QmPzXcJjrEwxBRD2uDcG69DZ8m992jM4ysrBwUuz6J6LGj/")
        PaymentSplitter(_payees, _shares) // Payment Splitter
    {}

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function allowListMint(uint256 _id, uint256 NFTAmount)public payable{
        require(allowList[msg.sender], "You aren't allowed");
        require(isAllow, "Temporarily Closed!!");
        require(_id<2, "Nft doesn't exist");
        require(msg.value==allowPrice*NFTAmount, "INsufficient Fund");
        require(totalSupply(_id)+NFTAmount<=maxSupply, "Max Limit reached");
        require(purchaseCount[msg.sender]+NFTAmount<=purchaseLimit, "Limit Reached");
        purchaseCount[msg.sender]++;
        _mint(msg.sender, _id, NFTAmount, "");

    }

    function mint(uint256 id, uint256 NFTamount)
        public payable
       
    {
        require(isPublic, "Temporarily Closed!");
        require(id<2, "Sorry you are minting the wrong NFT");
        require(msg.value==publicPrice*NFTamount, "Insufficient Funds!!");
        require(totalSupply(id)+NFTamount<=maxSupply, "Maximum suppy of NFT limit reached");
        require(purchaseCount[msg.sender]+NFTamount<=purchaseLimit, "Limit Reached");
        purchaseCount[msg.sender]++;
        _mint(msg.sender, id, NFTamount, "");
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        public
        onlyOwner
    {
        _mintBatch(to, ids, amounts, data);
    }

    function _beforeTokenTransfer(address operator, address from, address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        internal
        whenNotPaused
        override(ERC1155, ERC1155Supply)
    {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }

    function uri(uint256 _id) public view virtual override returns(string memory){
        require(exists(_id), "Nft doesn't exists");
        return string(abi.encodePacked(super.uri(_id), Strings.toString(_id), ""));
    }
    //     (bool success,)=payable(addr).call{value: address(this).balance}("");
    //     require(success, "Transaction Failed!!");
    // }   // function withdraw(address addr) public onlyOwner{
 
    function setAllowance(bool _allow, bool _public) external onlyOwner{
        isAllow=_allow;
        isPublic=_public;
    }
    function setAllowList(address[] calldata _addr)external onlyOwner{
        for(uint256 i=0; i<_addr.length; i++){
            allowList[_addr[i]]=true;
        }
    }
}