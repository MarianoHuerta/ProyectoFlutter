import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:http/http.dart' as http;

import '/components/card_consultorios.dart';
import '/components/refresh_widget.dart';
import '/model/consultorio.dart';

import '/util/constants.dart' as Constants;

class ConsultaConsultoriosPage extends StatefulWidget {
  @override
  _ConsultaConsultoriosPageState createState() => _ConsultaConsultoriosPageState();
}

class _ConsultaConsultoriosPageState extends State<ConsultaConsultoriosPage> {
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  List<Consultorio> data = [];

  @override
  void initState() {
    super.initState();

    loadList();
  }

 Future<List<Consultorio>> getConsultorios() async {
    var url = Uri.parse(
        'http://${Constants.IP_CONEXION}/proyecto_topicos/consultar_consultorio.php');

    final response = await http.get(url);

    print(response.body);

    return (jsonDecode(response.body) as List)
        .map((value) => Consultorio.fromJson(value))
        .toList();
  }

  Future loadList() async {
    keyRefresh.currentState?.show();

    final data = await getConsultorios();

    setState(() => this.data = data);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Consultorios"),
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
            Navigator.pushNamed(context, '/modificar-consultorio',
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
              final consultorio = data[index];
              return buildItem(consultorio, index);
            },
          ),
        );

  Widget buildItem(Consultorio consultorio, int index) => Dismissible(
      key: Key(consultorio.idConsultorio.toString()),
      onDismissed: (direction) {
        setState(() {
          data.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('La Consultorio ${consultorio.idConsultorio} se ha eliminado')));
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
      child: CardConsultorio( consultorio: consultorio));
}
