import 'package:flutter/material.dart';

import '../components/new_request_component.dart';
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Drawer Item 1'),
              onTap: () {
                // Navigate to Tab 1
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text('Drawer Item 2'),
              onTap: () {
                // Navigate to Tab 2
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text('Drawer Item 3'),
              onTap: () {
                // Navigate to Tab 3
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body: DefaultTabController(
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
