import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models/government_agency.dart';

class GovernmentAgencyDetailPage extends StatelessWidget {
  final GovernmentAgency agency;

  const GovernmentAgencyDetailPage({Key? key, required this.agency}) : super(key: key);

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunch(launchUri.toString())) {
      await launch(launchUri.toString());
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  Future<void> _openMaps(String address) async {
    final String mapsUrl = 'https://www.google.com/maps/search/?api=1&query=${Uri.encodeFull(address)}';
    if (await canLaunch(mapsUrl)) {
      await launch(mapsUrl);
    } else {
      throw 'Could not open Maps with $address';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          agency.title,
          style: TextStyle(fontSize: 20),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          textAlign: TextAlign.center,
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
            GestureDetector(
              onTap: () => _makePhoneCall(agency.tel),
              child: Text(
                'Tel: ${agency.tel}',
                style: TextStyle(fontSize: 18, color: Colors.blue, decoration: TextDecoration.underline),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Email: ${agency.email}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () => _openMaps(agency.address),
              child: Text(
                'Address: ${agency.address}',
                style: TextStyle(fontSize: 18, color: Colors.blue, decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}








