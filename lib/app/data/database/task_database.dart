import 'package:path/path.dart';
import 'package:simpler/app/data/model/project_model.dart';
import 'package:simpler/app/data/model/task_model.dart';
import 'package:sqflite/sqflite.dart';

class TaskDatabase {
  static final TaskDatabase instance = TaskDatabase._init();
  static Database? _database;
  TaskDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!; //? returning database if it alread exists
    }
    _database = await _initDB('tasks.db');
    return _database!;
  }

  //? initialize our datacase
  Future<Database> _initDB(String filePath) async {
    final dbPath =
        await getDatabasesPath(); //? on android - data/data//databases
    //? to store data in a different location we can use path_provider
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    // final boolType = 'BOOLEAN NOT NULL';
    final numberType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableTask (
  ${TaskFields.id} $idType,
  ${TaskFields.projectId} $numberType,
  ${TaskFields.projectTitle} $textType,
  ${TaskFields.task} $textType,
  ${TaskFields.status} $textType
)
''');
//? to create multiple datatable you can simply copy paste the above db.execute code
//? and change the $tableProjects name to a new one
  }

  Future<Task> create(Task task) async {
    final db = await instance.database;

    // final json = project.toJson();
    // final columns =
    //     '${TaskFields.title}, ${TaskFields.deadline}, ${TaskFields.createdTime}';
    // final values = '${json[TaskFields.title]},${json[TaskFields.deadline]},${json[TaskFields.createdTime]}'
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableTask, task.toJson());
    return task.copy(id: id);
  }

  //? read a single project
  Future<Task> readProject(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableTask,
      columns: TaskFields.values,
      where: '${TaskFields.id} = ?', //? the ? will take the value below, id
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Task.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  //? to read all projects
  Future<List<Task>> readAllProjects(int id) async {
    //? you can add more fields next to tableProjects inside db.query
    final db = await instance.database;
    final orderBy = '${TaskFields.id} DESC';
    //? you can also create your own query statement
    final result = await db.rawQuery(
        'SELECT * FROM $tableProjects WHERE $id=${TaskFields.projectId} ORDER BY $orderBy');
    // final result = await db.query(tableTask, orderBy: orderBy);
    return result.map((json) => Task.fromJson(json)).toList();
  }

  //? to update project
  Future<int> update(Task task) async {
    final db = await instance.database;
    //? like before you can also use your own statement by using rawupdate and pass sql statement inside
    return db.update(tableTask, task.toJson(),
        where: '${TaskFields.id} = ?', whereArgs: [task.id]);
  }

  //? to delete a project
  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db
        .delete(tableTask, where: '${TaskFields.id} = ?', whereArgs: [id]);
  }

  //? to close our database
  Future close() async {
    final db = await instance.database;
    db.close();
    print('db closed');
  }
}
