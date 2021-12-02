import 'dart:core';

import 'package:flutter/material.dart';

class Cita {
  int idCita = 0;
  DateTime fecha = DateTime.now();
  TimeOfDay hora = TimeOfDay.now();
  String situacion = '';
  double precio = 0;
  int idPaciente = 0;
  int idDoctor = 0;

  Cita.fromJson(dynamic json) {
    idCita = json['IdCita'];
    fecha = json['Fecha'];
    hora = json['Hora'];
    situacion = json['Situacion'];
    precio = json['Precio'];
    idPaciente = json['IdPaciente'];
    idDoctor = json['IdDoctor'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['IdCita'] = idCita;
    map['Fecha'] = fecha;
    map['Hora'] = hora;
    map['Situacion'] = situacion;
    map['Precio'] = precio;
    map['IdPaciente'] = idPaciente;
    map['IdDoctor'] = idDoctor;
    return map;
  }
}
