const { ethers, network } = require("hardhat");

module.exports = async function ({ getNamedAccounts, deployments }) {
  const { deploy, log } = deployments;
  const { deployer } = await getNamedAccounts();
  log("Local network");
  const ARGS=[["0x03b1A6689eB55cD8f04074ef1Be484EAC56e8690", "0xd6616693609D531a4A4066D886771155938C9F0E"], [90, 10]];
  const CONTRACT = await deploy("DappUni", {
    from: deployer,
    log: true,
    args: ARGS
  });
  log("Contract deployed!!!!!!!!!!!!!!!!!!");
  console.log(CONTRACT.address);
};
module.exports.tags=["all", "ERC1155"]
