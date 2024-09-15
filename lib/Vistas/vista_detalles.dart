import 'package:flutter/material.dart';
import 'package:practica1/models/Candidato.dart';

import '../database/database_empleados.dart';

class DetallesEmpleado extends StatelessWidget {
  final Candidato candidato;

  const DetallesEmpleado({Key? key,required this.candidato}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: scaffoldKey,
      backgroundColor: Color(0xFFF1F4F8),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 270,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color.fromARGB(255, 12, 14, 139), Colors.black],
                      stops: [0, 1],
                      begin: AlignmentDirectional(0, -1),
                      end: AlignmentDirectional(0, 1),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 105, 0, 0),
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        '${candidato.picture}',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                            child: Text(
                              '${candidato.title} ${candidato.first} ${candidato.last}',
                                style:TextStyle(color:Colors.white,fontSize: 24)
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: Text(
                              '(${candidato.age})',///correo
                              style:TextStyle(color:Color(0xFFEE8B60),fontSize: 24)
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 12, 0, 12),
                  child: Text(
                    'Informacion',
                      style:TextStyle(fontSize: 24)
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  Text(
                    'ID: ${candidato.id}'
                  ),
                  Text(
                    'Ciudad: ${candidato.city}'
                  ),
                  Text(
                    'Pais: ${candidato.country}'
                  ),
                  Text(
                    'Estado: ${candidato.state}'
                  ),
                  Text(
                    'Nacionalidad: ${candidato.nat}'
                  ),
                  Text(
                    'Fecha Nacimiento: ${candidato.date}'
                  ),
                  Text(
                    'Direccion: ${candidato.street} CP: ${candidato.postcode} No.${candidato.no}'
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () async{
                      Navigator.pop(context);
                    },),
                  IconButton(
                    icon: Icon(
                      Icons.delete_forever,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () async {
                      var confirmDialogResponse =
                          await showDialog<bool>(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: Text('¿Seguro?'),
                                content: Text(
                                    '¿Desea eliminar?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(
                                          alertDialogContext,
                                          false);
                                      eliminarRegistro(false,candidato.id);
                                    },
                                    child: Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(
                                          alertDialogContext,
                                          true);
                                      eliminarRegistro(true,candidato.id);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Si'),
                                  ),
                                ],
                              );
                            },
                          ) ??
                              false;
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  void eliminarRegistro(bool eliminar, int? id)
  {
    DatabaseCantidato dbCandidato=DatabaseCantidato();
    if(eliminar)
    {
      dbCandidato.delete(id!);
    }
  }


}
