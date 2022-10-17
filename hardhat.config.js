require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  paths: {
    artifacts: './src/artifacts',
  },
  networks: {
    ganache: {
      chainId: '5777',
      url: 'HTTP://127.0.0.1:7545'
    }
  }
};
