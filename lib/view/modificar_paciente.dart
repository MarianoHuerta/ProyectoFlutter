import 'package:flutter/material.dart';

import '/components/personal_textField.dart';
import '/components/personal_button.dart';

class ModificarPaciente extends StatefulWidget {
  ModificarPaciente({ Key? key }) : super(key: key);

  @override
  _ModificarPacienteState createState() => _ModificarPacienteState();
}

class _ModificarPacienteState extends State<ModificarPaciente>{

  TextEditingController numeroController = new TextEditingController();
  int id = 32;
  String _numero = '';

  //Función para traer el contenido de las cajas de texto del Widget PersonalTextField:
  //NombreFuncion(ID de la funcion):
  onPressedRol(id){
    _numero = numeroController.text;
    print('press modificar rol $_numero');
    numeroController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pacientes'),
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
        ),
        children: [
          //[Controller, Texto, Label, icono]:
          new PersonalTextField(numeroController, 'Nombre', 'Nombre Paciente', icono: Icons.accessibility),
          new PersonalTextField(numeroController, 'Apellidos', 'Apellidos Paciente', icono: Icons.accessibility),
          new PersonalTextField(numeroController, 'Edad', 'Edad Paciente', icono: Icons.accessibility),
          new PersonalTextField(numeroController, 'Fecha', 'Fecha Nacimiento', icono: Icons.calendar_today),

          Divider(),
          Divider(),
          Divider(),
          Divider(),
          //[ID, Funcion, Texto, icono]:
          //new PersonalButton(id, onPressedRol, 'Registrar', icono: Icons.add),
          //Divider(),
          new PersonalButton(id, onPressedRol, 'Modificar', icono: Icons.update),
          //Divider(),
          //PersonalButton('Eliminar', icono: Icons.delete),
        ],
      )
    );
  }
}