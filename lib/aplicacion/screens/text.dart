import 'package:flutter/material.dart';

const List<Widget> partes = <Widget>[
  Text('Mangas'),
  Text('Torso'),
  Text('Espalda'),
  //Text('Pecho')
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 98, 54, 244)),
        useMaterial3: true,
      ),
      home: const TextPage(title: 'Text Page'),
    );
  }
}

class TextPage extends StatefulWidget {
  const TextPage({super.key, required this.title});

  final String title;

  @override
  State<TextPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TextPage> {
  final List<bool> _selectedPartes = <bool>[true, false, false];
  String seleccion = "test";
  String textito = "";
  TextEditingController myController = TextEditingController();

  void textinho(String s) {
    setState(() {
      textito = s;
      myController.text = "";
    });
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DefaultTextStyle.merge(
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                child: Center(
                  child: Text(textito),
                ),
              ),
            ),
//            Padding(
//              padding: const EdgeInsets.all(16.0),
//              child: DefaultTextStyle.merge(
//                style: const TextStyle(
//                  fontSize: 24,
//                  fontWeight: FontWeight.bold,
//                ),
//                child: Center(
//                  child: Text(seleccion),
//                ),
//              ),
//            ),
            ToggleButtons(
              direction: Axis.horizontal,
              onPressed: (int index) {
                setState(() {
                  // The button that is tapped is set to true, and the others to false.

                  for (int i = 0; i < _selectedPartes.length; i++) {
                    _selectedPartes[i] = i == index;
                    if (_selectedPartes[i]) {
                      seleccion = partes[i].toString().split('"')[1];
                      //"Mangas", "Pecho", "Espalda"
                    }
                  }
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.red[700],
              selectedColor: Colors.white,
              fillColor: Colors.red[200],
              color: Colors.red[400],
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              isSelected: _selectedPartes,
              children: partes,
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: SizedBox(
                width: 250,
                child: TextField(
                  controller: myController,
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Texto',
                  ),
                ),
              ),
            ),
            TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return Colors.blue.withOpacity(0.04);
                      }
                      if (states.contains(MaterialState.focused) ||
                          states.contains(MaterialState.pressed)) {
                        return Colors.blue.withOpacity(0.12);
                      }
                      return null; // Defer to the widget's default.
                    },
                  ),
                ),
                onPressed: () {
                  textito = myController.text;
                  textinho(textito);
                  //print(textito);
                },
                child: const Text('Enter')),
          ],
        ),
      ),
    );
  }
}
