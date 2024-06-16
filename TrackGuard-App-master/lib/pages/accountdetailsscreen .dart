import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({super.key});

  @override
  _AccountDetailsScreenState createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  final _usernameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _imei1Controller = TextEditingController();
  final _imei2Controller = TextEditingController();

  bool _isEditing = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneNumberController.dispose();
    _imei1Controller.dispose();
    _imei2Controller.dispose();
    super.dispose();
  }

  Future<void> _fetchUserData() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

    setState(() {
      _usernameController.text = userData['username'] ?? '';
      _phoneNumberController.text = userData['phone_number'] ?? '';
      _imei1Controller.text = userData['imei1'] ?? '';
      _imei2Controller.text = userData['imei2'] ?? '';
    });
  }

  Future<void> _updateUserData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({
      'username': _usernameController.text,
      'phone_number': _phoneNumberController.text,
      'imei1': _imei1Controller.text,
      'imei2': _imei2Controller.text,
    });
    setState(() {
      _isEditing = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('User data updated successfully')),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Details'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: _isEditing
                ? _updateUserData
                : () {
                    setState(() {
                      _isEditing = true;
                    });
                  },
          ),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No user data found.'));
          }

          Map<String, dynamic> userData =
              snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildEditableField(
                  label: 'Username',
                  controller: _usernameController,
                  isEditing: _isEditing,
                ),
                const SizedBox(height: 16),
                _buildEditableField(
                  label: 'Email',
                  controller: TextEditingController(text: userData['email']),
                  isEditing: false,
                ),
                const SizedBox(height: 16),
                _buildEditableField(
                  label: 'Phone',
                  controller: _phoneNumberController,
                  isEditing: _isEditing,
                ),
                const SizedBox(height: 16),
                _buildEditableField(
                  label: 'IMEI 1',
                  controller: _imei1Controller,
                  isEditing: _isEditing,
                ),
                const SizedBox(height: 16),
                _buildEditableField(
                  label: 'IMEI 2',
                  controller: _imei2Controller,
                  isEditing: _isEditing,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    required bool isEditing,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          enabled: isEditing,
          decoration: InputDecoration(
            filled: true,
            fillColor: isEditing ? Colors.white : Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[400]!,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.blue,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          style: TextStyle(
            color: isEditing ? Colors.black : Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
