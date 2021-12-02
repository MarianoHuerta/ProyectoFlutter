import 'dart:core';

class Consultorio {
  int idConsultorio = 0;
  int numero = 0;
  int idDoctor = 0;

  Consultorio.fromJson(dynamic json) {
    idConsultorio = json['IdDoctor'];
    numero = json['Numero'];
    idDoctor = json['IdDoctor'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['IdConsultorio'] = idConsultorio;
    map['Numero'] = numero;
    map['IdDoctor'] = idDoctor;
    return map;
  }
}