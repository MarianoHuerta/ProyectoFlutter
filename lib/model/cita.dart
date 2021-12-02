import 'dart:core';

import 'package:flutter/material.dart';
import 'package:proyecto_topicos/model/paciente.dart';

class Cita {
  int idCita = 0;
  String fecha = DateTime.now().toString();
  String hora = TimeOfDay.now().toString();
  String situacion = '';
  double precio = 0;
  int idPaciente = 0;
  int idDoctor = 0;

  Paciente? paciente = Paciente();

  Cita(this.idCita, this.fecha, this.hora, this.situacion, this.precio,
      this.idPaciente, this.idDoctor,
      {this.paciente});

  Cita.fromJson(dynamic json) {
    idCita = int.parse(json['IdCita']);
    fecha = json['Fecha'];
    hora = json['Hora'];
    situacion = json['Situacion'];
    precio = double.parse(json['Precio']);
    idPaciente = int.parse(json['IdPaciente']);
    idDoctor = int.parse(json['IdDoctor']);
  }

  Cita.fromJsonWithPaciente(dynamic json) {
    idCita = int.parse(json['IdCita']);
    fecha = json['Fecha'];
    hora = json['Hora'];
    situacion = json['Situacion'];
    precio = double.parse(json['Precio']);
    idPaciente = int.parse(json['IdPaciente']);
    idDoctor = int.parse(json['IdDoctor']);
    paciente = Paciente();
    paciente!.idPaciente = int.parse(json['IdPaciente']);
    paciente!.nombres = json['NombresP'];
    paciente!.apellidos = json['ApellidosP'];
    paciente!.edad = int.parse(json['EdadP']);
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
