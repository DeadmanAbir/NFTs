// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract Sepolia is ERC721, ERC721Enumerable, Pausable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("SEPOLIA", "SEP") {}

    mapping (address=>bool) public allowList;
    bool isPublicMint=false;
    bool isAllowMint=false;


    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://QmZpTSXaoXPhkN8Vtd8wLT38PUQKKa47sAeQjDexFNXYKd/";
    }


    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function publicMint() public payable{
        require(isPublicMint, "Minting CLosed!!");
        require(msg.value==0.001 ether, "Not enough amount entered!!");
        require(totalSupply()<10, "Max supply limit hit");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
    }
     function allowMint()public payable{
        require(isAllowMint, "Minting Closed");
        require(allowList[msg.sender], "You are not allowed to mint");
        require(msg.value==0.0001 ether, "Not enough amount entered!!");
        internalMint();
     }
    function editMint(bool isPublic, bool isAllow) external onlyOwner{
        isPublicMint=isPublic;
        isAllowMint=isAllow;
    }
    function setAllowMint(address[] memory addresses) external onlyOwner{
        for(uint256 i=0; i<addresses.length; i++){
            allowList[addresses[i]]=true;
        }
    }



    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        whenNotPaused
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    // The following functions are overrides required by Solidity.

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function internalMint()internal{
        require(totalSupply()<10, "Max supply limit hit");

        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
    }
    function withdraw(address _addr)public onlyOwner{
        (bool success,)=payable(_addr).call{value: address(this).balance}("");
        require(success, "Transaction not successfull");
    }
}
