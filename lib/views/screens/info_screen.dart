// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants.dart';

import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});
  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 200.0,
                  backgroundImage: AssetImage(
                    'assets/images/image1.jpeg',
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Text(
                  'Ahmed Algzery',
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Text(
                  'Flutter Developer',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Divider(
                  thickness: 2.0,
                  color: Colors.red,
                  endIndent: 10.0,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                  width: 250,
                  height: 40.0,
                  padding: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: TextButton(
                    onPressed: () async {
                      launchInBrowser(Uri.parse(
                          'https://www.linkedin.com/in/%D9%90%D9%90ahmed-algzery/'));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          FontAwesomeIcons.linkedin,
                          size: 25,
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          'LinkedIn ',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 10, 38, 71),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: 250,
                  height: 40.0,
                  padding: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: TextButton(
                    onPressed: () async {
                      launchInBrowser(Uri.parse(
                          'https://www.facebook.com/profile.php?id=100014851561834'));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          FontAwesomeIcons.facebook,
                          size: 25,
                        ),
                        // Image.asset('images/linkedin.png'),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          'Facebook',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Color.fromARGB(255, 10, 38, 71),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: 250,
                  height: 40.0,
                  padding: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: TextButton(
                    onPressed: () async {
                      launchInBrowser(
                          Uri.parse('https://github.com/ahmedalgzery'));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          FontAwesomeIcons.github,
                          color: Colors.black,
                          size: 25,
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          'GitHub',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromARGB(255, 10, 38, 71),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
