// ignore_for_file: file_names

import 'dart:core';

class Paciente {
  int idPaciente = 0;
  String nombres = '';
  String apellidos = '';
  int edad = 0;
  String fechaNaci = '';

  Paciente();

  Paciente.fromJson(dynamic json) {
    idPaciente = int.parse(json['IdPaciente']);
    nombres = json['Nombres'];
    apellidos = json['Apellidos'];
    edad = int.parse(json['Edad']);
    fechaNaci = json['FechaNaci'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['IdPaciente'] = idPaciente;
    map['Nombres'] = nombres;
    map['Apellidos'] = apellidos;
    map['Edad'] = edad;
    map['FechaNaci'] = fechaNaci;
    return map;
  }
}
