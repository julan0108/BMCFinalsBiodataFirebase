import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController civilStatusController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController placeOfBirthController = TextEditingController();
  final TextEditingController religionController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController emergencyContactController = TextEditingController();
  final TextEditingController collegeController = TextEditingController();
  final TextEditingController seniorHighController = TextEditingController();
  final TextEditingController highSchoolController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController hobbiesController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController motherNameController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveData() async {
    final data = {
      'Full name': fullNameController.text.trim(),
      'Date of birth': dateOfBirthController.text.trim(),
      'Age': ageController.text.trim(),
      'Gender': genderController.text.trim(),
      'Civil status': civilStatusController.text.trim(),
      'Nationality': nationalityController.text.trim(),
      'Place of birth': placeOfBirthController.text.trim(),
      'Religion': religionController.text.trim(),
      'Address': addressController.text.trim(),
      'Phone number': phoneNumberController.text.trim(),
      'Email': emailController.text.trim(),
      'Emergency contact': emergencyContactController.text.trim(),
      'College': collegeController.text.trim(),
      'Senior high school': seniorHighController.text.trim(),
      'High school': highSchoolController.text.trim(),
      'Skills': skillsController.text.trim(),
      'Hobbies': hobbiesController.text.trim(),
      'Father name': fatherNameController.text.trim(),
      'Mother name': motherNameController.text.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    };

    final hasAnyValue = data.entries
        .where((entry) => entry.key != 'createdAt')
        .any((entry) => entry.value.toString().trim().isNotEmpty);

    if (!hasAnyValue) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in at least one field')),
      );
      return;
    }

    try {
      await firestore.collection('biodata').add(data);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Biodata saved successfully')),
      );

      fullNameController.clear();
      dateOfBirthController.clear();
      ageController.clear();
      genderController.clear();
      civilStatusController.clear();
      nationalityController.clear();
      placeOfBirthController.clear();
      religionController.clear();
      addressController.clear();
      phoneNumberController.clear();
      emailController.clear();
      emergencyContactController.clear();
      collegeController.clear();
      seniorHighController.clear();
      highSchoolController.clear();
      skillsController.clear();
      hobbiesController.clear();
      fatherNameController.clear();
      motherNameController.clear();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save: $e')),
      );
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    dateOfBirthController.dispose();
    ageController.dispose();
    genderController.dispose();
    civilStatusController.dispose();
    nationalityController.dispose();
    placeOfBirthController.dispose();
    religionController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    emergencyContactController.dispose();
    collegeController.dispose();
    seniorHighController.dispose();
    highSchoolController.dispose();
    skillsController.dispose();
    hobbiesController.dispose();
    fatherNameController.dispose();
    motherNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F5),
      appBar: AppBar(
        title: const Text('Biodata'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          children: [
            const Text(
              'Personal Information',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F1F1F),
              ),
            ),
            const SizedBox(height: 16),
            _buildTextField('Full name', fullNameController),
            _buildTextField('Date of birth', dateOfBirthController),
            _buildTextField('Age', ageController, keyboardType: TextInputType.number),
            _buildTextField('Gender', genderController),
            _buildTextField('Civil status', civilStatusController),
            _buildTextField('Nationality', nationalityController),
            _buildTextField('Place of birth', placeOfBirthController),
            _buildTextField('Religion', religionController),
            const SizedBox(height: 18),
            const Text(
              'Contact Details',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F1F1F),
              ),
            ),
            const SizedBox(height: 16),
            _buildTextField('Address', addressController),
            _buildTextField('Phone number', phoneNumberController, keyboardType: TextInputType.phone),
            _buildTextField('Email', emailController, keyboardType: TextInputType.emailAddress),
            _buildTextField('Emergency contact', emergencyContactController),
            const SizedBox(height: 18),
            const Text(
              'Education & Background',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F1F1F),
              ),
            ),
            const SizedBox(height: 16),
            _buildTextField('College', collegeController),
            _buildTextField('Senior high school', seniorHighController),
            _buildTextField('High school', highSchoolController),
            const SizedBox(height: 18),
            const Text(
              'Other Information',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F1F1F),
              ),
            ),
            const SizedBox(height: 16),
            _buildTextField('Skills', skillsController),
            _buildTextField('Hobbies', hobbiesController),
            _buildTextField('Father name', fatherNameController),
            _buildTextField('Mother name', motherNameController),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F1F1F),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Save to Firebase',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE6E1DB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE6E1DB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF1F1F1F), width: 1.2),
          ),
        ),
      ),
    );
  }
}
