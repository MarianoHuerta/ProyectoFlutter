import 'package:flutter/material.dart';

import '/components/personal_textField.dart';
import '/components/personal_button.dart';

class FormRol extends StatefulWidget {
  FormRol({ Key? key }) : super(key: key);

  @override
  _FormRolState createState() => _FormRolState();
}

class _FormRolState extends State<FormRol>{

  String _numero = '';
  String _opcion = 'Volar';

  List<String> _doctores = ['Volar', 'Rayo X', 'Super Aliento', 'super Fuerza'];
  TextEditingController _inputFieldDateController = new TextEditingController();

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
          PersonalTextField('Caja', 'label', icono: Icons.accessibility),
          Divider(),
          _ListaRoles(),
          Divider(),
          Divider(),
          Divider(),
          Divider(),
          PersonalButton('Modificar', icono: Icons.update),
          Divider(),
          PersonalButton('Eliminar', icono: Icons.delete),
        ],
      )
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown(){
    List<DropdownMenuItem<String>> lista = [];
    _doctores.forEach((poder) {
      lista.add(
        DropdownMenuItem(
          child: Text(poder),
          value: poder,
        )
      );
    });
    return lista;
  }

  Widget _ListaRoles() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.teal, width: 2.0),
                borderRadius: BorderRadius.circular(20.0)),
              child: DropdownButton<String>(
                hint: Text('Doctores'),
                dropdownColor: Colors.teal[300],
                elevation: 5,
                icon: Icon(Icons.keyboard_arrow_down),
                isExpanded: true,
                value: _opcion,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
                items: getOpcionesDropdown(),
                onChanged: (opt){
                  setState(() {
                    _opcion = opt.toString();
                  });
                },
              ),
        ),
      ), 
    );
  }
}