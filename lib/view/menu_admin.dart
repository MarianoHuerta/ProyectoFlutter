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
          
          Text('Agregar:'),
          Divider(),
          new PersonalButton(id, onPressedModificarDatos, 'Agregar Administrador', icono: Icons.manage_accounts),
          Divider(),
          new PersonalButton(id, onPressedAgregarMedico, 'Agregar Medico', icono: Icons.person_add),
          Divider(),
          new PersonalButton(id, onPressedAgregarRoles, 'Agregar Roles', icono: Icons.group_add),
          Divider(),
          new PersonalButton(id, onPressedAgregarConsultorio, 'Agregar Consultorio', icono: Icons.door_front_door_outlined),
          Divider(),
          Text('Modificar:'),
          Divider(),
          new PersonalButton(id, onPressedModificarRoles, 'Modificar Roles', icono: Icons.groups_sharp),
          Divider(),
          new PersonalButton(id, onPressedModificarConsultorio, 'Modificar Consultorio', icono: Icons.door_back_door_outlined),
          Divider(),
          Text('Cerrar Sesion:'),
          Divider(),
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
    Navigator.pushNamed(context, '/consultar-consultorios');
  }

  onPressedModificarRoles(id){
    Navigator.pushNamed(context, '/consulta-roles');
  }

  onPressedCerrarSesion(id){
    Navigator.pop(context);
  }
}
