import 'dart:typed_data';
import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:random_string/random_string.dart';

class EncryptionDecryptionHelper {
  static String _aesKey;
  static String _aesIv;
  static Key _key;
  static IV _iv;
  static Encrypted _encrypted;

  static String get getAESKey {
    return _aesKey;
  }

  static String getRSAPublicKey() {
    return '-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAw8MXJisODhbwspUD4XpYTdhCOUXfjdSeGpb306dbFFNqnCovWIQ9uKobfVi6V+WekX6Xw9pXNdEKIwlQceZfv06XUioC1RMQ9X15fyZIUpTyvM2BGE9+8WoAczdDWCLHI099L+5x9oCF4rZL9TBU+sFJap8gNcPktudIjZbwF5Ggh15fq9hp2lhSP5V5bDJpahGV1lyp55W/LmK+Kw58DToNJhl7iCbOmR7AZbPy28Ofq6AW9XdyA93sQKZJkAPoYhvJ3+6nB2FuqwWMDSN/LYTWaxxYFawWr6DlCSWl4k6hG3vKMCXlVemLpfek7r4nTH6XVHzUBjePLLaKJCOfAQIDAQAB\n-----END PUBLIC KEY-----';
  }

  static generateAESKey(int length) {
    _aesKey = randomAlphaNumeric(length);
    _key = Key.fromUtf8(_aesKey);
    _aesIv = randomAlphaNumeric(length);
    _iv = IV.fromUtf8(_aesIv);
    print(_aesKey);
  }

  static encryptData(String plaintext) {
    try {
      final encrypter =
          Encrypter(AES(_key, mode: AESMode.cbc, padding: "PKCS7"));
      final encrypted = encrypter.encrypt(plaintext, iv: _iv);
      Uint8List encryptedBytesListWithIv =
          Uint8List.fromList(_iv.bytes + encrypted.bytes);
      // print('AES IV: $_aesIv');
      // print('Encrypted : ${encrypted.base64}');
      // print('Combined : ${base64.encode(encryptedBytesListWithIv)}');
      return base64.encode(encryptedBytesListWithIv);
    } catch (e) {
      throw e;
    }
  }

  static encryptKey() {
    var keyParser = RSAKeyParser();
    final encrypter = Encrypter(
      RSA(
        publicKey: keyParser.parse(
          getRSAPublicKey(),
        ),
      ),
    );

    final encrypted = encrypter.encrypt(_aesKey);
    return encrypted.base64.toString();
  }

  static decryptData(String encryptedString) {
    try {
      // pad the encrypted base64 string with '=' characters until length matches a multiple of 4
      final int toPad = encryptedString.length % 4;
      if (toPad != 0) {
        encryptedString =
            encryptedString.padRight(encryptedString.length + toPad, "=");
      }

      // get first 16 bytes which is the initialization vector
      final iv = IV(Uint8List.fromList(
          base64Decode(encryptedString).getRange(0, 16).toList()));

      // get cipher bytes (without initialization vector)
      final Encrypted encrypted = Encrypted(Uint8List.fromList(
          base64Decode(encryptedString)
              .getRange(16, base64Decode(encryptedString).length)
              .toList()));

      // decrypt the string using the key and the initialization vector
      final key = Key.fromUtf8(_aesKey);
      final encrypter =
          Encrypter(AES(key, mode: AESMode.cbc, padding: "PKCS7"));
      return encrypter.decrypt(encrypted, iv: iv);
    } catch (e) {
      throw e;
    }
  }
}
