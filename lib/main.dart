import 'package:flutter/material.dart';
import 'package:Afyarecord/health_data_history.dart';
import 'package:Afyarecord/login_page.dart';
import 'package:Afyarecord/add_patient_screen.dart';
import 'package:Afyarecord/patient_info.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Afyarecord/update_patient_screen.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.blue),
    title: "Afya Record",
    home: LoginPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: const Text('Patients List'),
        
      ),*/
      body: MyDataListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addPatientScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.lightBlue[900],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class MyDataListView extends StatefulWidget {
  @override
  _MyDataListViewState createState() => _MyDataListViewState();
}

class _MyDataListViewState extends State<MyDataListView> {
  List<dynamic> patientresult = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('http://192.168.2.18:8000/patients'));
    if (response.statusCode == 200) {
      setState(() {
        patientresult = jsonDecode(response.body);
        print("response" + response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: patientresult.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MyHealthData(patientresult[index]['_id'])),
                // builder: (context) => MyHealthData(data: data[index]['patient_name'])),
              );
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.personal_injury),
                    Text(
                      patientresult[index]['patient_name'],
                      style: const TextStyle(
                          fontSize: 18.0,
                          color: Color.fromARGB(255, 1, 87, 155)),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      patientresult[index]['address'],
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.grey),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      patientresult[index]['age'],
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.grey),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      patientresult[index]['department'],
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.grey),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      patientresult[index]['doctor'],
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
