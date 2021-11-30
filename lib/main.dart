import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'view/registrar_consultorio.dart';
import 'view/registrar_rol.dart';
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
          '/registrar-consultorio': (BuildContext context) => FormConsultorio(),
          '/registrar-rol': (BuildContext context) => FormRol()
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
                  Navigator.pushNamed(context, '/consulta-citas');
                },
                child: const Text('Ingresar'))
          ],
        ),
      ),
    );
  }
}
