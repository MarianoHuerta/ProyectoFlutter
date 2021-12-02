import 'package:flutter/material.dart';

import '/components/personal_textField.dart';
import '/components/personal_button.dart';

class ModificarRol extends StatefulWidget {
  ModificarRol({Key? key}) : super(key: key);

  @override
  _ModificarRolState createState() => _ModificarRolState();
}

class _ModificarRolState extends State<ModificarRol> {
  TextEditingController numeroController = new TextEditingController();
  int id = 32;
  String _numero = '';

  //Función para traer el contenido de las cajas de texto del Widget PersonalTextField:
  //NombreFuncion(ID de la funcion):
  onPressedRol(id) {
    _numero = numeroController.text;
    print('press modificar rol $_numero');
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
            new PersonalTextField(numeroController, 'Nombre', 'Nombre Rol',
                icono: Icons.accessibility),
            Divider(),
            Divider(),
            Divider(),
            Divider(),
            //[ID, Funcion, Texto, icono]:
            //new PersonalButton(id, onPressedRol, 'Registrar', icono: Icons.add),
            //Divider(),
            new PersonalButton(id, onPressedRol, 'Modificar',
                icono: Icons.update),
            //Divider(),
            //PersonalButton('Eliminar', icono: Icons.delete),
          ],
        ));
  }
}
