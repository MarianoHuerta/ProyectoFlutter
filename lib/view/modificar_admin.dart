import 'package:flutter/material.dart';

import '/components/personal_textField.dart';
import '/components/personal_button.dart';

class ModificarAdmin extends StatefulWidget {
  ModificarAdmin({ Key? key }) : super(key: key);

  @override
  _ModificarAdminState createState() => _ModificarAdminState();
}

class _ModificarAdminState extends State<ModificarAdmin>{


  String _usuario = '';
  String _contrasenia = '';

  TextEditingController Nombre = new TextEditingController();
  TextEditingController Apellidos = new TextEditingController();
  TextEditingController Edad = new TextEditingController();
  TextEditingController Usuario = new TextEditingController();
  TextEditingController Contrasenia = new TextEditingController();

  int id = 11;
  TextEditingController _inputFieldDateController = new TextEditingController();
 onPressedModAdmin(id){
    _usuario = Usuario.text;
    _contrasenia = Contrasenia.text;
    print('press  $_usuario $_contrasenia');
    Nombre.clear();
    Apellidos.clear();
    Edad.clear();
    Usuario.clear();
    Contrasenia.clear();
    _inputFieldDateController.clear();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modificar Admin'),
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
        ),
        children: [
          //[Controller, Texto, Label, icono]:
          
          new PersonalTextField(Usuario, 'Usuario', 'Usuario', icono: Icons.person),
          Divider(),
          new PersonalTextField(Contrasenia, 'Contraseña', 'Contraseña', icono: Icons.password, obs: true),
          Divider(),
          //[ID, Funcion, Texto, icono]:
          //new PersonalButton(id, onPressedRol, 'Registrar', icono: Icons.add),
          //Divider(),
          new PersonalButton(id, onPressedModAdmin, 'Modificar', icono: Icons.update),
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