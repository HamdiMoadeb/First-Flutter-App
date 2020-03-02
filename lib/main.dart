// Flutter code sample for AppBar

// This sample shows an [AppBar] with two simple actions. The first action
// opens a [SnackBar], while the second action navigates to a new page.

import 'package:flutter/material.dart';
import 'package:i_am_rich/rest_api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: EmployeePage(),
    );
  }
}

class EmployeePage extends StatefulWidget {
  @override
  _EmployeePageState createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter REST API'),
      ),
      body: FutureBuilder(
        future: ApiService.getEmployees(),
        builder: (context, snapshot) {
          final employees = snapshot.data;
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(
                  height: 2,
                  color: Colors.black,
                );
              },
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(employees[index]['firstname']),
                  subtitle: Text('Email: ${employees[index]['email']}'),
                );
              },
              itemCount: employees.length,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewEmployeePage(),
            ),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddNewEmployeePage extends StatefulWidget {
  AddNewEmployeePage({Key key}) : super(key: key);

  _AddNewEmployeePageState createState() => _AddNewEmployeePageState();
}

class _AddNewEmployeePageState extends State<AddNewEmployeePage> {
  final _employeeNameController = TextEditingController();
  final _employeeBirth = TextEditingController();
  final _employeeLast = TextEditingController();
  final _employeeAddress = TextEditingController();
  final _employeePass = TextEditingController();
  final _employeeEmail = TextEditingController();
  final _employeePhone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Employee'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _employeeNameController,
                decoration: InputDecoration(hintText: 'Admin Name'),
              ),
              TextField(
                controller: _employeeLast,
                decoration: InputDecoration(hintText: 'Admin Lastname'),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: _employeeBirth,
                decoration: InputDecoration(hintText: 'Admin Birthday'),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: _employeePhone,
                decoration: InputDecoration(hintText: 'Admin Phone'),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: _employeeAddress,
                decoration: InputDecoration(hintText: 'Admin Address'),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: _employeeEmail,
                decoration: InputDecoration(hintText: 'Admin Email'),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: _employeePass,
                decoration: InputDecoration(hintText: 'Admin Password'),
                keyboardType: TextInputType.text,
              ),
              RaisedButton(
                child: Text(
                  'SAVE',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.purple,
                onPressed: () {
                  final body = {
                    "firstname": _employeeNameController.text.toString(),
                    "lastname": _employeeLast.text.toString(),
                    "birthday": _employeeBirth.text.toString(),
                    "address": _employeeAddress.text.toString(),
                    "phone": _employeePhone.text.toString(),
                    "email": _employeeEmail.text.toString(),
                    "password": _employeePass.text.toString(),
                  };
                  ApiService.addEmployee(body).then((success) {
                    if (success) {
                      showDialog(
                        builder: (context) => AlertDialog(
                          title: Text('Employee has been added!!!'),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _employeeNameController.text = '';
                                _employeeLast.text = '';
                                _employeeBirth.text = '';
                                _employeeAddress.text = '';
                                _employeePhone.text = '';
                                _employeeEmail.text = '';
                                _employeePass.text = '';
                              },
                              child: Text('OK'),
                            )
                          ],
                        ),
                        context: context,
                      );
                      return;
                    } else {
                      showDialog(
                        builder: (context) => AlertDialog(
                          title: Text('Error Adding Admin!!!'),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            )
                          ],
                        ),
                        context: context,
                      );
                      return;
                    }
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
