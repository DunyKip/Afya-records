import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Afyarecord/home_page.dart';

import 'main.dart';

// ignore: camel_case_types
class addPatientScreen extends StatelessWidget {
  const addPatientScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'We Care',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlue[900],
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding:
              const EdgeInsets.only(left: 15.0, bottom: 13.0, top: 0.0),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo),
          ),
        ),
      ),
      home: const PersonalInfoForm(heading: 'Add Patient'),
    );
  }
}

class PersonalInfoForm extends StatefulWidget {
  const PersonalInfoForm({super.key, required this.heading});
  final String heading;

  @override
  // ignore: library_private_types_in_public_api
  _PersonalInfoFormState createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final address = TextEditingController();
  final contact = TextEditingController();
  final department = TextEditingController();
  final doctor = TextEditingController();
  final age = TextEditingController();
  String? gender = "male";
  String? departmentDefault = "General";
  final bool _isChecked = false;

  // List of items in our dropdown menu
  var items = [
    'General',
    'ICU',
    'Surgery',
  ];

  get child => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: const Text('Add Patient'),
            backgroundColor: Colors.lightBlue[900],
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage())))),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*const Text(
                    'Name :',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),*/
                  TextFormField(
                    controller: name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue[900]),
                  ),
                  const SizedBox(height: 15),

                  //   const SizedBox(height: 16),
                  /*  const Text(
                    'Address :',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),*/
                  TextFormField(
                    controller: address,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter address';
                      }
                      return null;
                    },
                    maxLines: null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Address',
                      hintText: 'Enter Your Address',
                    ),
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  const SizedBox(height: 15),

                  //  const SizedBox(height: 16),
                  /* const Text(
                    'Contact :',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),*/
                  TextFormField(
                    controller: contact,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter contact number';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contact',
                      hintText: 'Enter Your Contact Number',
                    ),
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),

                  const SizedBox(height: 15),

                  //const SizedBox(height: 16),
                  const Text(
                    'Department :',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),

                  /*  TextFormField(
                    controller: department,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter department name';
                      }
                      return null;
                    },
                  ),*/

                  DropdownButton(
                    // Initial Value
                    value: departmentDefault,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        departmentDefault = newValue!;
                      });
                    },
                  ),
                  const SizedBox(height: 15),

                  /*  TextFormField(
                    controller: department,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter department name';
                      }
                      return null;
                    },
                  ),*/

                  // const SizedBox(height: 16),
                  /*const Text(
                    'Doctor :',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),*/
                  TextFormField(
                    controller: doctor,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter doctor name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Doctor Name',
                      hintText: 'Enter Your Doctor Name',
                    ),
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  const SizedBox(height: 15),

                  // const SizedBox(height: 16),
                  /* const Text(
                    'Age :',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),*/
                  TextFormField(
                    controller: age,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your age';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Age',
                      hintText: 'Enter Your Age',
                    ),
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),

                  //  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text("Gender : ",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue)),
                      Expanded(
                        child: RadioListTile(
                          title: const Text("Male"),
                          value: "male",
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: const Text("Female"),
                          value: "female",
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32.0),

                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Do something with the form data
                          String nameattribute = name.text;
                          String addressatrribute = address.text;
                          String contactattribute = contact.text;
                          String departmentattribute = departmentDefault!;
                          String doctorattribute = doctor.text;
                          String ageattribute = age.text;
                          String genderattribute = gender!;
                          print('Name: $nameattribute');
                          print('Address: $addressatrribute');
                          print('Contact: $contactattribute');
                          print('Department: $departmentattribute');
                          print('Doctor: $doctorattribute');
                          print('Age: $ageattribute');
                          print('Gender: $genderattribute');
                          savedata(
                              nameattribute,
                              addressatrribute,
                              contactattribute,
                              departmentattribute,
                              doctorattribute,
                              ageattribute,
                              genderattribute);
                        }
                        Fluttertoast.showToast(
                          msg: "Patient Added Successfully",
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

  savedata(String name, String address, String contact, String department,
      String doctor, String age, String gender) async {
    const url = 'http://192.168.2.18:8000/patients';
    print("Save data method called");

    final headers = {'Content-Type': 'application/json'};

    final data = {
      "patient_name": name,
      "address": address,
      "age": age,
      "gender": gender,
      "contact_no": contact,
      "department": department,
      "doctor": doctor,
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
