# Verifiable Credential NFT 
## Abstract
## Contracts 
### Read credential data for a NFT 
#### claimURI
Returns a URI pointing to a resource with the claims for the given credential NFT.
```
function claimURI(uint256 _tokenId) public view returns (string memory) 
```
#### claimHash
Returns the hash value for the claims for the given credential NFT.
```
function claimHash(uint256 _tokenId) public view returns (string memory) 
```
#### issuer
Returns the issuer's address (minter) for the given credential NFT.
```
function issuer(uint256 _tokenId) public view returns (address) 
```
#### issuerTokenID
Returns the identifier for a token stores the issuer's trusted certificate. 
```
function issuerTokenID(uint256 _tokenId) public view returns (uint256) 
```
#### issueDate
Returns the issuance date (Unix Time) for the given credential NFT.
```
function issueDate(uint256 _tokenId) public view returns (uint256) 
```
#### optionalData
Returns the optional data (string) for the given credential NFT.
```
function optionalData(uint256 _tokenId) public view returns (string memory) 
```

#### credential
Returns all credential data with the following structure for the given credential NFT.
```
struct Credential{
	string  ClaimURI;	// A URI pointing to a resource with the claims
	string  ClaimHash;	// A hash value for the claims
	address Issuer;		// Issuer's address (minter)
	uint256 IssuerTokenID;	// The identifier for a token stores the issuer's trusted certificate
	uint256 IssueDate;	// The issuance date (Unix Time)
	uint256 ExpirationDate;	// The expiration time (Unix Time). A value of 0 is infinite
	string  OptionalData;	// the optional data (string type)
}
```
```
function credential(uint256 _tokenId) public view returns (Credential memory) 
```
### certify 
Mint a credential NFT with the following parameters. 
```
function certify(
	address _to, 
	uint256 _tokenId, 
	string calldata _claimURI, 
	string calldata _claimHash, 
	uint256 _issuerTokenID, 
	uint256 _issueDate, 
	uint256 _expirationDate, 
	string calldata _optionalData
) 
```
### revoke 
Burn a credential NFT for the given credential NFT. Only the issuer of the NFT can execute it.
```
function revoke(uint256 tokenId) 
```
### transferFrom
Transfers a specific NFT (tokenId) from one account (from) to another (to). Only the issuer of the NFT can execute it.

``` 
function transferFrom(address _from, address _to, uint256 _tokenId) 
``` 
