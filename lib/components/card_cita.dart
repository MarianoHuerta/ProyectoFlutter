import 'package:flutter/material.dart';
import '/model/cita.dart';
import '/model/paciente.dart';

class CardCita extends StatelessWidget {
  final Cita cita;
  final Paciente paciente;

  const CardCita({Key? key, required this.cita, required this.paciente})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: ListTile(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text('Fecha: ${cita.fecha}',
                    style: TextStyle(
                        color: Colors.teal[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
              ),
              Container(
                  child: Text('Nombre: ${paciente.nombres}',
                      style: TextStyle(fontSize: 18))),
              Container(
                child: Text('Apellidos: ${paciente.apellidos}',
                    style: TextStyle(fontSize: 18)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: Text('Edad: ${paciente.edad}',
                          style: TextStyle(fontSize: 18))),
                ],
              )
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, '/agendar-cita',
                arguments: {'action': 'editar', 'cita': cita});
          },
          leading: Icon(
            Icons.calendar_today_rounded,
            color: Colors.teal[200],
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 16.0,
      ),
      padding: EdgeInsets.symmetric(vertical: 5),
    );
  }
}
