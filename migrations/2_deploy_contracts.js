const VCNFT = artifacts.require("VCNFT");

module.exports = function (deployer) {
	deployer.deploy(VCNFT, "VCNFT", "VC");
};
