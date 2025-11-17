import 'package:flutter/material.dart';

class Customcard extends StatelessWidget {
  const Customcard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 650,
        width: 400,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [Icon(Icons.more_vert)],
              ),
            ),
            // First element
            Stack(
              children: [
                Image.asset('assets/ashish.png', height: 180, width: 350),
                Positioned(
                  bottom: 0,
                  right: 110,
                  child: Image.asset(
                    'assets/verifieed.png',
                    height: 30,
                    width: 30,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            //second element
            Text(
              'Ashish Adhikari',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 5),
            Text(
              'Flutter Developer & UI Designer',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Column(
                    children: [
                      Text('Projects', style: TextStyle(color: Colors.grey)),
                      Text(
                        '17',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Following', style: TextStyle(color: Colors.grey)),
                      Text(
                        '25k',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Followers', style: TextStyle(color: Colors.grey)),
                      Text(
                        '15',
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
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Iam software developer based  in kathmandu ,Nepal. I love to design and code mobile applications.focus on Flutter and Dart programming language.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),

            Image.asset(
              'assets/social.png',
              height: 120,
              width: 150,
            ), // thirdelement
            TextButton(
              onPressed: () {
                // lastelement
                print('View Profile tapped');
              },
              child: const Text(
                'View Profile',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Customcard_1 extends StatelessWidget {
  const Customcard_1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650,
      width: 400,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [Icon(Icons.more_vert)],
            ),
          ),
          Stack(
            children: [
              Image.asset('assets/ashish.png', height: 180, width: 350),
              Positioned(
                bottom: 0,
                right: 110,
                child: Image.asset(
                  'assets/verifieed.png',
                  height: 30,
                  width: 30,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Ashish Adhikari',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Flutter Developer & UI Designer',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Column(
                  children: [
                    Text('Projects', style: TextStyle(color: Colors.grey)),
                    Text(
                      '17',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('Following', style: TextStyle(color: Colors.grey)),
                    Text(
                      '25k',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('Followers', style: TextStyle(color: Colors.grey)),
                    Text(
                      '15',
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
          const SizedBox(height: 5),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'I am a software developer based in Kathmandu, Nepal. I love to design and code mobile applications. Focus on Flutter and Dart programming language.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
          Image.asset('assets/social.png', height: 120, width: 150),

          // 👇 lastelement
          ElevatedButton(
            onPressed: () {
              // Add your navigation or action here
              print('View Profile tapped');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Button background color
              foregroundColor: Colors.white, // Text color
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('View Profile', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
