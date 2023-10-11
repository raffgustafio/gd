import 'package:flutter/material.dart';
import 'package:gd5_d_1204/database/sql_helper.dart';
import 'package:gd5_d_1204/entity/employee.dart';
import 'package:gd5_d_1204/entity/detail.dart';

class InputPage extends StatefulWidget {
  const InputPage(
      {super.key,
      required this.title,
      required this.id,
      required this.name,
      required this.email,
      required this.usia,
      required this.pekerjaan});

  final String? title, name, email, usia, pekerjaan;
  final int? id;

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerUsia = TextEditingController();
  TextEditingController controllerPekerjaan = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.id != null) {
      controllerName.text = widget.name!;
      controllerEmail.text = widget.email!;
      controllerUsia.text = widget.usia!;
      controllerPekerjaan.text = widget.pekerjaan!;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("INPUT EMPLOYEE"),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            TextField(
              controller: controllerName,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 24),
            TextField(
              controller: controllerEmail,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: controllerUsia,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Usia',
              ),
            ),
            TextField(
              controller: controllerPekerjaan,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Pekerjaan',
              ),
            ),
            SizedBox(height: 48),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () async {
                if (widget.id == null) {
                  await addEmployee();
                } else {
                  await editEmployee(widget.id!);
                }
                Navigator.pop(context);
              },
            )
          ],
        ));
  }

  Future<void> addEmployee() async {
    await SQLHelper.addEmployee(controllerName.text, controllerEmail.text);
  }

  Future<void> editEmployee(int id) async {
    await SQLHelper.editEmployee(id, controllerName.text, controllerEmail.text);
  }

    Future<void> addDetail() async {
    await SQLHelper.addDetail(controllerUsia.text, controllerPekerjaan.text);
  }

  Future<void> editDetail(int id) async {
    await SQLHelper.editEmployee(id, controllerName.text, controllerEmail.text);
  }
}
