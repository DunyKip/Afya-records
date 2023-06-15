import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'home_page.dart';

class addPatientHealthScreen extends StatelessWidget {
  var patientresult_id;
  addPatientHealthScreen(this.patientresult_id, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Afya Health',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.lightBlue[900],
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 12.0, top: 0.0),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo),
          ),
        ),
      ),
      home: PersonalInfoForm(patientresult_id),
    );
  }
}

class PersonalInfoForm extends StatefulWidget {
  var patientresult_id;
  PersonalInfoForm(this.patientresult_id);
  @override
  // ignore: library_private_types_in_public_api
  _PersonalInfoFormState createState() =>
      _PersonalInfoFormState(patientresult_id);
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  final _formKey = GlobalKey<FormState>();
  final _bloodpressureController = TextEditingController();
  final _bloodoxygenController = TextEditingController();
  final _heartbeatController = TextEditingController();
  final _respiratoryController = TextEditingController();

  var patientresult_id;

  _PersonalInfoFormState(this.patientresult_id);

  // final _doctorController = TextEditingController();
  //final _ageController = TextEditingController();
  //String? _gender = "male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: const Text('Add Patient Health'),
            backgroundColor: Colors.lightBlue[900],
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage())))),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Blood Pressure (X/Y) :',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 1, 87, 155)),
                  ),
                  TextFormField(
                    controller: _bloodpressureController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter blood pressure';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Heartbeat Reate :',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 1, 87, 155)),
                  ),
                  TextFormField(
                    controller: _heartbeatController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter heartbeat rate';
                      }
                      return null;
                    },
                    maxLines: null,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Blood Oxygen Level (X%) :',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 1, 87, 155)),
                  ),
                  TextFormField(
                    controller: _bloodoxygenController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter blood oxygen';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Respiratory Rate :',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 1, 87, 155)),
                  ),
                  TextFormField(
                    controller: _respiratoryController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter raspiratory rate';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  /*const Text(
                    'Doctor :',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  TextFormField(
                    controller: _doctorController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your doctor';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Age :',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  TextFormField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your age';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text("Gender : ",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue)),
                      Expanded(
                        child: RadioListTile(
                          title: const Text("Male"),
                          value: "male",
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: const Text("Female"),
                          value: "female",
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32.0),*/
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Do something with the form data
                          String bloodpressure = _bloodpressureController.text;
                          String bloodoxygen = _bloodoxygenController.text;
                          String heartbeat = _heartbeatController.text;
                          String raspiratory = _respiratoryController.text;
                          print('Blood Pressure: $bloodpressure');
                          print('Blood Oxygen: $bloodoxygen');
                          print('Heartbeat: $heartbeat');
                          print('Respiratory Rate: $raspiratory');
                          DateTime now = DateTime.now();
                          String formattedDate =
                              '${now.year}-${now.month}-${now.day}';
                          String formattedTime =
                              '${now.hour}:${now.minute}:${now.second}';

                          savedata(bloodpressure, bloodoxygen, heartbeat,
                              raspiratory, formattedDate, formattedTime);
                        }

                        Fluttertoast.showToast(
                          msg: "Test Records Added",
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      },
                      // child: const Text('Submit'),
                      child: const Text(
                        'Submit',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  savedata(String bloodpressure, String bloodoxygen, String heartbeat,
      String respiratory, String date, String time) async {
    String url = 'http://192.168.2.18:8000/patients/$patientresult_id/tests';
    var critical_condition = false;
    if (int.parse(bloodpressure) < 60 || int.parse(bloodpressure) > 83) {
      critical_condition = true;
    } else if (int.parse(bloodoxygen) < 92 || int.parse(bloodoxygen) > 100) {
      critical_condition = true;
    } else if (int.parse(heartbeat) < 60 || int.parse(heartbeat) > 100) {
      critical_condition = true;
    } else if (int.parse(respiratory) < 12 || int.parse(respiratory) > 16) {
      critical_condition = true;
    }
    // ignore: prefer_interpolation_to_compose_strings
    print(critical_condition);

    final headers = {'Content-Type': 'application/json'};

    final data = {
      "blood_pressue": bloodpressure,
      "respiratory_rate": respiratory,
      "blood_oxygen": bloodoxygen,
      "heart_rate": heartbeat,
      "patient_id": patientresult_id,
      "nurse_name": "",
      "date": date,
      "time": time,
      "critical_condition": critical_condition,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );
    if (response.statusCode == 201) {
      print(response.body.toString());
    } else {
      print("Data not send");
    }
  }
}
