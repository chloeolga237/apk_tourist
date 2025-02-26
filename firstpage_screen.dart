import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FirstPageScreen extends StatefulWidget {
  const FirstPageScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FirstPageScreenState createState() => _FirstPageScreenState();
}

class _FirstPageScreenState extends State<FirstPageScreen> {
  // State of the icons
  Map<String, bool> likedDestinations = {};
  Map<String, bool> favoriteDestinations = {};

  void _showCookieConsentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Accept Cookies'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What Are Cookies?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Cookies are small text files used to store small pieces of information. They are stored on your device when the website is loaded in your browser. These cookies help us make the website function properly, make it more secure, and provide a better user experience.',
              ),
              SizedBox(height: 16),
              Text(
                'Why Do We Use Cookies?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'When you use our website, we may collect information using cookies to improve our service. Cookies allow us to remember your preferences and recognize you on future visits. They help us analyze how our website is being used, which helps us optimize our content and functionality.',
              ),
              SizedBox(height: 16),
              Text(
                'Privacy Policy',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'By accepting cookies, you agree to our privacy policy. We are committed to protecting your data and ensuring that it is used responsibly. You can read our full privacy policy on our website, which explains how we handle your personal information.',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Decline cookies
            },
            child: Text('Decline'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Accept cookies
            },
            child: Text('Accept'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showCookieConsentDialog(context);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('APK TOURIST'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle menu actions here
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'trips', child: Text('Trips')),
              PopupMenuItem(value: 'write_review', child: Text('Write a Review')),
              PopupMenuItem(value: 'profile', child: Text('Profile')),
              PopupMenuItem(value: 'reservations', child: Text('Reservations')),
              PopupMenuItem(value: 'messages', child: Text('Messages')),
              PopupMenuItem(value: 'account_info', child: Text('Account Information')),
              PopupMenuItem(value: 'logout', child: Text('Log Out')),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Your existing content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Advertisement',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Places to go, things to do, hotels...',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  DropdownButton<String>(
                    items: [
                      DropdownMenuItem(value: 'Hotels', child: Text('Hotels')),
                      DropdownMenuItem(value: 'Things to Do', child: Text('Things to Do')),
                      DropdownMenuItem(value: 'Restaurants', child: Text('Restaurants')),
                      DropdownMenuItem(value: 'Flights', child: Text('Flights')),
                      DropdownMenuItem(value: 'Vacation Rentals', child: Text('Vacation Rentals')),
                    ],
                    onChanged: (value) {
                      // Handle selection change
                    },
                    hint: Text('Select'),
                  ),
                ],
              ),
            ),
            // Popular Destinations
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Popular Destinations',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 200, // Height for images
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildDestinationCard('Paris', 'assets/paris.jpg'),
                  _buildDestinationCard('New York', 'assets/new_york.jpg'),
                  _buildDestinationCard('Tokyo', 'assets/tokyo.jpg'),
                  _buildDestinationCard('Rome', 'assets/rome.jpg'),
                ],
              ),
            ),
            // Recommendations section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Recommendations',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            // List of reviews or recommendations
            _buildRecommendationTile('Visit the Eiffel Tower', 4.5),
            _buildRecommendationTile('Explore Central Park', 4.7),
            _buildRecommendationTile('Enjoy sushi in Tokyo', 4.9),
          ],
        ),
      ),
      drawer: Container(
        // ignore: deprecated_member_use
        color: Colors.blue[900]?.withOpacity(0.8),
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Contact Information',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Email: contact@apktourist.com',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 4),
            Text(
              'Phone: +33 1 23 45 67 89',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDestinationCard(String title, String imagePath) {
    bool isLiked = likedDestinations[title] ?? false;
    bool isFavorite = favoriteDestinations[title] ?? false;

    return Card(
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                imagePath,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 8,
                left: 8,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.thumb_up,
                        color: isLiked ? Colors.blue : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          likedDestinations[title] = !isLiked;
                        });
                      },
                    ),
                    SizedBox(width: 4),
                    IconButton(
                      icon: Icon(
                        Icons.star,
                        color: isFavorite ? Colors.yellow : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          favoriteDestinations[title] = !isFavorite;
                        });
                      },
                    ),
                    SizedBox(width: 4),
                    IconButton(
                      icon: Icon(Icons.more_vert, color: Colors.white),
                      onPressed: () {
                        // Action for options
                        if (kDebugMode) {
                          print('Options for $title');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationTile(String title, double rating) {
    return ListTile(
      title: Text(title),
      trailing: Text(rating.toString(), style: TextStyle(color: Colors.green)),
      onTap: () {
        // Action for the recommendation
      },
    );
  }
}