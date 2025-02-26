import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart'; // Assurez-vous d'importer le package WebView
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/questionnaire_screen.dart';
import 'screens/firstpage_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APK TOURIST',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/questionnaire': (context) => QuestionnaireScreen(),
        '/firstpage': (context) => FirstPageScreen(),
        '/webview': (context) => WebViewScreen(), // Utilisation de WebViewScreen
      },
    );
  }
}

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});
 // Modifiez ici pour étendre StatefulWidget
  @override
  // ignore: library_private_types_in_public_api
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {

  @override
  void initState() {
    super.initState();
    // Initialisation spécifique pour Android
    if (WebViewPlatform.instance is SurfaceAndroidWebView) {
      WebViewPlatform.instance = SurfaceAndroidWebView() as WebViewPlatform?;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Web View'),
      ),
      body: WebView(
        initialUrl: 'https://votre-site-web.com', // Remplacez par votre URL
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller) {
        },
      ),
    );
  }
  
  // ignore: non_constant_identifier_names
  WebView({required String initialUrl, required javascriptMode, required Null Function(WebViewController controller) onWebViewCreated}) {}
}

class JavascriptMode {
  // ignore: prefer_typing_uninitialized_variables
  static var unrestricted;
}

class SurfaceAndroidWebView {
}