import 'package:flutter/material.dart';

import '/components/personal_textField.dart';
import '/components/personal_button.dart';

class ModificarDoctor extends StatefulWidget {
  ModificarDoctor({ Key? key }) : super(key: key);

  @override
  _ModificarDoctorState createState() => _ModificarDoctorState();
}

class _ModificarDoctorState extends State<ModificarDoctor>{

  TextEditingController numeroController = new TextEditingController();
  int id = 32;
  String _numero = '';
  String _opcion = 'Volar';

  List<String> _consultorios = ['Volar', 'Rayo X', 'Super Aliento', 'super Fuerza'];

  //Función para traer el contenido de las cajas de texto del Widget PersonalTextField:
  //NombreFuncion(ID de la funcion):
  onPressedRol(id){
    _numero = numeroController.text;
    print('press modificar rol $_numero');
    numeroController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctores'),
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
        ),
        children: [
          //[Controller, Texto, Label, icono]:
          new PersonalTextField(numeroController, 'Nombre', 'Nombre Doctor', icono: Icons.accessibility),
          new PersonalTextField(numeroController, 'Apellidos', 'Apellidos Doctor', icono: Icons.accessibility),
          new PersonalTextField(numeroController, 'Edad', 'Edad Doctor', icono: Icons.accessibility),
          new PersonalTextField(numeroController, 'Fecha', 'Fecha Nacimiento', icono: Icons.calendar_today),
          
          _ListaConsultorios(),

          Divider(),
          Divider(),
          Divider(),
          Divider(),
          //[ID, Funcion, Texto, icono]:
          //new PersonalButton(id, onPressedRol, 'Registrar', icono: Icons.add),
          //Divider(),
          new PersonalButton(id, onPressedRol, 'Modificar', icono: Icons.update),
          //Divider(),
          //PersonalButton('Eliminar', icono: Icons.delete),
        ],
      )
    );
  }List<DropdownMenuItem<String>> getOpcionesDropdown(){
    List<DropdownMenuItem<String>> lista = [];
    _consultorios.forEach((poder) {
      lista.add(
        DropdownMenuItem(
          child: Text(poder),
          value: poder,
        )
      );
    });
    return lista;
  }

  Widget _ListaConsultorios() {
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
