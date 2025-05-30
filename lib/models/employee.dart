import 'package:isar/isar.dart';

part 'employee.g.dart';

@Collection()
class Employee{
  Id id = Isar.autoIncrement;
  late String name;
  late int age;
  late double salary;

}