import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gd5_d_1204/database/sql_helper.dart';
import 'package:gd5_d_1204/entity/employee.dart';
import 'package:gd5_d_1204/entity/detail.dart';
import 'package:gd5_d_1204/inputPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFLITE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'SQFLITE'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> employee = [];
  void refresh() async {
    final data = await SQLHelper.getEmployee();
    setState(() {
      employee = data;
    });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("EMPLOYEE"),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InputPage(
                            title: 'INPUT EMPLOYEE',
                            id: null,
                            name: null,
                            email: null,
                            usia: null,
                            pekerjaan: null)),
                  ).then((_) => refresh());
                }),
            IconButton(onPressed: () async {}, icon: Icon(Icons.clear))
          ],
        ),
        body: ListView.builder(
            itemCount: employee.length,
            itemBuilder: (context, index) {
              return Slidable(
                child: ListTile(
                  title: Text(employee[index]['name']),
                  subtitle: Text(employee[index]['email'])
                ),
                actionPane: SlidableDrawerActionPane(),
                secondaryActions: [
                  IconSlideAction(
                    caption: 'Update',
                    color: Colors.blue,
                    icon: Icons.update,
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InputPage(
                                title: 'INPUT EMPLOYEE',
                                id: employee[index]['id'],
                                name: employee[index]['name'],
                                email: employee[index]['email'],
                                usia: employee[index]['usia'],
                                pekerjaan: employee[index]['pekerjaan'])),
                      ).then((_) => refresh());
                    },
                  ),
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () async {
                      await deleteEmployee(employee[index]['id']);
                      await deleteDetail(employee[index]['id']);
                    },
                  )
                ],
              );
            }));
  }

  Future<void> deleteEmployee(int id) async {
    await SQLHelper.deleteEmployee(id);
    refresh();
  }

    Future<void> deleteDetail(int id) async {
    await SQLHelper.deleteDetail(id);
    refresh();
  }
}
