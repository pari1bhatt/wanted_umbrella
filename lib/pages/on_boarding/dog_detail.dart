import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanted_umbrella/pages/on_boarding/on_boarding_provider.dart';
import 'package:wanted_umbrella/routes.dart';
import 'package:wanted_umbrella/utils/constants.dart';
import 'package:wanted_umbrella/utils/utils.dart';

class DogDetail extends StatefulWidget {
  DogDetail({Key? key}) : super(key: key);

  @override
  State<DogDetail> createState() => _DogDetailState();
}

class _DogDetailState extends State<DogDetail> {
  late OnBoardingProvider onBoardingProvider;
  String dogName = '';
  String? genderDropdownValue;
  String? sizeDropdownValue;

  @override
  Widget build(BuildContext context) {
    onBoardingProvider = Provider.of<OnBoardingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: GetColors.white,
        leading: IconButton(
            icon: const Icon(Icons.keyboard_backspace, color: GetColors.black),
            onPressed: () => Navigator.pop(context)),
        actions: [
          TextButton(
              onPressed: () => Navigator.popUntil(context, ModalRoute.withName(Routes.login)),
              child: const Text("cancel", style: TextStyle(color: GetColors.black)))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Details about your dog:", style: TextStyle(fontSize: 22, color: GetColors.black,fontWeight: FontWeight.w600)),
              const SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(flex: 3, child: Text("Dog name", style: TextStyle(color: GetColors.black))),
                  Expanded(
                    flex: 7,
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        dogName = value;
                      },
                      decoration: const InputDecoration(hintText: 'Dog name', isDense: true),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Expanded(flex: 3, child: Text("Enter breed", style: TextStyle(color: GetColors.black))),
                  Expanded(
                    flex: 7,
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        // onBoardingProvider.regName = value;
                      },
                      decoration: const InputDecoration(hintText: 'Breed name', isDense: true),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Expanded(flex: 3, child: Text("Choose gender", style: TextStyle(color: GetColors.black))),
                  Expanded(
                    flex: 7,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: genderDropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          genderDropdownValue = newValue;
                        });
                      },
                      items: <String>['Male', 'Female'].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Expanded(flex: 3, child: Text("Choose size", style: TextStyle(color: GetColors.black))),
                  Expanded(
                    flex: 7,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: sizeDropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          sizeDropdownValue = newValue;
                        });
                      },
                      items: <String>['Small', 'Medium', 'Large', 'Very Large']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Expanded(flex: 3, child: Text("Enter age", style: TextStyle(color: GetColors.black))),
                  Expanded(
                    flex: 7,
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        // onBoardingProvider.regName = value;
                      },
                      decoration: const InputDecoration(hintText: 'Age in years', isDense: true),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Expanded(flex: 3, child: Text("Bio", style: TextStyle(color: GetColors.black))),
                  Expanded(
                    flex: 7,
                    child: TextFormField(
                      minLines: 3,
                      maxLines: 3,
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        // onBoardingProvider.regName = value;
                      },
                      decoration: const InputDecoration(
                          hintText: 'Please enter bio', isDense: true, border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: GetColors.purple),
                  onPressed: onNext,
                  child: const Text('Next', style: TextStyle(fontSize: 20, color: GetColors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  onNext() {
    if(dogName.isNotEmpty){
      Navigator.pushNamed(context, Routes.dog_photos);
    } else {
      Utils.showSnackBar(context, "Please enter dog name");
    }
  }
}
