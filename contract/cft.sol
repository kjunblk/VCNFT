// SPDX-License-Identifier: MIT

/**
 * Author: Jhone Seo <kjseo@blocko.io>
 * Github: https://github.com/kjunblk
 */

pragma solidity >=0.8.13 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract VCNFT is ERC721 {

	using Strings for uint256;

	struct Credential{
		string  ClaimURI;
		string  ClaimHash;
		address Issuer;
		uint256 IssuerTokenID;
	}
    
	mapping(uint256=>Credential) private _credentials;

	function _isIssuer(address spender, uint256 tokenId) internal view virtual returns (bool) {
		return
			spender != address(0) && _credentials[tokenId].Issuer == spender ;
	}

	function _transfer(address from, address to, uint256 tokenId) internal {
   		require(_isIssuer(msg.sender, tokenId), "VCNFT: caller is not issuer");
		super._transfer(from, to, tokenId);
	}

	// =====================

	// Get claimURI
	function claimURI(uint256 tokenId) public view virtual override returns (string memory) {
		require(_exists(tokenId), "VCNFT: URI query for nonexistent token.");
		return _credentials[_tokenId].ClaimURI ;
	}

	// Get claimHash
	function claimHash(uint256 tokenId) public view virtual override returns (string memory) {
		require(_exists(tokenId), "VCNFT: URI query for nonexistent token.");
		return _credentials[_tokenId].ClaimHash ;
	}

	// Get issuer
	function issuer(uint256 tokenId) public view virtual override returns (address memory) {
		require(_exists(tokenId), "VCNFT: URI query for nonexistent token.");
		return _credentials[_tokenId].Issuer ;
	}

	// Get issuerTokenID
	function issuerTokenID(uint256 tokenId) public view virtual override returns (uint256 memory) {
		require(_exists(tokenId), "VCNFT: URI query for nonexistent token.");
		return _credentials[_tokenId].IssuerTokenID ;
	}

	// =====================

	// certify --> mint
	function certify(address _to, uint256 _tokenId, string _claimURI, string _claimHash, address _issuer, uint256 _issuerTokenID) public {
		_safeMint(_to, _tokenId);
		_credentials[_tokenId] = Credential(_claimURI,_claimHash,_issuer,_issuerTokenID);
		_supply.increment();
	}

	// revoke --> burn
	function revoke(uint256 tokenId) public virtual {
		require(_isIssuer(msg.sender, tokenId), "VCNFT: caller is not issuer");
		_burn(tokenId);
		_supply.decrement();
	}
}