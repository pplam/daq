pragma solidity ^0.4.22;

contract Daq {
  struct A {
    string content;
    bytes signature;
  }

  A[] public answers;

  event Sender(address sender);
  event Signer(address signer);

  constructor() public { }

  function put(string content, bytes signature) public returns (address, address) {
    bytes32 hash = keccak256(content);
    bytes32 message = prefixed(hash);
    address signer = recoverSigner(message, signature);

    answers.push(A(content, signature));

    Sender(msg.sender);
    Signer(signer);
    return (msg.sender, signer);
  }


   /////////////////// Signature methods ///////////////////

  function recoverSigner(bytes32 message, bytes sig)
    internal
    pure
    returns (address)
  {
    uint8 v;
    bytes32 r;
    bytes32 s;
    (v, r, s) = splitSignature(sig);
    return ecrecover(message, v, r, s);
  }


  function splitSignature(bytes sig)
    internal
    pure
    returns (uint8, bytes32, bytes32)
  {
    bytes32 r;
    bytes32 s;
    uint8 v;
    assembly {
      r := mload(add(sig, 32))
      s := mload(add(sig, 64))
      v := and(mload(add(sig, 65)), 255)
    }
    if (v < 27) v += 27;
    return (v, r, s);
  }


  function isEqual(bytes a, bytes b) internal returns (bool) {
    if (a.length != b.length) {
      return false;
    }
    for (uint i = 0; i < a.length; i++) {
      if (a[i] != b[i]) {
        return false;
      }
    }
    return true;
  }


  function prefixed(bytes32 hash) internal pure returns (bytes32) {
    return keccak256("\x19Ethereum Signed Message:\n32", hash);
  }
}
