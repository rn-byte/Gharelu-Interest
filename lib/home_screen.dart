import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:gharelu_byaaj/logic/interest_calculator.dart';
import 'package:intl/intl.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _principalController = TextEditingController();
  final _rateController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  void _pickDate(BuildContext context, bool isStartDate,
      {bool aD = false, bool eN = true}) async {
    DateTime? pickedDate;
    aD
        ? await showCupertinoModalPopup(
            context: context,
            builder: (context) => SizedBox(
              height: 220,
              child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                backgroundColor: const Color.fromARGB(255, 5, 119, 168),
                dateOrder: DatePickerDateOrder.ydm,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (value) {
                  setState(() {
                    pickedDate = value;
                    print(pickedDate);
                  });
                },
              ),
            ),
          )
        : showCupertinoDatePicker(
            context: context,
            initialDate: NepaliDateTime.now(),
            firstDate: NepaliDateTime(2030),
            lastDate: NepaliDateTime(2100),
            language: eN ? Language.english : Language.nepali,
            dateOrder: DateOrder.ydm,
            onDateChanged: (newDate) {
              setState(() {
                pickedDate = newDate;
                print(pickedDate);
              });
            },
          );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  void _calculateInterest() {
    if (_principalController.text.isEmpty ||
        _rateController.text.isEmpty ||
        _startDate == null ||
        _endDate == null) {
      _showError('Please fill all fields!');
      return;
    }

    double principal = double.tryParse(_principalController.text) ?? 0;
    double annualRate = double.tryParse(_rateController.text) ?? 0;

    if (principal <= 0 || annualRate <= 0) {
      _showError('Please enter valid numbers!');
      return;
    }

    if (_startDate!.isAfter(_endDate!)) {
      _showError('Start date cannot be after end date!');
      return;
    }

    double interest = compoundInterestCalculator(
      principal: principal,
      annualRate: annualRate,
      startDate: _startDate!,
      endDate: _endDate!,
    );

    double totalAmount = interest + principal;

    _showResult(interest, totalAmount);
  }

  void _showResult(double interest, double totalAmount) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Calculation Result'),
        content: Text(
            'Compound Interest: Rs. ${interest.toStringAsFixed(2)}\nTotal Amount: Rs. ${totalAmount.toStringAsFixed(2)}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }

  bool bS = true;
  bool eN = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Interest Calculator',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 64, 3, 75),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Select Date Type and Language : ',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Expanded(
                    child: FlutterSwitch(
                      activeColor: Colors.green,
                      width: 70.0,
                      height: 30.0,
                      valueFontSize: 15.0,
                      toggleSize: 35.0,
                      value: bS,
                      borderRadius: 20.0,
                      padding: 5.0,
                      showOnOff: true,
                      activeText: 'BS',
                      inactiveText: 'AD',
                      inactiveColor: Colors.red,
                      onToggle: (val) {
                        setState(() {
                          bS = val;
                          if (!bS) {
                            eN = true;
                          }
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: FlutterSwitch(
                      activeColor: Colors.red,
                      width: 70.0,
                      height: 30.0,
                      valueFontSize: 15.0,
                      toggleSize: 35.0,
                      value: eN,
                      borderRadius: 20.0,
                      padding: 5.0,
                      showOnOff: true,
                      activeText: 'EN',
                      inactiveText: 'NP',
                      disabled: bS ? false : true,
                      inactiveColor: Colors.green,
                      onToggle: (val) {
                        setState(() {
                          eN = val;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              //SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Enter Borrowed Date  =>',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                        onTap: () => _pickDate(context, true, aD: !bS, eN: eN),
                        child: Chip(
                          label: Text(_startDate == null
                              ? 'Pick Borrowed Date'
                              : DateFormat('yyyy-MM-dd').format(_startDate!)),
                        )),
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     DropdownButton<String>(
              //       hint: const Text('Year'),
              //       items: List.generate(100, (index) {
              //         return DropdownMenuItem(
              //           value: (2030 + index).toString(),
              //           child: Text((2030 + index).toString()),
              //         );
              //       }),
              //       onChanged: (value) {},
              //     ),
              //     DropdownButton<String>(
              //       hint: const Text('Month'),
              //       items: List.generate(12, (index) {
              //         return DropdownMenuItem(
              //           value: (index + 1).toString(),
              //           child: Text((index + 1).toString()),
              //         );
              //       }),
              //       onChanged: (value) {},
              //     ),
              //     DropdownButton<String>(
              //       hint: const Text('Day'),
              //       items: List.generate(32, (index) {
              //         return DropdownMenuItem(
              //           value: (index + 1).toString(),
              //           child: Text((index + 1).toString()),
              //         );
              //       }),
              //       onChanged: (value) {},
              //     ),
              //   ],
              // ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Enter Payment Date  =>',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _pickDate(context, false, aD: !bS, eN: eN),
                      child: Chip(
                        label: Text(_endDate == null
                            ? 'Pick Payment Date'
                            : eN
                                ? DateFormat('yyyy-MM-dd').format(_endDate!)
                                : DateFormat('yyyy-MM-dd').format(_endDate!)),
                      ),
                    ),
                  ),
                ],
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     DropdownButton<String>(
              //       hint: const Text('Year'),
              //       items: List.generate(100, (index) {
              //         return DropdownMenuItem(
              //           value: (2030 + index).toString(),
              //           child: Text((2030 + index).toString()),
              //         );
              //       }),
              //       onChanged: (value) {},
              //     ),
              //     DropdownButton<String>(
              //       hint: const Text('Month'),
              //       items: List.generate(12, (index) {
              //         return DropdownMenuItem(
              //           value: (index + 1).toString(),
              //           child: Text((index + 1).toString()),
              //         );
              //       }),
              //       onChanged: (value) {},
              //     ),
              //     DropdownButton<String>(
              //       hint: const Text('Day'),
              //       items: List.generate(32, (index) {
              //         return DropdownMenuItem(
              //           value: (index + 1).toString(),
              //           child: Text((index + 1).toString()),
              //         );
              //       }),
              //       onChanged: (value) {},
              //     ),
              //   ],
              // ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              TextField(
                controller: _principalController,
                decoration: const InputDecoration(
                  labelText: 'Amount Lend [Rs.]',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              TextField(
                controller: _rateController,
                decoration: const InputDecoration(
                  labelText: 'Interest Rate (%)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              ElevatedButton(
                onPressed: _calculateInterest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 64, 3, 75),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text(
                  'Calculate',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              const Text('Calculated Interest and Amount',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Principal Amount => Rs. 5000",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  const Text(
                      "Amount Borrowed date => Year : 2080, Month: Poush, Day: 02",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                  const Text(
                      "Date of payment => Year : 2082, Month: Poush, Day: 02",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  const Text('Interest Period => 3 year 3 month 3 days',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                  const Text('Total Interest => Rs. 1000',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                  const Text('Total Amount With Interest => Rs. 6000',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400))
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
