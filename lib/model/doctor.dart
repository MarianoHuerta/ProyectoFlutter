// ignore_for_file: file_names

import 'dart:core';

class Doctor {
  int idDoctor = 0;
  String nombres = '';
  String apellidos = '';
  int edad = 0;
  String fechaNaci = '';
  int idConsultorio = 0;

  Doctor.fromJson(dynamic json) {
    idDoctor = json['IdDoctor'];
    nombres = json['Nombres'];
    apellidos = json['Apellidos'];
    edad = json['Edad'];
    fechaNaci = json['FechaNaci'];
    idConsultorio  = json['IdConsultorio'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['IdDoctor'] = idDoctor;
    map['Nombres'] = nombres;
    map['Apellidos'] = apellidos;
    map['Edad'] = edad;
    map['FechaNaci'] = fechaNaci;
    map['IdConsultorio'] = idConsultorio;
    return map;
  }
}
