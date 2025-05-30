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

class AllEmployees extends StatefulWidget {
  const AllEmployees({super.key});

  @override
  State<AllEmployees> createState() => _AllEmployeesState();
}

class _AllEmployeesState extends State<AllEmployees> {

    ScrollController myScroll = ScrollController();
    bool isVisible = true;

    @override
    void initState()
    {
      super.initState();
      context.read<EmployeeDatabase>().fetchEmployees();
      myScroll.addListener(
        (){
            if (myScroll.position.userScrollDirection == ScrollDirection.reverse 
            && isVisible) {
              setState(() {
                isVisible = false;
              });
            }
            else if (myScroll.position.userScrollDirection == ScrollDirection.forward 
            && !isVisible){
              setState(() {
                isVisible = true;
              });
            }
            
          }
      );
    }

    

  @override
  Widget build(BuildContext context) {

    // final List<String> mylist = <String>["Ali", "Mo", "Tala"];
    final List<Employee> currentEmployees = 
    context.watch<EmployeeDatabase>().allEmployees;

    return Scaffold(
      
      appBar: AppBar(        
        centerTitle: true,
        title: const Text('All Employees', style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),),
        backgroundColor: Colors.blue[200],

      ),
      drawer: Drawer(
        backgroundColor: Colors.blue[200],
        child: Column(children: [
          const DrawerHeader(
            child: Icon(
              Icons.home, 
              size: 70, 
              color: Colors.white,)),

              // --------- All fuckers -------------
              ListTile(
                leading: const Icon(Icons.home, color: Colors.white,),
                title: const Text("All Employees",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,),
                ),
                onTap: () {
                  Navigator.push(context, 
                  MaterialPageRoute(builder: 
                  (context) => const AllEmployees()));
                },
                ),
                
              // --------- Add fuckers -------------
              ListTile(
                leading: const Icon(Icons.add, color: Colors.white,),
                title: const Text("Add Employee",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, 
                  MaterialPageRoute(builder: 
                  (context) => const AddEmployee()));
                },
                ),
              
              // --------- Search fuckers -------------
              ListTile(
                leading: const Icon(Icons.search, color: Colors.white,),
                title: const Text("Search Employees",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,),
                ),
                onTap: () {
                  Navigator.push(context, 
                  MaterialPageRoute(builder: 
                  // SearchEmployee
                  (context) => const SearchMain()));
                },
                ),

              // --------- About the fuckers -------------
              ListTile(
                leading: const Icon(Icons.info, color: Colors.white,),
                title: const Text("About the app",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, 
                  MaterialPageRoute(builder: 
                  // AboutTheApp
                  (context) => const AboutUs()));
                },
                ),
                
              const Expanded(child: 
              SizedBox(height: 1,)),

              // --------- Exit fucker -------------
              ListTile(
                leading: const Icon(Icons.exit_to_app_outlined, color: Colors.white,),
                title: const Text("Exit the app",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,),
                ),
                onTap: () {
                  exit(0);
                },
                ),
              
        ],)
      ),

      body: ListView.builder(
        controller: myScroll,
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
        ) ,
      floatingActionButton: Visibility(
        visible: isVisible,
        child: FloatingActionButton(
          onPressed: (){
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddEmployee()));
          },
          child: const Icon(Icons.add),),
      ),
    );
  }
}