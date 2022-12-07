import 'package:flutter/material.dart';

import '../../models/settings_model.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final List<SettingsItemModel> settings = [
    SettingsItemModel(text: "Amazon", icon: Icons.person),
    SettingsItemModel(text: "Amazon", icon: Icons.person),
    SettingsItemModel(text: "Amazon", icon: Icons.person),
    SettingsItemModel(text: "Amazon", icon: Icons.person),
    SettingsItemModel(text: "Amazon", icon: Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.menu),
        title: const Text("Home"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 20),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: settings.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 139, 167, 205),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(settings[index].icon),
                              const SizedBox(width: 15),
                              Text(
                                settings[index].text.toString(),
                                style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                          Icon(
                            Icons.abc_outlined
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
