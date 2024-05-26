import 'package:flutter/material.dart';
import 'package:monitoring_maggot/model/data_maggot.dart';
import 'package:monitoring_maggot/theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartWidget extends StatelessWidget {
  final List<DataMaggot> dataList;

  ChartWidget({required this.dataList});

  @override
  Widget build(BuildContext context) {
    // Mengelompokkan data per jam
    Map<DateTime, DataMaggot> hourlyData = {};
    for (var data in dataList) {
      DateTime parsedTime = data.waktu;
      // Menyimpan waktu lengkap sebagai kunci
      DateTime roundedTime = DateTime(parsedTime.year, parsedTime.month,
          parsedTime.day, parsedTime.hour, parsedTime.minute);
      if (!hourlyData.containsKey(roundedTime)) {
        hourlyData[roundedTime] = data;
      }
    }

    List<DataMaggot> chartData = hourlyData.values.take(5).toList()
      ..sort((a, b) => a.waktu.compareTo(b.waktu));

    return Center(
      child: SfCartesianChart(
        backgroundColor: whiteColor,
        primaryXAxis: CategoryAxis(),
        series: [
          LineSeries<DataMaggot, String>(
            width: 5,
            isVisibleInLegend: true,
            color: Colors.red,
            dataSource: chartData,
            xValueMapper: (DataMaggot data, _) =>
                '${data.waktu.hour}:${data.waktu.minute}', // Menggunakan hanya jam dan menit
            yValueMapper: (DataMaggot data, _) => data.suhu,
            name: 'Suhu',
          ),
          LineSeries<DataMaggot, String>(
            width: 5,
            isVisibleInLegend: true,
            color: subtitleTextColor,
            dataSource: chartData,
            xValueMapper: (DataMaggot data, _) =>
                '${data.waktu.hour}:${data.waktu.minute}', // Menggunakan hanya jam dan menit
            yValueMapper: (DataMaggot data, _) => data.kelembaban,
            name: 'Kelembaban',
          ),
        ],
        tooltipBehavior: TooltipBehavior(
          enable: true,
        ),
      ),
    );
  }
}
