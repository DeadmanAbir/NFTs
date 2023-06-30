
# NFTs

NFTs are non-fungible tokens that represent unique digital assets on the blockchain. They can be used to create, buy, sell, and collect digital art, music, games, and more.

## Features

- Uses Solidity to write smart contracts for creating and managing NFTs
- Uses Hardhat to compile, test, and deploy smart contracts
- Uses OpenZeppelin to implement ERC-721 and ERC-1155 standards for NFTs
- Uses IPFS to store and access the metadata and content of NFTs
- Uses Ethers3.js to connect the web interface with the blockchain

## ERC721


- Sepolia is a smart contract that implements the ERC-721 standard for non-fungible tokens (NFTs).
- Sepolia allows the owner to pause and unpause the contract, and to edit the minting options.
- Sepolia has two minting options: public mint and allow mint. Public mint is open to anyone who pays 0.001 ether, while allow mint is restricted to a list of addresses that pay 0.0001 ether.
- Sepolia has a maximum supply of 10 NFTs, and each NFT has a unique token ID and a base URI that points to the IPFS metadata and content.
- Sepolia uses OpenZeppelin contracts for security, access control, and enumeration features.
- Sepolia also has a withdraw function that allows the owner to transfer the balance of the contract to a specified address.


## ERC1155

- DappUni is a smart contract that implements the ERC-1155 standard for multi-token NFTs.
- DappUni allows the owner to pause and unpause the contract, and to set the base URI for the NFT metadata and content.
- DappUni has two types of NFTs, with IDs 0 and 1, and each type has a maximum supply of 10 NFTs.
- DappUni has two minting options: allow list mint and public mint. Allow list mint is restricted to a list of addresses that pay 0.0001 ether per NFT, while public mint is open to anyone who pays 0.001 ether per NFT.
- DappUni also has a purchase limit of 5 NFTs per address, and a purchase count mapping to keep track of the number of NFTs purchased by each address.
- DappUni uses OpenZeppelin contracts for security, access control, enumeration, and payment splitting features.
- DappUni splits the payments among a list of payees with specified shares, using the PaymentSplitter contract.
## Installation

To run this project, you need to have Node.js and npm installed on your system. After cloning:

```bash
npm install
```

You also need to have MetaMask installed on your browser .



-To deploy the smart contracts to the local network, get into the project directory and run the following command:

```bash
npx hardhat deploy
```

To run the tests for the smart contracts, run the following command:

## Opensea Testnet-
- [ERC721](https://testnets.opensea.io/collection/sepolia-4)
- [ERC1155](https://testnets.opensea.io/assets/sepolia/0x6565e4447923a8709071aaad7ef4f7c77ed46348/0)

- <b>Connect with me :</b> Click


