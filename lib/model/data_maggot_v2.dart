class DataMaggotV2 {
  final double suhu;
  final double kelembaban;
  final String tanggal;
  DataMaggotV2({
    required this.suhu,
    required this.kelembaban,
    required this.tanggal,
  });

  static DataMaggotV2 fromJson(Map<Object?, Object?> json){
    return DataMaggotV2(
      suhu: json['suhu'] as double,
      kelembaban: json['kelembaban'] as double,
      tanggal: json['timestamp'].toString()
    );
  }
}