import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musait/screens/account/account_screen.dart';
import 'package:musait/screens/files/files_screen.dart';
import 'package:musait/screens/home/home_screen.dart';
import 'package:musait/screens/support/support_screen.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  int currentTab = 0;
  final List<Widget> screens = [
    HomeScreen(),
    FilesScreen(),
    SupportScreen(),
    AccountScreen(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.r),
        ),
        backgroundColor: const Color(0xff007AFF),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: BottomAppBar(
        height: 40.h,
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          height: 20.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = HomeScreen();
                        currentTab = 0;
                      });
                    },
                    minWidth: 40,
                    child: Icon(
                      Icons.home_filled,
                      color: currentTab == 0
                          ? const Color(0xff007AFF)
                          : Color(0xff848A94),
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = FilesScreen();
                        currentTab = 1;
                      });
                    },
                    minWidth: 40,
                    child: Icon(
                      Icons.file_copy,
                      color: currentTab == 1
                          ? const Color(0xff007AFF)
                          : Color(0xff848A94),
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = SupportScreen();
                        currentTab = 2;
                      });
                    },
                    minWidth: 40,
                    child: Icon(
                      Icons.chat,
                      color: currentTab == 2
                          ? const Color(0xff007AFF)
                          : Color(0xff848A94),
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = AccountScreen();
                        currentTab = 3;
                      });
                    },
                    minWidth: 40,
                    child: Icon(
                      Icons.person,
                      color: currentTab == 3
                          ? const Color(0xff007AFF)
                          : Color(0xff848A94),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
