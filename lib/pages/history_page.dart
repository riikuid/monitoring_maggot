
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:monitoring_maggot/model/data_maggot.dart';
import 'package:monitoring_maggot/theme.dart';
import 'package:monitoring_maggot/widget/chart_widget.dart';
import 'package:monitoring_maggot/widget/data_list_table.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final starCountRef =
  FirebaseDatabase.instance.ref('DataHistory');


  @override
  void initState() {
    super.initState();
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      final json = data as Map<Object?, Object?>;
      final jsonString = jsonEncode(json);

      debugPrint('qqq $jsonString');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor500,
      appBar: AppBar(
        // actions: [
        //   ElevatedButton(
        //     onPressed: () {
        //       // Membuat data acak untuk Suhu dan Kelembaban
        //       double suhu = Random().nextDouble() * (33 - 27) + 27;
        //       double kelembaban = Random().nextDouble() * (90 - 60) + 60;

        //       // Mendapatkan waktu saat ini
        //       Timestamp waktu = Timestamp.now();

        //       // Membuat data untuk dikirim ke Firestore
        //       Map<String, dynamic> data = {
        //         'Suhu': suhu,
        //         'Kelembaban': kelembaban,
        //         'Waktu': waktu,
        //       };

        //       // Mem-post data ke Firestore
        //       FirebaseFirestore.instance
        //           .collection('MAGGOTVISION')
        //           .add(data)
        //           .then((value) {
        //         // Berhasil mem-post data
        //         print('Data berhasil ditambahkan');
        //       }).catchError((error) {
        //         // Gagal mem-post data
        //         print('Error: $error');
        //       });
        //     },
        //     child: Text('Post Data to Firestore'),
        //   ),
        // ],
        title: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(100.0),
                ),
                image: const DecorationImage(
                  image: AssetImage(
                    "assets/icon_history.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "History",
              style: primaryTextStyle.copyWith(
                color: whiteColor,
                fontWeight: semibold,
              ),
            ),
          ],
        ),
        backgroundColor: primaryColor500,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          // top: device.padding.top,
          right: 20,
          left: 20,
        ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('MAGGOTVISION')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<DataMaggot> dataList =
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                return DataMaggot.fromJson(data);
              }).toList();

              dataList.sort((a, b) => b.waktu.compareTo(a.waktu));

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Temperature and Humidity\nGraph",
                    style: primaryTextStyle.copyWith(
                      color: whiteColor,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ChartWidget(dataList: dataList),
                  const SizedBox(
                    height: 20,
                  ),
                  ColoredBox(
                      color: secondaryColor,
                      child:
                          DataListTable(dataList: dataList.take(20).toList()))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
