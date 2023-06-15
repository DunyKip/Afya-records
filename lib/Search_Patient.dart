import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:Afyarecord/health_data_history.dart';

import 'package:collection/collection.dart';

class SearchPatient extends StatelessWidget {
  const SearchPatient({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
            // bodyText2: TextStyle(color: Colors.red, fontWeight: FontWeight.w900),
            ),
      ),
      home: const MyHomePage(title: 'Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // This controller will store the value of the search bar
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> patientresult = [];
  List<dynamic> filteredresult = [];

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
        // print("response" + response.body);
        //   _items = List<String>.generate(50, (index) => "Item ${index + 1}");
        filteredresult = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          // Add padding around the search bar
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          // Use a Material design search bar
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  // Add a clear button to the search bar
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () => _searchController.clear(),
                  ),
                  // Add a search icon or button to the search bar
                  prefixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      // Perform the search here
                    },
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onChanged: (text) {
                  setState(() {
                    filteredresult = [];

                    for (final item in patientresult) {
                      if (item["patient_name"]
                          .toLowerCase()
                          .contains(text.toLowerCase())) {
                        filteredresult.add(item);
                        return;
                      }
                    }
                  });
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredresult.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyHealthData(filteredresult[index]['_id'])),
                          // builder: (context) => MyHealthData(data: data[index]['patient_name'])),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                filteredresult[index]['patient_name'],
                                style: const TextStyle(fontSize: 18.0),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                filteredresult[index]['address'],
                                style: const TextStyle(
                                    fontSize: 14.0, color: Colors.grey),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                filteredresult[index]['age'],
                                style: const TextStyle(
                                    fontSize: 14.0, color: Colors.grey),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                filteredresult[index]['department'],
                                style: const TextStyle(
                                    fontSize: 14.0, color: Colors.grey),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                filteredresult[index]['doctor'],
                                style: const TextStyle(
                                    fontSize: 14.0, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
