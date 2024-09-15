import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica1/screens/databaseuser_helper.dart';

class NewUser extends StatefulWidget {
  const NewUser({Key? key}) : super(key: key);

  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  TextEditingController txtconNombre = TextEditingController();
  TextEditingController txtconCorreo = TextEditingController();
  TextEditingController txtconTelefono = TextEditingController();
  TextEditingController txtconpagina = TextEditingController();
  DatabaseHelper? _database;
  bool ban = false;

  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Error al escoger imagen:  $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _database = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    final txtNombre = TextField(
      controller: txtconNombre,
      decoration: InputDecoration(
        hintText: 'Introduce nombre completo ',
        label: Text('Nombre'),
      ),
    );
    final txtcorreo = TextField(
      controller: txtconCorreo,
      decoration:
          InputDecoration(hintText: 'Introduce el correo ', label: Text('Correo')),
    );

    final txtTelefono = TextField(
      controller: txtconTelefono,
      decoration: InputDecoration(
          hintText: 'Introduce el teléfono', label: Text('Teléfono')),
    );

    final txtpagina = TextField(
      controller: txtconpagina,
      decoration: InputDecoration(
          hintText: 'Introdue URL Github ', label: Text('GitHub')),
    );

    final btnGuardar = ElevatedButton(
      onPressed: () {
        _database!.insertar({
          'imagen': image.toString(),
          'nombre': txtconNombre.text,
          'correo': txtconCorreo.text,
          'numero': txtconTelefono.text,
          'urlGit': txtconpagina.text
        }, 'tblUser').then((value) {
          final snackBar =
              SnackBar(content: Text('Usuario registrado correctamente'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });

        Navigator.pop(context);
      },
      child: Text('Guardar'),
    );

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(children: <Widget>[
          Hero(
            tag: 'logoHero',
            child: Container(
              child: Padding(
                child: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/2503/2503796.png'),
                padding:
                    EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 20,
              right: MediaQuery.of(context).size.width / 20,
              bottom: MediaQuery.of(context).size.width / 20,
            ),
            color: Color.fromARGB(255, 60, 200, 255),
            child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                txtNombre,
                SizedBox(
                  height: 15,
                ),
                txtcorreo,
                SizedBox(
                  height: 15,
                ),
                txtTelefono,
                SizedBox(
                  height: 15,
                ),
                txtpagina,
                SizedBox(
                  height: 15,
                ),
                MaterialButton(
                  color: Colors.blue,
                  child: Text('Elegir imagen de la galeria',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold)),
                  onPressed: () {
                    pickImage();
                  },
                ),
                btnGuardar
              ],
            ),
          ),
        ]));
  }
}
