import 'package:flutter/material.dart';
import 'package:proyecto_topicos/components/personal_button.dart';

class MenuAdmin extends StatefulWidget {
  MenuAdmin({Key? key}) : super(key: key);

  @override
  _MenuAdminState createState() => _MenuAdminState();
}

class _MenuAdminState extends State<MenuAdmin> {
  int id = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Administrador'),
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
        ),

        children: [
          Text('Datos Personales:'),
          new PersonalButton(id, onPressedModificarDatos, 'Modificar Datos', icono: Icons.manage_accounts),
          Divider(),
          Text('Agregar:'),
          new PersonalButton(id, onPressedAgregarMedico, 'Agregar Medico', icono: Icons.person_add),
          Divider(),
          new PersonalButton(id, onPressedAgregarRoles, 'Agregar Roles', icono: Icons.people),
          Divider(),
          new PersonalButton(id, onPressedAgregarConsultorio, 'Agregar Consultorio', icono: Icons.door_front),
          Divider(),
          Text('Modificar:'),
          new PersonalButton(id, onPressedModificarRoles, 'Modificar Roles', icono: Icons.manage_accounts),
          Divider(),
          new PersonalButton(id, onPressedModificarConsultorio, 'Modificar Consultorio', icono: Icons.door_back_outlined),
          Divider(),
          Text('Cerrar Sesion:'),
          new PersonalButton(id, onPressedCerrarSesion, 'Cerrar Sesion', icono: Icons.logout,),
        ],
      ),
    );
  }

  onPressedModificarDatos(id){
    //Navigator.push(context, MaterialPageRoute(builder: (context) => NombredelDart()));
  }

  onPressedAgregarMedico(id){
    //Navigator.push(context, MaterialPageRoute(builder: (context) => NombredelDart()));
  }

  onPressedAgregarRoles(id){
    //Navigator.push(context, MaterialPageRoute(builder: (context) => NombredelDart()));
  }

  onPressedAgregarConsultorio(id){
    //Navigator.push(context, MaterialPageRoute(builder: (context) => NombredelDart()));
  }

  onPressedModificarConsultorio(id){
    //Navigator.push(context, MaterialPageRoute(builder: (context) => NombredelDart()));
  }

  onPressedModificarRoles(id){
    //Navigator.push(context, MaterialPageRoute(builder: (context) => NombredelDart()));
  }

  onPressedCerrarSesion(id){
    Navigator.pop(context);
  }
}
