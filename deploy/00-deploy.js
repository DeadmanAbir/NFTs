const { ethers, network } = require("hardhat");

module.exports = async function ({ getNamedAccounts, deployments }) {
  const { deploy, log } = deployments;
  const { deployer } = await getNamedAccounts();
  log("Local network");
  const CONTRACT = await deploy("DeadmanAbir", {
    from: deployer,
    log: true
  });
  log("Contract deployed!!!!!!!!!!!!!!!!!!");
  console.log(CONTRACT.address);
};
module.exports.tags=["all", "ERC20"]
