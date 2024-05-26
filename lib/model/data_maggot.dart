import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Import library untuk mengonversi String ke DateTime

class DataMaggot {
  final double kelembaban;
  final double suhu;
  final DateTime waktu; // Ubah tipe data menjadi DateTime

  DataMaggot({
    required this.kelembaban,
    required this.suhu,
    required this.waktu,
  });

  factory DataMaggot.fromJson(Map<String, dynamic> json) => DataMaggot(
        kelembaban: json["Kelembaban"]?.toDouble(),
        suhu: json["Suhu"]?.toDouble(),
        waktu: (json["Waktu"] as Timestamp)
            .toDate(), // Mengonversi Timestamp menjadi DateTime
        // Parsing String ke DateTime
      );

  Map<String, dynamic> toJson() => {
        "Kelembaban": kelembaban,
        "Suhu": suhu,
        "Waktu": DateFormat("MMMM d, yyyy 'at' h:mm:ss a 'UTC'Z")
            .format(waktu), // Format DateTime ke String
      };
}
