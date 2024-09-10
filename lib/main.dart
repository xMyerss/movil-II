import 'package:flutter/material.dart';
import 'package:phone_app/screens/InputAndText.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of screens to display in the navigation bar
  final List<Widget> _screens = [
    const InputAndText(),
    const StudentTableScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.text_fields),
            label: 'Stateless Widget',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Contacts',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}

class StudentTableScreen extends StatelessWidget {
  const StudentTableScreen({super.key});

  void _makePhoneCall(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Contact List'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 15.0,
                columns: const [
                  DataColumn(label: Text('Name', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Phone Number', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Matricula', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                rows: [
                  _buildDataRow('Jorge', '9614106069', '213500'),
                  _buildDataRow('Ramirez', '9614491891', '221260'),
                  _buildDataRow('Pedro', '9616665782', '213537'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DataRow _buildDataRow(String name, String phoneNumber, String matricula) {
    return DataRow(
      cells: [
        DataCell(Text(name)),
        DataCell(
          TextButton(
            onPressed: () => _makePhoneCall(phoneNumber),
            child: Text(phoneNumber, style: const TextStyle(color: Colors.blue)),
          ),
        ),
        DataCell(Text(matricula)),
        DataCell(IconButton(onPressed: () => _makePhoneCall(phoneNumber), icon: const Icon(Icons.phone)))
      ],
    );
  }
}
