import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/selection_model.dart';
import '../../utils/constants.dart';

class Vaccination extends StatefulWidget {
  const Vaccination({Key? key}) : super(key: key);

  @override
  State<Vaccination> createState() => _VaccinationState();
}

class _VaccinationState extends State<Vaccination> {
  List<SelectionModel> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Vaccination"),
        actions: [
          TextButton(
            onPressed: onDatePicker,
            child: const Text('Add', style: TextStyle(color: GetColors.white)),
          )
        ],
      ),
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            String currentEntry = (index + 1).toString();
            return Column(
              children: [
                ListTile(
                  leading: Text('$currentEntry. Vaccination $currentEntry'),
                  title: InkWell(
                    onTap: onDatePicker,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: Center(
                          child: Text(list[index].text ?? '00/00/0000',
                              style: const TextStyle(color: GetColors.grey))),
                    ),
                  ),
                ),
                getDivider()
              ],
            );
          }),
    );
  }

  onDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));
    if (pickedDate != null) {
      String formattedDate = DateFormat('dd-MMM-yyyy').format(pickedDate);
      setState(() {
        list.add(SelectionModel(text: formattedDate)); //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  getDivider() {
    return const Divider(thickness: 1, color: GetColors.black87, height: 10);
  }
}
