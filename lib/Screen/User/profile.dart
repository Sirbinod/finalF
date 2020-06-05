import 'package:flutter/material.dart';
import 'package:friendlocator/Database/user_database.dart';
import 'package:friendlocator/Model/user.dart';
import 'package:friendlocator/Screen/User/register.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DatabaseUser databaseUser = DatabaseUser();

  Widget _greenColors() {
    return Positioned(
      top: 0,
      child: Container(
        color: Colors.green,
        height: 250,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  Widget _getInfo() {
    return Positioned(
      top: 100,
      child: Container(
        margin: const EdgeInsets.all(20),
        height: 260,
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("User information:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Name: "),
                  SizedBox(
                    width: 20,
                  ),
                  Text(_useData['name'])
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Mobile: "),
                  SizedBox(
                    width: 20,
                  ),
                  Text(_useData['gender'])
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Age: "),
                  SizedBox(
                    width: 20,
                  ),
                  Text(_useData['mobile'])
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userAdress() {
    return Positioned(
      top: 350,
      child: Container(
        margin: EdgeInsets.all(20),
        height: 50,
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: RaisedButton(
          child: Text(
            "Delete",
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          color: Colors.red,
          onPressed: () {
            _delete(context, _useData['id']);
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => Registration()));
          },
        ),
      ),
    );
  }

  Map<String, dynamic> _useData;
  bool _fetchingData = true;
  @override
  void initState() {
    _query();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            _greenColors(),
            _getInfo(),
            _userAdress(),
          ],
        ),
      ),
    );
  }

  void _delete(BuildContext context, User user) async {
    int result = await databaseUser.deleteUser(user.id);
    if (result != 0) {
      _showSnackBar(context, 'User Deleted Successfully');
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _query() async {
    final allRows = await databaseUser.queryAllRows();
    print('query all rows:');

    setState(() {
      _useData = allRows.last;
      _fetchingData = false;
    });
    print('mobile' + _useData['mobile']);
    print('name' + _useData['name']);
    print('gender' + _useData['gender']);
    print('age' + _useData['age']);
  }
}
