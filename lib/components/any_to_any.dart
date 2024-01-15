import 'package:flutter/material.dart';
import '../models/fetch_rates.dart';

class AnyToAny extends StatefulWidget {
  final rates;
  final Map currencies;
  final Function(String) onAnswerChanged;

  const AnyToAny({
    Key? key,
    @required this.rates,
    required this.currencies,
    required this.onAnswerChanged,
  }) : super(key: key);

  @override
  _AnyToAnyState createState() => _AnyToAnyState();
}

class _AnyToAnyState extends State<AnyToAny> {
  TextEditingController amountController = TextEditingController();
  String dropdownValue1 = 'USD';
  String dropdownValue2 = 'PKR';
  String answer = 'Converted Currency :';

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 65),
        child: Card(
          elevation: 8,
          margin: const EdgeInsets.all(16),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Convert Any Currency',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    key: const ValueKey('amount'),
                    controller: amountController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.currency_exchange_sharp),
                      hintText: 'Enter Amount',
                      border: OutlineInputBorder(
                        gapPadding: 4.0,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButton<String>(
                          value: dropdownValue1,
                          icon: const Icon(Icons.arrow_drop_down_rounded),
                          iconSize: 30,
                          elevation: 20,
                          isExpanded: true,
                          underline: Container(
                            height: 5,
                            color: Colors.teal,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue1 = newValue!;
                            });
                          },
                          items: widget.currencies.keys
                              .toSet()
                              .toList()
                              .map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Text('To'),
                      ),
                      Expanded(
                        child: DropdownButton<String>(
                          value: dropdownValue2,
                          icon: const Icon(Icons.arrow_drop_down_rounded),
                          iconSize: 30,
                          elevation: 20,
                          isExpanded: true,
                          underline: Container(
                            height: 5,
                            color: Colors.teal,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue2 = newValue!;
                            });
                          },
                          items: widget.currencies.keys
                              .toSet()
                              .toList()
                              .map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              answer = amountController.text +
                                  ' ' +
                                  dropdownValue1 +
                                  ' ' +
                                  convertany(
                                      widget.rates,
                                      amountController.text,
                                      dropdownValue1,
                                      dropdownValue2) +
                                  ' ' +
                                  dropdownValue2;

                              widget.onAnswerChanged(answer);
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors
                                .teal), // Replace with your desired background color
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Adjust the border radius
                              ),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.currency_exchange,
                                    color: Colors
                                        .white), // Replace with your desired icon
                                SizedBox(width: 8),
                                Text(
                                  'Convert',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                  const SizedBox(width: 10),
                  const SizedBox(height: 30),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Card(
                          color: Colors.black,
                          elevation:
                              5, // Set the elevation to 0 to use the container's shadow
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              answer,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
