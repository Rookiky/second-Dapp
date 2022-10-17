const Web3 = require("web3");
const { artifacts } = require("hardhat");
const hre = require("hardhat");

async function main() {
  // const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  // const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
  // const unlockTime = currentTimestampInSeconds + ONE_YEAR_IN_SECS;

  // const lockedAmount = hre.ethers.utils.parseEther("1");
  const Tether = await hre.ethers.getContractFactory("Tether");
  const tether = await Tether.deploy();

  const RWD = await hre.ethers.getContractFactory("RWD");
  const rwd = await RWD.deploy();

  const DecentralBank = await hre.ethers.getContractFactory("DecentralBank");
  const decentralBank = await DecentralBank.deploy(rwd.address, tether.address);

  await rwd.deployed();
  await rwd.transfer(decentralBank.address, '100000000000000000000');

  await tether.deployed();
  await tether.transfer('0xF9c5C31fE00556f39269152Aa0a36E7633cE883b', "100000000000000000000");

  // const balance = Tether.balanceOf('0xc51C512698C13F96a11b9B4FFBac37E580ABec9b');
  // console.log(balance);
  

  // const rwdDeployed = await rwd.deployed();
  // const decentralBankDeployed = await decentralBank.deployed();

  // give 1 000 000 rwd to decentralBank address
  // await rwdDeployed.transfer(decentralBank.address, "1000000000000000000000000");

  // give 100 tether to each investor
  // await tetherDeployed.transfer( '0x9b3cA2f40A7d79139AC07f6f883Fda29d4f8Ed3B' , "100000000000000000000");

  console.log(`success contract address is ${tether.address}, ${rwd.address}, ${decentralBank.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
