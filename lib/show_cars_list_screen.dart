import 'package:flutter/material.dart';
import 'package:vehiclelist/cars_list.dart';
import 'package:vehiclelist/models/car_list_model.dart';

class CarTableScreen extends StatefulWidget {
  final List<Car> cars;

  const CarTableScreen({super.key, required this.cars});

  @override
  State<CarTableScreen> createState() => _CarTableScreenState();
}

class _CarTableScreenState extends State<CarTableScreen> {
  TextEditingController searchController = TextEditingController();

  List<Car> filteredCars = [];
  String? selectedOwner;
  String? selectedServiceDate;
  String? selectedRating;

  @override
  void initState() {
    filteredCars = cars;

    super.initState();
  }

  void filterCars(String query) {
    final List<Car> filtered = cars.where((car) {
      final carModelLower = car.model.toLowerCase();
      final searchLower = query.toLowerCase();

      bool matchesModel = carModelLower.contains(searchLower);

      return matchesModel;
    }).toList();

    setState(() {
      filteredCars = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Vehicle List"),
          centerTitle: true,
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Owner',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                        borderSide: BorderSide(
                          color: Colors.purple,
                          width: 2.0,
                        ),
                      ),
                    ),
                    value: selectedOwner,
                    items: const [
                      DropdownMenuItem(value: null, child: Text('All')),
                      DropdownMenuItem(
                          value: 'John Doe', child: Text('John Doe')),
                      DropdownMenuItem(
                          value: 'Jane Smith', child: Text('Jane Smith')),
                      DropdownMenuItem(
                          value: 'Michael Johnson',
                          child: Text('Michael Johnson')),
                      DropdownMenuItem(
                          value: 'Michael Johnson',
                          child: Text('Michael jecson')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedOwner = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Service Year',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                        borderSide: BorderSide(
                          color: Colors.purple,
                          width: 2.0,
                        ),
                      ),
                    ),
                    value: selectedServiceDate,
                    items: const [
                      DropdownMenuItem(value: null, child: Text('All')),
                      DropdownMenuItem(value: '2024', child: Text('2024')),
                      DropdownMenuItem(value: '2025', child: Text('2025')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedServiceDate = value;
                        filterCars(searchController.text);
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                // Dropdown for Rating
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Rating',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                        borderSide: BorderSide(
                          color: Colors.purple,
                          width: 2.0,
                        ),
                      ),
                    ),
                    value: selectedRating,
                    items: const [
                      DropdownMenuItem(value: null, child: Text('All')),
                      DropdownMenuItem(value: '4.9', child: Text('4.9')),
                      DropdownMenuItem(value: '4.8', child: Text('4.8')),
                      DropdownMenuItem(value: '4.7', child: Text('4.7')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedRating = value;
                        filterCars(searchController.text);
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),

                // Search Field
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      labelText: 'Search by car model',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                        borderSide: BorderSide(
                          color: Colors.purple,
                          width: 2.0,
                        ),
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (query) {
                      filterCars(query);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: DataTable(
                headingRowColor:
                    MaterialStatePropertyAll(Colors.purple.withOpacity(0.4)),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.purple)),
                headingTextStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
                columns: const [
                  DataColumn(
                    label: Text("Vehicle Model"),
                  ),
                  DataColumn(
                    label: Text("Owner"),
                  ),
                  DataColumn(
                    label: Text("Service Date"),
                  ),
                  DataColumn(
                    label: Text("Insurance Date"),
                  ),
                  DataColumn(
                    label: Text("Price"),
                  ),
                  DataColumn(
                    label: Text("Rating"),
                  ),
                ],
                rows: filteredCars.map((car) {
                  return DataRow(cells: [
                    DataCell(Text(car.model)),
                    DataCell(Text(car.owner)),
                    DataCell(Text(
                        "${car.serviceDate.day}-${car.serviceDate.month}-${car.serviceDate.year}")),
                    DataCell(Text(
                        "${car.insuranceDueDate.day}-${car.insuranceDueDate.month}-${car.insuranceDueDate.year}")),
                    DataCell(Text(car.price.toString())),
                    DataCell(Text(car.rating.toString())),
                  ]);
                }).toList(),
              ),
            ),
          ),
        ]));
  }
}
