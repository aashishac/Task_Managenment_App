import 'package:flutter/material.dart';

class FirstUI extends StatefulWidget {
  const FirstUI({super.key});

  @override
  State<FirstUI> createState() => _FirstUIState();
}

class _FirstUIState extends State<FirstUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 245, 241, 241),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: Image.asset('assets/old.png', fit: BoxFit.cover),
                    ),
                    Expanded(child: Container(color: Colors.transparent)),
                  ],
                ),
              ),

              // Foreground content
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Top icons
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Icon(
                              Icons.arrow_back,
                              size: 32,
                              color: Colors.white,
                            ),
                            Icon(Icons.edit, size: 28, color: Colors.white),
                          ],
                        ),
                      ),

                      const SizedBox(height: 180),

                      // Avatar + Name + Title
                      Transform.translate(
                        offset: const Offset(0, -60),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: const CircleAvatar(
                                radius: 70,
                                backgroundImage: AssetImage(
                                  'assets/ashish.png',
                                ),
                              ),
                            ),
                            const SizedBox(height: 0),
                            const Text(
                              'Ashish Adhikari',
                              style: TextStyle(
                                fontSize: 35,
                                color: Colors.black,
                              ),
                            ),
                            const Text(
                              'Flutter Developer',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(162, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 5),

                      // User Information Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'User Information',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: const [
                                  ListTile(
                                    leading: Icon(
                                      Icons.location_on,
                                      color: Colors.blue,
                                    ),
                                    title: Text('Location'),
                                    subtitle: Text('Kathmandu'),
                                  ),
                                  Divider(height: 1),

                                  ListTile(
                                    leading: Icon(
                                      Icons.email,
                                      color: Colors.red,
                                    ),
                                    title: Text('Email'),
                                    subtitle: Text('ashishadhikari@gmail.com'),
                                  ),
                                  Divider(height: 1),

                                  ListTile(
                                    leading: Icon(
                                      Icons.phone,
                                      color: Colors.green,
                                    ),
                                    title: Text('Phone'),
                                    subtitle: Text('+977-9813672338'),
                                  ),
                                  Divider(height: 1),

                                  ListTile(
                                    leading: Icon(
                                      Icons.info_outline,
                                      color: Colors.orange,
                                    ),
                                    title: Text('About Me'),
                                    subtitle: Text(
                                      'This is about me link and you can know about me in this section.',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
