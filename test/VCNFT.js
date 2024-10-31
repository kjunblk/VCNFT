const VCNFT = artifacts.require("VCNFT");
const BN = web3.utils.BN;

contract("VCNFT", async (accounts) => {

	let nft;
	const gas = 2000000;

	// Test accounts
	const [deployer, add1, add2, add3] = accounts;

	before(async () => {
		nft = await VCNFT.deployed();
	});


	it("contract info : ", async () => {
		console.log("name : ", await nft.name());
		console.log("symb : ", await nft.symbol());
	});

	it("Certify test", async () => {
		await nft.certify(add2, 1, "URL", "hash", 100, { from: add1});
		console.log("URI : ", await nft.claimURI(1)) ;
		console.log("owner1 : ", await nft.ownerOf(1)) ;
	});

	it("Transfer test", async () => {
		await nft.transferFrom(add2, add3, 1, { from: add1});
		console.log("owner1 : ", await nft.ownerOf(1)) ;
	});

	it("Revoke test", async () => {
		await nft.revoke(1, { from: add1});
//		console.log("owner1 : ", await nft.ownerOf(1)) ;
	});

	after(() => {
		nft = undefined;
	});
});

