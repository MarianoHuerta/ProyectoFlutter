import 'dart:core';

class Consultorio {
  int idConsultorio = 0;
  int numero = 0;

Consultorio(
      {
      this.idConsultorio = 0,
      this.numero = 0});

  Consultorio.fromJson(dynamic json) {
    idConsultorio = int.parse(json['IdConsultorio']);
    numero = int.parse(json['Numero']);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['IdConsultorio'] = idConsultorio.toString();
    map['Numero'] = numero.toString();
    return map;
  }
}