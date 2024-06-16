import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class MobileMisplaceScreen extends StatefulWidget {
  const MobileMisplaceScreen({super.key});

  @override
  State createState() => _MobileMisplaceScreenState();
}

class _MobileMisplaceScreenState extends State<MobileMisplaceScreen> {
  String? imei1;
  String? imei2;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchIMEINumbers();
  }

  Future<void> fetchIMEINumbers() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      setState(() {
        imei1 = userDoc['imei1'];
        imei2 = userDoc['imei2'];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle the error appropriately in your app
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'How to file a complaint for a lost phone:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '1. Ensure you have the IMEI number of your lost phone.\n'
                    '2. Click the link below to file a complaint.\n'
                    '3. Provide the necessary details, including the IMEI number.\n'
                    '4. Submit the complaint and follow further instructions.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  if (imei1 != null)
                    GestureDetector(
                      onLongPress: () => _copyToClipboard(imei1!),
                      child: Text(
                        'IMEI Number 1: $imei1',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  if (imei2 != null)
                    GestureDetector(
                      onLongPress: () => _copyToClipboard(imei2!),
                      child: Text(
                        'IMEI Number 2: $imei2',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Open the link to file a complaint
                      launchComplaintForm();
                    },
                    child: const Text('File Complaint'),
                  ),
                ],
              ),
            ),
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void launchComplaintForm() async {
    // Launch the URL for filing a complaint
    const url =
        'https://www.ceir.gov.in/Request/CeirUserBlockRequestDirect.jsp';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
