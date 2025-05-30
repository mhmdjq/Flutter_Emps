import 'package:flutter/material.dart';
import 'package:flutter_application_local_db/models/employee.dart';
import 'package:flutter_application_local_db/pages/search/search_by_id.dart';
import 'package:flutter_application_local_db/pages/search/search_by_name.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class EmployeeDatabase extends ChangeNotifier {
  static late Isar isar;

  // initialize db
  static Future<void> initialize() async{
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([EmployeeSchema], directory: dir.path);
  }

  // create a list to hold all emps
  final List<Employee> allEmployees = [];

  // Create a new emp
  Future<void> addNewEmployee(
    String newName, int newAge, double newSalary) async{
      final newEmployee = Employee()
      ..name = newName
      ..age = newAge
      ..salary = newSalary;

    await isar.writeTxn(() => isar.employees.put(newEmployee));
    fetchEmployees();
    }
  

  // read all emps
  Future<void> fetchEmployees() async{
    List<Employee> currentEmployess = await isar.employees.where().findAll();
    allEmployees.clear();
    allEmployees.addAll(currentEmployess);
    notifyListeners();
  }

  // Update an emp
  Future<void> updateEmployee(
    int id, String newName, int newAge, double newSalary) async{
      final exsitingEmployee = await isar.employees.get(id);
      if (exsitingEmployee != null)
      {
        exsitingEmployee.name = newName;
        exsitingEmployee.age = newAge;
        exsitingEmployee.salary = newSalary;
        await isar.writeTxn(() => isar.employees.put(exsitingEmployee));
        await fetchEmployees();
      }
    }

  // Delete an emp
  Future<void> deleteEmployee(int id) async {
    await isar.writeTxn(() => isar.employees.delete(id));
    await fetchEmployees();
  }

  // Search By ID
  Future<void> searchByID(String x) async{
    List<Employee> currentEmployess = [];

    int value = -1;
    if(int.tryParse(x) != null){
      value = int.parse(x);
    }

    if (value != -1) {
      currentEmployess = 
      await isar.employees.filter().idEqualTo(value).findAllSync();  
    }
    
    allEmployees.clear();
    allEmployees.addAll(currentEmployess);
    notifyListeners();
  }


  // search by name
  Future<void> searchByName(String x) async{
    List<Employee> currentEmployess = [];

    if (x.isNotEmpty) {
      currentEmployess = 
      await isar.employees.filter().
      nameContains(x, caseSensitive: false).sortByName().findAllSync();
    }
    
    allEmployees.clear();
    allEmployees.addAll(currentEmployess);
    notifyListeners();
  }

  //search by Age
  Future<void> searchByAge(String x, String y) async{
    List<Employee> currentEmployess = [];

    int valueX = -1, valueY = -1;

    if(int.tryParse(x) != null && int.tryParse(y) != null){
      valueX = int.parse(x);
      valueY = int.parse(y);
    }

    if (valueX != -1 && valueY != -1) {
      currentEmployess = 
      await isar.employees.filter().ageBetween(valueX, valueY).
      sortByAge().findAllSync();  
    }
    
    allEmployees.clear();
    allEmployees.addAll(currentEmployess);
    notifyListeners();
  }

  //search by Salary
  Future<void> searchBySalary(String from, String to) async{
    List<Employee> currentEmployess = [];

    double valueFrom = -1, valueTo = -1;

    if(int.tryParse(from) != null && int.tryParse(to) != null){
      valueFrom = double.parse(from);
      valueTo = double.parse(to);
    }

    if (valueFrom != -1 && valueTo != -1) {
      currentEmployess = 
      await isar.employees.filter().salaryBetween(valueFrom, valueTo).
      sortByAge().findAllSync();
    }
    
    allEmployees.clear();
    allEmployees.addAll(currentEmployess);
    notifyListeners();
  }

}