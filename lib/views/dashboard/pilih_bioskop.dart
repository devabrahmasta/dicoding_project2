import 'package:flutter/material.dart';

class PilihBioskop extends StatefulWidget {
  const PilihBioskop({super.key});

  @override
  State<PilihBioskop> createState() => _PilihBioskopState();
}

class _PilihBioskopState extends State<PilihBioskop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Bioskop'),
      ),
    );
  }
}
