import 'package:flutter/material.dart';
import 'package:monitoring_maggot/pages/history_page.dart';
import 'package:monitoring_maggot/pages/home_page.dart';
import 'package:monitoring_maggot/theme.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late int currentIndex = 0;

  List dashboardMenu = [
    [
      SizedBox(
        height: 40,
        child: Image.asset(
          "assets/icon_home.png",
          height: 60,
        ),
      ),
      const MyHomePage(),
    ],
    [
      Image.asset("assets/icon_history_db.png"),
      const HistoryPage(),
    ],
  ];

  Widget bottomNavBar() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        boxShadow: [defaultShadow],
      ),
      child: NavigationBar(
        backgroundColor: secondaryColor,
        surfaceTintColor: whiteColor,
        elevation: 5,
        indicatorColor: Colors.transparent,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        selectedIndex: currentIndex,
        onDestinationSelected: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        destinations: dashboardMenu.map(
          (item) {
            return NavigationDestination(
              icon: item[0],
              label: " ",
              selectedIcon: Stack(
                alignment: Alignment.topCenter,
                children: [
                  SizedBox(
                    height: double.infinity,
                    child: item[0],
                  ),
                  const SizedBox(
                    height: 3,
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showModal();
    });
    super.initState();
  }

  Future<void> _showModal() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Goal"),
          content: Text(
            "Tujuannya untuk membantu peternak maggot BSF dalam memonitoring kondisi suhu dan kelembaban kandang Maggot BSF dari jarak jauh. Kondisi suhu dan kelembaban kandang merupakan faktor penting dalam keberhasilan Maggot BSF.",
            style: primaryTextStyle.copyWith(),
            textAlign: TextAlign.justify,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: dashboardMenu[currentIndex][1],
      bottomNavigationBar: bottomNavBar(),
    );
  }
}
