import 'dart:core';

class Doctor {
  int idDoctor = 0;
  String nombres = '';
  String apellidos = '';
  int edad = 0;
  String fechaNaci = '';
  int idConsultorio = 0;

  Doctor(
      {this.idDoctor = 0,
      this.nombres = '',
      this.apellidos = '',
      this.edad = 0,
      this.fechaNaci = '',
      this.idConsultorio = 0});

  Doctor.fromJson(dynamic json) {
    idDoctor = int.parse(json['IdDoctor']);
    nombres = json['Nombres'];
    apellidos = json['Apellidos'];
    edad = int.parse(json['Edad']);
    fechaNaci = json['FechaNaci'];
    idConsultorio = int.parse(json['IdConsultorio']);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['IdDoctor'] = idDoctor.toString();
    map['Nombres'] = nombres;
    map['Apellidos'] = apellidos;
    map['Edad'] = edad.toString();
    map['FechaNaci'] = fechaNaci;
    map['IdConsultorio'] = idConsultorio.toString();
    return map;
  }
}
