import 'package:flutter/material.dart';
import '../Components/any_to_any.dart';
import '../Models/fetch_rates.dart';
import '../Models/rates_model.dart';
import 'bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<RatesModel> result;
  late Future<Map> allcurrencies;
  final formkey = GlobalKey<FormState>();
  String convertedCurrency = 'Converted Currency :';

  @override
  void initState() {
    super.initState();
    setState(() {
      result = fetchrates();
      allcurrencies = fetchcurrencies();
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Currency Converter',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black,
        height: h,
        width: w,
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: FutureBuilder<RatesModel>(
              future: result,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Center(
                  child: FutureBuilder<Map>(
                    future: allcurrencies,
                    builder: (context, currSnapshot) {
                      if (currSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnyToAny(
                            currencies: currSnapshot.data!,
                            rates: snapshot.data!.rates,
                            onAnswerChanged: (String newAnswer) {
                              setState(() {
                                convertedCurrency = newAnswer;
                              });
                            },
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        convertedCurrency: convertedCurrency,
      ),
    );
  }
}
