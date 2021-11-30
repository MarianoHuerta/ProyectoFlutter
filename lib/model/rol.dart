import 'dart:core';

class Rol {
  int idRol = 0;
  String nombre = '';

  Rol.fromJson(dynamic json) {
    idRol = json['IdRol'];
    nombre = json['Nombre'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['IdRol'] = idRol;
    map['Nombre'] = nombre;
    return map;
  }
}