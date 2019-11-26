import 'package:flutter/material.dart';
import 'add_edit.dart';
import 'contactsInput.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'database.dart';
import 'view_contacts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;
  DatabaseDB databaseDB = DatabaseDB();
  List<Contacts> contactsList;

  @override
  Widget build(BuildContext context) {
    if (contactsList == null) {
      contactsList = List<Contacts>();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        leading: Text(''),
        title: Text('Contacts'),
      ),
      body: contactList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          gotoEdit(
            'Add New Contact',
            Contacts('', '', null),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  ListView contactList() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                this.contactsList[position].name.substring(0, 1).toUpperCase(),
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            title: Text(
              this.contactsList[position].name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              this.contactsList[position].number,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            trailing: GestureDetector(
              child: Icon(
                Icons.phone,
                color: Colors.grey,
              ),
              onTap: () {},
            ),
            onTap: () {
              gotoDetails(this.contactsList[position]);
            },
          ),
        );
      },
    );
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseDB.initialiseDatabase();
    dbFuture.then((database) {
      Future<List<Contacts>> contactsListFuture = databaseDB.getContactsList();
      contactsListFuture.then((contactsList) {
        setState(() {
          this.contactsList = contactsList;
          this.count = contactsList.length;
        });
      });
    });
  }

  void gotoDetails(Contacts contacts) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewPage(contacts),
      ),
    );
    if (result == true) {
      updateListView();
    }
  }

  void gotoEdit(String name, Contacts contacts) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEdit(name, contacts),
      ),
    );
    if (result == true) {
      updateListView();
    }
  }
}
