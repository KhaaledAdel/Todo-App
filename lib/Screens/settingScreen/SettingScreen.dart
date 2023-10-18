import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      color: theme.primaryColor,
      width: double.infinity,
      height: 160,
      child: Text(
        "Settings",
        style: theme.textTheme.titleLarge,
      ),
    );
  }
}