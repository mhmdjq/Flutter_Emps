import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_local_db/models/employee.dart';
import 'package:flutter_application_local_db/models/employee_database.dart';
import 'package:flutter_application_local_db/pages/about_us.dart';
import 'package:flutter_application_local_db/pages/add_employee.dart';
import 'package:flutter_application_local_db/pages/edit_employee.dart';
import 'package:flutter_application_local_db/pages/my_blue_text.dart';
import 'package:flutter_application_local_db/pages/search/search_main.dart';
import 'package:provider/provider.dart';

class SearchByAge extends StatefulWidget {
  const SearchByAge({super.key});

  @override
  State<SearchByAge> createState() => _SearchByAgeState();
}

class _SearchByAgeState extends State<SearchByAge> {

    final controllerX = TextEditingController();
    final controllerY = TextEditingController();

    @override
    void initState()
    {
      super.initState();
      context.read<EmployeeDatabase>().fetchEmployees();
      
    }

    

  @override
  Widget build(BuildContext context) {    

    final List<Employee> currentEmployees = 
    context.watch<EmployeeDatabase>().allEmployees;

    return Scaffold(
      
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Search By Age', style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),),
        backgroundColor: Colors.blue[200],
      ),
      

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Age : From',
                      labelText: 'From',
                      labelStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      border: const OutlineInputBorder(),
                      fillColor: Colors.green[200],
                      filled: true,                
                      // icon: const Icon(Icons.numbers),
                      // suffixIcon: IconButton(onPressed: (){
                      //   context.read<EmployeeDatabase>().searchByAge(controllerX.text, controllerY.text);
                      // }, icon: const Icon(Icons.search)),
                    ),
                    controller: controllerX,
                    keyboardType: TextInputType.number,
                    // maxLength: 5,
                    // maxLines: 3,
                  ),                              
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter Age: To',
                        labelText: 'To',
                        labelStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        border: const OutlineInputBorder(),
                        fillColor: Colors.green[200],
                        filled: true,                
                        // icon: const Icon(Icons.numbers),
                        suffixIcon: IconButton(onPressed: (){
                          context.read<EmployeeDatabase>().searchByAge(controllerX.text, controllerY.text);
                        }, icon: const Icon(Icons.search)),
                      ),
                      controller: controllerY,
                      keyboardType: TextInputType.number,
                      // maxLength: 5,
                      // maxLines: 3,
                    ),
          ),  

          // IconButton(onPressed: (){
          //   context.read<EmployeeDatabase>().searchByAge(controllerX.text, controllerY.text);
          // }, icon: const Icon(Icons.search)),

          
          if (currentEmployees.isEmpty) ...[
            const Text("No data founded!")
          ]
          else 
          Expanded(
            child: ListView.builder(
              // controller: myScroll,
              itemCount: currentEmployees.length,
              itemBuilder: (BuildContext context, int index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey[200],
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          width: 60,
                          height: 60,
                          
                          decoration: BoxDecoration(
                            color: Colors.blue[400],
                            borderRadius: BorderRadius.circular(10),
            
                          ),
                          child: Center(child: Text(currentEmployees[index].id.toString(), 
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          ))),
                        
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(("Name:") + currentEmployees[index].name,
                            style: const TextStyle(
                              color: Colors.black
                              ),
                              ),
                            
                            Text(("Ag : ") + currentEmployees[index].age.toString()),
                            
                            Text(("Salary: ") + currentEmployees[index].salary.toString()),
                          ],
                        ),
            
                        const Expanded(child: SizedBox(width: 1,)),
                        IconButton(onPressed: (){
                          Navigator.push(context, 
                          MaterialPageRoute(builder:
                           (context) => EditEmployee(currentEmployees[index])));
            
                        }, icon: const Icon(Icons.edit)),
            
            
                        IconButton(
                          onPressed: (){
                            showDialog(
                              context: context, 
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.blue[100],
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: MyBlueText("Are u sure that u want to delete this emp?"),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FilledButton(onPressed: (){
                                        context.read<EmployeeDatabase>()
                                        .deleteEmployee(currentEmployees[index].id);
                                        Navigator.pop(context);
                                      }, 
                                      child: const Text("Yes", style: TextStyle(color: Colors.red),)),
                                      
                                      const SizedBox(width: 20,),
            
                                      FilledButton(onPressed: (){
                                        Navigator.pop(context);
                                      }, 
                                      child: const MyBlueText("No")),
                                    ],
                                  )
                                ],
                              ),
                            ) );
                            // context
                            //   .read<EmployeeDatabase>()
                            //   .deleteEmployee(currentEmployees[index].id);
                          },
                          icon: const Icon(Icons.delete)),
                        // Text(' - '),
                      ],
                    ),
                  ),
                );
              }
              ),
          ),
        ],
      ) ,
    );
  }
}