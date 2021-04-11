import 'package:flutter/material.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:intl/intl.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String city_name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter City'),
        backgroundColor:
            int.parse(DateFormat('H').format(DateTime.now())) > 18 ||
                    int.parse(DateFormat('H').format(DateTime.now())) < 6
                ? kNightAppbar
                : kDayAppbar,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: int.parse(DateFormat('H').format(DateTime.now())) > 18 ||
                      int.parse(DateFormat('H').format(DateTime.now())) < 6
                  ? kNightTheme
                  : kDayTheme),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Icon(
                    Icons.ac_unit_outlined,
                    size: 120,
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          onChanged: (value) {
                            city_name = value;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            prefixIcon: Icon(
                              Icons.location_city,
                              color: Colors.deepPurple,
                            ),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        RawMaterialButton(
                          fillColor: Colors.deepPurple,
                          onPressed: () {
                            Navigator.pop(context, city_name);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Text('Get Weather'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
