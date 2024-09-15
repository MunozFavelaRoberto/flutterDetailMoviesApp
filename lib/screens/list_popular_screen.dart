import 'package:flutter/material.dart';
import 'package:practica1/models/popular_model.dart';
import 'package:practica1/network/popular_movies_api.dart';

class ListPopularScreen extends StatefulWidget {
  ListPopularScreen({Key? key}) : super(key: key);

  @override
  State<ListPopularScreen> createState()=> _ListPopularScreenState();
}

class _ListPopularScreenState extends State<ListPopularScreen> {
  PopularMoviesAPI popularAPI = PopularMoviesAPI();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular movies'),
      ),
      body: FutureBuilder(
        future: popularAPI.getAllPopular(),
        builder: (BuildContext context,
        AsyncSnapshot<List<PopularModel>?> snapshot) {
          if(snapshot.hasData)
            return _listViewPopular(snapshot.data); //si trae datos entramos a regresar el _listViewPopular
          else if(snapshot.hasError)
          return Center(child: Text('Ocurrio un error en la petición ${snapshot.error.toString()}'));
          else
          return Center(child: CircularProgressIndicator());
        },
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Peliculas Favoritas'),
              leading: Icon(Icons.favorite,color:Colors.black),
              trailing: Icon(Icons.chevron_right,color:Colors.black),
              onTap: (){
                
                
                
                Navigator.pushNamed(
                  context,'/favorites',
                  /*arguments: {
                    'id': widget.popularModel.id,
                    'title':widget.popularModel.title,
                    'imagen':widget.popularModel.backdropPath,
                    'descripcion': widget.popularModel.overview,
                    'lanzamiento': widget.popularModel.releaseDate
                  }*/
                ).whenComplete(() {
                  setState(() {

                  });
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _listViewPopular(List<PopularModel>? snapshot) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(color: Colors.black,), //separador con una linea.
      padding: EdgeInsets.all(10), //espaciado entre las orillas de la pantalla.
      itemCount: snapshot!.length, //para que no siga infinitamente, hasta que encuentra algo que ya no existe.
      itemBuilder: (context, index) {
        return ClipRRect( //para que aplique el recorte a las imagenes y no solo al contenedor.
        borderRadius: BorderRadius.circular(10), //borde circular a la imagen.
          child: Stack(
            alignment: Alignment.bottomCenter,//pa alinear abajo el stack
            children: [
              FadeInImage(
                fadeInDuration: Duration(milliseconds: 500),
                placeholder: AssetImage('assets/loading_movie.webp'),
                image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500/${snapshot[index].backdropPath!}'),
              ),
              Container(
                color: Colors.black.withOpacity(.6),
                height: 60,
                child: ListTile(
                  onTap: () => Navigator.pushNamed(context, '/detail',
                      arguments: snapshot[index]),
                  title: Text(
                    '${snapshot[index].title}',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Icon(Icons.favorite,color:Colors.black),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              )
            ],
            
          ),
          
        );
      },
      );
  }
}