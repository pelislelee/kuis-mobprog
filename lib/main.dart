import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // State untuk tema aplikasi
  ThemeData _currentTheme = ThemeData.light();
  TextStyle _currentTextStyle = const TextStyle(
    fontFamily: 'sour', // Nama font sesuai yang ada di pubspec.yaml
    fontSize: 20,
    fontWeight: FontWeight.bold, // Optional, jika ingin mengatur berat font
  );

  // Daftar tema
  final ThemeData _cinamorollTheme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: const Color.fromARGB(255, 199, 226, 239),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black, fontSize: 16),
    ),
  );

  final ThemeData _myMelodyTheme = ThemeData(
    primarySwatch: Colors.pink,
    scaffoldBackgroundColor: const Color.fromARGB(255, 255, 204, 229),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white, fontSize: 16),
    ),
  );

  final ThemeData _pomPomPurinTheme = ThemeData(
    primarySwatch: Colors.amber,
    scaffoldBackgroundColor: const Color.fromARGB(255, 255, 243, 204),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.brown, fontSize: 16),
    ),
  );

  // Method untuk mengubah tema dan font
  void _changeTheme(String theme, String font) {
    setState(() {
      switch (theme) {
        case 'Cinamoroll':
          _currentTheme = _cinamorollTheme;
          break;
        case 'My Melody':
          _currentTheme = _myMelodyTheme;
          break;
        case 'Pom Pom Purin':
          _currentTheme = _pomPomPurinTheme;
          break;
      }
      // Mengubah font sesuai pilihan
      _currentTextStyle = _getTextStyle(font);
    });
  }

  // Fungsi untuk mendapatkan text style dari font yang dipilih
  TextStyle _getTextStyle(String font) {
    switch (font) {
      case 'Edu':
        return const TextStyle(
          fontFamily: 'edu', // Nama font sesuai yang ada di pubspec.yaml
          fontSize: 16,
          fontWeight: FontWeight.normal,
        );
      case 'Sour':
        return const TextStyle(
          fontFamily: 'sour', // Nama font sesuai yang ada di pubspec.yaml
          fontSize: 16,
          fontWeight: FontWeight.normal,
        );
      case 'Inconsolata':
        return const TextStyle(
          fontFamily: 'inconsolata', // Nama font sesuai yang ada di pubspec.yaml
          fontSize: 16,
          fontWeight: FontWeight.normal,
        );
      default:
        return const TextStyle(
          fontFamily: 'Roboto', // Default font, misalnya Roboto
          fontSize: 16,
          fontWeight: FontWeight.normal,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: _currentTheme, // Tema dinamis
      home: MyHomePage(
        onThemeChanged: _changeTheme,
        currentTextStyle: _currentTextStyle,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final Function(String, String) onThemeChanged;
  final TextStyle currentTextStyle;

  const MyHomePage({super.key, required this.onThemeChanged, required this.currentTextStyle});

  @override
  Widget build(BuildContext context) {
    // Menentukan gambar berdasarkan tema yang aktif
    String imageAsset = '';
    String textBelow = '';

    if (Theme.of(context).scaffoldBackgroundColor == const Color.fromARGB(255, 199, 226, 239)) {
      imageAsset = 'lib/cinamoroll.jpg';
      textBelow = 'Hi! I am Cinamoroll';
    } else if (Theme.of(context).scaffoldBackgroundColor == const Color.fromARGB(255, 255, 204, 229)) {
      imageAsset = 'lib/mymelody.jpg';
      textBelow = 'Hi! I am My Melody';
    } else if (Theme.of(context).scaffoldBackgroundColor == const Color.fromARGB(255, 255, 243, 204)) {
      imageAsset = 'lib/pompom.jpg';
      textBelow = 'Hi! I am Pom Pom Purin';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        leading: IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsScreen(onThemeChanged: onThemeChanged),
              ),
            );
          },
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imageAsset,
              height: 200,
              width: 400,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 40),
            Text(
              textBelow,
              style: currentTextStyle.copyWith(fontSize: 20), // Menampilkan teks dengan font yang dipilih
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final Function(String, String) onThemeChanged;

  const SettingsScreen({super.key, required this.onThemeChanged});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedTheme = 'Cinamoroll'; // Default tema
  String _selectedFont = 'sour'; // Default font

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Theme:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            RadioListTile<String>(
              title: const Text('Cinamoroll'),
              value: 'Cinamoroll',
              groupValue: _selectedTheme,
              onChanged: (value) {
                setState(() {
                  _selectedTheme = value!;
                  widget.onThemeChanged(value, _selectedFont);
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('My Melody'),
              value: 'My Melody',
              groupValue: _selectedTheme,
              onChanged: (value) {
                setState(() {
                  _selectedTheme = value!;
                  widget.onThemeChanged(value, _selectedFont);
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Pom Pom Purin'),
              value: 'Pom Pom Purin',
              groupValue: _selectedTheme,
              onChanged: (value) {
                setState(() {
                  _selectedTheme = value!;
                  widget.onThemeChanged(value, _selectedFont);
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Font:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            RadioListTile<String>(
              title: const Text('Sour'),
              value: 'Sour',
              groupValue: _selectedFont,
              onChanged: (value) {
                setState(() {
                  _selectedFont = value!;
                  widget.onThemeChanged(_selectedTheme, value);
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Edu'),
              value: 'Edu',
              groupValue: _selectedFont,
              onChanged: (value) {
                setState(() {
                  _selectedFont = value!;
                  widget.onThemeChanged(_selectedTheme, value);
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Inconsolata'),
              value: 'Inconsolata',
              groupValue: _selectedFont,
              onChanged: (value) {
                setState(() {
                  _selectedFont = value!;
                  widget.onThemeChanged(_selectedTheme, value);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
