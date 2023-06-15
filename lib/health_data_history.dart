import 'package:flutter/material.dart';
import 'package:Afyarecord/login_page.dart';
import 'package:Afyarecord/add_patient_screen.dart';
import 'package:Afyarecord/patient_info.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Afyarecord/update_patient_screen.dart';
import 'package:Afyarecord/add_patient_health.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.blue),
    title: "We Care",
    home: LoginPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Health Data'),
      ),
    );
  }
}

class MyHealthData extends StatefulWidget {
  var patientresult_id;

  MyHealthData(this.patientresult_id);

  @override
  _MyHealthDataState createState() => _MyHealthDataState(patientresult_id);
}

class _MyHealthDataState extends State<MyHealthData> {
  List<dynamic> result = [];

  var patientresult_id;

  _MyHealthDataState(this.patientresult_id);

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://192.168.2.18:8000/patients/' + patientresult_id + '/tests'));
    if (response.statusCode == 200) {
      setState(() {
        result = jsonDecode(response.body);
        print("response" + response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Health Data'),
        backgroundColor: Colors.lightBlue[900],
        actions: <Widget>[
          IconButton(
            icon: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cdn-icons-png.flaticon.com/512/6522/6522516.png'),
            ),
            onPressed: () {
              // Perform some action when the profile button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PatientInfoPage(patientresult_id)),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: result.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Icon(Icons.health_and_safety_outlined),
                    const SizedBox(height: 8.0),
                    Text(
                      'Blood pressure:    ' + result[index]['blood_pressue'],
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Blood Oxgen level:   ' + result[index]['blood_oxygen'],
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Heartbeat Rate:   ' + result[index]['heart_rate'],
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Respiratory Rate:   ' +
                          result[index]['respiratory_rate'],
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Date and time:   ' +
                          result[index]['date'] +
                          ' ' +
                          result[index]['time'],
                      style: const TextStyle(fontSize: 10.0),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => addPatientHealthScreen(patientresult_id)),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.lightBlue[900],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
