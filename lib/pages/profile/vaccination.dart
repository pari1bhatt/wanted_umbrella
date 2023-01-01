import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/constants.dart';

class Vaccination extends StatefulWidget {
  const Vaccination({Key? key}) : super(key: key);

  @override
  State<Vaccination> createState() => _VaccinationState();
}

class _VaccinationState extends State<Vaccination> {
  String dateinput = '00/00/0000';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Vaccination"),
        actions: [
          TextButton(
              onPressed: () {}, child: Text('Add', style: TextStyle(color: GetColors.white)))
        ],
      ),
      body: Column(
        children: [
          ListTile(
            leading: Text('1. Vaccination 1'),
            title: InkWell(
              onTap: onDatePicker,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 1)
                ),
                child: Center(child: Text(dateinput,style: TextStyle(color: GetColors.grey))),
              ),
            ),
            trailing: Icon(Icons.radio_button_off),
          ),
          getDivider(),
          ListTile(
            leading: Text('2. Vaccination 2'),
            title: InkWell(
              onTap: onDatePicker,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(width: 1)
                ),
                child: Center(child: Text(dateinput,style: TextStyle(color: GetColors.grey))),
              ),
            ),
            trailing: Icon(Icons.radio_button_off),
          ),
          getDivider(),
          ListTile(
            leading: Text('3. Vaccination 3'),
            title: InkWell(
              onTap: onDatePicker,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(width: 1)
                ),
                child: Center(child: Text(dateinput,style: TextStyle(color: GetColors.grey))),
              ),
            ),
            trailing: Icon(Icons.radio_button_off),
          ),
          getDivider(),
        ],
      ),
    );
  }

  onDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
        context: context, initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101)
    );
    if(pickedDate != null ){
      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(formattedDate); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      setState(() {
        dateinput = formattedDate; //set output date to TextField value.
      });
    }else{
      print("Date is not selected");
    }
  }

  getDivider() {
    return const Divider(thickness: 1, color: GetColors.black87, height: 10);
  }

}
