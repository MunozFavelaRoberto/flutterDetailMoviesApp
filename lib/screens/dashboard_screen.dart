import 'package:flutter/material.dart';
import 'package:practica1/screens/theme_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 179, 111, 23),
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                  'https://static.wixstatic.com/media/549f63_baad2b5efa4d46d9a4b62a2f49041d42~mv2.png/v1/fill/w_640,h_470,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/549f63_baad2b5efa4d46d9a4b62a2f49041d42~mv2.png'),
                fit: BoxFit.cover), //para estirar la imagen
              ),
              currentAccountPicture: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/addUser');
                },
                child: Hero(
                  tag: 'logoH',
                  child: CircleAvatar(
                    backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/2503/2503796.png'),
                  ),
                ),
              ),
            accountName: Text(
              'Roberto',
              style: TextStyle(color: Colors.black, fontSize: 18), 
              ),
            accountEmail: Text(
              '18030061@itcelaya.edu.mx',
              style: TextStyle(color: Colors.black), 
              ), 
            ),
            ListTile(
              leading: Image.asset('assets/aguacaemamadisimo.png'),
              trailing: Icon(Icons.chevron_right), //simbolo de > al lado de cerrar sesion.
              title: Text('Práctica 1'),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
            ListTile(
              leading: Image.asset('assets/aguacaemamadisimo.png'),
              trailing: Icon(Icons.chevron_right), //simbolo de > al lado de cerrar sesion.
              title: Text('Base de datos'),
              onTap: () {
                Navigator.pushNamed(context, '/task');
              },
            ),
            ListTile(
              leading: Image.asset('assets/aguacaemamadisimo.png'),
              trailing: Icon(Icons.chevron_right), //simbolo de > al lado de cerrar sesion.
              title: Text('Popular Movies'),
              onTap: () {
                Navigator.pushNamed(context, '/list');
              },
            ),
            ListTile(
              leading: Image.asset('assets/aguacaemamadisimo.png'),
              trailing: Icon(Icons.chevron_right), //simbolo de > al lado de cerrar sesion.
              title: Text('About Us'),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
            ListTile(
              leading: Image.asset('assets/aguacaemamadisimo.png'),
              trailing: Icon(Icons.chevron_right), //simbolo de > al lado de cerrar sesion.
              title: Text('Places'),
              onTap: () {
                Navigator.pushNamed(context, '/places');
              },
            ),
            ListTile(
              leading: Image.asset('assets/aguacaemamadisimo.png'),
              trailing: Icon(Icons.chevron_right), //simbolo de > al lado de cerrar sesion.
              title: Text('Practica 5'),
              onTap: () {
                debugShowCheckedModeBanner: false;
                Navigator.pushNamed(context, '/vistaprincipal');
              },
            ),
            ListTile(
              leading: Image.asset('assets/aguacaemamadisimo.png'),
              trailing: Icon(Icons.chevron_right), //simbolo de > al lado de cerrar sesion.
              title: Text('Cerrar Sesión'),
              onTap: () {
                //Navigator.popUntil(context, ModalRoute.withName('/login'));
                Navigator.pushNamed(context, '/login');
              },
            )
          ],
        ),
      ),
      body: ThemeScreen(),
    );
  }
}