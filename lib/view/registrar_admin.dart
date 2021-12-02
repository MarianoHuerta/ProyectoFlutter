import 'dart:convert';

import '/model/usuario.dart';
import 'package:flutter/material.dart';

import '/components/personal_textField.dart';
import '/components/personal_button.dart';

import '/util/constants.dart' as Constants;
import 'package:http/http.dart' as http;

class ModificarAdmin extends StatefulWidget {
  ModificarAdmin({ Key? key }) : super(key: key);

  @override
  _ModificarAdminState createState() => _ModificarAdminState();
}

class _ModificarAdminState extends State<ModificarAdmin>{


  String _usuario = '';
  String _contrasenia = '';

 
  TextEditingController UsuarioController = new TextEditingController();
  TextEditingController ContraseniaController = new TextEditingController();

  int id = 11;
  TextEditingController _inputFieldDateController = new TextEditingController();

  var urlUsuario = Uri.parse(
      'http://${Constants.IP_CONEXION}/proyecto_topicos/registrar_usuario.php');

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Usuario'),
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
        ),
        children: [
          //[Controller, Texto, Label, icono]:
          
          new PersonalTextField(UsuarioController, 'Usuario', 'Usuario', icono: Icons.person),
          Divider(),
          new PersonalTextField(ContraseniaController, 'Contraseña', 'Contraseña', icono: Icons.password, obs: true),
          Divider(),
          //[ID, Funcion, Texto, icono]:
          //new PersonalButton(id, onPressedRol, 'Registrar', icono: Icons.add),
          //Divider(),
          new PersonalButton(id, onPressedGuardarUsuario, 'Añadir', icono: Icons.add),
          Divider(),
          //PersonalButton('Eliminar', icono: Icons.delete),
          
        ],
      )
    );
  }

  onPressedGuardarUsuario(id) async {
    Usuario cita = Usuario(
        idUsuario: 0,
        nombre: UsuarioController.text,
        contrasenia: ContraseniaController.text,
        idRol: 1);
    await registrarUsuario(cita);
  }

  Future registrarUsuario(Usuario usuario) async {
    final response = await http.post(urlUsuario, body: usuario.toJson());
    print(response.body);

    var message = json.decode(response.body.toString());
    _mostrarMensaje('Se ha registrado con éxito',
        'Ha habido un error vuelva a intentarlo', message['status']);
  }

  _mostrarMensaje(String mensajeExito, String mensajeError, bool status) {
    var colorMessage;
    var textMessage;

    if (status) {
      colorMessage = Colors.green[300];
      textMessage = mensajeExito;
    } else {
      colorMessage = Colors.red[300];
      textMessage = mensajeError;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(textMessage),
      backgroundColor: colorMessage,
    ));
  }
}
