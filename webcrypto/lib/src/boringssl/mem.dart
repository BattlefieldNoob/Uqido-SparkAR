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
/// https://commondatastorage.googleapis.com/chromium-boringssl-docs/mem.h.html
///
/// BoringSSL has its own set of allocation functions, which keep track of
/// allocation lengths and zero them out before freeing. All memory returned by
/// BoringSSL API calls must therefore generally be freed using OPENSSL_free
/// unless stated otherwise.
library mem;

import 'dart:ffi';
import 'types.dart';
import 'lookup/lookup.dart';

/// OPENSSL_malloc acts like a regular malloc.
///
/// ```c
/// OPENSSL_EXPORT void *OPENSSL_malloc(size_t size);
/// ```
final OPENSSL_malloc = resolve(Sym.OPENSSL_malloc)
    .lookupFunc<Pointer<Data> Function(IntPtr)>()
    .asFunction<Pointer<Data> Function(int)>();

/// OPENSSL_free does nothing if ptr is NULL. Otherwise it zeros out the memory
/// allocated at ptr and frees it.
///
/// ```c
/// OPENSSL_EXPORT void OPENSSL_free(void *ptr);
/// ```
final OPENSSL_free = resolve(Sym.OPENSSL_free)
    .lookupFunc<Void Function(Pointer<Data>)>()
    .asFunction<void Function(Pointer<Data>)>();

/// CRYPTO_memcmp returns zero iff the len bytes at a and b are equal. It takes
/// an amount of time dependent on len, but independent of the contents of
/// a and b. Unlike memcmp, it cannot be used to put elements into a defined
/// order as the return value when a != b is undefined, other than to be
/// non-zero.
///
/// ```c
/// int CRYPTO_memcmp(const void *a, const void *b, size_t len);
/// ```
final CRYPTO_memcmp = resolve(Sym.CRYPTO_memcmp)
    .lookupFunc<Uint32 Function(Pointer<Data>, Pointer<Data>, IntPtr)>()
    .asFunction<int Function(Pointer<Data>, Pointer<Data>, int)>();

/// OPENSSL_memdup returns an allocated, duplicate of size bytes from data or
/// NULL on allocation failure.
///
/// ```c
/// OPENSSL_EXPORT void *OPENSSL_memdup(const void *data, size_t size);
/// ```
final OPENSSL_memdup = resolve(Sym.OPENSSL_memdup)
    .lookupFunc<Pointer<Data> Function(Pointer<Data>, IntPtr)>()
    .asFunction<Pointer<Data> Function(Pointer<Data>, int)>();
