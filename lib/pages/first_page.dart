import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_app/components/primary_button.dart';
import 'package:suitmedia_app/pages/second_page.dart';
import 'package:suitmedia_app/providers/user_logger.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String palindrome = "";

  Future<void> _checkPalindrome() async {
    bool isPalindrome = false;
    String str = palindrome.toLowerCase().replaceAll(RegExp("/[\\W_ ]/g"), "");
    str.split('').reversed.join('') == str
        ? isPalindrome = true
        : isPalindrome = false;
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Palindrome Test'),
          content: Text(
              'Text: "$palindrome" is ${isPalindrome ? "a" : "not a"} palindrome'),
          actions: [
            TextButton(
              child: const Text('Return'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/image/ic_photo.png"),
                const SizedBox(height: 58.12),
                CustomTextField(
                  hintText: "Name",
                  onChanged: (value) {
                    Provider.of<UserLogger>(context, listen: false)
                        .setUsername(value);
                  },
                ),
                const SizedBox(height: 22.12),
                CustomTextField(
                  hintText: "Palindrome",
                  onChanged: (value) {
                    setState(() {
                      palindrome = value;
                    });
                  },
                ),
                const SizedBox(height: 45),
                PrimaryButton(
                  text: "CHECK",
                  onPressed: () => _checkPalindrome(),
                ),
                const SizedBox(height: 15),
                PrimaryButton(
                  text: "NEXT",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SecondPage(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);
  final Function(String) onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310,
      height: 39.88,
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color(0x6867775C),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
