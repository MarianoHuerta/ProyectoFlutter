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
  var url = Uri.parse('http://192.168.100.34/proyectotopicos/');
  int id = 36;
  
  //Función que inserta a la base de datos:
  /*Future<void> sendData() async{
    var res = await http.post(url.parse(url), body: {
      "Nombre": nombreController.text,
    });
  }*/
  
  //Función para traer el contenido de las cajas de texto del Widget PersonalTextField:
  //NombreFuncion(ID de la funcion):
  onPressedConsultorio(id){
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
        ],
      )
    );
  }
}
