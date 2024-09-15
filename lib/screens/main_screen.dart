import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

Future<void> sesionCheck(context) async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  bool? bandera = await prefs.getBool('bandera');
  print('El valor de la bandera es $bandera');

  if(bandera == true){
    Navigator.pushNamed(context, '/dash');
  }
  else{
    Navigator.pushNamed(context, '/login');
  }
}

  @override
  Widget build(BuildContext context) {
    sesionCheck(context);
    return Container();
  }
}


