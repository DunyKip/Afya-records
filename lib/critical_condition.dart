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
    title: "Afya record",
    home: LoginPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class CriticalCondition extends StatelessWidget {
  const CriticalCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: const Text('Patients List'),
        
      ),*/
      body: MyDataListView(),
    );
  }
}

class MyDataListView extends StatefulWidget {
  @override
  _MyDataListViewState createState() => _MyDataListViewState();
}

class _MyDataListViewState extends State<MyDataListView> {
  List<dynamic> patientresult = [];
  List<dynamic> criticalpatientlist = [];
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
        //   print("response" + response.body);
        for (int i = 0; i < patientresult.length; i++) {
          if (patientresult[i]['critical_condition'] == true) {
            criticalpatientlist.add(patientresult[i]);
          }
        }
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: criticalpatientlist.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MyHealthData(criticalpatientlist[index]['_id'])),
                // builder: (context) => MyHealthData(data: data[index]['patient_name'])),
              );
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.person_remove),
                    Text(
                      criticalpatientlist[index]['patient_name'],
                      style: const TextStyle(
                          fontSize: 18.0, color: Colors.redAccent),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      criticalpatientlist[index]['address'],
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.grey),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      criticalpatientlist[index]['age'],
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.grey),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      criticalpatientlist[index]['department'],
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.grey),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      criticalpatientlist[index]['doctor'],
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
