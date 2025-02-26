import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _progress = 0.0; // Pour suivre la progression de la barre

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3), // Durée de l'animation
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startLoading() {
    _controller.forward(from: 0.0); // Démarre l'animation

    // Simule un chargement
    _controller.addListener(() {
      setState(() {
        _progress = _controller.value; // Met à jour la progression
      });
    });

    // Navigue vers la page de connexion après le chargement
    Future.delayed(const Duration(seconds: 3), () {
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/login');
      _controller.reset(); // Reset l'animation
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black, // Fond noir
        child: Stack(
          children: [
            // Formes abstraites
            Positioned(
              top: 100,
              left: 50,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // ignore: deprecated_member_use
                  color: Colors.purple.withOpacity(0.5),
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              right: 50,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(75),
                  // ignore: deprecated_member_use
                  color: Colors.orange.withOpacity(0.5),
                ),
              ),
            ),
            // Contenu principal
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to Your APK Tourist',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '...',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _startLoading, // Appel de la méthode pour charger
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Couleur du bouton
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Get Started',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Barre de chargement
                  SizedBox(
                    width: 250,
                    child: LinearProgressIndicator(
                      value: _progress,
                      backgroundColor: Colors.grey[800],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Train (représentation simple)
                  SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.train, color: Colors.white),
                        SizedBox(width: 5),
                        Text(
                          'Loading...',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}