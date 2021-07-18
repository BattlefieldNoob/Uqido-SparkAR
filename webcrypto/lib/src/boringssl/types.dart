// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// ignore_for_file: camel_case_types

/// This library defines types used in various BoringSSL headers.
library types;

import 'dart:ffi';

/// digest algorithm.
class EVP_MD extends Struct {}

/// digest context.
class EVP_MD_CTX extends Struct {}

/// HMAC context.
class HMAC_CTX extends Struct {}

/// ENGINE, usually just leave this NULL.
class ENGINE extends Struct {}

/// An EVP_PKEY object represents a public or private key. A given object may be
/// used concurrently on multiple threads by non-mutating functions, provided no
/// other thread is concurrently calling a mutating function. Unless otherwise
/// documented, functions which take a const pointer are non-mutating and
/// functions which take a non-const pointer are mutating.
class EVP_PKEY extends Struct {}

/// EVP_PKEY_CTX objects hold the context of an operation (e.g. signing or
/// encrypting) that uses a public key.
class EVP_PKEY_CTX extends Struct {}

/// Big number.
class BIGNUM extends Struct {}

/// bn_gencb_st, or BN_GENCB, holds a callback function that is used by
/// generation functions that can take a very long time to complete.
/// Use BN_GENCB_set to initialise a BN_GENCB structure.
class BN_GENCB extends Struct {}

/// Certain BIGNUM operations need to use many temporary variables and
/// allocating and freeing them can be quite slow. Thus such operations
/// typically take a BN_CTX parameter, which contains a pool of BIGNUMs.
/// The ctx argument to a public function may be NULL, in which case a local
/// BN_CTX will be created just for the lifetime of that call.
///
/// A function must call BN_CTX_start first. Then, BN_CTX_get may be called
/// repeatedly to obtain temporary BIGNUMs. All BN_CTX_get calls must be made
/// before calling any other functions that use the ctx as an argument.
///
/// Finally, BN_CTX_end must be called before returning from the function.
/// When BN_CTX_end is called, the BIGNUM pointers obtained from BN_CTX_get
/// become invalid.
class BN_CTX extends Struct {}

/// Symmetric cipher.
class EVP_CIPHER extends Struct {}

/// An EVP_CIPHER_CTX represents the state of an encryption or decryption in
/// progress.
class EVP_CIPHER_CTX extends Struct {}

/// Authenticated Encryption with Additional Data.
class EVP_AEAD extends Struct {}

/// An EVP_AEAD_CTX represents an AEAD algorithm configured with a specific key and message-independent IV.
///
/// ```c
/// typedef struct evp_aead_ctx_st {
///   const EVP_AEAD *aead;
///   union evp_aead_ctx_st_state state;
///   // tag_len may contain the actual length of the authentication tag if it is
///   // known at initialization time.
///   uint8_t tag_len;
/// } EVP_AEAD_CTX;
/// ```
class EVP_AEAD_CTX extends Struct {}

/// An RSA object represents a public or private RSA key. A given object may be
/// used concurrently on multiple threads by non-mutating functions, provided no
/// other thread is concurrently calling a mutating function. Unless otherwise
/// documented, functions which take a const pointer are non-mutating and
/// functions which take a non-const pointer are mutating.
class RSA extends Struct {}

/// An EC_KEY object represents a public or private EC key. A given object may
/// be used concurrently on multiple threads by non-mutating functions, provided
/// no other thread is concurrently calling a mutating function. Unless
/// otherwise documented, functions which take a const pointer are non-mutating
/// and functions which take a non-const pointer are mutating.
class EC_KEY extends Struct {}

/// Elliptic curve group.
class EC_GROUP extends Struct {}

/// Elliptic curve point.
class EC_POINT extends Struct {}

/// ECDSA signature.
class ECDSA_SIG extends Struct {}

/// Type for `void*` used to represent opaque data.
class Data extends Struct {}

/// Type for `uint8_t*` used to represent byte data.
class Bytes extends Struct {}
