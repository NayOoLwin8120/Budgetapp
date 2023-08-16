// import 'package:flutter/material.dart';

// Widget dataList(
//   String date,
//   String about,
//   String money,
// ) {
//   return Column(
//     // crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(date),
//       const SizedBox(
//         height: 3,
//       ),
//       Container(
//         padding: const EdgeInsets.only(left: 30, right: 30),
//         height: 40,
//         color: Colors.green.withOpacity(0.3),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(about),
//             Row(
//               children: [const Text("+ "), Text(money), const Text("K")],
//             ),
//           ],
//         ),
//       ),
//       const SizedBox(
//         height: 10,
//       ),
//       Container(
//         padding: const EdgeInsets.only(left: 30, right: 30),
//         height: 40,
//         color: Colors.red.withOpacity(0.3),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(about),
//             // Text("+ 1000 K"),
//             Row(
//               children: [const Text("+ "), Text(money), const Text("K")],
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }

import "package:flutter/material.dart";

class DataListItem extends StatelessWidget {
  DataListItem({
    required this.filename,
    required this.iconaction,
    required this.about,
    required this.money,
    this.title,
    super.key,
  });
  final String about;
  final String money;
  VoidCallback iconaction;
  String filename;
  String? title;

  @override
  Widget build(BuildContext context) {
    final isIncome = title!.contains("income");
    debugPrint(isIncome.toString());

    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 3),
        Container(
          padding: const EdgeInsets.only(left: 30, right: 30),
          height: 40,
          color: isIncome
              ? Colors.green.withOpacity(0.3)
              : Colors.red.withOpacity(0.3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(about),
              Row(
                children: [
                  Text(isIncome ? "+ " : " - "),
                  Text(money),
                  const Text("K")
                ],
              ),
              IconButton(
                onPressed: iconaction,
                icon: const Icon(Icons.remove_red_eye),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
