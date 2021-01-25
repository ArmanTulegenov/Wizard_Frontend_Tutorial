import 'dart:io';

import 'package:flutter_app/models/user_details.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../crypto/crypto_service.dart';

class SqliteService {
  static final SqliteService _instance = SqliteService._internal();
  Database _database;

  factory SqliteService() {
    return _instance;
  }

  SqliteService._internal() {
    initDB();
  }

  Future<void> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Preferences.db");
    _database = await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Preferences ("
          "name TEXT PRIMARY KEY,"
          "value TEXT"
          ")");
      await db.execute(
          "INSERT INTO Preferences ('name', 'value')"
          "values (?, ?)",
          ["user_name", "user123"]);
      await db.execute(
          "INSERT INTO Preferences ('name', 'value')"
          "values (?, ?)",
          ["password", "PaFZDV0tgifuba1h4LiV2XJh44fUSgsb+KDQMUXxQz4="]);
    });
  }

  Future<UserDetails> getUserDetailsByUserName(
      String userName, String pinCode) async {
    if (null == _database) {
      return null;
    }
    var result = await _database.query("Preferences");
    UserDetails userDetails = new UserDetails();
    for (var row in result) {
      if (row['name'] == 'user_name') {
        userDetails.identity = row['value'];
      } else if (row['name'] == 'password') {
        var decryptedPassword = CryptoUtils.aesDecrypt(pinCode, row['value']);
        userDetails.password = decryptedPassword;
      }
    }
    return userDetails;
  }
}
