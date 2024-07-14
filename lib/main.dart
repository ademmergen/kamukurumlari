import 'package:flutter/material.dart';
import 'services/government_service.dart'; // GovernmentService'in doğru yolu
import 'models/government_agency.dart'; // GovernmentAgency'i içe aktarıyoruz

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kamu Kurumları',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState(); // _HomePageState yerine HomePageState
}

class HomePageState extends State<HomePage> { // _HomePageState yerine HomePageState
  final GovernmentService _service = GovernmentService();
  List<GovernmentAgency> _agencies = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchAgencies();
  }

  Future<void> _fetchAgencies() async {
    try {
      await _service.fetchGovernmentAgencies().then((agencies) {
        setState(() {
          _agencies = agencies;
          _isLoading = false;
        });
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kamu Kurumları'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text('Error: $_errorMessage'))
              : ListView.builder(
                  itemCount: _agencies.length,
                  itemBuilder: (context, index) {
                    final agency = _agencies[index];
                    return ListTile(
                      title: Text(agency.title),
                    );
                  },
                ),
    );
  }
}

