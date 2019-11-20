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
              child: TextField(
                keyboardType: TextInputType.text,
                controller: nameController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Something changed in Title Text Field');
                  updateName();
                },
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
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
                          debugPrint("Save button clicked");
                          _save();
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
    gotoHome();

    int result;
    if (contacts.id != null) {
      result = await dataDb.updateContact(contacts);
    } else {
      result = await dataDb.insertContact(contacts);
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
