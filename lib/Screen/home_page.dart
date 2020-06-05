import 'package:flutter/material.dart';
import 'package:friendlocator/Database/friend_database.dart';
import './start_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sms/sms.dart';
import '../Model/friend.dart';
import 'Friends/friend_list.dart';
import 'Place/place_page.dart';
import 'User/profile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseFriend databaseHelper = DatabaseFriend();
  String location = "loading";
  void stateinit() async {
    // TODO: implement initState
    location = await _getCurrentLocation();

    this.setState(() {
      location = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    stateinit();
    return Scaffold(
        appBar: AppBar(
          title: Text('Friend Locator'),
        ),
        body: Container(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Current Location :",
                style: TextStyle(letterSpacing: 2.0, fontSize: 15.0),
              ),
              SizedBox(
                height: 15.0,
              ),
              // current location call
              this.location == "loading"
                  ? CircularProgressIndicator()
                  : Text(this.location),
              Divider(
                height: 40.0,
              ),
              Text(
                'Tap the button to send your location:',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 20.0,
              ),
              RawMaterialButton(
                onPressed: () {
                  _getCurrentLocation();
                  _ackAlert(context);
                  _sms();
                },
                child: new Icon(
                  Icons.warning,
                  color: Colors.redAccent,
                  size: 250.0,
                ),
                shape: new CircleBorder(),
                elevation: 6.0,
                fillColor: Colors.yellow,
                padding: const EdgeInsets.all(30.0),
              ),
              SizedBox(
                height: 40.0,
              ),
            ],
          ),
        )),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white54,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.library_add),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => FriendList()));
                },
              ),
              IconButton(
                icon: Icon(Icons.people),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Profile()));
                },
              ),
              IconButton(
                icon: Icon(Icons.label_important),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => PlacePage()));
                },
              ),
            ],
          ),
        ));
  }
}

Future<void> _sms() async {
  String location = await _getCurrentLocation();
  DatabaseFriend h = new DatabaseFriend();
  List<Friend> friends = await h.getFriendList();
  friends.forEach((element) async {
    SmsSender sender = new SmsSender();

    var message = "Emergency!!!! Help! My location is $location";
    String recipents = element.number;
    SmsMessage _message = new SmsMessage(recipents, message);
    _message.onStateChanged.listen((event) {
      if (event == SmsMessageState.Sent) {
        print("Sms Sent");
      } else if (event == SmsMessageState.Delivered) {
        print("Delevered");
      } else {
        print(event);
      }
    });
    sender.sendSms(_message);
  });
}

Future<String> _getCurrentLocation() async {
  final position = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  print(position);
  return "${position.latitude}, ${position.longitude}";
}

Future<void> _ackAlert(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('SMS sent'),
        content: const Text('this SMS sent you friend'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
