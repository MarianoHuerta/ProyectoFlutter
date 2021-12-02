import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:http/http.dart' as http;

import '/components/card_roles.dart';
import '/components/refresh_widget.dart';
import '/model/rol.dart';

import '/util/constants.dart' as Constants;

class ConsultaRolesPage extends StatefulWidget {
  @override
  _ConsultaRolesPageState createState() => _ConsultaRolesPageState();
}

class _ConsultaRolesPageState extends State<ConsultaRolesPage> {
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  List<Rol> data = [];

  @override
  void initState() {
    super.initState();

    loadList();
  }

 Future<List<Rol>> getRoles() async {
    var url = Uri.parse(
        'http://${Constants.IP_CONEXION}/proyecto_topicos/consultar_roles.php');

    final response = await http.get(url);

    print(response.body);

    return (jsonDecode(response.body) as List)
        .map((value) => Rol.fromJson(value))
        .toList();
  }

  Future loadList() async {
    keyRefresh.currentState?.show();

    final data = await getRoles();

    setState(() => this.data = data);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Roles"),
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
            Navigator.pushNamed(context, '/modificar-rol',
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
              final rol = data[index];
              return buildItem(rol, index);
            },
          ),
        );

  Widget buildItem(Rol rol, int index) => Dismissible(
      key: Key(rol.idRol.toString()),
      onDismissed: (direction) {
        setState(() {
          data.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('La rol ${rol.idRol} se ha eliminado')));
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
      child: CardRol(rol: rol));
}
