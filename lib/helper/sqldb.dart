import 'package:news_app/common/constant.dart';
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
    "$kCityIdDB" TEXT NOT NULL,
    "$kCityNameDB" TEXT NOT NULL,
    "$kCategoryIdDB" TEXT NOT NULL,
    "$kCategoryNameDB" TEXT NOT NULL
    )
  ''');
    print('Create DATABASE =========================================');
  }

  readData(String sql) async {
    Database? myDb =await db;
    List<Map> response =await myDb!.rawQuery(sql);
    return response;
  }

  Future<List<Map<String, dynamic>>> readDataWithWhere(int categoryId, int? cityId) async {
    Database? myDb = await db;
    print(cityId);
    if (cityId == null) {
      List<Map<String, dynamic>> results = await myDb!.query(
        'favorite',
        where: '$kCategoryIdDB = ? ',
        whereArgs: [categoryId],
      );
    return results;
    }
    else {
      List<Map<String, dynamic>> results = await myDb!.query(
        'favorite',
        where: '$kCategoryIdDB = ? AND $kCityIdDB = ? ',
        whereArgs: [categoryId , cityId],
      );
      return results;
    }
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

  Future<void> deleteTable(String tableName) async {
    Database? myDb = await db;
    await myDb!.execute('DROP TABLE IF EXISTS $tableName');
  }
}
