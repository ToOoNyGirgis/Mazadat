import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
    }
    return _db;
  }


  Future<Database> initialDb() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'Mazadat.db');
    Database myDb = await openDatabase(path, onCreate: _onCreate ,version:  1 ,onUpgrade: _onUpdate);
    return myDb;
  }

  _onUpdate(Database db , int oldVersion , int newVersion){
    print('onUpgrade ==========================================');
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE "favorite"(
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "cityId" TEXT NOT NULL,
    "categoryId" TEXT NOT NULL
    )
  ''');
    print('Create DATABASE =========================================');
  }

  readData(String sql) async {
    Database? myDb =await db;
    List<Map> response =await myDb!.rawQuery(sql);
    return response;
  }
  insertData(String sql) async {
    Database? myDb =await db;
    int response =await myDb!.rawInsert(sql);
    return response;
  }
  deleteData(String sql) async {
    Database? myDb =await db;
    int response =await myDb!.rawDelete(sql);
    return response;
  }

  updateData(String sql) async {
    Database? myDb =await db;
    int response =await myDb!.rawUpdate(sql);
    return response;
  }
}
