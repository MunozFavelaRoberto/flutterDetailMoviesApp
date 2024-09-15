import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practica1/firebase/email_authentication.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:practica1/provider/theme_provider.dart';
import 'package:practica1/screens/theme_screen.dart';
import 'package:practica1/settings/styles_settings.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController txtConUser = TextEditingController();
  TextEditingController txtConPwd = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final EmailAuthentication _emailAuth = EmailAuthentication();
  bool? _checkBox = false;

  Future<void> sesionActive() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('bandera', true);
    Navigator.pushNamed(context, '/onboarding');
    txtConUser.clear();
    txtConPwd.clear();
    _checkBox = false;
  }

  bool? bandera;
  late SharedPreferences _prefs;
  late String t;

  Future<void> sesionCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bandera = await prefs.getBool('bandera');

    print('El valor de la bandera es $bandera');
    if (bandera == true) {
      Navigator.pushNamed(context, '/onboarding');
    }
  }

  definirTema() async {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);
    _prefs = await SharedPreferences.getInstance();
    t = (_prefs.getString('theme') ?? 'dia');

    if (t == 'dia') {
      tema.setthemeData(temaDia());
    } else if (t == 'noche') {
      tema.setthemeData(temaNoche());
    } else if (t == 'calido') {
      tema.setthemeData(temaCalido());
    }
  }

//con lo de la sesion del profe con firebase hasta aqui podrias comentar para arriba.
  @override
  Widget build(BuildContext context) {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);
    definirTema();
    final txtUser = TextField(
      decoration: InputDecoration(
          hintText: 'Introduce el usuario', label: Text('Correo Electronico')),
      //onChanged: (value) {} recuprra la info de las cajas de texto, regresa string asi que se puede hacer una conversion si quiero otro tipo de dato.
    );

    final txtPwd = TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Introduce el password',
        label: Text('Contraseña'),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset:
          false, //para que no se mueva nada de su lugar al desplegar el teclado del telefono.

      body: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
          height: MediaQuery.of(context)
              .size
              .height, //double.infinity, para ajustar el tamaño de la pantalla.
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/palta.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: MediaQuery.of(context).size.width / 200,
                right: MediaQuery.of(context).size.width / 3.3,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 30),
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Column(
                    children: [
                                  TextButton.icon(
                        onPressed: () async {
                          SharedPreferences _prefs = await SharedPreferences.getInstance();
                          _prefs.setString('theme', 'dia');
                          tema.setthemeData(temaDia());
                        },
                        icon: Icon(Icons.brightness_1),
                        label: Text('Tema de Día'),
                      ),
                      TextButton.icon(
                        onPressed: () async{
                          SharedPreferences _prefs = await SharedPreferences.getInstance();
                          _prefs.setString('theme', 'noche');
                          tema.setthemeData(temaNoche());
                        },
                        icon: Icon(Icons.dark_mode),
                        label: Text('Tema de Noche'),
                      ),
                      TextButton.icon(
                        onPressed: () async {
                          SharedPreferences _prefs = await SharedPreferences.getInstance();
                          _prefs.setString('theme', 'calido');
                          tema.setthemeData(temaCalido());
                        },
                        icon: Icon(Icons.hot_tub_sharp),
                        label: Text('Tema Calido'),
                      ),
                    ],
                  ),
                )),
              Positioned(
                top: MediaQuery.of(context).size.width / 9,
                left: MediaQuery.of(context).size.width / 2.5,
                child: Image.asset(
                  'assets/aguacate.png',
                  width: MediaQuery.of(context).size.width / 3,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 20,
                  right: MediaQuery.of(context).size.width / 20,
                  bottom: MediaQuery.of(context).size.width / 20,
                ),
                color: Color.fromARGB(255, 63, 208, 228),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    txtUser,
                    SizedBox(
                      height: 15,
                    ),
                    txtPwd,
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: _checkBox,
                            onChanged: (value) {
                              setState(() {
                                _checkBox = value;
                              });
                            }),
                        Text('Mantener inicio de sesión.'),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.width / 22,
                right: MediaQuery.of(context).size.width / 20,
                child: GestureDetector(
                  onTap: () async {
                  var ban = await _emailAuth.signInWithEmailAndPassword(
                      email: txtConUser.text, password: txtConPwd.text);
                  if (ban == true) {
                    if (_auth.currentUser!.emailVerified)
                      Navigator.pushNamed(context, '/onboarding');
                    else
                      print('Usuario no validado');
                  } else {
                    print('Credenciales invalidas');
                  }

                    if ((_checkBox == true)) {
                      sesionActive();
                    } else {
                      Navigator.pushNamed(
                        context,
                        '/onboarding',
                      );
                    } //hasta aqui terminaria la parte de la validacion de usuarios del profesor.
                  },
                  child: Image.asset('assets/pan.png',
                      height: MediaQuery.of(context).size.width / 10),
                ),
              ),
              
              Positioned(
                bottom: MediaQuery.of(context).size.width / 50,
                right: MediaQuery.of(context).size.width / 7,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 30),
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Column(
                    //shrinkWrap: true,
                    children: [
                      SocialLoginButton(
                        buttonType: SocialLoginButtonType.facebook,
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SocialLoginButton(
                        buttonType: SocialLoginButtonType.github,
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SocialLoginButton(
                        buttonType: SocialLoginButtonType.google,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(                
                top: MediaQuery.of(context).size.width / 2.4,
                right: MediaQuery.of(context).size.width / 1.6,
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/signup'),
                  child: Text('Sign Up', style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }
}