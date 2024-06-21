import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/custom_drawer_component.dart';
import 'all_requests_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String id = 'homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/images/welcome_screen_logo.png', height: 45),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Implement notification action
            },
          ),
        ],
      ),
      drawer: CustomDrawer(
        avatarUrl: '',
        isAvailable: false,
        onAvailabilityChanged: (value) {
          // Implement availability change
        },
        professionalName: FirebaseAuth.instance.currentUser!.displayName.toString(),
      ),
      body: const DefaultTabController(
        length: 3, // Number of tabs
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'All Requests'),
                Tab(text: 'Video Calls'),
                Tab(text: 'Chats'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  AllRequestsPage(),
                  Center(child: Text('Tab 2 Content')),
                  Center(child: Text('Tab 3 Content')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
