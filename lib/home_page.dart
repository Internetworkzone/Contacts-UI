import 'package:flutter/material.dart';
import 'details_page.dart';


class HomePage extends StatefulWidget {
  final int count = 0;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: contactList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          gotoDetails('Add New Contact');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  ListView contactList() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: Text(
              'Dummy Name',
              style: titleStyle,
            ),
            subtitle: Text('Dummy Number'),
            trailing: GestureDetector(
              child: Icon(
                Icons.phone,
                color: Colors.grey,
              ),
              onTap: () {},
            ),
            onTap: () {
              debugPrint("ListTile Tapped");
              gotoDetails('Contact Details');
            },
          ),
        );
      },
    );
  }

  void gotoDetails(String appBarTitle) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Details(appBarTitle)));
  }
}
