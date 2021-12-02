import 'package:flutter/material.dart';

import '/components/personal_textField.dart';
import '/components/personal_button.dart';

class RegistrarRol extends StatefulWidget {
  RegistrarRol({ Key? key }) : super(key: key);

  @override
  _RegistrarRolState createState() => _RegistrarRolState();
}

class _RegistrarRolState extends State<RegistrarRol>{

  TextEditingController nombreController = new TextEditingController();
  var url = Uri.parse('http://192.168.100.34/proyectotopicos/');
  int id = 31;

  //Función que inserta a la base de datos:
  /*Future<void> sendData() async{
    var res = await http.post(url.parse(url), body: {
      "Nombre": nombreController.text,
    });
  }*/

  //Función para traer el contenido de las cajas de texto del Widget PersonalTextField:
  //NombreFuncion(ID de la funcion):
  onPressedRol(id){
    //sendData();
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
          new PersonalTextField(nombreController, 'Nombre', 'Nombre Rol', icono: Icons.accessibility),
          Divider(),
          Divider(),
          Divider(),
          Divider(),
          //[ID, Funcion, Texto, icono]:
          new PersonalButton(id, onPressedRol, 'Registrar', icono: Icons.add),
         Divider(),
          //PersonalButton('Eliminar', icono: Icons.delete),
          
          _salirBoton(),
        ],
      )
    );
  }
  
 Widget _salirBoton(){
    return ElevatedButton.icon(
      icon: Icon(
        Icons.arrow_back
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        primary: Colors.teal,
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontStyle: FontStyle.italic
        )
      ),
      label: Text('Regresar'),
      onPressed: (){
        Navigator.pop(context);
      },
      );
  }

}