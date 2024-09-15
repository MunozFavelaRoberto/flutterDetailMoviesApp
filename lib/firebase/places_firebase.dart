import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/places_model.dart';

class PlacesFirebase{
  FirebaseFirestore? _firestore; //? si es nulo o no es nulo.
  CollectionReference? _placesCollection; //apunta a la coleccion en firebase.

  PlacesFirebase() {
    _firestore =FirebaseFirestore.instance;
    _placesCollection = _firestore!.collection('places'); //lo transforme a objeto y ya esta la conexion divina con la nube xd. asi se debe llamar la coleccion 'places'.
    
  }

  Future<void> insPlace (PlacesModel objPlace){
    return _placesCollection!.add(objPlace.toMap());
  }

  Future<void> delPlace (String idPlace){
    return _placesCollection!.doc(idPlace).delete();
  }

  Future<void> updPlace (PlacesModel objPlace, String idPlace){
    return _placesCollection!.doc(idPlace).update(objPlace.toMap());
  }


  Stream<QuerySnapshot> getAllPlaces(){ 
    return _placesCollection!.snapshots();
  }
}