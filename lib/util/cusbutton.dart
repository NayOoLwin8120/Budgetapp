import "package:flutter/material.dart";

Widget cusbutton({
  required String title,
  required VoidCallback onPressed,
}) =>
    Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xff05AACB),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          // style: Get.textTheme.bodyMedium!.copyWith(
          //     fontWeight: FontWeight.normal, color: Color(0xff0A4D68)),
        ),
      ),
    );
