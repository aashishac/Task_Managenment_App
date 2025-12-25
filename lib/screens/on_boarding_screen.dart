import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/storage_provider.dart';
import 'package:flutter_application_1/screens/TaskListScreen.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentPageIndex = 0;

  final _pageController = PageController();

  void _nextPage() async {
    if (_currentPageIndex < _pages.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    } else {
      // Logic to show once
      await context.read<StorageProvider>().markOnBoardingSeen();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TaskListScreen()),
      );
    }
  }

  void _skipOnBoarding() {
    _pageController.jumpToPage(_pages.length - 1);
  }

  final List<Widget> _pages = [
    _buildOnboardingContent(
      imagePath: 'assets/onboard_one.png',
      shortInfo:
          'You can easily create and manage your tasks is simple and straightforward ',
    ),
    _buildOnboardingContent(
      imagePath: 'assets/onboard_two.png',
      shortInfo: 'Easy organize your tasks and projects with filters',
    ),
    _buildOnboardingContent(
      imagePath: 'assets/get started.png',
      shortInfo:
          'welcome to task manager ,It is easy to manage your tasks with the help of th app that is simple and straightforward',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    bool isLastPage = _currentPageIndex == _pages.length - 1;
    return Scaffold(
      body: Column(
        children: [
          // page view
          Expanded(
            flex: 3,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (value) {
                _currentPageIndex = value;
                setState(() {});
              },
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                return _pages[index];
              },
            ),
          ),
          //dot indicator
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                final currentPageIndex = _currentPageIndex == index;
                return Container(
                  margin: EdgeInsets.all(8),
                  width: currentPageIndex ? 18 : 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: currentPageIndex ? Colors.grey : Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                );
              }),
            ),
          ),

          // skip + continue buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isLastPage
                    ? SizedBox.shrink()
                    : Expanded(
                        child: ElevatedButton(
                          onPressed: _skipOnBoarding,
                          child: Text('Skip'),
                        ),
                      ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _nextPage();
                    },
                    child: Text(isLastPage ? 'Get Started' : 'Continue'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}

Widget _buildOnboardingContent({
  required String imagePath,
  required String shortInfo,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    spacing: 10,
    children: [
      SizedBox(height: 70),
      Image.asset(imagePath, height: 200),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 55),
        child: Text(shortInfo),
      ),
    ],
  );
}
