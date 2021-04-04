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
/// https://commondatastorage.googleapis.com/chromium-boringssl-docs/ec.h.html
library ecdh;

import 'dart:ffi';
import 'types.dart';
import 'lookup/lookup.dart';

//---------------------- Elliptic curve Diffie-Hellman.

/// ECDH_compute_key calculates the shared key between pub_key and priv_key. If kdf is not NULL, then it is called with the bytes of the shared key and the parameter out. When kdf returns, the value of *outlen becomes the return value. Otherwise, as many bytes of the shared key as will fit are copied directly to, at most, outlen bytes at out. It returns the number of bytes written to out, or -1 on error.
///
/// ```c
/// OPENSSL_EXPORT int ECDH_compute_key(
///     void *out, size_t outlen, const EC_POINT *pub_key, const EC_KEY *priv_key,
///     void *(*kdf)(const void *in, size_t inlen, void *out, size_t *outlen));
/// ```
///
final ECDH_compute_key = resolve(Sym.ECDH_compute_key)
    .lookupFunc<
        Int32 Function(
      Pointer<Data>,
      IntPtr,
      Pointer<EC_POINT>,
      Pointer<EC_KEY>,
      Pointer<
          NativeFunction<
              Void Function(
        Pointer<Data>,
        IntPtr,
        Pointer<Data>,
        Pointer<IntPtr>,
      )>>,
    )>()
    .asFunction<
        int Function(
      Pointer<Data>,
      int,
      Pointer<EC_POINT>,
      Pointer<EC_KEY>,
      Pointer<
          NativeFunction<
              Void Function(
        Pointer<Data>,
        IntPtr,
        Pointer<Data>,
        Pointer<IntPtr>,
      )>>,
    )>();
