import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../routes.dart';
import '../../utils/constants.dart';
import '../dashboard_provider.dart';

class Adoption extends StatefulWidget {
  const Adoption({Key? key}) : super(key: key);

  @override
  State<Adoption> createState() => _AdoptionState();
}

class _AdoptionState extends State<Adoption> {
  late Size size;
  late DashboardProvider provider;
  UserModel? tempModel;
  bool showAdoption = false;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<DashboardProvider>(context, listen: false);
    tempModel = provider.currentUserModel;
    showAdoption = tempModel?.showAdoption ?? false;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Put your dog for adoption"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  Container(
                    height: size.height * .12,
                    width: size.height * .14,
                    decoration: BoxDecoration(
                        color: GetColors.blue,
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              tempModel?.profile_image ?? GetImages.placeholderNetwork),
                        )),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      "Profile pic",
                      style: TextStyle(
                          color: GetColors.lightBlue,
                          decoration: TextDecoration.underline,
                          fontSize: 22),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const Divider(thickness: 2, color: GetColors.black87, height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("Your dog details :",
                      style: TextStyle(
                          fontSize: 22, color: GetColors.black, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                          flex: 3,
                          child: Text("Dog name", style: TextStyle(color: GetColors.black))),
                      Expanded(
                        flex: 7,
                        child: TextFormField(
                          readOnly: true,
                          initialValue: tempModel?.dog_name ?? '',
                          keyboardType: TextInputType.name,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))],
                          onChanged: (value) {
                            tempModel?.dog_name = value;
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
                          flex: 3, child: Text("Breed", style: TextStyle(color: GetColors.black))),
                      Expanded(
                        flex: 7,
                        child: TextFormField(
                          readOnly: true,
                          initialValue: tempModel?.breed ?? '',
                          keyboardType: TextInputType.name,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))],
                          onChanged: (value) {
                            tempModel?.breed = value;
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
                          flex: 3, child: Text("Gender", style: TextStyle(color: GetColors.black))),
                      Expanded(
                        flex: 7,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: tempModel?.gender,
                          onTap: () {},
                          onChanged: (String? newValue) {},
                          items: <String>['Male', 'Female']
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
                      const Expanded(
                          flex: 30, child: Text("Age", style: TextStyle(color: GetColors.black))),
                      Expanded(
                        flex: 20,
                        child: TextFormField(
                          readOnly: true,
                          initialValue: tempModel?.age ?? '',
                          keyboardType: TextInputType.name,
                          onChanged: (value) {
                            tempModel?.age = value;
                          },
                          decoration:
                              const InputDecoration(hintText: 'Age in months', isDense: true),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 50,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 0),
                          decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 0.6),
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            ),
                          ),
                          child: DropdownButton<String>(
                            underline: Container(),
                            isExpanded: true,
                            value: tempModel?.ageDuration,
                            onChanged: (String? newValue) {},
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
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: showAdoption ? GetColors.grey : GetColors.purple),
                onPressed: showAdoption ? null : onSave,
                child: Text(showAdoption ? 'Available for adoption' : 'Save',
                    style: const TextStyle(fontSize: 20, color: GetColors.white)),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  onSave() {
    tempModel?.showAdoption = true;
    provider.onUpdateProfile(tempModel!, context,msg: 'Now your dog is open for adoption');
  }
}
