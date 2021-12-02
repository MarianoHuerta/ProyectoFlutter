import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '/components/personal_button.dart';
import '/components/personal_textField.dart';
import '/model/rol.dart';

import '/util/constants.dart' as Constants;

class FormRol extends StatefulWidget {
  @override
  _FormRolState createState() => _FormRolState();
}

class _FormRolState extends State<FormRol> {

  TextEditingController nombreController = TextEditingController();

  var urlRol = Uri.parse(
      'http://${Constants.IP_CONEXION}/proyecto_topicos/RegistrarRol.php');


  @override
  Widget build(BuildContext context) {
    onPressedCancelar(id) {
      Navigator.pop(context);
    }

    Widget build(BuildContext context) {
  return Column(
    children: <Widget>[
              Container(
                child: PersonalTextField(nombreController, 'Nombre', 'Nombre de Rol',
                    icono: Icons.account_circle, maxLineas: 3, minLineas: 1),
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
              ),
              
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PersonalButton(16, onPressedGuardarRol, 'Guardar',
                      icono: Icons.add_sharp, classColor: 'primary'),
                  PersonalButton(
                    17,
                    onPressedCancelar,
                    'Cancelar',
                    icono: Icons.cancel,
                    classColor: 'secondary',                  
            ),
        ],
      )
    ],
  );
}

    return Scaffold(
      appBar: AppBar(
        title: Text("Registrar Rol"),
      ),
      body: build(context),
    );
  }
 

  onPressedGuardarRol(id) async {
    Rol cita = Rol(
        idRol: 0,
        nombre: nombreController.text);
    await registrarRol(cita);
  }

  Future registrarRol(Rol Rol) async {
    final response = await http.post(urlRol, body: Rol.toJson());
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
