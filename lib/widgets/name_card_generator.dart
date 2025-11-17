import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NameCardForm(),
    );
  }
}

class NameCardForm extends StatefulWidget {
  const NameCardForm({super.key});

  @override
  State<NameCardForm> createState() => _NameCardFormState();
}

class _NameCardFormState extends State<NameCardForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  bool isLoading = false;
  String? errorMessage;
  String? name;
  String? job;

  void handleGenerateCard() {
    final enteredName = nameController.text.trim();
    final enteredJob = jobController.text.trim();

    if (enteredName.isEmpty || enteredJob.isEmpty) {
      setState(() {
        errorMessage = 'Both fields are required!';
        name = null;
        job = null;
      });
    } else {
      setState(() {
        errorMessage = null;
        name = enteredName;
        job = enteredJob;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    jobController.dispose();
    super.dispose();
  }

  void _refreshHome() async {
    setState(() {
      isLoading = true;
    });

    try {
      await Future.delayed(Duration(seconds: 1)); // Simulate refresh delay

      nameController.clear();
      jobController.clear();

      setState(() {
        name = null;
        job = null;
        errorMessage = null;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Refresh failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(color: Colors.white),

        title: const Text(
          "Name Card Generator APP",

          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Enter your name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: jobController,
              decoration: const InputDecoration(
                labelText: 'Enter your job title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: handleGenerateCard,
              child: const Text('Generate Name Card'),
            ),
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            IconButton(icon: Icon(Icons.refresh), onPressed: _refreshHome),
            const SizedBox(height: 30),
            if (name != null && job != null)
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('You tapped the card')),
                  );
                },
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Colors.blueAccent,
                          Color.fromARGB(255, 89, 170, 207),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 90,
                          backgroundImage: AssetImage('assets/man-r.png'),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          name!,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          job!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Divider(color: Colors.white54),
                        const SizedBox(height: 10),
                        const Text(
                          'Passionate about my work !!!'
                          ' Tap  Here !! to HIRE ME',
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
