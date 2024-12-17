# Verifiable Credential NFT 
## Abstract

## Contracts 

### Simple Summary
### Definitions

* Identifier: a piece of data that uniquely identifies the identity, an ethereum address
* delegate: an address that is delegated for a specific time to perform some sort of function on behalf of an identity
* delegateType: the type of a delegate, is a section name with verification relationships (https://www.w3.org/TR/did-core/#verification-relationships) in a DID document for examples:
    * authentication
    * assertionMethod
* attribute: a piece of data associated with the identity

### Read credential data for a NFT 
#### claimURI
Returns a URI pointing to a resource with the claims of the given credential NFT.
```
function claimURI(uint256 _tokenId) public view returns (string memory) 
```
#### claimHash
Returns the hash value for the claims of the given credential NFT.
```
function claimHash(uint256 _tokenId) public view returns (string memory) 
```
#### issuer
Returns the issuer's address (minter) for the given credential NFT.
```
function issuer(uint256 _tokenId) public view returns (address) 
```
#### issuer TokenID
Returns the identifier for a token stores the issuer's trusted certificate. 
```
function issuerTokenID(uint256 _tokenId) public view returns (uint256) 
```
#### issue date
Returns the issuance date for the given credential NFT.
```
function issueDate(uint256 _tokenId) public view returns (uint256) 
```
#### optional data
Returns the optional data (string) for the given credential NFT.
```
function optionalData(uint256 _tokenId) public view returns (string memory) 
```

#### credential data
Returns all credential data with the following structure for the given credential NFT.
```
        struct Credential{
                string  ClaimURI;
                string  ClaimHash;
                address Issuer;
                uint256 IssuerTokenID;   // Issuer 신원검증용 Token ID, chain ID등 부가 정보가 필요할 수 있음
                uint256 IssueDate;       // 발급 시각 (Unix Time)
                uint256 ExpirationDate;  // 만료 시각 (Unix Time), 0값은 무한으로 사용 권장
                string  OptionalData;    // 기타 데이터, 문자열로 저장, 응용에서 자유롭게 사용
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
function transferFrom(address from, address to, uint256 tokenId) 
``` 

