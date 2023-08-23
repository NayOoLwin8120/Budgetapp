import "package:flutter/material.dart";

Widget ShowImage(String imagePath, String title, VoidCallback OnTap) {
  return GestureDetector(
    onTap: OnTap,
    child: Column(
      children: [
        Container(
          width: 60,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xff088395),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                width: 30,
                height: 30,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 100,
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 10),
                child: Text(
                  maxLines: 2,
                  // overflow: TextOverflow.ellipsis,
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xff0A4D68),
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 1),
      ],
    ),
  );
}
