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
/// https://commondatastorage.googleapis.com/chromium-boringssl-docs/bn.h.html
library bn;

import 'dart:ffi';
import 'types.dart';
import 'lookup/lookup.dart';

// On 64bit we have.
// #define BN_ULONG uint64_t
// TODO: Solve BN_ULONG having a different size on other platforms.

//---------------------- Allocation and freeing.

/// BN_new creates a new, allocated BIGNUM and initialises it.
///
/// ```c
/// BIGNUM *BN_new(void);
/// ```
final BN_new = resolve(Sym.BN_new)
    .lookupFunc<Pointer<BIGNUM> Function()>()
    .asFunction<Pointer<BIGNUM> Function()>();

/// BN_free frees the data referenced by bn and, if bn was originally allocated
/// on the heap, frees bn also.
///
/// ```c
/// void BN_free(BIGNUM *bn);
/// ```
final BN_free = resolve(Sym.BN_free)
    .lookupFunc<Void Function(Pointer<BIGNUM>)>()
    .asFunction<void Function(Pointer<BIGNUM>)>();

/// BN_value_one returns a static BIGNUM with value 1.
///
/// ```c
/// OPENSSL_EXPORT const BIGNUM *BN_value_one(void);
/// ```
final BN_value_one = resolve(Sym.BN_value_one)
    .lookupFunc<Pointer<BIGNUM> Function()>()
    .asFunction<Pointer<BIGNUM> Function()>();

//---------------------- Basic functions.

/// BN_num_bytes returns the minimum number of bytes needed to represent the
/// absolute value of bn.
///
/// ```c
/// OPENSSL_EXPORT unsigned BN_num_bytes(const BIGNUM *bn);
/// ```
final BN_num_bytes = resolve(Sym.BN_num_bytes)
    .lookupFunc<Uint32 Function(Pointer<BIGNUM>)>()
    .asFunction<int Function(Pointer<BIGNUM>)>();

/// BN_set_word sets bn to value. It returns one on success or zero on
/// allocation failure.
///
/// ```c
/// int BN_set_word(BIGNUM *bn, BN_ULONG value);
/// ```
final BN_set_word = resolve(Sym.BN_set_word)
    .lookupFunc<Int32 Function(Pointer<BIGNUM>, Uint64)>()
    .asFunction<int Function(Pointer<BIGNUM>, int)>();
// TODO: Solve that int doesn't match Uint64, probably need to try BigInt

//---------------------- Conversion functions.

/// BN_bin2bn sets *ret to the value of len bytes from in, interpreted as a
/// big-endian number, and returns ret. If ret is NULL then a fresh BIGNUM is
/// allocated and returned. It returns NULL on allocation failure.
///
/// ```c
/// OPENSSL_EXPORT BIGNUM *BN_bin2bn(const uint8_t *in, size_t len, BIGNUM *ret);
/// ```
final BN_bin2bn = resolve(Sym.BN_bin2bn)
    .lookupFunc<
        Pointer<BIGNUM> Function(Pointer<Bytes>, IntPtr, Pointer<BIGNUM>)>()
    .asFunction<
        Pointer<BIGNUM> Function(Pointer<Bytes>, int, Pointer<BIGNUM>)>();

/// BN_bn2bin_padded serialises the absolute value of in to out as a big-endian
/// integer. The integer is padded with leading zeros up to size len. If len is
/// smaller than BN_num_bytes, the function fails and returns 0.
/// Otherwise,it returns 1.
///
/// ```c
/// OPENSSL_EXPORT int BN_bn2bin_padded(uint8_t *out, size_t len, const BIGNUM *in);
/// ```
final BN_bn2bin_padded = resolve(Sym.BN_bn2bin_padded)
    .lookupFunc<Int32 Function(Pointer<Bytes>, IntPtr, Pointer<BIGNUM>)>()
    .asFunction<int Function(Pointer<Bytes>, int, Pointer<BIGNUM>)>();

//---------------------- Simple arithmetic

/// BN_add sets r = a + b, where r may be the same pointer as either a or b.
/// It returns one on success and zero on allocation failure.
///
/// ```c
/// OPENSSL_EXPORT int BN_add(BIGNUM *r, const BIGNUM *a, const BIGNUM *b);
/// ```
final BN_add = resolve(Sym.BN_add)
    .lookupFunc<
        Int32 Function(Pointer<BIGNUM>, Pointer<BIGNUM>, Pointer<BIGNUM>)>()
    .asFunction<
        int Function(Pointer<BIGNUM>, Pointer<BIGNUM>, Pointer<BIGNUM>)>();

/// BN_sub sets r = a - b, where r may be the same pointer as either a or b.
/// It returns one on success and zero on allocation failure.
///
/// ```c
/// OPENSSL_EXPORT int BN_sub(BIGNUM *r, const BIGNUM *a, const BIGNUM *b);
/// ```
final BN_sub = resolve(Sym.BN_sub)
    .lookupFunc<
        Int32 Function(Pointer<BIGNUM>, Pointer<BIGNUM>, Pointer<BIGNUM>)>()
    .asFunction<
        int Function(Pointer<BIGNUM>, Pointer<BIGNUM>, Pointer<BIGNUM>)>();

//---------------------- Comparison functions

/// BN_cmp returns a value less than, equal to or greater than zero if a is less
/// than, equal to or greater than b, respectively.
///
/// ```c
/// OPENSSL_EXPORT int BN_cmp(const BIGNUM *a, const BIGNUM *b);
/// ```
final BN_cmp = resolve(Sym.BN_cmp)
    .lookupFunc<Int32 Function(Pointer<BIGNUM>, Pointer<BIGNUM>)>()
    .asFunction<int Function(Pointer<BIGNUM>, Pointer<BIGNUM>)>();

//---------------------- Bitwise operations.

/// BN_lshift sets r equal to a << n. The a and r arguments may be the same
/// BIGNUM. It returns one on success and zero on allocation failure.
///
/// ```c
/// OPENSSL_EXPORT int BN_lshift(BIGNUM *r, const BIGNUM *a, int n);
/// ```
final BN_lshift = resolve(Sym.BN_lshift)
    .lookupFunc<Int32 Function(Pointer<BIGNUM>, Pointer<BIGNUM>, Int32)>()
    .asFunction<int Function(Pointer<BIGNUM>, Pointer<BIGNUM>, int)>();
