import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = true,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? (isDarkMode ? Colors.white : Colors.black),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      leading: showBackButton
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: textColor ?? (isDarkMode ? Colors.white : Colors.black),
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      actions: actions,
      backgroundColor: backgroundColor ??
          (isDarkMode ? const Color(0xFF1E1E1E) : Colors.white),
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: textColor ?? (isDarkMode ? Colors.white : Colors.black),
      ),
    );
  }
}