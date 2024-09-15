import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/movie_model.dart';


class DatabaseMovies
{
  static const _nombreDB = "P4MMovies";
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


  /*
  * String? backdropPath;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  double? voteAverage;
  int? voteCount;
  *
  *
  * */


  _crearTablas(Database db,int version)async
  {
    await db.execute("Create table tbl_movies(backdropPath text,id integer ,originalLanguage text,originalTitle text,overview text,popularity double ,posterPath text,releaseDate text,title text,voteAverage double,voteCount integer)");
  }



  _updTablas(Database db, int oldVersion, int newVersion) {
  }

  Future <int> insertar(Map<String,dynamic> row) async
  {
    var dbConexion= await database;
    return dbConexion!.insert("tbl_movies", row);

  }

  Future<int> update(Map<String,dynamic> row) async
  {
    var dbConexion = await database;
    return dbConexion!.update("tbl_movies", row,
        where: "id=?",whereArgs: [row['id']]);
  }

  Future<int> delete(int id_Movie) async
  {
    var dbConexion = await database;
    return await dbConexion!
        .delete("tbl_movies",where: "id=?",whereArgs: [id_Movie]);
  }

  Future<bool> ifExistMovie(int? id_movie) async
  {
    int tam;
    var dbConexion = await database;
    bool retorno=false;
    try{
      var result=await dbConexion!.query("tbl_movies");
      var list=result.map((movie)=>MovieModel.fromMap(movie)).toList();
      tam=list.length;
      if(tam==0) {
        return false;
      }
      else
      {
        for (MovieModel movie in list)
          if (movie.id == id_movie)
            retorno = true;
      }
    }
    on Exception catch(sauf)
    {
      print('aqui');
      retorno=false;
    }

    return retorno;
  }

  Future<List<MovieModel>?> getAllMovies() async
  {
    var dbConexion=await database;
    var result=await dbConexion?.query("tbl_movies");
    var list=result?.map((movie)=>MovieModel.fromMap(movie)).toList();
    return list;

  }






}

