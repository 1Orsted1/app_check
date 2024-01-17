import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:appcheck/appcheck.dart';

class AppCheckExample extends StatefulWidget {
  const AppCheckExample({Key? key}) : super(key: key);

  @override
  State<AppCheckExample> createState() => _AppCheckExampleState();
}

class _AppCheckExampleState extends State<AppCheckExample> {
  List<AppInfo>? installedAppsAndroid;
  List<AppInfo> iOSApps = [
    AppInfo(appName: "Calendar", packageName: "calshow://"),
    AppInfo(appName: "Facebook", packageName: "fb://"),
    AppInfo(appName: "Whatsapp", packageName: "whatsapp://"),
  ];

  @override
  void initState() {
    getApps();
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> getApps() async {
    List<AppInfo>? installedApps;

    if (Platform.isAndroid) {
      const package = "com.google.android.apps.fitness";
      installedApps = await AppCheck.getInstalledApps();
      debugPrint(installedApps.toString());

      await AppCheck.checkAvailability(package).then(
        (app) => debugPrint(app.toString()),
      );

      await AppCheck.isAppEnabled(package).then(
        (enabled) => enabled
            ? debugPrint('\n===========>$package enabled')
            : debugPrint('\n===========>$package disabled'),
      );

      installedApps?.sort(
        (a, b) => a.appName!.toLowerCase().compareTo(b.appName!.toLowerCase()),
      );
      print("%" * 1000);
      var googlFit =
          installedApps?.where((element) => element.appName == "Fit");
      print("google fit resolve: $googlFit");
    } else if (Platform.isIOS) {
      // iOS doesn't allow to get installed apps.
      installedApps = iOSApps;

      await AppCheck.checkAvailability("calshow://").then(
        (app) => debugPrint(app.toString()),
      );
    }
    // print(
    //     "installed apps ${installedApps?.firstWhere((element) => element.appName == "google")}");
    setState(() {
      installedAppsAndroid = installedApps;
    });
    //   print(
    //       "${"----" * 1000}installed apps ${installedAppsAndroid?.firstWhere((element) => element.appName == "google")}");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('AppCheck Example App')),
        body: installedAppsAndroid != null && installedAppsAndroid!.isNotEmpty
            ? ListView.builder(
                itemCount: installedAppsAndroid!.length,
                itemBuilder: (context, index) {
                  final app = installedAppsAndroid![index];

                  return ListTile(
                    title: Text(app.appName ?? app.packageName),
                    subtitle: Text(
                      (app.isSystemApp ?? false) ? 'System App' : 'User App',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.open_in_new),
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        AppCheck.launchApp(app.packageName).then((_) {
                          debugPrint(
                            "${app.appName ?? app.packageName} launched!",
                          );
                        }).catchError((err) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "${app.appName ?? app.packageName} not found!",
                            ),
                          ));
                          debugPrint(err.toString());
                        });
                      },
                    ),
                  );
                },
              )
            : const Center(child: Text('No installed apps found!')),
      ),
    );
  }
}
