import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monitoring_maggot/model/data_maggot.dart';

class DataListTable extends StatelessWidget {
  final List<DataMaggot> dataList;

  DataListTable({required this.dataList});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 20, // Spasi antara kolom
      columns: [
        DataColumn(
          label: Text('Waktu'),
        ),
        // Kolom untuk Suhu dengan lebar 120
        DataColumn(
          label: SizedBox(
            width: 50,
            child: Text('Suhu\n(°C)'),
          ),
          numeric: true,
        ),
        // Kolom untuk Kelembaban dengan lebar 120
        DataColumn(
          label: SizedBox(
            width: 80,
            child: Text('Kelemba-\nban (%)'),
          ),
          numeric: true,
        ),
        // Kolom untuk Waktu
      ],
      rows: dataList.map((data) {
        return DataRow(cells: [
          DataCell(Text(DateFormat('dd/MMM/yyyy HH:mm').format(data.waktu))),
          DataCell(
            SizedBox(
              width: 50,
              child: Text(
                data.suhu.toStringAsFixed(1),
              ),
            ),
          ),
          DataCell(SizedBox(
              width: 80, child: Text(data.kelembaban.toStringAsFixed(1)))),
        ]);
      }).toList(),
    );
  }
}
