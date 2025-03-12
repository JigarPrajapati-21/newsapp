import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/theme_controller.dart';
import '../about_app_screen.dart';
import 'bookmark_screen.dart';

class ProfileScreen extends StatelessWidget {
  // final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Colors.blue.shade700;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background Gradient with modern curve
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, Colors.blue.shade900],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 15),
                  // Profile Header
                  _buildProfileHeader(context),
                  SizedBox(height: 30),
                  // Profile Options
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15, bottom: 10),
                            child: Text(
                              "Settings",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          _buildProfileOption(
                            icon: Icons.bookmark_rounded,
                            label: 'Saved Articles',
                            onTap: () {
                              Get.to(SavedArticlesScreen());
                            },
                            context: context,
                            primaryColor: primaryColor,
                          ),
                          _buildProfileOption(
                            icon: Icons.info_rounded,
                            label: 'About App',
                            onTap: () {
                              Get.to(const AboutAppScreen());
                            },
                            context: context,
                            primaryColor: primaryColor,
                          ),
                          _buildProfileOption(
                            icon: Icons.logout_rounded,
                            label: 'Logout',
                            onTap: () {
                              // Show logout confirmation dialog
                              _showLogoutDialog(context);
                            },
                            context: context,
                            primaryColor: primaryColor,
                            isLast: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Dark-light Theme Toggle Card
                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 20),
                  //   decoration: BoxDecoration(
                  //     color: Theme.of(context).cardColor,
                  //     borderRadius: BorderRadius.circular(20),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.black.withOpacity(0.05),
                  //         blurRadius: 10,
                  //         spreadRadius: 1,
                  //       ),
                  //     ],
                  //   ),
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  //     child: Row(
                  //       children: [
                  //         Icon(
                  //           themeController.isDarkMode.value ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                  //           color: primaryColor,
                  //           size: 24,
                  //         ),
                  //         SizedBox(width: 15),
                  //         Expanded(
                  //           child: Text(
                  //             "Dark Mode",
                  //             style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  //                 fontSize: 16, fontWeight: FontWeight.w500
                  //             ),
                  //           ),
                  //         ),
                  //         Obx(() => Switch(
                  //           value: themeController.isDarkMode.value,
                  //           onChanged: (value) {
                  //             themeController.toggleTheme();
                  //           },
                  //           activeColor: primaryColor,
                  //         )),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  SizedBox(height: 20),

                  // // Social Links
                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 20),
                  //   padding: EdgeInsets.symmetric(vertical: 15),
                  //   decoration: BoxDecoration(
                  //     color: Theme.of(context).cardColor,
                  //     borderRadius: BorderRadius.circular(20),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.black.withOpacity(0.05),
                  //         blurRadius: 10,
                  //         spreadRadius: 1,
                  //       ),
                  //     ],
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       _buildSocialIcon(Icons.mail_outline_rounded, primaryColor),
                  //       _buildSocialIcon(Icons.phone_rounded, primaryColor),
                  //       _buildSocialIcon(Icons.facebook_rounded, primaryColor),
                  //       _buildSocialIcon(Icons.share_rounded, primaryColor),
                  //     ],
                  //   ),
                  // ),

                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Column(
      children: [
        // Profile Picture with ring effect
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 60,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue.shade50,
              backgroundImage: AssetImage('assets/dp1.png'),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Jigar Prajapati',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.email, color: Colors.white, size: 16),
              SizedBox(width: 8),
              Text(
                'jigar@gmail.com',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.phone, color: Colors.white, size: 16),
              SizedBox(width: 8),
              Text(
                '+91 9016770858',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required BuildContext context,
    required Color primaryColor,
    bool isLast = false,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: primaryColor, size: 22),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.grey.shade400, size: 16),
              ],
            ),
          ),
        ),
        if (!isLast)
          Divider(
            color: Colors.grey.withOpacity(0.2),
            indent: 60,
            endIndent: 20,
          ),
      ],
    );
  }

  // Widget _buildSocialIcon(IconData icon, Color color) {
  //   return Container(
  //     padding: EdgeInsets.all(12),
  //     decoration: BoxDecoration(
  //       color: color.withOpacity(0.1),
  //       shape: BoxShape.circle,
  //     ),
  //     child: Icon(
  //       icon,
  //       color: color,
  //       size: 22,
  //     ),
  //   );
  // }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?",style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 16, fontWeight: FontWeight.w500
          ),),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle logout logic here
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}


