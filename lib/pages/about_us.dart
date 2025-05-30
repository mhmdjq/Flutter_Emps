import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_local_db/models/employee.dart';
import 'package:flutter_application_local_db/models/employee_database.dart';
import 'package:flutter_application_local_db/pages/add_employee.dart';
import 'package:flutter_application_local_db/pages/all_employees.dart';
import 'package:flutter_application_local_db/pages/edit_employee.dart';
import 'package:flutter_application_local_db/pages/my_blue_text.dart';
import 'package:provider/provider.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {

    var myWidth = 100.0;
    var myHeight = 50.0;
    var mySize = 5.0;

    @override
    void initState()
    {
      super.initState();
      context.read<EmployeeDatabase>().fetchEmployees();
      
      WidgetsBinding.instance.addPostFrameCallback((_)
      {
          setState(() {
          myWidth = 250.0;
          myHeight = 150.0;
          mySize = 30;
          });
      });
      
    }

    

  @override
  Widget build(BuildContext context) {

    // final List<String> mylist = <String>["Ali", "Mo", "Tala"];
    final List<Employee> currentEmployees = 
    context.watch<EmployeeDatabase>().allEmployees;

    return Scaffold(
      
      appBar: AppBar(        
        centerTitle: true,
        title: const Text('About Us', style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),),
        backgroundColor: Colors.blue[200],

      ),
      
      body: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: AnimatedContainer(
              duration: const Duration(seconds: 3),
              width: myWidth,
              height: myHeight,
              decoration: BoxDecoration(
                color: Colors.blue[400],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(child: 
                AnimatedDefaultTextStyle(
                  duration: const Duration(seconds: 4),
                  style: TextStyle(
                    fontSize: mySize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  child: const Text("Welcome"),
              ),)),
            ),
          
        ]
      )
      ,
    );
  }
}