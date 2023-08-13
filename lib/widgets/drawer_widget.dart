import 'package:forge_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:forge_app/shared/env.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  PackageInfo _packageInfo =
  PackageInfo(
    appName: 'appName', 
    packageName: 'packageName', 
    version: 'version', 
    buildNumber: 'buildNumber');
  Future<void> initPackageInfo() async{
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }
  @override
  void initState() {
    initPackageInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Column(
        children: [
          DrawerHeader(
            margin: EdgeInsets.only(top: 0),
            decoration: BoxDecoration(
              color: Colors.black, 
              image: DecorationImage(image: AssetImage("assets/logo.png"), fit: BoxFit.contain)),
            child: 
              Align(alignment: Alignment.bottomRight, child: Text("Version: 1.0.1", style: GlobalData.textWhite10,),)
          ),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: ((context, index){
        return ListTile(
            title: Text(AppRoutes.menuOptions[index].name), 
            leading: Icon(AppRoutes.menuOptions[index].icon),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.menuOptions[index].router,);
            },
            );
      }),  
            separatorBuilder: (__, _) => const Divider(), 
            itemCount: AppRoutes.menuOptions.length)
        ],
      ),);
  }
}