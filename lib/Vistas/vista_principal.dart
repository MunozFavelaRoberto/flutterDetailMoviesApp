import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:practica1/database/database_empleados.dart';
import 'package:practica1/Vistas/vista_contratados.dart';

import '../Models/Candidato.dart';


class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {

  late Map<String,dynamic> posts={};
  Map <String,dynamic>? get data=>null;
  int index = 0;
  late DatabaseCantidato dbContrato;

  @override
  void initState()
  {
    dbContrato=DatabaseCantidato();
    getDataApi();
  }

  Future <List<Map<String,dynamic>>?> getDataApi() async{
      http.Response response= await http.get(Uri.parse('https://randomuser.me/api/'));
      if(response.statusCode != 200) return null;
      Map<String, dynamic> data = Map<String, dynamic>.from(json.decode(response.body));

      setState(() {
        posts = data;
      });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color.fromARGB(255, 12, 14, 139), Colors.black],
                    stops: [0, 1],
                    begin: AlignmentDirectional(0, -1),
                    end: AlignmentDirectional(0, 1),
                  ),
                ),
                child: Align(
                  alignment: AlignmentDirectional(0, 0),
                  child:
                  posts.isEmpty || posts==null?
                  Center(child: CircularProgressIndicator())
                  : index==0?

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                            child: Container(
                              width: 120,
                              height: 120,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                '${posts['results'][0]['picture']['large']}',
                              ),
                            ),
                          ),
                          Text(
                            '${posts['results'][0]['name']['first']}  ${posts['results'][0]['name']['last']}',
                            style:TextStyle(color:Colors.white),
                          ),
                          Text(
                            'Nacionalidad : ${posts['results'][0]['nat']}  ',
                            style:TextStyle(color:Colors.white),
                          ),
                          Text(
                            'Genero: ${posts['results'][0]['gender']}',
                            style:TextStyle(color:Colors.white),
                          ),
                          Text(
                            'E-mail : ${posts['results'][0]['email']}',
                            style:TextStyle(color:Colors.white),
                          ),
                          Text(
                            'Age : ${posts['results'][0]['dob']['age']}',
                            style:TextStyle(color:Colors.white),
                          ),
                          Text(
                            'Telefono: ${posts['results'][0]['phone']}',
                            style:TextStyle(color:Colors.white),
                          ),
                          Text(
                            'Dob : ${posts['results'][0]['dob']['date']}',
                            style:TextStyle(color:Colors.white),
                          ),
                          Text(
                            'Direccion',
                            style:TextStyle(color:Colors.white),
                          ),
                          Text(
                            'Calle : No.${posts['results'][0]['location']['street']['number']} ${posts['results'][0]['location']['street']['name']}\nCiudad : ${posts['results'][0]['location']['city']}\nEstado - Pais : ${posts['results'][0]['location']['state']} - ${posts['results'][0]['location']['country']} \nCP : ${posts['results'][0]['location']['postcode']}',
                            style:TextStyle(color:Colors.white),
                          ),

                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(
                                      Icons.navigate_next,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                    onPressed: () {
                                      if (posts.isEmpty) Center(child: CircularProgressIndicator());
                                      getDataApi().whenComplete(() {
                                        setState(() {
                                          posts = data!;
                                        });
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(
                                      Icons.add_circle,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                    onPressed: () async {
                                      Candidato objCandiato = Candidato(
                                        gender: posts['results'][0]['gender'],
                                        title: posts['results'][0]['name']['title'],
                                        first: posts['results'][0]['name']['first'],
                                        last: posts['results'][0]['name']['last'],
                                        no:posts['results'][0]['location']['street']['number'],
                                        street: posts['results'][0]['location']['street']['name'],
                                        city:posts['results'][0]['location']['city'],
                                        state: posts['results'][0]['location']['state'],
                                        country: posts['results'][0]['location']['country'],
                                        postcode: '${posts['results'][0]['location']['postcode']}',
                                        date: posts['results'][0]['dob']['date'],
                                        age: posts['results'][0]['dob']['age'],
                                        phone: posts['results'][0]['phone'],
                                        picture: posts['results'][0]['picture']['large'],
                                        nat: posts['results'][0]['nat'] ,
                                      );
                                      dbContrato.insertar(objCandiato.toMap()).then((value) async {

                                        if(value>0)
                                        {
                                          await showDialog(
                                            context: context,
                                            builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title: Text('Agregado'),
                                              content:
                                              Text('Agregado exitosamente'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Navigator.pop(
                                                      alertDialogContext),
                                                    child: Text('Ok'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                          if (posts.isEmpty) Center(child: CircularProgressIndicator());
                                          getDataApi().whenComplete(() {
                                            setState(() {
                                              posts = data!;
                                            });
                                          });
                                        }
                                        else
                                        {
                                          await showDialog(
                                            context: context,
                                            builder: (alertDialogContext) {
                                              return AlertDialog(
                                                title: Text('Agregado'),
                                                content:
                                                Text('Error en la insercion'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(
                                                        alertDialogContext),
                                                    child: Text('Ok'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }

                                      });

                                    },
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(
                                      Icons.list_alt_sharp,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                    onPressed: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Contratados(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  )
                  :Text('Holi')
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
