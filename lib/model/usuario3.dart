// ignore_for_file: file_names

import 'dart:core';

class Usuario {
  int idUsuario = 0;
  String nombre = '';
  String contrasenia = '';
  int idRol = 0;

  Usuario(
      {this.idUsuario = 0,
      this.nombre = '',
      this.contrasenia = '',
      this.idRol = 0});

  Usuario.fromJson(dynamic json) {
    idUsuario = int.parse(json['IdUsuario']);
    nombre = json['Nombre'];
    contrasenia = json['Contrasenia'];
    idRol = int.parse(json['IdRol']);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['IdUsuario'] = idUsuario.toString();
    map['Nombre'] = nombre;
    map['Contrasenia'] = contrasenia;
    map['IdRol'] = idRol.toString();
    return map;
  }
}
