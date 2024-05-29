
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:monitoring_maggot/model/data_maggot.dart';
import 'package:monitoring_maggot/theme.dart';
import 'package:monitoring_maggot/widget/chart_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData device = MediaQuery.of(context);
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
        title: Text(
          "Dashboard",
          style: primaryTextStyle.copyWith(
            color: whiteColor,
            fontWeight: semibold,
          ),
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
                  Text(
                    "Realtime",
                    style: primaryTextStyle.copyWith(
                      color: whiteColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icon_suhu.png",
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Temp",
                                    style: primaryTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: medium,
                                    ),
                                  ),
                                  Text(
                                    "${double.parse(dataList.first.suhu.toStringAsFixed(1))}°C",
                                    style: primaryTextStyle.copyWith(
                                      fontSize: 20,
                                      fontWeight: semibold,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icon_kelembapan.png",
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Humidity",
                                    style: primaryTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: medium,
                                    ),
                                  ),
                                  Text(
                                    "${double.parse(dataList.first.kelembaban.toStringAsFixed(1))}%",
                                    style: primaryTextStyle.copyWith(
                                      fontSize: 24,
                                      fontWeight: semibold,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Normal Condition",
                    style: primaryTextStyle.copyWith(
                      color: whiteColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icon_suhu.png",
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Temp",
                                    style: primaryTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: medium,
                                    ),
                                  ),
                                  Text(
                                    "30-36°C",
                                    style: primaryTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: semibold,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          height: 90,
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icon_kelembapan.png",
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Humidity",
                                    style: primaryTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: medium,
                                    ),
                                  ),
                                  Text(
                                    "60%-70%",
                                    style: primaryTextStyle.copyWith(
                                      fontSize: 15,
                                      fontWeight: semibold,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Latest Data Graph",
                    style: primaryTextStyle.copyWith(
                      color: whiteColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ChartWidget(dataList: dataList),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
