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

// ignore_for_file: non_constant_identifier_names

/// This library maps symbols from:
/// https://commondatastorage.googleapis.com/chromium-boringssl-docs/evp.h.html
library evp;

import 'dart:ffi';
import 'types.dart';
import 'lookup/lookup.dart';
import 'bytestring.dart';

//---------------------- Public key objects.

/// EVP_PKEY_new creates a new, empty public-key object and returns it or NULL
/// on allocation failure.
///
/// ```c
/// EVP_PKEY *EVP_PKEY_new(void);
/// ```
final EVP_PKEY_new = resolve(Sym.EVP_PKEY_new)
    .lookupFunc<Pointer<EVP_PKEY> Function()>()
    .asFunction<Pointer<EVP_PKEY> Function()>();

/// EVP_PKEY_free frees all data referenced by pkey and then frees pkey itself.
///
/// ```c
/// void EVP_PKEY_free(EVP_PKEY *pkey);
/// ```
final EVP_PKEY_free_ =
    resolve(Sym.EVP_PKEY_free).lookupFunc<Void Function(Pointer<EVP_PKEY>)>();

/// EVP_PKEY_free frees all data referenced by pkey and then frees pkey itself.
///
/// ```c
/// void EVP_PKEY_free(EVP_PKEY *pkey);
/// ```
final EVP_PKEY_free =
    EVP_PKEY_free_.asFunction<void Function(Pointer<EVP_PKEY>)>();

/// EVP_PKEY_id returns the type of pkey, which is one of the EVP_PKEY_* values.
///
/// ```c
/// OPENSSL_EXPORT int EVP_PKEY_id(const EVP_PKEY *pkey);
/// ```
final EVP_PKEY_id = resolve(Sym.EVP_PKEY_id)
    .lookupFunc<Int32 Function(Pointer<EVP_PKEY>)>()
    .asFunction<int Function(Pointer<EVP_PKEY>)>();

//---------------------- Getting and setting concrete public key types

/// The following functions get and set the underlying public key in an EVP_PKEY
/// object. The set1 functions take an additional reference to the underlying
/// key and return one on success or zero if key is NULL. The assign functions
/// adopt the caller's reference and return one on success or zero if key is
/// NULL. The get1 functions return a fresh reference to the underlying object
/// or NULL if pkey is not of the correct type. The get0 functions behave the
/// same but return a non-owning pointer.
///
/// The get0 and get1 functions take const pointers and are thus non-mutating
/// for thread-safety purposes, but mutating functions on the returned
/// lower-level objects are considered to also mutate the EVP_PKEY and may not
/// be called concurrently with other operations on the EVP_PKEY.
///
/// ```c
/// int EVP_PKEY_set1_RSA(EVP_PKEY *pkey, RSA *key);
/// int EVP_PKEY_assign_RSA(EVP_PKEY *pkey, RSA *key);
/// RSA *EVP_PKEY_get0_RSA(const EVP_PKEY *pkey);
/// RSA *EVP_PKEY_get1_RSA(const EVP_PKEY *pkey);
/// int EVP_PKEY_set1_DSA(EVP_PKEY *pkey, DSA *key);
/// int EVP_PKEY_assign_DSA(EVP_PKEY *pkey, DSA *key);
/// DSA *EVP_PKEY_get0_DSA(const EVP_PKEY *pkey);
/// DSA *EVP_PKEY_get1_DSA(const EVP_PKEY *pkey);
/// int EVP_PKEY_set1_EC_KEY(EVP_PKEY *pkey, EC_KEY *key);
/// int EVP_PKEY_assign_EC_KEY(EVP_PKEY *pkey, EC_KEY *key);
/// EC_KEY *EVP_PKEY_get0_EC_KEY(const EVP_PKEY *pkey);
/// EC_KEY *EVP_PKEY_get1_EC_KEY(const EVP_PKEY *pkey);
/// ```
final EVP_PKEY_set1_RSA = resolve(Sym.EVP_PKEY_set1_RSA)
    .lookupFunc<Int32 Function(Pointer<EVP_PKEY>, Pointer<RSA>)>()
    .asFunction<int Function(Pointer<EVP_PKEY>, Pointer<RSA>)>();

final EVP_PKEY_get1_RSA = resolve(Sym.EVP_PKEY_get1_RSA)
    .lookupFunc<Pointer<RSA> Function(Pointer<EVP_PKEY>)>()
    .asFunction<Pointer<RSA> Function(Pointer<EVP_PKEY>)>();

final EVP_PKEY_set1_EC_KEY = resolve(Sym.EVP_PKEY_set1_EC_KEY)
    .lookupFunc<Int32 Function(Pointer<EVP_PKEY>, Pointer<EC_KEY>)>()
    .asFunction<int Function(Pointer<EVP_PKEY>, Pointer<EC_KEY>)>();

final EVP_PKEY_get1_EC_KEY = resolve(Sym.EVP_PKEY_get1_EC_KEY)
    .lookupFunc<Pointer<EC_KEY> Function(Pointer<EVP_PKEY>)>()
    .asFunction<Pointer<EC_KEY> Function(Pointer<EVP_PKEY>)>();

/// Constants that can be returned from [EVP_PKEY_id] or set with
/// [EVP_PKEY_set_type].
///
/// ```c
/// // from evp.h and nid.h
/// #define EVP_PKEY_NONE NID_undef
/// #define NID_undef 0
///
/// #define EVP_PKEY_RSA NID_rsaEncryption
/// #define NID_rsaEncryption 6
///
/// #define EVP_PKEY_RSA_PSS NID_rsassaPss
/// #define NID_rsassaPss 912
///
/// #define EVP_PKEY_DSA NID_dsa
/// #define NID_dsa 116
///
/// #define EVP_PKEY_EC NID_X9_62_id_ecPublicKey
/// #define NID_X9_62_id_ecPublicKey 408
///
/// #define EVP_PKEY_ED25519 NID_ED25519
/// #define NID_ED25519 949
/// ```
const int EVP_PKEY_RSA = 6,
    EVP_PKEY_RSA_PSS = 912,
    EVP_PKEY_DSA = 116,
    EVP_PKEY_EC = 408,
    EVP_PKEY_ED25519 = 949;

/// EVP_PKEY_set_type sets the type of pkey to type. It returns one if
/// successful or zero if the type argument is not one of the EVP_PKEY_* values.
/// If pkey is NULL, it simply reports whether the type is known.
///
/// ```c
/// OPENSSL_EXPORT int EVP_PKEY_set_type(EVP_PKEY *pkey, int type);
/// ```
final EVP_PKEY_set_type = resolve(Sym.EVP_PKEY_set_type)
    .lookupFunc<Int32 Function(Pointer<EVP_PKEY>, Int32)>()
    .asFunction<int Function(Pointer<EVP_PKEY>, int)>();

//---------------------- ASN.1 functions

/// EVP_parse_public_key decodes a DER-encoded SubjectPublicKeyInfo structure
/// (RFC 5280) from cbs and advances cbs. It returns a newly-allocated
/// EVP_PKEY or NULL on error. If the key is an EC key, the curve is guaranteed
/// to be set.
///
/// The caller must check the type of the parsed public key to ensure it is
/// suitable and validate other desired key properties such as RSA modulus
/// size or EC curve.
///
/// ```c
/// EVP_PKEY *EVP_parse_public_key(CBS *cbs);
/// ```
final EVP_parse_public_key = resolve(Sym.EVP_parse_public_key)
    .lookupFunc<Pointer<EVP_PKEY> Function(Pointer<CBS>)>()
    .asFunction<Pointer<EVP_PKEY> Function(Pointer<CBS>)>();

/// EVP_marshal_public_key marshals key as a DER-encoded SubjectPublicKeyInfo
/// structure (RFC 5280) and appends the result to cbb. It returns one on
/// success and zero on error.
///
/// ```c
/// int EVP_marshal_public_key(CBB *cbb, const EVP_PKEY *key);
/// ```
final EVP_marshal_public_key = resolve(Sym.EVP_marshal_public_key)
    .lookupFunc<Int32 Function(Pointer<CBB>, Pointer<EVP_PKEY>)>()
    .asFunction<int Function(Pointer<CBB>, Pointer<EVP_PKEY>)>();

/// EVP_parse_private_key decodes a DER-encoded PrivateKeyInfo structure
/// (RFC 5208) from cbs and advances cbs. It returns a newly-allocated EVP_PKEY
/// or NULL on error.
///
/// The caller must check the type of the parsed private key to ensure it is
/// suitable and validate other desired key properties such as RSA modulus size
/// or EC curve.
///
/// A PrivateKeyInfo ends with an optional set of attributes. These are not
/// processed and so this function will silently ignore any trailing data in
/// the structure.
///
/// ```c
/// EVP_PKEY *EVP_parse_private_key(CBS *cbs);
/// ```
final EVP_parse_private_key = resolve(Sym.EVP_parse_private_key)
    .lookupFunc<Pointer<EVP_PKEY> Function(Pointer<CBS>)>()
    .asFunction<Pointer<EVP_PKEY> Function(Pointer<CBS>)>();

/// EVP_marshal_private_key marshals key as a DER-encoded PrivateKeyInfo
/// structure (RFC 5208) and appends the result to cbb. It returns one on
/// success and zero on error.
///
/// ```c
/// int EVP_marshal_private_key(CBB *cbb, const EVP_PKEY *key);
/// ```
final EVP_marshal_private_key = resolve(Sym.EVP_marshal_private_key)
    .lookupFunc<Int32 Function(Pointer<CBB>, Pointer<EVP_PKEY>)>()
    .asFunction<int Function(Pointer<CBB>, Pointer<EVP_PKEY>)>();

//---------------------- Signing

/// EVP_DigestSignInit sets up ctx for a signing operation with type and pkey.
/// The ctx argument must have been initialised with EVP_MD_CTX_init. If pctx
/// is not NULL, the EVP_PKEY_CTX of the signing operation will be written to
/// *pctx; this can be used to set alternative signing options.
///
/// For single-shot signing algorithms which do not use a pre-hash, such as
/// Ed25519, type should be NULL. The EVP_MD_CTX itself is unused but is present
/// so the API is uniform. See EVP_DigestSign.
///
/// This function does not mutate pkey for thread-safety purposes and may be
/// used concurrently with other non-mutating functions on pkey.
///
/// It returns one on success, or zero on error.
/// ```c
/// int EVP_DigestSignInit(EVP_MD_CTX *ctx, EVP_PKEY_CTX **pctx,
///                                       const EVP_MD *type, ENGINE *e,
///                                       EVP_PKEY *pkey);
/// ```
final EVP_DigestSignInit = resolve(Sym.EVP_DigestSignInit)
    .lookupFunc<
        Int32 Function(
      Pointer<EVP_MD_CTX>,
      Pointer<Pointer<EVP_PKEY_CTX>>,
      Pointer<EVP_MD>,
      Pointer<ENGINE>,
      Pointer<EVP_PKEY>,
    )>()
    .asFunction<
        int Function(
      Pointer<EVP_MD_CTX>,
      Pointer<Pointer<EVP_PKEY_CTX>>,
      Pointer<EVP_MD>,
      Pointer<ENGINE>,
      Pointer<EVP_PKEY>,
    )>();

/// EVP_DigestSignUpdate appends len bytes from data to the data which will be
/// signed in EVP_DigestSignFinal. It returns one.
///
/// This function performs a streaming signing operation and will fail for
/// signature algorithms which do not support this. Use EVP_DigestSign for a
/// single-shot operation.
///
/// ```c
/// int EVP_DigestSignUpdate(EVP_MD_CTX *ctx, const void *data,
///                                         size_t len);
/// ```
final EVP_DigestSignUpdate = resolve(Sym.EVP_DigestSignUpdate)
    .lookupFunc<Int32 Function(Pointer<EVP_MD_CTX>, Pointer<Data>, IntPtr)>()
    .asFunction<int Function(Pointer<EVP_MD_CTX>, Pointer<Data>, int)>();

/// EVP_DigestSignFinal signs the data that has been included by one or more
/// calls to EVP_DigestSignUpdate. If out_sig is NULL then *out_sig_len is set
/// to the maximum number of output bytes. Otherwise, on entry, *out_sig_len
/// must contain the length of the out_sig buffer. If the call is successful,
/// the signature is written to out_sig and *out_sig_len is set to its length.
///
/// This function performs a streaming signing operation and will fail for
/// signature algorithms which do not support this. Use EVP_DigestSign for a
/// single-shot operation.
///
/// It returns one on success, or zero on error.
///
/// ```c
/// int EVP_DigestSignFinal(EVP_MD_CTX *ctx, uint8_t *out_sig,
///                                        size_t *out_sig_len);
/// ```
final EVP_DigestSignFinal = resolve(Sym.EVP_DigestSignFinal)
    .lookupFunc<
        Int32 Function(
      Pointer<EVP_MD_CTX>,
      Pointer<Bytes>,
      Pointer<IntPtr>,
    )>()
    .asFunction<
        int Function(
      Pointer<EVP_MD_CTX>,
      Pointer<Bytes>,
      Pointer<IntPtr>,
    )>();

//---------------------- Verifying

/// EVP_DigestVerifyInit sets up ctx for a signature verification operation
/// with type and pkey. The ctx argument must have been initialised with
/// EVP_MD_CTX_init. If pctx is not NULL, the EVP_PKEY_CTX of the signing
/// operation will be written to *pctx; this can be used to set alternative
/// signing options.
///
/// For single-shot signing algorithms which do not use a pre-hash, such as
/// Ed25519, type should be NULL. The EVP_MD_CTX itself is unused but is present
/// so the API is uniform. See EVP_DigestVerify.
///
/// This function does not mutate pkey for thread-safety purposes and may be
/// used concurrently with other non-mutating functions on pkey.
///
/// It returns one on success, or zero on error.
///
/// ```c
/// int EVP_DigestVerifyInit(EVP_MD_CTX *ctx, EVP_PKEY_CTX **pctx,
///                                         const EVP_MD *type, ENGINE *e,
///                                         EVP_PKEY *pkey);
/// ```
final EVP_DigestVerifyInit = resolve(Sym.EVP_DigestVerifyInit)
    .lookupFunc<
        Int32 Function(
      Pointer<EVP_MD_CTX>,
      Pointer<Pointer<EVP_PKEY_CTX>>,
      Pointer<EVP_MD>,
      Pointer<ENGINE>,
      Pointer<EVP_PKEY>,
    )>()
    .asFunction<
        int Function(
      Pointer<EVP_MD_CTX>,
      Pointer<Pointer<EVP_PKEY_CTX>>,
      Pointer<EVP_MD>,
      Pointer<ENGINE>,
      Pointer<EVP_PKEY>,
    )>();

/// EVP_DigestVerifyUpdate appends len bytes from data to the data which will be
/// verified by EVP_DigestVerifyFinal. It returns one.
///
/// This function performs streaming signature verification and will fail for
/// signature algorithms which do not support this. Use EVP_PKEY_verify_message
/// for a single-shot verification.
///
/// ```c
/// int EVP_DigestVerifyUpdate(EVP_MD_CTX *ctx, const void *data,
///                                           size_t len);
/// ```
final EVP_DigestVerifyUpdate = resolve(Sym.EVP_DigestVerifyUpdate)
    .lookupFunc<Int32 Function(Pointer<EVP_MD_CTX>, Pointer<Data>, IntPtr)>()
    .asFunction<int Function(Pointer<EVP_MD_CTX>, Pointer<Data>, int)>();

/// EVP_DigestVerifyFinal verifies that sig_len bytes of sig are a valid
/// signature for the data that has been included by one or more calls to
/// EVP_DigestVerifyUpdate. It returns one on success and zero otherwise.
///
/// This function performs streaming signature verification and will fail for
/// signature algorithms which do not support this. Use EVP_PKEY_verify_message
/// for a single-shot verification.
///
/// ```c
/// int EVP_DigestVerifyFinal(EVP_MD_CTX *ctx, const uint8_t *sig,
///                                          size_t sig_len);
/// ```
final EVP_DigestVerifyFinal = resolve(Sym.EVP_DigestVerifyFinal)
    .lookupFunc<Int32 Function(Pointer<EVP_MD_CTX>, Pointer<Bytes>, IntPtr)>()
    .asFunction<int Function(Pointer<EVP_MD_CTX>, Pointer<Bytes>, int)>();

//---------------------- Password stretching.

// Password stretching functions take a low-entropy password and apply a slow
// function that results in a key suitable for use in symmetric cryptography.

/// PKCS5_PBKDF2_HMAC computes iterations iterations of PBKDF2 of password and
/// salt, using digest, and outputs key_len bytes to out_key. It returns one on
/// success and zero on allocation failure or if iterations is 0.
///
/// ```c
/// OPENSSL_EXPORT int PKCS5_PBKDF2_HMAC(const char *password, size_t password_len,
///                                      const uint8_t *salt, size_t salt_len,
///                                      unsigned iterations, const EVP_MD *digest,
///                                      size_t key_len, uint8_t *out_key);
/// ```
final PKCS5_PBKDF2_HMAC = resolve(Sym.PKCS5_PBKDF2_HMAC)
    .lookupFunc<
        Int32 Function(
      Pointer<Int8>,
      IntPtr,
      Pointer<Bytes>,
      IntPtr,
      Uint32,
      Pointer<EVP_MD>,
      IntPtr,
      Pointer<Bytes>,
    )>()
    .asFunction<
        int Function(
      Pointer<Int8>,
      int,
      Pointer<Bytes>,
      int,
      int,
      Pointer<EVP_MD>,
      int,
      Pointer<Bytes>,
    )>();

//---------------------- Public key contexts

/// EVP_PKEY_CTX_new allocates a fresh EVP_PKEY_CTX for use with pkey.
/// It returns the context or NULL on error.
///
/// ```c
/// OPENSSL_EXPORT EVP_PKEY_CTX *EVP_PKEY_CTX_new(EVP_PKEY *pkey, ENGINE *e);
/// ```
final EVP_PKEY_CTX_new = resolve(Sym.EVP_PKEY_CTX_new)
    .lookupFunc<
        Pointer<EVP_PKEY_CTX> Function(Pointer<EVP_PKEY>, Pointer<ENGINE>)>()
    .asFunction<
        Pointer<EVP_PKEY_CTX> Function(Pointer<EVP_PKEY>, Pointer<ENGINE>)>();

/// EVP_PKEY_CTX_free frees ctx and the data it owns.
///
/// ```c
/// OPENSSL_EXPORT void EVP_PKEY_CTX_free(EVP_PKEY_CTX *ctx);
/// ```
final EVP_PKEY_CTX_free = resolve(Sym.EVP_PKEY_CTX_free)
    .lookupFunc<Void Function(Pointer<EVP_PKEY_CTX>)>()
    .asFunction<void Function(Pointer<EVP_PKEY_CTX>)>();

/// EVP_PKEY_encrypt_init initialises an EVP_PKEY_CTX for an encryption operation. It should be called before EVP_PKEY_encrypt.
///
/// It returns one on success or zero on error.
///
/// ```c
/// OPENSSL_EXPORT int EVP_PKEY_encrypt_init(EVP_PKEY_CTX *ctx);
/// ```
final EVP_PKEY_encrypt_init = resolve(Sym.EVP_PKEY_encrypt_init)
    .lookupFunc<Int32 Function(Pointer<EVP_PKEY_CTX>)>()
    .asFunction<int Function(Pointer<EVP_PKEY_CTX>)>();

/// EVP_PKEY_encrypt encrypts in_len bytes from in. If out is NULL, the maximum size of the ciphertext is written to out_len. Otherwise, *out_len must contain the number of bytes of space available at out. If sufficient, the ciphertext will be written to out and *out_len updated with the true length.
///
/// WARNING: Setting out to NULL only gives the maximum size of the ciphertext. The actual ciphertext may be smaller.
///
/// It returns one on success or zero on error.
///
/// ```c
/// OPENSSL_EXPORT int EVP_PKEY_encrypt(EVP_PKEY_CTX *ctx, uint8_t *out,
///                                     size_t *out_len, const uint8_t *in,
///                                     size_t in_len);
/// ```
final EVP_PKEY_encrypt = resolve(Sym.EVP_PKEY_encrypt)
    .lookupFunc<
        Int32 Function(
      Pointer<EVP_PKEY_CTX>,
      Pointer<Bytes>,
      Pointer<IntPtr>,
      Pointer<Bytes>,
      IntPtr,
    )>()
    .asFunction<
        int Function(
      Pointer<EVP_PKEY_CTX>,
      Pointer<Bytes>,
      Pointer<IntPtr>,
      Pointer<Bytes>,
      int,
    )>();

/// EVP_PKEY_decrypt_init initialises an EVP_PKEY_CTX for a decryption
/// operation. It should be called before EVP_PKEY_decrypt.
///
/// It returns one on success or zero on error.
///
/// ```c
/// OPENSSL_EXPORT int EVP_PKEY_decrypt_init(EVP_PKEY_CTX *ctx);
/// ```
final EVP_PKEY_decrypt_init = resolve(Sym.EVP_PKEY_decrypt_init)
    .lookupFunc<Int32 Function(Pointer<EVP_PKEY_CTX>)>()
    .asFunction<int Function(Pointer<EVP_PKEY_CTX>)>();

/// EVP_PKEY_decrypt decrypts in_len bytes from in. If out is NULL, the maximum
/// size of the plaintext is written to out_len. Otherwise, *out_len must
/// contain the number of bytes of space available at out. If sufficient, the
/// ciphertext will be written to out and *out_len updated with the true length.
///
/// WARNING: Setting out to NULL only gives the maximum size of the plaintext.
/// The actual plaintext may be smaller.
///
/// It returns one on success or zero on error.
///
/// ```c
/// OPENSSL_EXPORT int EVP_PKEY_decrypt(EVP_PKEY_CTX *ctx, uint8_t *out,
///                                     size_t *out_len, const uint8_t *in,
///                                     size_t in_len);
/// ```
final EVP_PKEY_decrypt = resolve(Sym.EVP_PKEY_decrypt)
    .lookupFunc<
        Int32 Function(
      Pointer<EVP_PKEY_CTX>,
      Pointer<Bytes>,
      Pointer<IntPtr>,
      Pointer<Bytes>,
      IntPtr,
    )>()
    .asFunction<
        int Function(
      Pointer<EVP_PKEY_CTX>,
      Pointer<Bytes>,
      Pointer<IntPtr>,
      Pointer<Bytes>,
      int,
    )>();

//---------------------- RSA specific control functions

/// EVP_PKEY_CTX_set_rsa_padding sets the padding type to use. It should be one
/// of the RSA_*_PADDING values. Returns one on success or zero on error.
///
/// ```c
/// OPENSSL_EXPORT int EVP_PKEY_CTX_set_rsa_padding(EVP_PKEY_CTX *ctx, int padding);
/// ```
final EVP_PKEY_CTX_set_rsa_padding = resolve(Sym.EVP_PKEY_CTX_set_rsa_padding)
    .lookupFunc<Int32 Function(Pointer<EVP_PKEY_CTX>, Int32)>()
    .asFunction<int Function(Pointer<EVP_PKEY_CTX>, int)>();

/// EVP_PKEY_CTX_set_rsa_pss_saltlen sets the length of the salt in a PSS-padded
/// signature. A value of -1 cause the salt to be the same length as the digest
/// in the signature. A value of -2 causes the salt to be the maximum length
/// that will fit when signing and recovered from the signature when verifying.
/// Otherwise the value gives the size of the salt in bytes.
///
/// If unsure, use -1.
///
/// Returns one on success or zero on error.
/// ```c
/// OPENSSL_EXPORT int EVP_PKEY_CTX_set_rsa_pss_saltlen(EVP_PKEY_CTX *ctx,
///                                                     int salt_len);
/// ```
final EVP_PKEY_CTX_set_rsa_pss_saltlen =
    resolve(Sym.EVP_PKEY_CTX_set_rsa_pss_saltlen)
        .lookupFunc<Int32 Function(Pointer<EVP_PKEY_CTX>, Int32)>()
        .asFunction<int Function(Pointer<EVP_PKEY_CTX>, int)>();

/// EVP_PKEY_CTX_set_rsa_oaep_md sets md as the digest used in OAEP padding.
/// Returns one on success or zero on error.
///
/// ```c
/// OPENSSL_EXPORT int EVP_PKEY_CTX_set_rsa_oaep_md(EVP_PKEY_CTX *ctx,
///                                                 const EVP_MD *md);
/// ```
final EVP_PKEY_CTX_set_rsa_oaep_md = resolve(Sym.EVP_PKEY_CTX_set_rsa_oaep_md)
    .lookupFunc<Int32 Function(Pointer<EVP_PKEY_CTX>, Pointer<EVP_MD>)>()
    .asFunction<int Function(Pointer<EVP_PKEY_CTX>, Pointer<EVP_MD>)>();

/// EVP_PKEY_CTX_set_rsa_mgf1_md sets md as the digest used in MGF1. Returns one
/// on success or zero on error.
///
/// ```c
/// OPENSSL_EXPORT int EVP_PKEY_CTX_set_rsa_mgf1_md(EVP_PKEY_CTX *ctx,
///                                                 const EVP_MD *md);
/// ```
final EVP_PKEY_CTX_set_rsa_mgf1_md = resolve(Sym.EVP_PKEY_CTX_set_rsa_mgf1_md)
    .lookupFunc<Int32 Function(Pointer<EVP_PKEY_CTX>, Pointer<EVP_MD>)>()
    .asFunction<int Function(Pointer<EVP_PKEY_CTX>, Pointer<EVP_MD>)>();

/// EVP_PKEY_CTX_set0_rsa_oaep_label sets label_len bytes from label as the
/// label used in OAEP. DANGER: On success, this call takes ownership of label
/// and will call OPENSSL_free on it when ctx is destroyed.
///
/// Returns one on success or zero on error.
///
/// ```c
/// OPENSSL_EXPORT int EVP_PKEY_CTX_set0_rsa_oaep_label(EVP_PKEY_CTX *ctx,
///                                                     uint8_t *label,
///                                                     size_t label_len);
/// ```
final EVP_PKEY_CTX_set0_rsa_oaep_label = resolve(
  Sym.EVP_PKEY_CTX_set0_rsa_oaep_label,
)
    .lookupFunc<Int32 Function(Pointer<EVP_PKEY_CTX>, Pointer<Bytes>, IntPtr)>()
    .asFunction<int Function(Pointer<EVP_PKEY_CTX>, Pointer<Bytes>, int)>();
