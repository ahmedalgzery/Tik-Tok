import 'package:flutter/material.dart';
import 'package:tiktok/constants.dart';

// A reusable TextFormField widget for text input
class TextInputField extends StatelessWidget {
  final TextEditingController controller; // Controller to manage the text input
  final String labelText; // Label text for the input field
  final bool isObscure; // Flag to determine whether the input should be obscured (e.g., for passwords)
  final IconData icon; // Icon to display as a prefix in the input field

  // Constructor for TextInputField widget
  const TextInputField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.isObscure = false,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // Assign the provided controller to the TextFormField
      decoration: InputDecoration(
        labelText: labelText, // Set the label text for the input field
        prefixIcon: Icon(icon), // Display an icon as a prefix in the input field
        prefixIconColor: buttonColor, // Set the color of the prefix icon
        
        labelStyle: const TextStyle(fontSize: 20, color: Colors.grey), // Style for the label text
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
      ),
      obscureText: isObscure, // If 'true', obscure the text input (e.g., for password input)
      validator: (value) {
        // Validation function to check the input's validity
        if (value == null || value.isEmpty) {
          return 'Enter your $labelText'; // Display an error message if the input is empty
        }
        return null; // Validation passed (no error message)
      },
    );
  }
}
