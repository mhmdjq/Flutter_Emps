import 'package:flutter/material.dart';
import 'package:flutter_application_local_db/models/employee.dart';
import 'package:flutter_application_local_db/models/employee_database.dart';
import 'package:provider/provider.dart';

class EditEmployee extends StatefulWidget {
  const EditEmployee(this.emp,{super.key});
  final Employee emp;

  @override
  State<EditEmployee> createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {

  String nameErrorMsg = "";
  String ageErrorMsg = "";
  String salaryErrorMsg = "";
  bool allCorrect = true;
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final salaryController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    nameController.text = widget.emp.name;
    ageController.text = widget.emp.age.toString();
    salaryController.text = widget.emp.salary.toString();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Employee', style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),),
        backgroundColor: Colors.blue[200],

      ),

      // body: const Text("Hi Mohammed AlQudimat"),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [              
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter name',
                    labelText: 'Name',
                    labelStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    border: const OutlineInputBorder(),
                    fillColor: Colors.green[200],
                    filled: true,                
                    // icon: const Icon(Icons.abc),
                    suffixIcon: const Icon(Icons.abc), 
                    errorText: nameErrorMsg,
                  ),
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  // maxLength: 5,
                  // maxLines: 3,
                ),
              ),
          
              // ------- Age -------
          
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter age',
                    labelText: 'Age',
                    labelStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    border: const OutlineInputBorder(),
                    fillColor: Colors.green[200],
                    filled: true,                
                    // icon: const Icon(Icons.abc),
                    suffixIcon: const Icon(Icons.numbers), 
                    errorText: ageErrorMsg,
                  ),
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  // maxLength: 5,
                  // maxLines: 3,
                ),
              ),
          
              // ------- Sal TextFiled -----------
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter Salary',
                    labelText: 'Salary',
                    labelStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    border: const OutlineInputBorder(),
                    fillColor: Colors.green[200],
                    filled: true,                
                    // icon: const Icon(Icons.abc),
                    suffixIcon: const Icon(Icons.numbers), 
                    errorText: salaryErrorMsg,
                  ),
                  controller: salaryController,
                  keyboardType: TextInputType.number,
                  // maxLength: 5,
                  // maxLines: 3,
                ),
              ),
              
              // ------------------ add and cancel
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: const Text("Cancel")),
                  const SizedBox(width: 20,),
                  FilledButton(onPressed: () {
                    allCorrect = true;
                    setState(() {
                      // ------ nameController ---------------
                      if (nameController.text.length < 2)
                      {
                        nameErrorMsg = "Name must be at least 2 characters long";
                        allCorrect = false;
                      }
                      else
                      {
                        nameErrorMsg = "";
                      }

                      // ------ ageController ---------------
                      if (ageController.text.isEmpty) 
                      {
                        ageErrorMsg = "U must enter age";
                        allCorrect = false;
                      }
                      else
                      {
                        int age = int.parse(ageController.text);
                        if ( age < 18 || age > 50) {
                          ageErrorMsg = "Age must be from 18 to 50";
                          allCorrect = false;
                        }
                        else
                        {
                          ageErrorMsg = "";
                        }                        
                      }

                      // ------ salaryController ---------------
                      if (salaryController.text.isEmpty)
                      {
                        salaryErrorMsg = "U must enter salary";
                        allCorrect = false;
                      }
                      else 
                      {
                        double salary = double.parse(salaryController.text);
                        if (salary < 275 || salary > 3000)
                        {
                          salaryErrorMsg = "Salary must be from 275 to 3000";
                          allCorrect = false;
                        }

                        else
                        {
                          salaryErrorMsg = "";
                        }
                      }

                      if (allCorrect == true)
                      {
                        context.read<EmployeeDatabase>()
                        .updateEmployee(
                            widget.emp.id, 
                            nameController.text,
                            int.parse(ageController.text),
                            double.parse(salaryController.text));
                        Navigator.pop(context);
                      }


                    });
                  }, child: const Text("  Save  ")),
                ],
              )
              
            ],),
        ),
      ),
    );
  }
}