

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_own_project/helpers/drawer_navigation.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Todo Version'),
      ),
      drawer: DrawerNavigation(),
      body: Container(
        child: Center(
            child: Text(
              'home screen',
              style: TextStyle(
                fontSize: 20.0,
              ),
        )),
      ),
    );
  }
}

