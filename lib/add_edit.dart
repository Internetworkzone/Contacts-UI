import 'package:flutter/material.dart';
import 'database.dart';
import 'contactsInput.dart';
import 'home_page.dart';

class AddEdit extends StatefulWidget {
  AddEdit(this.appBarTitle, this.contacts);

  String appBarTitle;
  Contacts contacts;

  @override
  _AddEditState createState() => _AddEditState(this.appBarTitle, this.contacts);
}

class _AddEditState extends State<AddEdit> {
  DatabaseDB dataDb = DatabaseDB();
  _AddEditState(this.appBarTitle, this.contacts);

  String appBarTitle;
  Contacts contacts;
  List<Contacts> contactsList;
  int listPosition;

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    nameController.text = contacts.name;
    numberController.text = contacts.number;

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: nameController,
                style: textStyle,
                onChanged: (value) {
                  updateName();
                },
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: textStyle,
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(5.0),
                  // ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 10,
                controller: numberController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Something changed in Description Text Field');
                  updateNumber();
                },
                decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      padding: EdgeInsets.all(15),
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Save',
                        textScaleFactor: 2,
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          _save();
                          print(contacts.id);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateName() {
    contacts.name = nameController.text;
  }

  void updateNumber() {
    contacts.number = numberController.text;
  }

  void _save() async {
    int result;

    if (contacts.name.isNotEmpty &&
            contacts.number.isNotEmpty &&
            contacts.number.length == 10 &&
            contacts.number.substring(0, 1) == '9' ||
        contacts.number.substring(0, 1) == '8' ||
        contacts.number.substring(0, 1) == '7' ||
        contacts.number.substring(0, 1) == '6') {
      if (contacts.id != null) {
        result = await dataDb.updateContact(contacts);
      } else {
        result = await dataDb.insertContact(contacts);
      }
      gotoHome();
    } else {
      AlertDialog alertDialog = AlertDialog(
        title: Text('Enter Valid Input'),
        content: Text('Enter the name and 10 digit Indian Mobile Number'),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
      showDialog(
        context: context,
        builder: (_) => alertDialog,
      );
      result = null;
    }
  }

  void gotoHome() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }
}
