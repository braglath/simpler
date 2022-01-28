import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:simpler/app/data/model/project_model.dart';

class ProjectDatabase {
  static final ProjectDatabase instance = ProjectDatabase._init();
  static Database? _database;
  ProjectDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!; //? returning database if it alread exists
    }
    _database = await _initDB('projects.db');
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
    final boolType = 'BOOLEAN NOT NULL';
    // final numberType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableProjects (
  ${ProjectFields.id} $idType,
  ${ProjectFields.isCompleted} $boolType,
  ${ProjectFields.title} $textType,
  ${ProjectFields.avatar} $textType,
  ${ProjectFields.deadline} $textType,
  ${ProjectFields.createdTime} $textType,
  ${ProjectFields.completedTime} $textType
)
''');
//? to create multiple datatable you can simply copy paste the above db.execute code
//? and change the $tableProjects name to a new one
  }

  Future<Project> create(Project project) async {
    final db = await instance.database;

    // final json = project.toJson();
    // final columns =
    //     '${ProjectFields.title}, ${ProjectFields.deadline}, ${ProjectFields.createdTime}';
    // final values = '${json[ProjectFields.title]},${json[ProjectFields.deadline]},${json[ProjectFields.createdTime]}'
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableProjects, project.toJson());
    return project.copy(id: id);
  }

  //? read a single project
  Future<Project> readProject(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableProjects,
      columns: ProjectFields.values,
      where: '${ProjectFields.id} = ?', //? the ? will take the value below, id
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Project.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  //? to read projects limit by 5
  Future<List<Project>> readAllProjects() async {
    //? you can add more fields next to tableProjects inside db.query
    final db = await instance.database;
    final orderBy = '${ProjectFields.createdTime} DESC';
    //? you can also create your own query statement
    // final result = await db.rawQuery('SELECT * FROM $tableProjects ORDER BY $orderBy');
    final result = await db.query(tableProjects, orderBy: orderBy, limit: 5);
    return result.map((json) => Project.fromJson(json)).toList();
  }

  //? to fetch all projects
  Future<List<Project>> fetchAllProjects() async {
    //? you can add more fields next to tableProjects inside db.query
    final db = await instance.database;
    final orderBy = '${ProjectFields.createdTime} DESC';
    //? you can also create your own query statement
    // final result = await db.rawQuery('SELECT * FROM $tableProjects ORDER BY $orderBy');
    final result = await db.query(tableProjects, orderBy: orderBy);
    return result.map((json) => Project.fromJson(json)).toList();
  }

  //? to read all projects
  Future<List<Project>> readCompletedProjects() async {
    //? you can add more fields next to tableProjects inside db.query
    final db = await instance.database;
    final orderBy = '${ProjectFields.createdTime} DESC';
    //? you can also create your own query statement
    // final result = await db.rawQuery('SELECT * FROM $tableProjects ORDER BY $orderBy');
    final result = await db.query(tableProjects,
        where: '${ProjectFields.isCompleted} = ?',
        whereArgs: [0],
        orderBy: orderBy);
    return result.map((json) => Project.fromJson(json)).toList();
  }

  //? to read all projects
  Future<List<Project>> readPendingProjects() async {
    //? you can add more fields next to tableProjects inside db.query
    final db = await instance.database;
    final orderBy = '${ProjectFields.createdTime} DESC';
    //? you can also create your own query statement
    // final result = await db.rawQuery('SELECT * FROM $tableProjects ORDER BY $orderBy');
    final result = await db.query(tableProjects,
        where: '${ProjectFields.isCompleted} = ?',
        whereArgs: [1],
        orderBy: orderBy);
    return result.map((json) => Project.fromJson(json)).toList();
  }

  //? to set completed project time
  Future<int> updateProjectCompleted(
      int id, DateTime projectCompletedTime) async {
    final db = await instance.database;
    return db.rawUpdate(
        'UPDATE ${ProjectFields.id} SET (${ProjectFields.completedTime}) value ($projectCompletedTime) WHERE ${ProjectFields.id} = $id');
  }

  //? to update project
  Future<int> update(Project project) async {
    final db = await instance.database;
    print('project - $project');
    //? like before you can also use your own statement by using rawupdate and pass sql statement inside
    return db.update(tableProjects, project.toJson(),
        where: '${ProjectFields.id} = ?', whereArgs: [project.id]);
  }

  //? to delete a project
  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(tableProjects,
        where: '${ProjectFields.id} = ?', whereArgs: [id]);
  }

  //? to close our database
  Future close() async {
    final db = await instance.database;
    db.close();
    print('db closed');
  }

  Future deleteDataBase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'projects.db');
    return await deleteDatabase(path);
  }

  Future<bool> projectDatabaseExists() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'projects.db');
    return databaseFactory.databaseExists(path);
  }
}
