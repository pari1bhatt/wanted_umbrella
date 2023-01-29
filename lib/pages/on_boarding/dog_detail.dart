import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    onBoardingProvider = Provider.of<OnBoardingProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: GetColors.white,
        leading: IconButton(
            icon: const Icon(Icons.keyboard_backspace, color: GetColors.black),
            onPressed: () => Navigator.pop(context)),
        actions: [
          TextButton(
              onPressed: () {
                onBoardingProvider.reset();
                Navigator.popUntil(context, ModalRoute.withName(Routes.login));
              },
              child: const Text("cancel", style: TextStyle(color: GetColors.black)))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Details about your dog:",
                    style: TextStyle(
                        fontSize: 22, color: GetColors.black, fontWeight: FontWeight.w600)),
                const SizedBox(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(
                        flex: 3, child: Text("Dog name", style: TextStyle(color: GetColors.black))),
                    Expanded(
                      flex: 7,
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))],
                        validator: Utils.validateText,
                        onChanged: (value) {
                          onBoardingProvider.userModel.dog_name = value;
                        },
                        decoration: const InputDecoration(hintText: 'Dog name', isDense: true),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Expanded(
                        flex: 3,
                        child: Text("Enter breed", style: TextStyle(color: GetColors.black))),
                    Expanded(
                      flex: 7,
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))],
                        validator: Utils.validateText,
                        onChanged: (value) {
                          onBoardingProvider.userModel.breed = value;
                        },
                        decoration: const InputDecoration(hintText: 'Breed name', isDense: true),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Expanded(
                        flex: 3,
                        child: Text("Choose gender", style: TextStyle(color: GetColors.black))),
                    Expanded(
                      flex: 7,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 0.6),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          underline: Container(),
                          hint: Text('Select gender'),
                          value: onBoardingProvider.userModel.gender,
                          onChanged: (String? newValue) {
                            setState(() {
                              onBoardingProvider.userModel.gender = newValue;
                            });
                          },
                          items: <String>['Male', 'Female']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Expanded(
                        flex: 3,
                        child: Text("Choose size", style: TextStyle(color: GetColors.black))),
                    Expanded(
                      flex: 7,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 0.6),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        child: DropdownButton<String>(
                          underline: Container(),
                          isExpanded: true,
                          value: onBoardingProvider.userModel.size,
                          hint: Text('Select size'),
                          onChanged: (String? newValue) {
                            setState(() {
                              onBoardingProvider.userModel.size = newValue;
                            });
                          },
                          items: <String>['Miniature','Small', 'Medium', 'Large']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Expanded(
                        flex: 30,
                        child: Text("Enter age", style: TextStyle(color: GetColors.black))),
                    Expanded(
                      flex: 20,
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        maxLength: 3,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        validator: Utils.validateText,
                        onChanged: (value) {
                          onBoardingProvider.userModel.age = value;
                        },
                        decoration:
                            InputDecoration(hintText: 'Age', isDense: true, counter: Container()),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 50,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 0),
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 0.6),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        child: DropdownButton<String>(
                          underline: Container(),
                          isExpanded: true,
                          value: onBoardingProvider.userModel.ageDuration,
                          onChanged: (String? newValue) {
                            setState(() {
                              onBoardingProvider.userModel.ageDuration = newValue;
                            });
                          },
                          items: <String>['Months', 'Years']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Expanded(
                        flex: 3, child: Text("Bio", style: TextStyle(color: GetColors.black))),
                    Expanded(
                      flex: 7,
                      child: TextFormField(
                        minLines: 3,
                        maxLines: 3,
                        keyboardType: TextInputType.name,
                        validator: Utils.validateText,
                        onChanged: (value) {
                          onBoardingProvider.userModel.bio = value;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Please enter bio',
                            isDense: true,
                            border: OutlineInputBorder()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Center(
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: GetColors.purple),
                    onPressed: onNext,
                    child:
                        const Text('Next', style: TextStyle(fontSize: 20, color: GetColors.white)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  onNext() {
    if (_formKey.currentState!.validate()) {
      if (onBoardingProvider.userModel.gender?.isEmpty ?? true) {
        Utils.showSnackBar(context, "Please Select gender");
      } else if (onBoardingProvider.userModel.size?.isEmpty ?? true) {
        Utils.showSnackBar(context, "Please Select size");
      } else if (onBoardingProvider.userModel.age?.isEmpty ?? true) {
        Utils.showSnackBar(context, "Please enter age");
      } else {
        Navigator.pushNamed(context, Routes.dog_photos);
      }
    }
  }
}
