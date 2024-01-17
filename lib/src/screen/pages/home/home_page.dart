// import 'package:app_checker_test/src/screen/pages/home/home_controller.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final controller = HomeController();

//   @override
//   void initState() {
//     controller.getData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Health Data')),
//       floatingActionButton: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const SizedBox(height: 16),
//           FloatingActionButton(
//             onPressed: () => controller.getData(),
//             child: const Icon(Icons.refresh),
//           ),
//         ],
//       ),
//       body: ValueListenableBuilder(
//         valueListenable: controller.steps,
//         builder: (context, value, child) {
//           return value == []
//               ? const Center(
//                   child: CircularProgressIndicator(),
//                 )
//               : ListView(
//                   //padding: const EdgeInsets.all(15),

//                   children: [
//                       for (final steps in value)
//                         SizedBox(
//                           height: 80,
//                           width: 20,
//                           child: Card(
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceAround,
//                                     children: [
//                                       Text("${steps.dateFrom}   to"),
//                                       Text(steps.dateTo.toString()),
//                                     ],
//                                   ),
//                                   Center(
//                                     child: Text(
//                                         "total steps for this week\n                ${steps.value}"),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                     ]);
//         },
//       ),
//     );
//   }
// }
