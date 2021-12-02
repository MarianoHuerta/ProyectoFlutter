import 'dart:core';

class Consultorio {
  int idConsultorio = 0;
  int numero = 0;

  Consultorio.fromJson(dynamic json) {
    idConsultorio = json['IdConsultorio'];
    numero = json['Numero'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['IdConsultorio'] = idConsultorio;
    map['Numero'] = numero;
    return map;
  }
}