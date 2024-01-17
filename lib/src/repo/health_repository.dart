// import 'package:app_checker_test/src/model/foot_setps.dart';
// import 'package:flutter/material.dart';
// import 'package:health/health.dart';
// import 'package:permission_handler/permission_handler.dart';

// import '../model/blood_glucose.dart';

// class HealthRepository {
//   final health = HealthFactory();

//   // Future<List<BloodGlucose>> getBloodGlucose() async {
//   //   bool requested =
//   //       await health.requestAuthorization([HealthDataType.BLOOD_GLUCOSE]);

//   //   if (requested) {
//   //     var now = DateTime.now();
//   //     List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
//   //         DateTime.now().subtract(const Duration(days: 1)),
//   //         DateTime.now(),
//   //         [HealthDataType.BLOOD_GLUCOSE]);
//   //     //write data
//   //     // await health.writeHealthData(4.1, HealthDataType.BLOOD_GLUCOSE, now, now);

//   //     return healthData.map((e) {
//   //       var b = e;
//   //       print(b.value.toJson()['numericValue']);
//   //       return BloodGlucose(
//   //         double.parse(b.value.toJson()['numericValue']),
//   //         b.unitString,
//   //         b.dateFrom,
//   //         b.dateTo,
//   //       );
//   //     }).toList();
//   //   }
//   //   return [];
//   // }

//   Future<List<FootSteps>> getFootSteep() async {
//     final activity = await Permission.activityRecognition.request();
//     final location = await Permission.location.request();
//     if (activity.isGranted && location.isGranted) {
//       bool requested =
//           await health.requestAuthorization([HealthDataType.STEPS]);
//       if (requested) {
//         var now = DateTime.now();
//         List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
//             DateTime.now().subtract(const Duration(days: 1)),
//             DateTime.now(),
//             [HealthDataType.STEPS]);
//         print("healthData======================>");
//         //print(healthData.last.value);
//         List<FootSteps> steps = [];
//         for (var element in healthData) {
//           print("element: ${element.value}");
//           steps.add(FootSteps(
//             element.value,
//             element.unitString,
//             element.dateFrom,
//             element.dateTo,
//           ));
//         }
//         print("healthData======================>");
//         return steps;
//       } else {
//         return [];
//       }
//     } else {
//       return [];
//     }
//   }

//   Future<List<StepsOfWeek>> getTotalStepsOnInterval() async {
//     final activity = await Permission.activityRecognition.request();
//     final location = await Permission.location.request();
//     List<StepsOfWeek> steps = [];
//     if (activity.isGranted && location.isGranted) {
//       bool requested =
//           await health.requestAuthorization([HealthDataType.STEPS]);
//       if (requested) {
//         final weekDays = getDaysOfMonth();
//         for (var element in weekDays) {
//           final healthData = await health.getTotalStepsInInterval(
//             element.$1,
//             element.$2,
//           );
//           steps.add(StepsOfWeek(healthData!, element.$1, element.$2));
//         }
//       }
//     }
//     return steps;
//   }

//   List<(DateTime, DateTime)> getDaysOfMonth() {
//     DateTime now = DateTime.now();

//     // Find the first day of the current month
//     DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);

//     // Calculate the current week number
//     int currentWeek = ((now.day - firstDayOfMonth.day) / 7).ceil();

//     // Calculate the starting and ending days for each week
//     List<(DateTime, DateTime)> weekDays = [];
//     for (int week = currentWeek; week > 0; week--) {
//       DateTime startOfWeek =
//           firstDayOfMonth.add(Duration(days: (week - 1) * 7));
//       DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));
//       weekDays.add((startOfWeek, endOfWeek));
//     }
//     return weekDays;
//   }
// }
// /*
// / create a HealthFactory for use in the app
//     final health = HealthFactory(useHealthConnectIfAvailable: false);

//     // define the types to get
//     var types = [
//       HealthDataType.WEIGHT,
//       HealthDataType.STEPS,
//       HealthDataType.HEIGHT,
//       HealthDataType.BLOOD_GLUCOSE,
//       HealthDataType.WORKOUT,
//       HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
//       HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
//     ];

//     // requesting access to the data types before reading them
//     bool requested = await health.requestAuthorization(types);

//     var now = DateTime.now();

//     // fetch health data from the last 24 hours
//     List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
//         now.subtract(const Duration(days: 1)), now, types);

//     // request permissions to write steps and blood glucose
//     var permissions = types.map((e) => HealthDataAccess.READ_WRITE).toList();

//     await health.requestAuthorization(types, permissions: permissions);

//     // write steps and blood glucose
//     bool success =
//         await health.writeHealthData(10, HealthDataType.BLOOD_OXYGEN, now, now);
//     success = await health.writeHealthData(
//         3.1, HealthDataType.BLOOD_GLUCOSE, now, now);

//     // get the number of steps for today
//     var midnight = DateTime(now.year, now.month, now.day);
//     int? steps = await health.getTotalStepsInInterval(midnight, now);
//     print(healthData);
// */