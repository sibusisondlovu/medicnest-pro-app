import 'package:flutter/material.dart';

import '../config/strings.dart';

class CustomDrawer extends StatelessWidget {
  final String avatarUrl;
  final String professionalName;
  final bool isAvailable;
  final Function(bool) onAvailabilityChanged;

  const CustomDrawer({
    super.key,
    required this.avatarUrl,
    required this.professionalName,
    required this.isAvailable,
    required this.onAvailabilityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 230,
            child: DrawerHeader(

                decoration: const BoxDecoration(
                  color: Strings.mainColor,
                ),
                child: Column(
                  children: [
                    ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(avatarUrl),
                        ),
                        title: Text(professionalName, style: const TextStyle(fontSize: 12, color: Colors.white),),
                        subtitle: Text(isAvailable ? 'Available' : 'Not Available', style: const TextStyle(fontSize: 10, color: Colors.white)),
                        ),
                    Switch(
                      value: isAvailable,
                      onChanged: onAvailabilityChanged,
                    ),
                    TextButton(onPressed: (){}, child: const Text('My Account', style: TextStyle(color: Colors.white),))
                  ],
                )),
          )
          // Add more ListTile widgets for other menu items as needed
        ],
      ),
    );
  }
}
