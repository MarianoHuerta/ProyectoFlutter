import 'package:flutter/material.dart';

import '/components/personal_textField.dart';
import '/components/personal_button.dart';

class ModificarRol extends StatefulWidget {
  ModificarRol({ Key? key }) : super(key: key);

  @override
  _ModificarRolState createState() => _ModificarRolState();
}

class _ModificarRolState extends State<ModificarRol>{

  TextEditingController numeroController = new TextEditingController();
  var url = Uri.parse('http://192.168.100.34/proyectotopicos/');
  int id = 32;

  //Función que inserta a la base de datos:
  /*Future<void> sendData() async{
    var res = await http.post(url.parse(url), body: {
      "Nombre": nombreController.text,
    });
  }*/

  //Función para traer el contenido de las cajas de texto del Widget PersonalTextField:
  //NombreFuncion(ID de la funcion):
  onPressedRol(id){
    
    numeroController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Roles'),
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
        ),
        children: [
          //[Controller, Texto, Label, icono]:
          new PersonalTextField(numeroController, 'Nombre', 'Nombre Rol', icono: Icons.accessibility),
          Divider(),
          Divider(),
          Divider(),
          Divider(),
          //[ID, Funcion, Texto, icono]:
          new PersonalButton(id, onPressedRol, 'Modificar', icono: Icons.update),
        ],
      )
    );
  }
}