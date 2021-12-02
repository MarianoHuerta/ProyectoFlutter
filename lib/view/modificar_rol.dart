import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '/components/personal_button.dart';
import '/components/personal_textField.dart';
import '/model/rol.dart';
import '/model/paciente.dart';

import '/util/constants.dart' as Constants;

class ModificarRol extends StatefulWidget {
  @override
  _ModificarRolState createState() => _ModificarRolState();
}

class _ModificarRolState extends State<ModificarRol> {
  TextEditingController nombreController = TextEditingController();
  List<Paciente> pacientes = [];

  Rol? rolEditar;
  bool isEditar = false;

  var urlEditarRols = Uri.parse(
      'http://${Constants.IP_CONEXION}/proyecto_topicos/editar_rol.php');

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;

    if (arg['action'] == 'editar' && !isEditar) {
      setState(() {
        rolEditar = arg['rol'];
        nombreController.text = rolEditar!.nombre;
        isEditar = true;
      });
    }

    onPressedCancelar(id) {
      Navigator.pop(context);
    }
    Widget build(BuildContext context) {
  return Column(
    children: <Widget>[
              Container(
                child: PersonalTextField(
                    nombreController, 'Nombre', 'Nombre del rol',
                    icono: Icons.list_alt, maxLineas: 3, minLineas: 1),
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
              ),
              
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PersonalButton(16, onPressedEditarRol, 'Guardar',
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
        title: Text("modificar Rol"),
      ),
      body: build(context),
    );
  }
 

  onPressedEditarRol(id) async {
    if (rolEditar != null) {
      rolEditar!.nombre = nombreController.text;

      await editarRol(rolEditar!);
    }
  }

  Future editarRol(Rol rol) async {
    final response = await http.post(urlEditarRols, body: rol.toJson());

    var message = json.decode(response.body);
    _mostrarMensaje('Se ha actualizado su Rol',
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
