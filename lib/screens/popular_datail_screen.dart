import 'package:flutter/material.dart';
import 'package:practica1/models/popular_model.dart';

class PopularDetailScreen extends StatefulWidget {
  const PopularDetailScreen({Key? key}) : super(key: key);

  @override
  State<PopularDetailScreen> createState() => _PopularDetailScreenState();
}

class _PopularDetailScreenState extends State<PopularDetailScreen> {
  PopularModel? popularModel;
  @override
  Widget build(BuildContext context) {
    ModalRoute.of(context)?.settings.arguments as PopularModel;
    return Scaffold(
      appBar: AppBar(
        title: Text('${popularModel!.title}'),
      ),
    );
  }
}