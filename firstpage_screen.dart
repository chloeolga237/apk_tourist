import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FirstPageScreen extends StatefulWidget {
  const FirstPageScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FirstPageScreenState createState() => _FirstPageScreenState();
}

class _FirstPageScreenState extends State<FirstPageScreen> {
  // État des icônes
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
                'Cookies are small text files that are used to store small pieces of information. They are stored on your device when the website is loaded on your browser. These cookies help us make the website function properly, make it more secure, and provide better user experience.',
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
              Navigator.of(context).pop(); // Refuser les cookies
            },
            child: Text('Decline'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Accepter les cookies
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
              // Gérer les actions de menu ici
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'voyages', child: Text('Voyages')),
              PopupMenuItem(value: 'avis', child: Text('Écrire un avis')),
              PopupMenuItem(value: 'profil', child: Text('Profil')),
              PopupMenuItem(value: 'reservations', child: Text('Réservations')),
              PopupMenuItem(value: 'messages', child: Text('Messages')),
              PopupMenuItem(value: 'infos_compte', child: Text('Informations sur le compte')),
              PopupMenuItem(value: 'deconnexion', child: Text('Se déconnecter')),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Votre contenu existant
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Publicité',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Lieux où aller, choses à faire, hôtels...',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            // Barre de recherche
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Recherchez...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  DropdownButton<String>(
                    items: [
                      DropdownMenuItem(value: 'Hôtels', child: Text('Hôtels')),
                      DropdownMenuItem(value: 'Choses à faire', child: Text('Choses à faire')),
                      DropdownMenuItem(value: 'Restaurants', child: Text('Restaurants')),
                      DropdownMenuItem(value: 'Vols', child: Text('Vols')),
                      DropdownMenuItem(value: 'Locations de vacances', child: Text('Locations de vacances')),
                    ],
                    onChanged: (value) {
                      // Gérer le changement de sélection
                    },
                    hint: Text('Sélectionner'),
                  ),
                ],
              ),
            ),
            // Destinations populaires
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Destinations Populaires',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 200, // Hauteur pour les images
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
            // Section des recommandations
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Recommandations',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            // Liste d'avis ou recommandations
            _buildRecommendationTile('Visitez la Tour Eiffel', 4.5),
            _buildRecommendationTile('Explorez Central Park', 4.7),
            _buildRecommendationTile('Dégustez des sushis à Tokyo', 4.9),
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
              'Informations de contact',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Email: contact@apktourist.com',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 4),
            Text(
              'Téléphone: +33 1 23 45 67 89',
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
                        // Action pour les options
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
        // Action pour la recommandation
      },
    );
  }
}