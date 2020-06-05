import 'dart:async';
import 'package:flutter/material.dart';
import 'package:friendlocator/Database/friend_database.dart';
import 'package:friendlocator/Model/friend.dart';
import 'package:friendlocator/Screen/Friends/friend_details.dart';
import 'package:sqflite/sqflite.dart';

class FriendList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FriendListState();
  }
}

class FriendListState extends State<FriendList> {
  DatabaseFriend databaseFriend = DatabaseFriend();
  List<Friend> friendList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (friendList == null) {
      friendList = List<Friend>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Friends'),
      ),
      body: getFriendListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(Friend('', '', ''), 'Add Friend');
        },
        tooltip: 'Add Friend',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getFriendListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              child: Text(getFirstLetter(this.friendList[position].name),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(this.friendList[position].name,
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(this.friendList[position].number),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onTap: () {
                    _delete(context, friendList[position]);
                  },
                ),
              ],
            ),
            onTap: () {
              navigateToDetail(this.friendList[position], 'Edit Friend');
            },
          ),
        );
      },
    );
  }

  getFirstLetter(String title) {
    return title.substring(0, 2);
  }

  void _delete(BuildContext context, Friend friend) async {
    int result = await databaseFriend.deleteFriend(friend.id);
    if (result != 0) {
      _showSnackBar(context, 'friend Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Friend friend, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return FriendDetail(friend, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseFriend.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Friend>> friendListFuture = databaseFriend.getFriendList();
      friendListFuture.then((friendList) {
        setState(() {
          this.friendList = friendList;
          this.count = friendList.length;
        });
      });
    });
  }
}
