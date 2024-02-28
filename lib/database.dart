import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import './model.dart';

class appDatabase{
  static Database? _database;

  Future<Database> initializedb() async {
    if(_database == null) _database = await createdb();
    return _database!;
  }

  Future <Database> createdb() async{
    final path = await getDatabasesPath();

    var database = await openDatabase(
      join(path, 'topicDB.db'),
      version: 1,
      onCreate: ((db, version) async {
        await db.execute(
          '''CREATE TABLE topic(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
        title TEXT, 
        conversation TEXT)''',
        );
      }
      ),
    );
    return database;
  }

  Future<List<TopicModel>> getAllData() async {
    var db = await initializedb();
    List<Map<String, dynamic >> result = await db.query('topic');
    return List.generate(
      result.length,
      (index) => TopicModel(
        id: result[index]['id'],
        title: result[index]['title'],
        conversation: result[index]['conversation'],
      ),
    );
  }

  Future updataData(TopicModel model) async {
    var db = await initializedb();
    // print('++++ ${model.id}');
    var result = await db.update(
      'topic',
      model.toMap(),
      where: 'id=?',
      whereArgs: [model.id],
    );
    return result;
  }

  Future deleteData(TopicModel model) async {
    var db = await initializedb();
    // print('++++ ${model.id}');
    var result = db.delete(
      'topic',
      where: 'id=?',
      whereArgs: [model.id],
    );
    return result;
  }
}