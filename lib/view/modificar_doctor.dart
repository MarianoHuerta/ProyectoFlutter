import 'package:flutter/material.dart';

import '/components/personal_textField.dart';
import '/components/personal_button.dart';

class ModificarDoctor extends StatefulWidget {
  ModificarDoctor({ Key? key }) : super(key: key);

  @override
  _ModificarDoctorState createState() => _ModificarDoctorState();
}

class _ModificarDoctorState extends State<ModificarDoctor>{

    String _nombre = '';
  String _apellido = '';
  String _usuario = '';
  String _contrasenia = '';
  String _fecha='';
  int _edad = 0;
  String _opcion = 'Volar';

  List<String> _consultorios = ['Volar', 'Rayo X', 'Super Aliento', 'super Fuerza'];

  TextEditingController Nombre = new TextEditingController();
  TextEditingController Apellidos = new TextEditingController();
  TextEditingController Edad = new TextEditingController();
  TextEditingController Usuario = new TextEditingController();
  TextEditingController Contrasenia = new TextEditingController();

  int id = 11;
  TextEditingController _inputFieldDateController = new TextEditingController();
 onPressedModDoctor(id){
    _nombre = Nombre.text;
    _apellido = Apellidos.text;
    _fecha = _inputFieldDateController.text;
    _usuario = Usuario.text;
    _contrasenia = Contrasenia.text;
    print('press $_nombre $_apellido $_fecha $_edad $_usuario $_contrasenia $_opcion');
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
        title: Text('Modificar Doctor'),

      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,

        ),
        children: [
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
          _ListaConsultorios(),
          Divider(),
          
          new PersonalButton(id, onPressedModDoctor, 'Modificar', icono: Icons.add),
          Divider(),
          _salirBoton(),
        ],
      ),

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
    List<DropdownMenuItem<String>> getOpcionesDropdown(){
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