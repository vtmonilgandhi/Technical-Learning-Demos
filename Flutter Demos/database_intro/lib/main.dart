import 'package:database_intro/models/user.dart';
import 'package:database_intro/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

List _users;

void main() async {
  var db = new DatabaseHelper();

//  int savedUser = await db.saveUser(new User("Kiran", "12345678"));
//  print("User saved: $savedUser");

  int count = await db.getCount();
  print("Count: $count");

  User userDetails = await db.getUser(1);
  print("Got Username: ${userDetails.username}");

//  int userDeleted = await db.deleteUser(5);
//  print("Deleted user: $userDeleted");

  User updateUser =
      User.fromMap({"username": "updatedAna", "password": "12345678", "id": 1});
  int userUpdated = await db.updateUser(updateUser);
  print("Updated user: $userUpdated");

  _users = await db.getAllUsers();
  for (int i = 0; i < _users.length; i++) {
    User user = User.map(_users[i]);
    print("Username: ${user.username}, User Id: ${user.id}");
  }

  runApp(new MaterialApp(
    title: "DataBase",
    home: new Home(),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Database"),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: new ListView.builder(
          itemCount: _users.length,
          itemBuilder: (_, int position) {
            return new Card(
              color: Colors.white,
              elevation: 2.0,
              child: new ListTile(
                leading: new CircleAvatar(
                  child: new Text(
                      "${User.fromMap(_users[position]).username.substring(0, 1)}"),
                ),
                title: new Text(
                    "User: ${User.fromMap(_users[position]).username}"),
                subtitle: new Text("Id: ${User.fromMap(_users[position]).id}"),
              ),
            );
          }),
    );
  }
}
