import 'dart:io';

import 'package:appcheck/appcheck.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppCheckMyImplementation extends StatefulWidget {
  const AppCheckMyImplementation({super.key});

  @override
  State<AppCheckMyImplementation> createState() =>
      _AppCheckMyImplementationState();
}

class _AppCheckMyImplementationState extends State<AppCheckMyImplementation> {
  final String googleFitPackageName = "com.google.android.apps.fitness";
  AppInfo? appInfo;
  bool isLoading = true;

  @override
  void initState() {
    _searchApp();
    super.initState();
  }

  _searchApp() async {
    AppInfo? googleFit;
    if (Platform.isIOS) {
      // AppInfo? iosApp;
      // try {
      //   iosApp = await AppCheck.checkAvailability("x-apple-health://");
      // } catch (e) {}
      const String applePackage = "com.apple.Health";
      try {
        final AppInfo? appleHealth =
            await AppCheck.checkAvailability(applePackage);
        setState(() {
          appInfo = appleHealth;
        });
        //eturn appleHealth != null;
      } catch (e) {
        //return false;
      }

      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = true;
      });
      try {
        //final installedApps = await AppCheck.getInstalledApps();
        googleFit = await AppCheck.checkAvailability(googleFitPackageName);
        // googleFit = installedApps?.firstWhere(
        //     (element) => element.packageName == googleFitPackageName);
      } catch (e) {}
      setState(() {
        appInfo = googleFit;
      });
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _launchUrl() async {
    final Uri androidUrl = Uri.parse(
        "https://play.google.com/store/apps/details?id=com.google.android.apps.fitness");
    final iosUrl =
        Uri.parse('https://apps.apple.com/us/app/apple-health/id1242545199');
    if (Platform.isAndroid) {
      if (!await launchUrl(androidUrl)) {
        throw Exception('Could not launch $androidUrl');
      }
    } else if (Platform.isIOS) {
      if (!await launchUrl(iosUrl)) {
        throw Exception('Could not launch $iosUrl');
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator.adaptive()
            : appInfo == null
                ? SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("google fit or not found"),
                          ElevatedButton(
                              onPressed: () {
                                print("go to store");
                                launchUrl;
                              },
                              child: const Text("install google fit")),
                        ],
                      ),
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Center(
                              child: Text(
                                  "Google fit or  health  found \n ${appInfo!}")),
                          ElevatedButton(
                              onPressed: () {},
                              child: const Text("proceed to challenge")),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
