const assert = require('assert');
const HDWalletProvider = require("truffle-hdwallet-provider");
const MNEMONIC = process.env.MNEMONIC || "";
const RINKEBY_RPC = process.env.RINKEBY_RPC || "http://127.0.0.1:8545/";

assert(MNEMONIC);

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  networks: {
    dev: {
      provider: new HDWalletProvider(MNEMONIC, "http://127.0.0.1:8545/"),
      network_id: "*", // Match any network id
    },
    rinkeby: {
      provider: new HDWalletProvider(MNEMONIC, RINKEBY_RPC),
      network_id: 4,
    },
  }, 
};
