// SPDX-License-Identifier: MIT

/**
 * Author: Jhone Seo <kjseo@blocko.io>
 * Github: https://github.com/kjunblk
 */

pragma solidity ^0.8.20 ;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract VCNFT is ERC721 {

	using Strings for uint256;

	struct Credential{
		string  ClaimURI;
		string  ClaimHash;

		address Issuer;
		uint256 IssuerTokenID;   // Issuer 신원검증용 Token ID, chain ID등 부가 정보가 필요할 수 있음 

		uint256 IssueDate;       // 발급 시각 (Unix Time)
		uint256 ExpirationDate;  // 만료 시각 (Unix Time), 0값은 무한으로 사용 권장

		string  OptionalData;    // 기타 데이터, 문자열로 저장, 응용에서 자유롭게 사용

	}
    
	mapping(uint256=>Credential) private _credentials;

	constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {
	}

	function _isIssuer(address spender, uint256 tokenId) internal view virtual returns (bool) {
		return spender != address(0) && _credentials[tokenId].Issuer == spender ;
	}

	function _exists(uint256 tokenId) internal view virtual returns (bool) {
		return _ownerOf(tokenId) != address(0) ;
	}

	// =====================

	// Get claimURI
	function claimURI(uint256 _tokenId) public view returns (string memory) {
		require(_exists(_tokenId), "VCNFT: URI query for nonexistent token.");
		return _credentials[_tokenId].ClaimURI ;
	}

	// Get claimHash
	function claimHash(uint256 _tokenId) public view returns (string memory) {
		require(_exists(_tokenId), "VCNFT: URI query for nonexistent token.");
		return _credentials[_tokenId].ClaimHash ;
	}

	// Get issuer
	function issuer(uint256 _tokenId) public view returns (address) {
		require(_exists(_tokenId), "VCNFT: URI query for nonexistent token.");
		return _credentials[_tokenId].Issuer ;
	}

	// Get issuer TokenID
	function issuerTokenID(uint256 _tokenId) public view returns (uint256) {
		require(_exists(_tokenId), "VCNFT: URI query for nonexistent token.");
		return _credentials[_tokenId].IssuerTokenID ;
	}

	// Get issue date
	function issueDate(uint256 _tokenId) public view returns (uint256) {
		require(_exists(_tokenId), "VCNFT: URI query for nonexistent token.");
		return _credentials[_tokenId].IssueDate ;
	}

	// Get expiration date
	function expirationDate(uint256 _tokenId) public view returns (uint256) {
		require(_exists(_tokenId), "VCNFT: URI query for nonexistent token.");
		return _credentials[_tokenId].ExpirationDate ;
	}

	// Get optional data
	function optionalData(uint256 _tokenId) public view returns (string memory) {
		require(_exists(_tokenId), "VCNFT: URI query for nonexistent token.");
		return _credentials[_tokenId].OptionalData ;
	}

	// Get credential
	function credential(uint256 _tokenId) public view returns (Credential memory) {
		require(_exists(_tokenId), "VCNFT: URI query for nonexistent token.");
		return _credentials[_tokenId] ;
	}

	// =====================

	// certify --> mint
	function certify(
		address _to,
		uint256 _tokenId,
		string calldata _claimURI,
		string calldata _claimHash,
		uint256 _issuerTokenID,
		uint256 _issueDate,
		uint256 _expirationDate,
		string calldata _optionalData
	) public virtual {
		_safeMint(_to, _tokenId);
		_credentials[_tokenId] = Credential(
			_claimURI,
			_claimHash,
			msg.sender,
			_issuerTokenID,
			_issueDate,
			_expirationDate,
			_optionalData
		);
	}

	// revoke --> burn
	function revoke(uint256 tokenId) public virtual {
		require(_isIssuer(msg.sender, tokenId), "VCNFT: caller is not issuer");
		_burn(tokenId);
	}

	function transferFrom(address from, address to, uint256 tokenId) public virtual override {
		require(_isIssuer(msg.sender, tokenId), "VCNFT: caller is not issuer");

		if (to == address(0)) {
			revert ERC721InvalidReceiver(address(0));
		}

		address previousOwner = _update(to, tokenId, address(0));
		if (previousOwner != from) {
			revert ERC721IncorrectOwner(from, tokenId, previousOwner);
		}
	}
}
