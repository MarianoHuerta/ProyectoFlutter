import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:proyecto_topicos/components/card_cita.dart';
import 'package:proyecto_topicos/components/refresh_widget.dart';

class ConsultaCitasPage extends StatefulWidget {
  @override
  _ConsultaCitasPageState createState() => _ConsultaCitasPageState();
}

class _ConsultaCitasPageState extends State<ConsultaCitasPage> {
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  List<int> data = [];

  @override
  void initState() {
    super.initState();

    loadList();
  }

  Future loadList() async {
    keyRefresh.currentState?.show();
    await Future.delayed(Duration(milliseconds: 4000));

    final random = Random();
    final data = List.generate(100, (_) => random.nextInt(100));

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
            Navigator.pushNamed(context, '/agendar-cita');
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
              final number = data[index];
              return buildItem(number, index);
            },
          ),
        );

  Widget buildItem(int number, int index) => Dismissible(
      key: Key(number.toString()),
      onDismissed: (direction) {
        setState(() {
          data.removeAt(index);
        });

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Número $number eliminado')));
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
      child: CardCita(
        number: number,
      ));
}
