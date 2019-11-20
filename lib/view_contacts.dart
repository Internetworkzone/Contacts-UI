import 'package:flutter/material.dart';
import 'database.dart';
import 'contactsInput.dart';
import 'add_edit.dart';
import 'package:sqflite/sqflite.dart';

class ViewPage extends StatefulWidget {
  ViewPage(this.contacts);
  final Contacts contacts;

  @override
  _ViewPageState createState() => _ViewPageState(this.contacts);
}

class _ViewPageState extends State<ViewPage> {
  int count = 0;
  DatabaseDB databaseDB = DatabaseDB();
  List<Contacts> contactsList;
  _ViewPageState(this.contacts);
  Contacts contacts;

  DatabaseDB dataDb = DatabaseDB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          GestureDetector(
            child: Row(
              children: <Widget>[
                Text(
                  'Edit',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 20,
                )
              ],
            ),
            onTap: () {
              gotoEdit('Edit Contact',
                  Contacts(this.contacts.name, this.contacts.number));
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: Colors.blueGrey),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.40,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    SizedBox(height: 20),
                    Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 160,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            contacts.name,
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Card(
                      child: ListTile(
                        title: Text(
                          contacts.number,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        leading: IconButton(
                          icon: Icon(Icons.phone, color: Colors.indigo),
                          onPressed: () {},
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.message),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _delete();
        },
        child: Icon(Icons.delete),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _delete() async {
    gotoHome();

    if (contacts.id == null) {
      return;
    }

    int result = await dataDb.deleteContact(contacts.id);
  }

  void gotoHome() {
    Navigator.pop(context, true);
  }

  void gotoEdit(String name, Contacts contacts) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEdit(name, contacts),
      ),
    );
    if (result == true) {
      // updateListView();
    }
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
}
