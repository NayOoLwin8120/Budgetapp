import "package:flutter/material.dart";
import "package:get/get.dart";

class AllAppBar extends GetView implements PreferredSizeWidget {
  const AllAppBar({
    super.key,
    this.title,
    this.leading,
    this.data,
    this.action,
    this.color,
  });
  final String? title;
  final Widget? leading;
  final Widget? action;
  final Widget? data;
  final Color? color;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color ?? Get.theme.colorScheme.background,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(data == null ? 0 : 100),
        child: data ?? const SizedBox(),
      ),
      title: title != null
          ? Center(
              child: Text(
                title.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : const SizedBox.shrink(),
      leading: leading,
      actions: [
        action!,
      ],
    );
  }
}

class AppBarAction extends StatelessWidget {
  const AppBarAction({
    required this.data,
    super.key,
  });
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xff50A6B2),
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 1),
            spreadRadius: 0.1,
            blurRadius: 8,
            color: Color.fromARGB(34, 0, 0, 0),
          ),
        ],
      ),
      child: Image.asset(
        data,
        color: Colors.white,
        fit: BoxFit.cover,
      ),
    );
  }
}
