import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class DatePick extends StatefulWidget {
  const DatePick({super.key});

  @override
  State<DatePick> createState() => _DatePickState();
}

class _DatePickState extends State<DatePick> {
  NepaliDateTime nepaliDateTime = NepaliDateTime(2030, 2, 1);
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Date Picker Demo'),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
                onPressed: () {
                  ////////////
                  showCupertinoDatePicker(
                    context: context,
                    initialDate: NepaliDateTime.now(),
                    firstDate: NepaliDateTime(2030),
                    lastDate: NepaliDateTime(2100),
                    language: Language.nepali,
                    dateOrder: DateOrder.ydm,
                    onDateChanged: (newDate) {
                      setState(() {
                        nepaliDateTime = newDate;
                      });
                    },
                  );

                  ////////////
                },
                child: Text(
                    'Pick Date: ${nepaliDateTime.year} - ${nepaliDateTime.month} - ${nepaliDateTime.day}'))
          ]),
        ),
      ),
    );
  }
}
