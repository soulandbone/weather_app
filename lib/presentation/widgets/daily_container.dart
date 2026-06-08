// import 'package:flutter/material.dart';

// import 'package:weather_app/models/weather_models.dart';

// class DailyContainer extends StatelessWidget {
//   const DailyContainer({
//     required this.forecast,
//     required this.isSelected,
//     required this.onSelection,
//     required this.isCelsius,
//     super.key,
//   });
//   final DailyForecast forecast;
//   final bool isSelected;
//   final bool isCelsius;
//   final VoidCallback onSelection;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onSelection,
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 3),
//         padding: EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.green : Colors.blue,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,

//           children: [
//             Row(
//               children: [
//                 Text(
//                   isCelsius
//                       ? "${forecast.maxTempC} °C"
//                       : "${forecast.maxTempF} °F",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 10,
//                   ),
//                 ),
//                 Text(
//                   isCelsius
//                       ? "${forecast.minTempC} °C"
//                       : "${forecast.minTempF} °F",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 8,
//                   ),
//                 ),
//               ],
//             ),

//             Image.network(forecast.icon),
//             Text(

//               style: TextStyle(fontSize: 11, color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
