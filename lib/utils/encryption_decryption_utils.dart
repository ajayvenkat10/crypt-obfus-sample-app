import 'dart:typed_data';
import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:random_string/random_string.dart';

class AesCryptHelper {
  static const int _KEY_LENGTH = 16;

  static String get _getRSAPublicKey {
    return '-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAw8MXJisODhbwspUD4XpYTdhCOUXfjdSeGpb306dbFFNqnCovWIQ9uKobfVi6V+WekX6Xw9pXNdEKIwlQceZfv06XUioC1RMQ9X15fyZIUpTyvM2BGE9+8WoAczdDWCLHI099L+5x9oCF4rZL9TBU+sFJap8gNcPktudIjZbwF5Ggh15fq9hp2lhSP5V5bDJpahGV1lyp55W/LmK+Kw58DToNJhl7iCbOmR7AZbPy28Ofq6AW9XdyA93sQKZJkAPoYhvJ3+6nB2FuqwWMDSN/LYTWaxxYFawWr6DlCSWl4k6hG3vKMCXlVemLpfek7r4nTH6XVHzUBjePLLaKJCOfAQIDAQAB\n-----END PUBLIC KEY-----';
  }

  static generateAesKey() {
    return randomAlphaNumeric(_KEY_LENGTH);
  }

  static encryptData(String plaintext, String aesKey) {
    try {
      final key = Key.fromUtf8(aesKey);
      final encrypter =
          Encrypter(AES(key, mode: AESMode.ecb, padding: "PKCS7"));
      final encrypted = encrypter.encrypt(plaintext);
      return encrypted.base64;
    } catch (e) {
      throw e;
      //TODO: Use CC logger
    }
  }

  static encryptKey(String aesKey) {
    var keyParser = RSAKeyParser();
    final encrypter = Encrypter(
      RSA(
        publicKey: keyParser.parse(
          _getRSAPublicKey,
        ),
      ),
    );

    final encrypted = encrypter.encrypt(aesKey);
    return encrypted.base64.toString();
  }

  static decryptData(String encryptedString, String aesKey) {
    try {
      // pad the encrypted base64 string with '=' characters until length matches a multiple of 4
      final int toPad = encryptedString.length % 4;
      if (toPad != 0) {
        encryptedString =
            encryptedString.padRight(encryptedString.length + toPad, "=");
      }
      // get cipher bytes
      final Encrypted encrypted =
          Encrypted(Uint8List.fromList(base64Decode(encryptedString).toList()));

      // decrypt the string using the key
      final key = Key.fromUtf8(aesKey);
      final encrypter =
          Encrypter(AES(key, mode: AESMode.ecb, padding: "PKCS7"));
      return encrypter.decrypt(encrypted);
    } catch (e) {
      throw e;
      //TODO: Use CC logger
    }
  }
}
