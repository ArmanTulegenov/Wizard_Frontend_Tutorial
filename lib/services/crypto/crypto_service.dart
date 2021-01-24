import 'dart:convert';

import 'package:encrypt/encrypt.dart';

class CryptoUtils {
  static const String _IV = "0000000000000000";

  static String encodeBase64(String data) {
    return base64Encode(utf8.encode(data));
  }

  static String decodeBase64(String data) {
    return String.fromCharCodes(base64Decode(data));
  }

  static dynamic aesEncrypt(String encryptKey, String plainText) {
    try {
      encryptKey = prepareEncryptKey(encryptKey);
      final key = Key.fromUtf8(encryptKey);
      final iv = IV.fromUtf8(_IV);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final encrypted = encrypter.encrypt(plainText, iv: iv);
      return encrypted.base64;
    } catch (err) {
      print("aes encode error:$err");
      return null;
    }
  }

  static dynamic aesDecrypt(String encryptKey, String encrypted) {
    try {
      encryptKey = prepareEncryptKey(encryptKey);
      final key = Key.fromUtf8(encryptKey);
      final iv = IV.fromUtf8(_IV);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final decrypted = encrypter.decrypt64(encrypted, iv: iv);
      return decrypted;
    } catch (err) {
      print("aes decode error:$err");
      return null;
    }
  }

  static prepareEncryptKey(String encryptKey) {
    if (encryptKey.length > 32) {
      return encryptKey.substring(0, 32);
    }
    return encryptKey.padRight(32, 'Z');
  }
}
