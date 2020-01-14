import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hellochat/chatlist.dart';
import 'package:hellochat/services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';

class AddNewFriend extends StatefulWidget {
  final BaseAuth auth;
  AddNewFriend({Key key, this.auth}) : super(key: key);
  @override
  _AddNewFriendState createState() => _AddNewFriendState();
}

class _AddNewFriendState extends State<AddNewFriend> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  // var listusers = [];
  var listdataback = [];
  var listdata = [];
  @override
  void initState() {
    final databaseReference = FirebaseDatabase.instance.reference();
    databaseReference.child('users').once().then((snapshot) {
      if (listdata.length == 0) {
        Map<dynamic, dynamic> datas = snapshot.value;
        setState(() {
          for (var data in datas.values) {
            UserList userList = new UserList();
            userList.useremail = data['email'];
            userList.useravatar = data['avatar'];
            userList.username = data['name'];
            listdata.add(userList);
          }
        });
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('友だち追加'),
      leading: InkWell(
        child: Text('キャンセル'),
        onTap: (){
          Navigator.pop(
                       context,
                       MaterialPageRoute(builder: (context) => ChatList()),
                    );
        },
      ),),
      body: _listnewfriend(),
    );
    
  }
  _listnewfriend(){
    return Container(
      padding: EdgeInsets.all(40.0),
      child: ListView.builder(
        itemCount: listdata.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              ListTile(
                title: Text(listdata[index].username),
                leading: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage((listdata[index].useravatar) != null ? listdata[index].useravatar : ''),
                ),
                onTap: () {
                  
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
class UserList {
  String username;
  String useremail;
  String useravatar;
  String usermess;
  UserList({this.username, this.useremail, this.useravatar, this.usermess});
}