var Migrations = artifacts.require("./Daq.sol");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
};
