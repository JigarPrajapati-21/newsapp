import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../about_app_screen.dart';
import 'bookmark_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade900, Colors.blue.shade300],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Profile Image and Info
                  Container(

                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child:  Column(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 65,

                            backgroundColor: Colors.blue.shade50,
                            backgroundImage: const AssetImage(
                              'assets/dp1.png',
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Jigar Prajapati',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'jigar@gmail.com',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          '+91 9016770858',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Profile Options in a clean, modern list style
                  Container(
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildProfileOption(
                          icon: Icons.bookmark_outline,
                          label: 'Saved Articles',
                          onTap: () {
                            Get.to(SavedArticlesScreen());
                          },
                        ),
                        const Divider(),
                        _buildProfileOption(
                          icon: Icons.info_outline,
                          label: 'About App',
                          onTap: () {
                            Get.to(const AboutAppScreen());
                          },
                        ),
                        const Divider(),
                        _buildProfileOption(
                          icon: Icons.logout,
                          label: 'Logout',
                          onTap: () {
                            // Handle logout tap
                          },
                        ),

                        const Divider(),



                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.blueAccent, size: 30),
            const SizedBox(width: 20),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }
}


