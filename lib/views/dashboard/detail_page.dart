import 'package:dicoding_project2/models/movie.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final Movie movie;

  const DetailPage({super.key, required this.movie});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
    );
  }
}
