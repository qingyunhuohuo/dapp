var Blacklist = artifacts.require('./Blacklist.sol')

module.exports = function (deployer) {
  deployer.deploy(Blacklist, '0xc2f5C7B8Bbd6BB7EE2e4feE6D60e60B3B5D62c82')
}
