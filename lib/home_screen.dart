import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              const Text(
                'Enter Starting Date',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton<String>(
                    hint: const Text('Year'),
                    items: List.generate(100, (index) {
                      return DropdownMenuItem(
                        value: (2000 + index).toString(),
                        child: Text((2030 + index).toString()),
                      );
                    }),
                    onChanged: (value) {},
                  ),
                  DropdownButton<String>(
                    hint: const Text('Month'),
                    items: List.generate(12, (index) {
                      return DropdownMenuItem(
                        value: (index + 1).toString(),
                        child: Text((index + 1).toString()),
                      );
                    }),
                    onChanged: (value) {},
                  ),
                  DropdownButton<String>(
                    hint: const Text('Day'),
                    items: List.generate(32, (index) {
                      return DropdownMenuItem(
                        value: (index + 1).toString(),
                        child: Text((index + 1).toString()),
                      );
                    }),
                    onChanged: (value) {},
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              const Text(
                'Enter End Date',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton<String>(
                    hint: const Text('Year'),
                    items: List.generate(100, (index) {
                      return DropdownMenuItem(
                        value: (2030 + index).toString(),
                        child: Text((2000 + index).toString()),
                      );
                    }),
                    onChanged: (value) {},
                  ),
                  DropdownButton<String>(
                    hint: const Text('Month'),
                    items: List.generate(12, (index) {
                      return DropdownMenuItem(
                        value: (index + 1).toString(),
                        child: Text((index + 1).toString()),
                      );
                    }),
                    onChanged: (value) {},
                  ),
                  DropdownButton<String>(
                    hint: const Text('Day'),
                    items: List.generate(32, (index) {
                      return DropdownMenuItem(
                        value: (index + 1).toString(),
                        child: Text((index + 1).toString()),
                      );
                    }),
                    onChanged: (value) {},
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Amount Lend [Rs.]',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Interest Rate (%)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              ElevatedButton(
                onPressed: () {},
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
