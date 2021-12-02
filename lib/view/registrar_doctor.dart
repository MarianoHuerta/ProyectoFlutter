import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_topicos/components/personal_button.dart';
import 'package:proyecto_topicos/components/personal_textField.dart';
import 'package:proyecto_topicos/model/cita.dart';
import 'package:proyecto_topicos/model/doctor.dart';

class FormDoctor extends StatefulWidget {
  @override
  _FormDoctorState createState() => _FormDoctorState();
}

class _FormDoctorState extends State<FormDoctor> {
  TextEditingController nombresController = TextEditingController();
  TextEditingController apellidosController = TextEditingController();
  TextEditingController edadController = TextEditingController();
  TextEditingController fechaNaciController = TextEditingController();
  String? consultorioSeleccionado = '';
  List<String> consultorios = [];
  DateTime fechaSeleccionada = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;

    Widget buildForm() => ListView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
              child: DropdownButtonFormField<String>(
                value: consultorioSeleccionado,
                isExpanded: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: 'Seleccione un consultorio',
                  labelText: 'Seleccione un consultorio',
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.teal[400],
                  ),
                ),
                items:
                    consultorios.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    consultorioSeleccionado = value;
                  });
                },
              ),
            ),
            Container(
              child: PersonalTextField(nombresController, 'Nombres', 'Nombres',
                  icono: Icons.account_box_rounded, maxLineas: 3, minLineas: 1),
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
            ),
            Container(
              child: PersonalTextField(
                  apellidosController, 'Apellidos', 'Apellidos',
                  icono: Icons.supervisor_account),
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
              child: TextField(
                controller: edadController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'Edad',
                    hintText: 'Edad',
                    prefixIcon: Icon(
                      Icons.assignment_ind_rounded,
                      color: Colors.teal[600],
                    )),
                keyboardType: TextInputType.number,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
              child: TextField(
                controller: fechaNaciController,
                enableInteractiveSelection: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'Fecha de nacimiento',
                    hintText: 'Fecha de nacimiento',
                    prefixIcon: Icon(
                      Icons.calendar_today,
                      color: Colors.teal[600],
                    )),
                onTap: () => _selectDate(context),
                readOnly: true,
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                (arg['action'] == 'guardar')
                    ? PersonalButton(1, onPressedRegistrarDoctor, 'Guardar',
                        icono: Icons.add_sharp, classColor: 'primary')
                    : PersonalButton(2, onPressedRegistrarDoctor, 'Editar',
                        icono: Icons.edit, classColor: 'primary'),
                PersonalButton(
                  3,
                  onPressedRegistrarDoctor,
                  'Cancelar',
                  icono: Icons.cancel,
                  classColor: 'secondary',
                )
              ],
            )
          ],
        );

    return Scaffold(
      appBar: AppBar(
        title: Text("Registrar doctor"),
      ),
      body: buildForm(),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: fechaSeleccionada,
        firstDate: DateTime(2020),
        lastDate: DateTime(2035),
        initialEntryMode: DatePickerEntryMode.input,
        helpText: 'Selecciona una fecha',
        cancelText: 'Cancelar',
        confirmText: 'Agendar');

    if (picked != null && picked != fechaSeleccionada) {
      setState(() {
        fechaSeleccionada = picked;
        fechaNaciController.text =
            fechaSeleccionada.toLocal().toString().split(' ')[0];
      });
    }
  }

  onPressedRegistrarDoctor(id) {
    Doctor doctor = Doctor(
        idDoctor: 0,
        nombres: nombresController.text,
        apellidos: apellidosController.text,
        edad: int.parse(edadController.text),
        fechaNaci: fechaNaciController.text,
        idConsultorio: int.parse(consultorioSeleccionado.toString()));
  }

  registrarDoctor(Doctor doctor) {}
}
