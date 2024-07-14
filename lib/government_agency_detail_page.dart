 import 'package:flutter/material.dart';
 import 'models/government_agency.dart';

class GovernmentAgencyDetailPage extends StatelessWidget {
  final GovernmentAgency agency;

  const GovernmentAgencyDetailPage({Key? key, required this.agency}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Flexible(
          child: Text(
            agency.title,
            style: TextStyle(fontSize: 20),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Code: ${agency.code}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Link: ${agency.link}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Tel: ${agency.tel}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Email: ${agency.email}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Address: ${agency.address}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

