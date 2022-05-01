import 'package:flutter/material.dart';

import 'package:flutter_sqflite_basic/models/password_model.dart';
import 'package:flutter_sqflite_basic/providers/db_provider.dart';

class PasswordProvider with ChangeNotifier {
  bool onLoad = false;
  bool inputObscureText = true;
  PasswordModel passModel = PasswordModel();

  void obscureText(bool value) {
    inputObscureText = value;
    notifyListeners();
  }

  Future<int> savePassword() async {
    onLoad = true;
    notifyListeners();
    int id = await DBProvider.db.nuevoPassword(passModel);
    onLoad = false;
    notifyListeners();
    return id;
  }

  Future<PasswordModel> viewAccounts(int id) async {
    onLoad = true;
    notifyListeners();
    PasswordModel acount = await DBProvider.db.getAccount(id);
    onLoad = false;
    notifyListeners();
    return acount;
  }

  Future<List<PasswordModel>> getAllAccounts() async {
    onLoad = true;
    notifyListeners();
    final list = await DBProvider.db.getAllAccounts();
    onLoad = false;
    notifyListeners();
    return list;
  }
}
