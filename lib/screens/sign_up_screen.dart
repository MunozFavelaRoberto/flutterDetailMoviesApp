import 'package:flutter/material.dart';
import 'package:practica1/firebase/email_authentication.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({ Key? key }) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtNick = TextEditingController();
  TextEditingController txtMail = TextEditingController();
  TextEditingController txtPwd = TextEditingController();
  EmailAuthentication? _emailAuth;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailAuth = EmailAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de usuarios'),
      ),
      body: Container(
        color: Colors.green,
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Container(
            padding: EdgeInsets.all(35),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 63, 208, 228),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        
                        },
                      child: Icon(Icons.close),
                    ),
                    GestureDetector(
                      onTap: (){
                        _emailAuth!
                        .createUserWhithEmailAndPassword(
                              email: txtMail.text, password: txtPwd.text)
                            .then((value) {
                          print(value);
                          }); //valida que la contraseña tenga mas de 6 caracteres, metele 8 como el profe alv xd.
                        //Navigator.pop(context);
                      },
                    child: Text(
                      'Guardar Perfil',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Swiss',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      
                      ),
                    ),
                    ),
                  ],
                ),
                TextFormField(
                  controller: txtName,
                  decoration: InputDecoration(
                    hintText: 'Nombre',                    
                  ),
                ),
                TextFormField(
                  controller: txtMail,
                  decoration: InputDecoration(
                    hintText: 'Correo',                    
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  controller: txtPwd,
                  decoration: InputDecoration(
                    hintText: 'Contraseña',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}