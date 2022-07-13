import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_app/components/custom_appbar.dart';
import 'package:suitmedia_app/components/primary_button.dart';
import 'package:suitmedia_app/pages/third_page.dart';
import 'package:suitmedia_app/providers/user_logger.dart';
import 'package:suitmedia_app/providers/user_selector.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String fullName = Provider.of<UserSelector>(context).getFullName;
    String username = Provider.of<UserLogger>(context).getUsername;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: "Second Screen"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, top: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome",
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                Text(
                  username,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                fullName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: PrimaryButton(
                text: "Choose a User",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ThirdPage(),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
