import 'package:flutter/material.dart';
import 'package:friendlocator/Database/user_database.dart';
import 'package:friendlocator/Model/user.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();
  final _nameEditController = TextEditingController();
  final _mobileEditController = TextEditingController();
  final _genderEditController = TextEditingController();
  final _ageEditController = TextEditingController();
  String mobile_pattern = r'^(?:[+0]9)?[0-9]{10}$';
  Size size;
  String selectGender;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    size = MediaQuery.of(context).size;
    return new Scaffold(
      backgroundColor: Colors.black,
      key: _scafoldKey,
      body: Stack(
        children: <Widget>[
          // Image.asset("splash_img.png",fit: BoxFit.cover, width: size.width,height: size.height,),
          Container(
            color: const Color(0x99FFFFFF),
          ),
          Container(
            height: 120,
            decoration: new BoxDecoration(
              border: Border.all(color: Colors.teal),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(size.width / 2),
                  topRight: Radius.circular(size.width / 2)),
              color: Colors.teal,
            ),
          ),

          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: new BoxDecoration(
                            border: new Border.all(color: Colors.teal),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.teal,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Registration Form",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        //--------------Name FormFiled------------------------------------------
                        TextFormField(
                          controller: _nameEditController,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter Full Name";
                            }
                            return null;
                          },
                          style: getTextStyle(),
                          decoration: InputDecoration(
                            labelText: 'Enter Full Name',
                            hintText: "ex. Ram Prasad",
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //--------------Mobile FormFiled------------------------------------------
                        TextFormField(
                          controller: _mobileEditController,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            RegExp regex = RegExp(mobile_pattern);
                            if (!regex.hasMatch(value))
                              return 'Enter valid mobile number';
                            else
                              return null;
                          },
                          // keyboardType: TextInputType.number,
                          style: getTextStyle(),
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            hintText: "ex-9800000000",
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField<String>(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                          value: selectGender,
                          hint: Text(
                            'Select gender',
                            style: TextStyle(color: Colors.black),
                          ),
                          onChanged: (gender) =>
                              setState(() => selectGender = gender),
                          validator: (value) =>
                              value == null ? 'field required' : null,
                          items: ['Male', 'Female', 'Others']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _ageEditController,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "age requerd";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          style: getTextStyle(),
                          decoration: InputDecoration(
                            labelText: 'Enter You Age',
                            hintText: "ex. 20",
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              DatabaseUser.instance
                                  .insertUser(User(
                                      _nameEditController.text,
                                      _ageEditController.text,
                                      _mobileEditController.text,
                                      _genderEditController.text))
                                  .then((result) {
                                if (result == -1) {
                                  _scafoldKey.currentState.showSnackBar(SnackBar(
                                      content: Text(
                                          'User with same number already existed $result')));
                                } else {
                                  _scafoldKey.currentState.showSnackBar(SnackBar(
                                      content: Text(
                                          'User Registered Succesfully $result')));
                                  Navigator.pushReplacementNamed(
                                      context, "/home");
                                }
                              });
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: Colors.green,
                          child: Text(
                            "Register",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }

  TextStyle getTextStyle() {
    return TextStyle(fontSize: 20, color: Colors.black);
  }

  InputDecoration customInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.black),
      contentPadding: EdgeInsets.all(10),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.black)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.black)),
    );
  }
}
