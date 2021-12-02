import 'dart:core';

class Consultorio {
  int idConsultorio = 0;
  int numero = 0;
  int idDoctor = 0;

  Consultorio();

  Consultorio.fromJson(dynamic json) {
    idConsultorio = int.parse(json['IdConsultorio']);
    numero = int.parse(json['Numero']);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['IdConsultorio'] = idConsultorio;
    map['Numero'] = numero;
    return map;
  }
}