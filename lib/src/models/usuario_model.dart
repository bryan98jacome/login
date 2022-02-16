import 'dart:convert';

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({this.displayName, this.email, this.password});

  String? displayName;
  String? email;
  String? password;

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "email": email,
        "password": password,
      };
}
