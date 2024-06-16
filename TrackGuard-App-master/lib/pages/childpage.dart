import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class CustomCallLogEntry {
  String number;
  int duration;
  int timestamp;
  String callType;

  CustomCallLogEntry({
    required this.number,
    required this.duration,
    required this.timestamp,
    required this.callType,
  });

  // Method to convert CustomCallLogEntry object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'duration': duration,
      'timestamp': timestamp,
      'callType': callType,
    };
  }
}

class ChildTrackerScreen extends StatefulWidget {
  const ChildTrackerScreen({super.key});

  @override
  _ChildTrackerScreenState createState() => _ChildTrackerScreenState();
}

class _ChildTrackerScreenState extends State<ChildTrackerScreen> {
  List<CustomCallLogEntry> _callLogs = [];
  bool _loading = false;
  bool _showCallLogs = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchCallLogs();
    _schedulePeriodicFetch();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _schedulePeriodicFetch() {
    _timer = Timer.periodic(const Duration(hours: 24), (timer) {
      _fetchCallLogs();
    });
  }

  Future<void> _fetchCallLogs() async {
    setState(() {
      _loading = true;
    });

    var permission = await Permission.phone.status;
    if (permission.isDenied) {
      permission = await Permission.phone.request();
    }

    if (permission.isGranted) {
      try {
        final FirebaseAuth _auth = FirebaseAuth.instance;
        final User? user = _auth.currentUser;

        if (user != null) {
          DocumentSnapshot<Map<String, dynamic>> userDoc =
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .get();

          if (userDoc.exists) {
            String? selectedDeviceType = userDoc.get('deviceType');

            if (selectedDeviceType == 'base_phone') {
              // Fetch call logs from the device
              final Iterable<CallLogEntry> result = await CallLog.query(
                // Adjust the date range as needed
                dateFrom: DateTime.now()
                    .subtract(const Duration(days: 15))
                    .millisecondsSinceEpoch,
                dateTo: DateTime.now().millisecondsSinceEpoch,
              );

              // Convert call logs to CustomCallLogEntry objects
              List<CustomCallLogEntry> callLogs = result
                  .map((log) => CustomCallLogEntry(
                        number: log.number ?? '',
                        duration: log.duration ?? 0,
                        timestamp: log.timestamp ?? 0,
                        callType: (log.callType ?? '').toString(),
                      ))
                  .toList();

              // Save call logs to Firebase Firestore
              await saveCallLogsToFirebase(user.uid, callLogs);

              setState(() {
                _callLogs = callLogs;
                _showCallLogs = true;
                _loading = false;
              });
            } else if (selectedDeviceType == 'track_phone') {
              // Fetch call logs from Firebase Firestore
              List<CustomCallLogEntry> callLogs =
                  await getCallLogsFromFirebase(user.uid);

              setState(() {
                _callLogs = callLogs;
                _showCallLogs = true;
                _loading = false;
              });
            }
          } else {
            print('User document does not exist');
          }
        } else {
          print('User not logged in');
        }
      } catch (e) {
        print('Failed to get call logs: $e');
        setState(() {
          _loading = false;
        });
      }
    } else {
      print('Permission denied');
      setState(() {
        _loading = false;
      });
    }
  }

  // Method to save call logs to Firebase Firestore
  Future<void> saveCallLogsToFirebase(
      String userId, List<CustomCallLogEntry> callLogs) async {
    try {
      await FirebaseFirestore.instance
          .collection('call_logs')
          .doc(userId)
          .set({'callLogs': callLogs.map((log) => log.toJson()).toList()});
    } catch (e) {
      print('Error saving call logs to Firebase Firestore: $e');
    }
  }

  // Method to retrieve call logs from Firebase Firestore
  Future<List<CustomCallLogEntry>> getCallLogsFromFirebase(
      String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('call_logs')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        List<dynamic> callLogsData = snapshot.get('callLogs');
        List<CustomCallLogEntry> callLogs = callLogsData.map((data) {
          return CustomCallLogEntry(
            number: data['number'] as String,
            duration: data['duration'] as int,
            timestamp: data['timestamp'] as int,
            callType: data['callType'] as String,
          );
        }).toList();
        return callLogs;
      } else {
        print('No call logs found for user: $userId');
        return [];
      }
    } catch (e) {
      print('Error retrieving call logs: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Child Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _fetchCallLogs,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.all(16),
                child: const Center(
                  child: Text(
                    'Fetch Call Logs',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _loading
                ? const Center(child: CircularProgressIndicator())
                : _showCallLogs
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: _callLogs.length,
                          itemBuilder: (context, index) {
                            final callLog = _callLogs[index];
                            return ListTile(
                              title: Text('Number: ${callLog.number}'),
                              subtitle: Text(
                                'Duration: ${callLog.duration} seconds\nDate: ${DateTime.fromMillisecondsSinceEpoch(callLog.timestamp)}\nType: ${callLog.callType}',
                              ),
                            );
                          },
                        ),
                      )
                    : const Center(
                        child: Text('Tap the button to fetch call logs')),
          ],
        ),
      ),
    );
  }
}
