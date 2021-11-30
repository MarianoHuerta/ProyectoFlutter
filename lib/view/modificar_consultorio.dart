import 'package:flutter/material.dart';

import '/components/personal_textField.dart';
import '/components/personal_button.dart';

class ModificarConsultorio extends StatefulWidget {
  ModificarConsultorio({ Key? key }) : super(key: key);

  @override
  _ModificarConsultorioState createState() => _ModificarConsultorioState();
}

class _ModificarConsultorioState extends State<ModificarConsultorio>{

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
          PersonalTextField('Numero', 'Numero Consultorio', icono: Icons.meeting_room),
          Divider(),
          _ListaDoctores(),
          Divider(),
          Divider(),
          Divider(),
          Divider(),
          PersonalButton('Modificar', icono: Icons.update),
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

  Widget _ListaDoctores() {
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