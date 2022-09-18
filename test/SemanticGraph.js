const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");
Web3 = require('web3')

describe("SemanticGraph", function () {

  async function deploySemanticGraph() {
    const [owner, otherAccount] = await ethers.getSigners();

    const SemanticGraph = await ethers.getContractFactory("SemanticGraph");
    const graph = await SemanticGraph.deploy();

    return { graph, owner, otherAccount };
  }

  describe("Deployment", function () {
    it("Should deploy successfully", async function () {
      const { graph, owner, otherAccount } = await loadFixture(deploySemanticGraph);
    });
  });

  describe("Update", function () {

    describe("Update edge", function () {
      it("Should update edge successfully", async function () {
        const { graph, owner, otherAccount} = await loadFixture(deploySemanticGraph);

        await graph.update("BAYC 4848", "SpinnerHat", "has");

      });
    });
  });
});
