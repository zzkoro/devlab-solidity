const PracticeContract = artifacts.require("Practice");

module.exports = function (deployer) {
  deployer.deploy(PracticeContract);
};
