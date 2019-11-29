import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'contactsInput.dart';

class DatabaseDB {
  static DatabaseDB _databaseDB;
  static Database _database;
  DatabaseDB._name();
  String dataTable = 'contactstable';
  String dataId = 'id';
  String dataName = 'name';
  String dataNumber = 'number';
  int position;

  factory DatabaseDB() {
    if (_databaseDB == null) {
      _databaseDB = DatabaseDB._name();
    }
    return _databaseDB;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initialiseDatabase();
    }
    return _database;
  }

  Future<Database> initialiseDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'contacts.db';

    var contactsDB = openDatabase(path, version: 1, onCreate: _createDB);
    return contactsDB;
  }

  void _createDB(Database dataB, int newVersion) async {
    await dataB.execute(
        'CREATE TABLE $dataTable($dataId INTEGER PRIMARY KEY AUTOINCREMENT, $dataName TEXT, '
        '$dataNumber TEXT)');
  }

  Future<List<Map<String, dynamic>>> getContactsMapList() async {
    Database db = await this.database;
    var result = await db.query(dataTable, orderBy: '$dataName ASC');
    return result;
  }

  Future<int> insertContact(Contacts contacts) async {
    Database db = await this.database;
    var result = await db.insert(dataTable, contacts.toMap());
    return result;
  }

  Future<int> updateContact(Contacts contacts) async {
    var db = await this.database;
    var result = await db.update(dataTable, contacts.toMap(),
        where: '$dataId = ?', whereArgs: [contacts.id]);
    return result;
  }

  Future<int> deleteContact(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $dataTable WHERE $dataId = $id');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $dataTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Contacts>> getContactsList() async {
    var contactsMapList = await getContactsMapList();
    int count = contactsMapList.length;

    List<Contacts> contactsList = List<Contacts>();
    for (int i = 0; i < count; i++) {
      contactsList.add(Contacts.map(contactsMapList[i]));
    }

    return contactsList;
  }
}
