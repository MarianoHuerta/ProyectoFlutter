import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '/components/personal_button.dart';
import '/components/personal_textField.dart';
import '/model/consultorio.dart';

import '/util/constants.dart' as Constants;

class ModificarConsultorio extends StatefulWidget {
  @override
  _ModificarConsultorioState createState() => _ModificarConsultorioState();
}

class _ModificarConsultorioState extends State<ModificarConsultorio> {
  TextEditingController numeroController = TextEditingController();

  Consultorio? consultorioEditar;
  bool isEditar = false;

  var urlEditarConsultorios = Uri.parse(
      'http://${Constants.IP_CONEXION}/proyecto_topicos/editar_consultorio.php');

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;

    if (arg['action'] == 'editar' && !isEditar) {
      setState(() {
        consultorioEditar = arg['consultorio'];
        numeroController.text = consultorioEditar!.numero.toString();
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
                    numeroController, 'Nombre', 'Nombre del Consultorio',
                    icono: Icons.list_alt, maxLineas: 3, minLineas: 1),
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
              ),
              
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PersonalButton(16, onPressedEditarConsultorio, 'Guardar',
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
        title: Text("modificar Consultorio"),
      ),
      body: build(context),
    );
  }
 

  onPressedEditarConsultorio(id) async {
    if (consultorioEditar != null) {
      consultorioEditar!.numero = int.parse(numeroController.text);

      await editarConsultorio(consultorioEditar!);
    }
  }

  Future editarConsultorio(Consultorio consultorio) async {
    final response = await http.post(urlEditarConsultorios, body: consultorio.toJson());

    var message = json.decode(response.body);
    _mostrarMensaje('Se ha actualizado su Consultorio',
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
