import 'package:flutter/material.dart';

class SecondUI extends StatefulWidget {
  const SecondUI({super.key});

  @override
  State<SecondUI> createState() => _SecondUIState();
}

class _SecondUIState extends State<SecondUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 245, 241, 241),
      body: Stack(
        children: [
          Image.asset(
            'assets/women.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: 480,
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 0),
                    child: Column(
                      children: const [
                        Text(
                          'Aanika Johnson',
                          style: TextStyle(fontSize: 35, color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Freelancer',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45.0),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Projects',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 20, 20, 20),
                                ),
                              ),
                              Text(
                                '1135',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          VerticalDivider(
                            color: Colors.grey,
                            thickness: 2,
                            width: 30,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Hourly Rate',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 20, 20, 20),
                                ),
                              ),
                              Text(
                                "\$65",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          VerticalDivider(
                            color: Colors.grey,
                            thickness: 2,
                            width: 30,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Location',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 20, 20, 20),
                                ),
                              ),
                              Text(
                                'Dusseldorf',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.blue,
                          side: const BorderSide(
                            color: Colors.blue,
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'View Profile',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 55,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          'Message',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/Screenshot.png',
                    height: 200,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
