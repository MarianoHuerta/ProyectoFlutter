import 'package:flutter/material.dart';

import '/components/personal_textField.dart';
import '/components/personal_button.dart';

class RegistrarConsultorio extends StatefulWidget {
  RegistrarConsultorio({ Key? key }) : super(key: key);

  @override
  _RegistrarConsultorioState createState() => _RegistrarConsultorioState();
}

class _RegistrarConsultorioState extends State<RegistrarConsultorio>{
  
  TextEditingController numeroController = new TextEditingController();
  int id = 36;
  String _numero = '';
  String _opcion = 'Volar';

  List<String> _doctores = ['Volar', 'Rayo X', 'Super Aliento', 'super Fuerza'];

  //Función para traer el contenido de las cajas de texto del Widget PersonalTextField:
  //NombreFuncion(ID de la funcion):
  onPressedConsultorio(id){
    _numero = numeroController.text;
    print('press $_numero');
    numeroController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultorios'),
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
        ),
        children: [
          //[Controller, Texto, Label, icono]:
          new PersonalTextField(numeroController, 'Numero', 'Numero Consultorio', icono: Icons.meeting_room),
          Divider(),
          Divider(),
          Divider(),
          Divider(),
          //[ID, Funcion, Texto, icono]:
          new PersonalButton(id, onPressedConsultorio, 'Registrar', icono: Icons.add),
          //Divider(),
          //new PersonalButton(id, onPressedConsultorio, 'Modificar', icono: Icons.update),
          //Divider(),
          //PersonalButton(id, onPressedConsultorio, 'Eliminar', icono: Icons.delete),
        ],
      )
    );
  }
}
