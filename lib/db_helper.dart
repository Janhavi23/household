import 'package:household_app/vendor_details.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

class DBhelper{
  static Database _db;
  static const String ID = 'id';
  static const String Name = 'vname';
  static const String TABLE = 'Vendordata';
  static const String DB_name = 'Vendordb';


Future<Database> get db async{
  if(_db != null)
  {
    return _db;
  }
  _db = await dbInit();
  return _db;
}
dbInit()async{
  io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentsDirectory.path,DB_name);
  var db = openDatabase(path,version: 1,onCreate: _onCreate);
  return db;
}
_onCreate(Database db,int version)
{
  db.execute('CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY,$Name TEXT)');
}
Future<Vendor> save(Vendor v) async{
  var dbClient = await db;
  v.id = await dbClient.insert(TABLE,v.toMap());
  return v;
}

Future<List<Vendor>> getVendor() async{
  var dbClient = await db;
  List<Map> maps = await dbClient.query(TABLE, columns:[ID,Name]);
  List<Vendor> vdata =[];
  if(maps.length >0)
  {
    for(int i=0;i<maps.length;i++)
    {
      vdata.add(Vendor.fromMap(maps[i]));
    }
  }
  return vdata;
}

Future<int> update(Vendor vendor) async
{
  var dbClient = await db;
  return await dbClient.update(TABLE, vendor.toMap(),
  where: '$ID = ?', whereArgs: [vendor.id]);

}

Future close()async{
  var dbClient = await db;
  dbClient.close();
}
}