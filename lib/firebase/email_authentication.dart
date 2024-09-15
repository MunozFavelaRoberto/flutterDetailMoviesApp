import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class EmailAuthentication{

  final FirebaseAuth _auth = FirebaseAuth.instance; //autentificacion hacia firebase. .instance para saber wue tipo de provedor estamos usando.

  Future<bool> createUserWhithEmailAndPassword(
    {required String email, required String password}) async{ //required es para que sean forzosamente enviados los parametros.

    try{
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

        User user = userCredential.user!; //creacion de un usuario.
        user.sendEmailVerification(); //le llega un correo para verificar y que el email es valido.

      return true;
    } catch(e){
      return false;
    }
  }

  //metodo para la autentificacion.
  Future<bool> signInWithEmailAndPassword(
    {required String email, required String password}) async{    
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch(e){
      return false;
    }
  }
}