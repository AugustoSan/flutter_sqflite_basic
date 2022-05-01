import 'dart:convert';

class PasswordModel {
  String cuenta = '';
  String password = '';
  int id = 0;

  PasswordModel({
    this.id = 0,
    this.cuenta = '',
    this.password = '',
  });

  /*
  Map<String, dynamic> toJson() => {
        "id": id,
        "cuenta": cuenta,
        "password": password,
      };
*/
  factory PasswordModel.fromJson(String str) =>
      PasswordModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PasswordModel.fromMap(Map<String, dynamic> json) => PasswordModel(
        id: json["id"] ?? 0,
        cuenta: json["cuenta"] ?? '',
        password: json["password"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "cuenta": cuenta,
        "password": password,
      };
}
