import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'page_form.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Biodata Form',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF315B7D)),
          scaffoldBackgroundColor: const Color(0xFFF4F6F8),
        ),
        home: const FormPage(),
      );
}

class BiodataFormPage extends StatefulWidget {
  const BiodataFormPage({super.key});

  @override
  State<BiodataFormPage> createState() => _BiodataFormPageState();
}

class _BiodataFormPageState extends State<BiodataFormPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Map<String, TextEditingController> _fields = {
    'Full name': TextEditingController(),
    'Date of birth': TextEditingController(),
    'Age': TextEditingController(),
    'Gender': TextEditingController(),
    'Civil status': TextEditingController(),
    'Nationality': TextEditingController(),
    'Address': TextEditingController(),
    'Phone number': TextEditingController(),
    'Email': TextEditingController(),
    'College': TextEditingController(),
    'Senior high school': TextEditingController(),
    'High school': TextEditingController(),
  };

  Future<void> _saveBiodata() async {
    final data = {
      for (final entry in _fields.entries)
        entry.key: entry.value.text.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    };

    await _firestore.collection('biodata').add(data);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Biodata saved to Firebase')),
    );

    for (final controller in _fields.values) {
      controller.clear();
    }
    setState(() {});
  }

  @override
  void dispose() {
    for (final controller in _fields.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filledFields = _fields.entries
        .where((entry) => entry.value.text.trim().isNotEmpty)
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Biodata')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _sectionCard(
              title: 'Enter biodata',
              child: Column(
                children: [
                  for (final entry in _fields.entries)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: TextField(
                        controller: entry.value,
                        onChanged: (_) => setState(() {}),
                        textCapitalization: TextCapitalization.words,
                        keyboardType: entry.key == 'Email'
                            ? TextInputType.emailAddress
                            : entry.key == 'Phone number' || entry.key == 'Age'
                                ? TextInputType.phone
                                : TextInputType.text,
                        decoration: InputDecoration(
                          labelText: entry.key,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: filledFields.isEmpty ? null : _saveBiodata,
                      icon: const Icon(Icons.save_alt),
                      label: const Text('Save to Firebase'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            _sectionCard(
              title: 'Biodata output',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final entry in filledFields)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        '${entry.key}: ${entry.value.text.trim()}',
                        style: const TextStyle(fontSize: 16, height: 1.35),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionCard({required String title, required Widget child}) => Card(
        color: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),
              child,
            ],
          ),
        ),
      );
}