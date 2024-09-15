import 'package:practica1/models/Candidato.dart';
import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseCantidato
{
  static const _nombreDB = "P5Candidatos";
  static const _versionBD =1;

  static Database?  _database;
  Future<Database?> get database async {
    if (_database != null) return _database;

    _database=await _initDatabase();
    return _database;
  }

  _initDatabase() async
  {
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaDB=join(carpeta.path,_nombreDB);
    return await openDatabase(
        rutaDB,
        version:_versionBD,
        onCreate:_crearTablas//,
      //onUpgrade: _updTablas
    );
  }

  _crearTablas(Database db,int version)async
  {
    await db.execute("Create table tbl_candidato(id integer primary key,"
                                                "gender text,"
                                                "title text,"
                                                "first text,"
                                                "last text,"
                                                "no integer ,"
                                                "street text,"
                                                "city text,"
                                                "state text,"
                                                "country text ,"
                                                "postcode text,"
                                                "date text,"
                                                "age int,"
                                                "phone text,"
                                                "picture text,"
                                                "nat text)");
  }

  _updTablas(Database db, int oldVersion, int newVersion) {
  }

  Future <int> insertar(Map<String,dynamic> row) async
  {
    var dbConexion= await database;
    return dbConexion!.insert("tbl_candidato", row);

  }

  Future<int> update(Map<String,dynamic> row) async
  {
    var dbConexion = await database;
    return dbConexion!.update("tbl_candidato", row,
        where: "id=?",whereArgs: [row['id']]);
  }

  Future<int> delete(int id) async
  {
    var dbConexion = await database;
    return await dbConexion!
        .delete("tbl_candidato",where: "id=?",whereArgs: [id]);
  }

  Future<List<Candidato>?> getAllCandidatos() async
  {
    var dbConexion=await database;
    var result=await dbConexion?.query("tbl_candidato");
    var list=result?.map((candidato)=>Candidato.fromMap(candidato)).toList();
    return list;

  }

}

