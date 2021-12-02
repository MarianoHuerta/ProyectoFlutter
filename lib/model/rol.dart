import 'dart:core';

class Rol {
  int idRol = 0;
  String nombre ='';

Rol(
      {
      this.idRol = 0,
      this.nombre = ''});

  Rol.fromJson(dynamic json) {
    idRol = int.parse(json['IdRol']);
    nombre = (json['Nombre']);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['IdRol'] = idRol.toString();
    map['Nombre'] = nombre;
    return map;
  }
}