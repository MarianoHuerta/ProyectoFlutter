import 'dart:core';

import 'package:flutter/material.dart';

class Cita {
  int idCita = 0;
  String fecha = DateTime.now().toString();
  String hora = TimeOfDay.now().toString();
  String situacion = '';
  double precio = 0;
  int idPaciente = 0;
  int idDoctor = 0;

  Cita(this.idCita, this.fecha, this.hora, this.situacion, this.precio,
      this.idPaciente, this.idDoctor);

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
    map['IdCita'] = idCita.toString();
    map['Fecha'] = fecha;
    map['Hora'] = hora;
    map['Situacion'] = situacion;
    map['Precio'] = precio.toString();
    map['IdPaciente'] = idPaciente.toString();
    map['IdDoctor'] = idDoctor.toString();
    return map;
  }
}
