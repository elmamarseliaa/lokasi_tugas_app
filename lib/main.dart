import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: LokasiTugasPage()),
  );
}

class LokasiTugasPage extends StatefulWidget {
  const LokasiTugasPage({super.key});

  @override
  LokasiTugasPageState createState() => LokasiTugasPageState();
}

class LokasiTugasPageState extends State<LokasiTugasPage> {
  String _lokasi = "Menunggu lokasi...";

  @override
  void initState() {
    super.initState();
    _ambilLokasi();
  }

  Future<void> _ambilLokasi() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _lokasi = "Lat: ${position.latitude}, Long: ${position.longitude}";
      });
    } else {
      setState(() {
        _lokasi = "Izin lokasi ditolak.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Aplikasi Lokasi Tugas")),
      body: Center(child: Text(_lokasi, style: TextStyle(fontSize: 20))),
    );
  }
}
