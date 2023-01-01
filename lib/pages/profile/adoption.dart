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

  @override
  void initState() {
    super.initState();
    provider = Provider.of<DashboardProvider>(context, listen: false);
    tempModel = provider.currentUserModel;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Put your dog on adoption"),
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
                              tempModel?.dog_images?.first ?? GetImages.placeholderNetwork),
                        )),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      "add photo",
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
                  const Text("Dog details :",
                      style:
                      TextStyle(fontSize: 22, color: GetColors.black, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                          flex: 3, child: Text("Dog name", style: TextStyle(color: GetColors.black))),
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
                          flex: 3,
                          child: Text("Enter breed", style: TextStyle(color: GetColors.black))),
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
                          flex: 3,
                          child: Text("Choose gender", style: TextStyle(color: GetColors.black))),
                      Expanded(
                        flex: 7,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: tempModel?.gender,
                          onChanged: (String? newValue) {
                            setState(() {
                              tempModel?.gender = newValue;
                            });
                          },
                          items:
                          <String>['Male', 'Female'].map<DropdownMenuItem<String>>((String value) {
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
                          flex: 3, child: Text("Enter age", style: TextStyle(color: GetColors.black))),
                      Expanded(
                        flex: 7,
                        child: TextFormField(
                          readOnly: true,
                          initialValue: tempModel?.age ?? '',
                          keyboardType: TextInputType.name,
                          onChanged: (value) {
                            tempModel?.age = value;
                          },
                          decoration: const InputDecoration(hintText: 'Age in months', isDense: true),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: GetColors.purple),
                onPressed: onSave,
                child: const Text('Save', style: TextStyle(fontSize: 20, color: GetColors.white)),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  onSave(){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      dismissOnTouchOutside: false,
      title: 'Success',
      desc: 'Now your dog is open for adoption',
      btnCancel: null,
      btnOkOnPress: () => Navigator.popUntil(context, ModalRoute.withName(Routes.dashboard)),
    ).show();
  }
}
