import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:uqido_sparkar/db/rest_client.dart';
import 'package:webcrypto/webcrypto.dart';

class EncryptedLoginData {
  final String lsd;
  final String encpass;

  EncryptedLoginData(this.lsd, this.encpass);
}

Future<EncryptedLoginData> getEncryptedPasswordAndLoginData(
    String unencryptedPassword) async {
  final RestClient client = RestClient(Dio());

  //get public keys for encrypt
  var encryptdata = await client.getPublicKeys();
  var data = encryptdata;

  var encpass = await _passwordEncrypt(unencryptedPassword, data);

  return EncryptedLoginData(data['lsd'], encpass);
}

Future<String> _passwordEncrypt(String password, dynamic encryption) async {
  final publicKey = (encryption['encryption'] as dynamic)!['publickey'];
  final keyId =
      int.parse((encryption['encryption'] as dynamic)!['keyId'] as String);
  final seal =
      (encryption['seal'] as Map<dynamic, dynamic>).values.cast<int>().toList();
  final key = encryption['generatedKey'];
  final raw =
      (encryption['raw'] as Map<dynamic, dynamic>).values.cast<int>().toList();
  var date = (DateTime.now().millisecondsSinceEpoch / 1e3).floor().toString();
  return await _encryptPassword(
      keyId, publicKey, password, date, seal, key, raw);
}

Future<String> _encryptPassword(a, publicKey, String password, String date,
    List<int> seal, keyy, List<int> raw) async {
  var f, g, passwordBytes, dateBytes;
  f = "#PWD_BROWSER";
  g = 5;
  passwordBytes = password.codeUnits;
  dateBytes = date.codeUnits;
  var key =
      await _encrypt(a, publicKey, passwordBytes, dateBytes, seal, keyy, raw);
  return [f, g, date, base64Encode(key)].join(":");
}

Future<Uint8List> _encrypt(a, publicKey, passwordBytes, dateBytes,
    List<int> seal, key, List<int> raw) async {
  var f, s, u, v, w, x;
  var h = 64,
      i = 1,
      j = 1,
      k = 1,
      l = 48,
      m = 2,
      n = 32,
      o = 16,
      p = j + k + m + n + l + o;
  f = p + passwordBytes.length;
  var t = Uint8List(f);
  u = 0;
  t[u] = i;
  u += j;
  t[u] = a;
  u += k;

  var secretKey = await AesGcmSecretKey.importRawKey(raw);
  var enc = await secretKey.encryptBytes(passwordBytes, Uint8List(12),
      additionalData: dateBytes);
  o = 16;
  var b = seal;

  t[u] = b.length & 255;
  t[u + 1] = b.length >> 8 & 255;
  u += m;
  //t.set(b, u);
  t.setAll(u, b);
  u += n;
  u += l;
  if (b.length != n + l) throw new Error();
  b = enc;
  var end = b.length - o;
  if (end < 0) {
    end = b.length - o;
  }
  a = b.sublist(b.length - o);
  b = b.sublist(0, b.length - o);
  //t.set(a, u);
  t.setAll(u, a);
  u += o;
  //t.set(b, u);
  t.setAll(u, b);
  return t;
}
