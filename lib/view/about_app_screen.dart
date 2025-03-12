import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  // Method to launch URLs
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About App'),
        // foregroundColor: Colors.white,
        // backgroundColor: Colors.blue.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/logo.png'), // Add your app logo
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'App Name: NewsApp',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
             Text(
              'Version: 1.0.0',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 16
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'About:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'NewsApp is a  news app that allows users to browse the latest news articles from various sources, read detailed articles, and save their favorite articles for offline access. Stay updated with breaking news and trending topics from around the world.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Developer:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Developed by Jigar, a passionate Flutter developer aiming to provide the latest news updates with a seamless user experience.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.web, color: Colors.blue),
                  onPressed: () {
                    _launchURL('https://yourwebsite.com'); // Replace with your website URL
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.privacy_tip, color: Colors.blue),
                  onPressed: () {
                    _launchURL('https://yourprivacypolicy.com'); // Replace with your privacy policy URL
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.email, color: Colors.blue),
                  onPressed: () {
                    _launchURL('mailto:developer@example.com'); // Replace with your email
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
