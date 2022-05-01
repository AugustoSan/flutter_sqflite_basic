import 'dart:io';
import 'package:flutter_sqflite_basic/models/password_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    //Path de donde se almacenara la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'passwordDB.db');
    //Crear la base de datos
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE Password(
            id INTEGER PRIMARY KEY,
            password TEXT,
            cuenta TEXT
          )
      ''');
    });
  }

  Future<void> deleteDB() async {
    //Path de donde se almacenara la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'passwordDB.db');
    //Crear la base de datos
    await deleteDatabase(path);
    _database = null;
  }

  Future<int> nuevoPassword(PasswordModel passwordModel) async {
    //Verificar la bd
    final db = await database;
    final res = await db.insert('Password', passwordModel.toMap());

    //Es el id del ultimo registro insertado
    return res;
  }

  Future<PasswordModel> getAccount(int id) async {
    PasswordModel account = PasswordModel();
    final db = await database;
    final res = await db.query('Password', where: 'id = ?', whereArgs: [id]);
    if (res.isNotEmpty) {
      account = PasswordModel.fromMap(res.first);
    }
    return account;
  }

  Future<List<PasswordModel>> getAllAccounts() async {
    final db = await database;
    final res = await db.query('Password');

    return res.isNotEmpty
        ? res.map((s) => PasswordModel.fromMap(s)).toList()
        : [];
  }
}
