import 'package:flutter/material.dart';
import 'package:tutory/services/auth.dart';

class AdminSettings extends StatefulWidget {
  const AdminSettings({Key? key}) : super(key: key);

  @override
  State<AdminSettings> createState() => _AdminSettingsState();
}

class _AdminSettingsState extends State<AdminSettings> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: size.height / 8,
          ),
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(
                  Icons.person,
                  size: 140,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await AuthService().signOut();
                    },
                    child: const Text('Logout'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
