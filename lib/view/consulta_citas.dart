import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:http/http.dart' as http;

import '/components/card_cita.dart';
import '/components/refresh_widget.dart';
import '/model/cita.dart';

import '/util/constants.dart' as Constants;

class ConsultaCitasPage extends StatefulWidget {
  @override
  _ConsultaCitasPageState createState() => _ConsultaCitasPageState();
}

class _ConsultaCitasPageState extends State<ConsultaCitasPage> {
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  List<Cita> data = [];

  @override
  void initState() {
    super.initState();

    loadList();
  }

  Future<List<Cita>> getCitas() async {
    var url = Uri.parse(
        'http://${Constants.IP_CONEXION}/proyecto_topicos/consulta_citas.php');

    final response = await http.get(url);

    print(response.body);

    return (jsonDecode(response.body) as List)
        .map((value) => Cita.fromJsonWithPaciente(value))
        .toList();
  }

  Future loadList() async {
    keyRefresh.currentState?.show();

    final random = Random();
    final data = await getCitas();

    setState(() => this.data = data);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Citas"),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: loadList,
            ),
          ],
        ),
        backgroundColor: Colors.grey[300],
        body: buildList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/agendar-cita',
                arguments: {'action': 'agendar'});
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );

  Widget buildList() => data.isEmpty
      ? Center(child: CircularProgressIndicator())
      : RefreshWidget(
          keyRefresh: keyRefresh,
          onRefresh: loadList,
          child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.symmetric(vertical: 10),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final cita = data[index];
              return buildItem(cita, index);
            },
          ),
        );

  Widget buildItem(Cita cita, int index) => Dismissible(
      key: Key(cita.idCita.toString()),
      onDismissed: (direction) {
        setState(() {
          data.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('La cita ${cita.idCita} se ha eliminado')));
      },
      background: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(Icons.delete, color: Colors.white),
          ],
        ),
      ),
      child: CardCita(cita: cita, paciente: cita.paciente!));
}
