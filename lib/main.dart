import '/view/menu_admin.dart';
import '/view/menu_medico.dart';
import '/view/menu_paciente.dart';
import '/view/modificar_admin.dart';
import '/view/modificar_doctor.dart';
import '/view/modificar_paciente.dart';
import '/view/registro_doctor.dart';
import '/view/registro_paciente.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'view/login.dart';
import '/view/registro_paciente.dart';

import 'view/registrar_consultorio.dart';
import 'view/registrar_rol.dart';
import 'view/modificar_consultorio.dart';
import 'view/modificar_rol.dart';
import 'view/agendar_citas.dart';
import 'view/consulta_citas.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
        routes: <String, WidgetBuilder>{
          '/consulta-citas': (BuildContext context) => ConsultaCitasPage(),
          '/agendar-cita': (BuildContext context) => FormCitas(),
          '/registrar-consultorio': (BuildContext context) => RegistrarConsultorio(),
          '/modificar-consultorio': (BuildContext context) => ModificarConsultorio(),
          '/registrar-rol': (BuildContext context) => RegistrarRol(),
          '/modificar-rol': (BuildContext context) => ModificarRol(),
          '/registrar-paciente': (BuildContext context) => registroPaciente(),
          '/modificar-paciente': (BuildContext context) => ModificarPaciente(),
          '/registrar-doctor': (BuildContext context) => FormDoctor(),
          '/modificar-doctor': (BuildContext context) => ModificarDoctor(),
          '/modificar-admin': (BuildContext context) => ModificarAdmin(),
          '/login': (BuildContext context) => Login(),
          '/menu-admin': (BuildContext context) => MenuAdmin(),
          '/menu-paciente': (BuildContext context) => menuPaciente(),
          '/menu-doctor': (BuildContext context) => menuMedico(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Ingresar'))
                
          ],
        ),
        
      ),
      
    );
  }
}
