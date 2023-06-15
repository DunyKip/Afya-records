import 'package:flutter/material.dart';

import 'package:Afyarecord/main.dart' as mainPage;
import 'package:Afyarecord/critical_condition.dart'
    as critical_condition;
import 'package:Afyarecord/Search_Patient.dart'
    as SearchPatient;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.blueGrey[50],
          appBar: AppBar(
            title: new Text("Home Page"),
            backgroundColor: Colors.lightBlue[900],
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.person_add), text: 'Patient List'),
                Tab(
                  icon: Icon(Icons.medical_information),
                  text: 'Critical Record',
                ),
                Tab(
                  icon: Icon(Icons.manage_search),
                  text: 'Search',
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            new mainPage.MyApp(),
            Center(
              child: new critical_condition.CriticalCondition(),
            ),
            Center(
              child: new SearchPatient.SearchPatient(),
            ),
          ]),
        ),
      ),
    );
  }
}

class TabBardemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
