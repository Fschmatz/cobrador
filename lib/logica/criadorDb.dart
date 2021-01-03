import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class criadorDB {

  static final _databaseName = "CobradorDB.db";
  static final _databaseVersion = 1;

  criadorDB._privateConstructor(); //_privateConstructor
  static final criadorDB instance = criadorDB._privateConstructor();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  // abre o banco de dados e o cria se ele não existir
  initDatabase() async { //_initDatabase();
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // Código SQL para criar o banco de dados e a tabela
  Future _onCreate(Database db, int version) async {
    print("OI DO CRIADOR DE DB");

    await db.execute('''
           CREATE TABLE dividas (
          
            _id INTEGER PRIMARY KEY,
            nomePessoa TEXT NOT NULL, 
            valor REAL NOT NULL,
            data TEXT NOT NULL,
            nota TEXT   
                      
          )
          ''');


    await db.execute('''
          CREATE TABLE emprestimos (
          
            _id INTEGER PRIMARY KEY,
            nomePessoa TEXT NOT NULL, 
            valor REAL NOT NULL,
            data TEXT NOT NULL,
            nota TEXT                  
                 
          )
          ''');

  }

}