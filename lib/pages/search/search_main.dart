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
import 'package:flutter_application_local_db/pages/search/search_by_age.dart';
import 'package:flutter_application_local_db/pages/search/search_by_id.dart';
import 'package:flutter_application_local_db/pages/search/search_by_name.dart';
import 'package:flutter_application_local_db/pages/search/search_by_salary.dart';
import 'package:provider/provider.dart';

class SearchMain extends StatefulWidget {
  const SearchMain({super.key});

  @override
  State<SearchMain> createState() => _SearchMainState();
}

class _SearchMainState extends State<SearchMain> {

    
    @override
    void initState()
    {
      super.initState();
      context.read<EmployeeDatabase>().fetchEmployees();

    }

    

  @override
  Widget build(BuildContext context) {

    // final List<String> mylist = <String>["Ali", "Mo", "Tala"];
    final List<Employee> currentEmployees = 
    context.watch<EmployeeDatabase>().allEmployees;

    return Scaffold(
      
      appBar: AppBar(        
        centerTitle: true,
        title: const Text('Search Page', style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),),
        backgroundColor: Colors.blue[200],

      ),
      
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilledButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchById()));
            }, child: const MyBlueText("Search by ID")),
            FilledButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchByName()));
            }, child: const MyBlueText("Search by Name")),
            FilledButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchByAge()));
            }, child: const MyBlueText("Search by Age")),
            FilledButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchBySalary()));
            }, child: const MyBlueText("Search by Salary")),
          ],
        ),
      ),
    );
  }
}