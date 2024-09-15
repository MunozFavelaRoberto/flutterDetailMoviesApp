import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:practica1/models/Candidato.dart';
import 'package:practica1/Vistas/vista_detalles.dart';

import '../Database/database_empleados.dart';

class Contratados extends StatefulWidget {
  const Contratados({Key? key}) : super(key: key);

  @override
  State<Contratados> createState() => _ContratadosState();
}

class _ContratadosState extends State<Contratados> {
  late DatabaseCantidato dbCandidato;


  @override
  void initState()
  {
    dbCandidato=DatabaseCantidato();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 43, 8, 169),
        automaticallyImplyLeading: true,
        title: Text(
          'Contratados',
          style: TextStyle(color:Colors.white)
          ),
        centerTitle: true,
      ),

      backgroundColor: Colors.white,
      body:
      FutureBuilder<List<Candidato>?>(
          future: dbCandidato.getAllCandidatos(),
          builder: (BuildContext context,AsyncSnapshot<List<Candidato>?>snapshot)
          {
            if(snapshot.hasError)
            {
              return Center(child: Text('Ocurrio un error'),);
            }
            else
            {
              if(snapshot.hasData)
              {
                return _listCandidatos(snapshot.data!);
              }
              else
              {
                return Center(child: CircularProgressIndicator(),);
              }
            }
          }
      )
    );
  }

  Widget _listCandidatos(List<Candidato>? candidatos) {
    return Padding(padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
          itemBuilder: (context, index) {
            Candidato candidato = candidatos![index];
            return tarjeta(candidato);//View(movieModel: movie);//Text(popular.title!);
          },
          separatorBuilder: (_, __) => Divider(
            height: 10,
          ),
          itemCount: candidatos!.length),
    );
  }


  Widget tarjeta(Candidato candidato)
  {
    bool eliminar=false;


    return Slidable(
      key: const ValueKey(0),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {
          eliminarRegistro(true,candidato.id);

        }),
        children: const [
          SlidableAction(
            onPressed: null,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child:
      Card(
        child: ListTile(
          leading: Container(
            width: 90,
            height: 90,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child:
            Image.network('${candidato.picture}',),
          ),
          title: Text('${candidato.id} - ${candidato.title} ${candidato.first} ${candidato.last} (${candidato.age})'),
          subtitle: Text('${candidato.country} - ${candidato.city}'),
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetallesEmpleado( candidato: candidato)
              ),
            ).whenComplete(() => setState((){}));
          },
        ),
      )
    );
  }

  void eliminarRegistro(bool eliminar, int? id)
  {
    if(eliminar)
    {
       dbCandidato.delete(id!);
       setState(() {});
    }
  }
  
  

}
