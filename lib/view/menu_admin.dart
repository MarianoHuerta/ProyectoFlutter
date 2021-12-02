import 'package:flutter/material.dart';
import '/components/personal_button.dart';

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
          new PersonalButton(id, onPressedAgregarConsultorio, 'Agregar Consultorio', icono: Icons.door_front_door_outlined),
          Divider(),
          Text('Modificar:'),
          new PersonalButton(id, onPressedModificarRoles, 'Modificar Roles', icono: Icons.manage_accounts),
          Divider(),
          new PersonalButton(id, onPressedModificarConsultorio, 'Modificar Consultorio', icono: Icons.door_back_door_outlined),
          Divider(),
          Text('Cerrar Sesion:'),
          new PersonalButton(id, onPressedCerrarSesion, 'Cerrar Sesion', icono: Icons.logout,),
        ],
      ),
    );
  }

  onPressedModificarDatos(id){
    Navigator.pushNamed(context, '/modificar-admin');
  }

  onPressedAgregarMedico(id){
    Navigator.pushNamed(context, '/registrar-doctor');
  }

  onPressedAgregarRoles(id){
    Navigator.pushNamed(context, '/registrar-rol');
  }

  onPressedAgregarConsultorio(id){
    Navigator.pushNamed(context, '/registrar-consultorio');
  }

  onPressedModificarConsultorio(id){
    Navigator.pushNamed(context, '/modificar-consultorio');
  }

  onPressedModificarRoles(id){
    Navigator.pushNamed(context, '/modificar-rol');
  }

  onPressedCerrarSesion(id){
    Navigator.pop(context);
  }
}
