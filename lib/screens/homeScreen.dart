import 'package:flutter/material.dart';
import 'package:forge_app/providers/products_provider.dart';
import 'package:forge_app/screens/detailScreen.dart';
import 'package:forge_app/shared/env.dart';
import 'package:forge_app/widgets/topBar.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  void initState() {
    Provider.of<ProductsProvider>(context, listen: false).getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    List windows = productProvider.windows;
    List doors = productProvider.doors;
    List pots = productProvider.pots;
    double winLen = windows.length/2;
    double doorsLen = doors.length/2;
    double potsLen = pots.length/2;

    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Center(
          child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              color: Colors.white,
              child: Container(
                padding: const EdgeInsets.only(left: 5, bottom: 15, right: 10),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TopBar(),
                      // FIN TOPBAR
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: TabBar(
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Colors.black,
                          controller: _tabController,
                          isScrollable: true,
                          labelColor: Colors.black,
                          labelStyle: GlobalData.textBlack22,
                          unselectedLabelColor: Colors.grey.withOpacity(0.3),
                          tabs: const [
                            Text("Window Frames"),
                            Text("Door Frames"),
                            Text("Pot Stands"),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.3),
              child: TabBarView(controller: _tabController, children: [
                Column(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height * .7,
                        color: Colors.black,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: winLen.toInt(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(25),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.white,
                                            spreadRadius: 1,
                                            blurRadius: 0.1,
                                            offset: Offset(0, 1))
                                      ]),
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(children: [
                                      Image.memory(base64.decode(windows[index]['image'],)),
                                      Text(
                                        windows[index]['name'],
                                        style: GlobalData.textBlack22,
                                      ),
                                      FilledButton.icon(
                                          onPressed: () {
                                            Navigator.push(context,
                                                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen(id: windows[index]['id'],)));
                                            },
                                          icon: const Icon(Icons.remove_red_eye_outlined),
                                          label: const Text('Details'))
                                    ]),
                                  ),
                                ),
                              );
                            })),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .7,
                      color: Colors.white,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: doorsLen.toInt(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(25),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black,
                                          spreadRadius: 1,
                                          blurRadius: 0.1,
                                          offset: Offset(0, 1))
                                    ]),
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(children: [
                                      Image.memory(base64.decode(doors[index]['image'],)),
                                      Text(
                                        doors[index]['name'],
                                        style: GlobalData.textWhite22,
                                      ),
                                      FilledButton.icon(
                                          onPressed: () {
                                            Navigator.push(context,
                                                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen(id: doors[index]['id'],)));
                                            },
                                          icon: const Icon(Icons.remove_red_eye_outlined),
                                          label: const Text('Details'))
                                    ]),
                                  ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .7,
                      color: Colors.black,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: potsLen.toInt(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(25),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.white,
                                          spreadRadius: 1,
                                          blurRadius: 0.1,
                                          offset: Offset(0, 1))
                                    ]),
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(children: [
                                      Image.memory(base64.decode(pots[index]['image'],)),
                                      Text(
                                        pots[index]['name'],
                                        style: GlobalData.textBlack22,
                                      ),
                                      FilledButton.icon(
                                          onPressed: () {
                                            Navigator.push(context,
                                                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen(id: pots[index]['id'],)));
                                            },
                                          icon: const Icon(Icons.remove_red_eye_outlined),
                                          label: const Text('Details'))
                                    ]),
                                  ),
                              ),
                            );
                          }),
                    )
                  ],
                )
              ]),
            )
          ],
        ),
      )),
    );
  }
}
