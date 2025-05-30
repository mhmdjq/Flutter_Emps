import 'package:flutter/material.dart';
import 'package:flutter_application_local_db/models/employee_database.dart';
import 'package:flutter_application_local_db/pages/all_employees.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EmployeeDatabase.initialize();
  runApp(ChangeNotifierProvider(
  create: (context) => EmployeeDatabase(),
  child: const Home(),));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AllEmployees(),
    );
  }
}