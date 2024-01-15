import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final String convertedCurrency;

  CustomBottomNavigationBar({required this.convertedCurrency});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.teal,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            'Date:  ${DateFormat('dd/MM/yyyy hh:mm').format(DateTime.now())}',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(),
          Card(
            color: Colors.black, // Set your desired background color
            elevation: 10, // Add some elevation for a subtle shadow effect
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(10), // Round the corners of the card
            ),
            child: Padding(
              padding: const EdgeInsets.all(10), // Add padding for spacing
              child: Text(
                '$convertedCurrency',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set text color
                  fontSize: 11, // Adjust font size
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
