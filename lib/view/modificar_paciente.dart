import 'package:flutter/material.dart';

import '/components/personal_textField.dart';
import '/components/personal_button.dart';

class ModificarPaciente extends StatefulWidget {
  ModificarPaciente({ Key? key }) : super(key: key);

  @override
  _ModificarPacienteState createState() => _ModificarPacienteState();
}

class _ModificarPacienteState extends State<ModificarPaciente>{

String _nombre = '';
  String _apellido = '';
  String _usuario = '';
  String _contrasenia = '';
  String _fecha='';
  int _edad = 0;

  TextEditingController Nombre = new TextEditingController();
  TextEditingController Apellidos = new TextEditingController();
  TextEditingController Edad = new TextEditingController();
  TextEditingController Usuario = new TextEditingController();
  TextEditingController Contrasenia = new TextEditingController();

  int id = 11;
  TextEditingController _inputFieldDateController = new TextEditingController();
 onPressedModPaciente(id){
    _nombre = Nombre.text;
    _apellido = Apellidos.text;
    _fecha = _inputFieldDateController.text;
    _usuario = Usuario.text;
    _contrasenia = Contrasenia.text;
    print('press $_nombre $_apellido $_fecha $_edad $_usuario $_contrasenia');
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
        title: Text('Pacientes'),
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
        ),
        children: [
          //[Controller, Texto, Label, icono]:
          new PersonalTextField(Nombre, 'Nombre', 'Nombre Paciente', icono: Icons.accessibility),
          Divider(),
          new PersonalTextField(Apellidos, 'Apellidos', 'Apellidos Paciente', icono: Icons.accessibility),
          Divider(),
          _crearFecha(context),
          Divider(),
          new PersonalTextField(Usuario, 'Usuario', 'Usuario', icono: Icons.person),
          Divider(),
          new PersonalTextField(Contrasenia, 'Contraseña', 'Contraseña', icono: Icons.password, obs: true),
          Divider(),
          Divider(),
          _salirBoton(),
          //[ID, Funcion, Texto, icono]:
          //new PersonalButton(id, onPressedRol, 'Registrar', icono: Icons.add),
          //Divider(),
          new PersonalButton(id, onPressedModPaciente, 'Modificar', icono: Icons.update),
          //Divider(),
          //PersonalButton('Eliminar', icono: Icons.delete),
        ],
      )
    );
  }
   Widget _crearFecha(BuildContext context){
    return TextField(
      controller: _inputFieldDateController,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: 'Fecha de Nacimiento',
        labelText: 'Fecha de Nacimeinto',
        suffixIcon: Icon(Icons.calendar_today),
      ),
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context) async {
    DateTime? picked= await showDatePicker(
      context: context, 
      initialDate: new DateTime.now(), 
      firstDate: new DateTime(1960), 
      lastDate: new DateTime.now()
      );
      
    if(picked != null){
      setState(() {
        DateTime ano = DateTime.now();
        if(ano.month >= picked.month){
          _edad = ano.year - picked.year;
        }else{
          _edad = ano.year - picked.year - 1;
        }
        
        _fecha = picked.toString();
        _inputFieldDateController.text = _fecha;
      });
    }
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