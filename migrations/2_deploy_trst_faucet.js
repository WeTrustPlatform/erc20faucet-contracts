const Trustcoin = artifacts.require("./ERC20Tokens/Trustcoin.sol");
const Faucet = artifacts.require('./ERC20Faucet.sol');
const TrstRinkeby = '0x87099adD3bCC0821B5b151307c147215F839a110';
const MaxAllowance = 1000000000;

module.exports = function(deployer, network, accounts) {
  let deployerPromise;

  if (network === 'rinkeby') {
    console.log(`On Rinkeby, TRST address is ${TrstRinkeby}`);
    deployerPromise = deployer.then(() => {
      return Trustcoin.at(TrstRinkeby);
    })
  } else {
    console.log(accounts[0].balance);
    deployerPromise = deployer.deploy(Trustcoin, accounts[0]);
  }

  deployerPromise.then((trstInstance) => {
    return Faucet.new(trstInstance.address, MaxAllowance);
  }).then((faucetInstance) => {
    console.log(`Faucet deployed @ ${faucetInstance.address}`);
  });
};