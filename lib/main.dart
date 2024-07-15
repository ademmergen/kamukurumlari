import 'package:flutter/material.dart';
import 'services/government_service.dart'; 
import 'models/government_agency.dart';
import 'government_agency_detail_page.dart';

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
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GovernmentService _service = GovernmentService();
  List<GovernmentAgency> _agencies = [];
  List<GovernmentAgency> _filteredAgencies = [];
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
          _filteredAgencies = agencies;
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

  void _filterAgencies(String query) {
    final filtered = _agencies.where((agency) {
      final titleLower = agency.title.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      _filteredAgencies = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kamu Kurumları'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterAgencies,
              decoration: const InputDecoration(
                hintText: 'Ara...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text('Error: $_errorMessage'))
              : ListView.builder(
                  itemCount: _filteredAgencies.length,
                  itemBuilder: (context, index) {
                    final agency = _filteredAgencies[index];
                    return ListTile(
                      title: Text(agency.title),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GovernmentAgencyDetailPage(agency: agency),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}


