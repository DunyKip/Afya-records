import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PatientInfoPage extends StatefulWidget {
  var patientresult_id;

  PatientInfoPage(this.patientresult_id, {Key? key}) : super(key: key);

  @override
  _PatientInfoPageState createState() =>
      _PatientInfoPageState(patientresult_id);
}

class _PatientInfoPageState extends State<PatientInfoPage> {
  // Sample patient data
  String _patientName = '';
  String _patientAge = '';
  String _patientAddress = '';

  var patient_id = "";

  // Controllers for text fields
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();

  Map<String, dynamic> patientresult = {};

  _PatientInfoPageState(this.patient_id);

  // Set initial values for text fields
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('http://192.168.2.18:8000/patients/' + patient_id));
    if (response.statusCode == 200) {
      setState(() {
        patientresult = jsonDecode(response.body);
        _patientName = patientresult['patient_name'];
        _patientAge = patientresult['age'];
        _patientAddress = patientresult['address'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Information'),
        backgroundColor: Colors.lightBlue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: TextEditingController(text: _patientName),
            ),
            SizedBox(height: 16.0),
            Text(
              'Age',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: TextEditingController(text: _patientAge.toString()),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            Text(
              'Address',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: TextEditingController(text: _patientAddress),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Perform edit operation
                    setState(() {
                      _patientName = _nameController.text;
                      _patientAge = _ageController.text;
                      _patientAddress = _addressController.text;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Patient information updated')),
                    );
                  },
                  child: Text('Edit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Perform delete operation
                    setState(() {
                      _nameController.text = '';
                      _ageController.text = '';
                      _addressController.text = '';
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Patient information deleted')),
                    );
                  },
                  child: Text('Delete'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
