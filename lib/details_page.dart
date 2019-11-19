import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  Details(this.appBarTitle);

  final String appBarTitle;

  @override
  _DetailsState createState() => _DetailsState(this.appBarTitle);
}

class _DetailsState extends State<Details> {
  _DetailsState(this.appBarTitle);
  final String appBarTitle ;

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

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
                },
                decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: numberController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Something changed in Description Text Field');
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
                          gotoHome();
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
  }

  void gotoHome() {
    Navigator.pop(context);
  }
}
