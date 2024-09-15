import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practica1/models/popular_model.dart';

class  PopularMoviesAPI{

  final URL = 'https://api.themoviedb.org/3/movie/popular?api_key=89a512f0796fc32fa6a16f7f52ff8e24&language=es-MX&page=1';

  Future<List<PopularModel>?> getAllPopular() async{
    final response = await http.get(Uri.parse(URL)); //poner el await si no el statusCode del if marca error.
    if(response.statusCode == 200){
      var popular = jsonDecode(response.body)['results'] as List; //haciendo una conversion a formato JSON de la cadena results.
      List<PopularModel> listPopular = popular.map(
        (movie) => PopularModel.fromJSON(movie)
        ).toList();//convertir a lista el JSON.
        return listPopular;
    }else{
      return null;
    }
  }
}