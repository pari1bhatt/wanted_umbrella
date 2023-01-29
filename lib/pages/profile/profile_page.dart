import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanted_umbrella/models/user_model.dart';
import 'package:wanted_umbrella/pages/dashboard_provider.dart';
import 'package:wanted_umbrella/utils/constants.dart';

import '../../routes.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  var textStyle = const TextStyle(fontSize: 18, color: GetColors.black87);

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, bloc, _) {
      return SafeArea(
        child: ListView(
          children: [
            getDivider(),
            ListTile(
              leading: CircleAvatar(
                  radius: 40,
                  foregroundImage: NetworkImage(
                      bloc.currentUserModel?.profile_image ?? GetImages.placeholderNetwork)),
              title: Text(bloc.currentUserModel?.dog_name ?? '',
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
              subtitle: InkWell(
                onTap: () => Navigator.pushNamed(context, Routes.dog_profile),
                child: const Text(
                  "edit personal details and photos",
                  style:
                      TextStyle(color: GetColors.lightBlue, decoration: TextDecoration.underline),
                ),
              ),
            ),
            getDivider(),
            getListTile('Vaccination details',
                onTap: () => Navigator.pushNamed(context, Routes.vaccination)),
            getDivider(),
            getListTile('Put your dog for adoption',
                onTap: () => Navigator.pushNamed(context, Routes.adoption)),
            getDivider(),
            ExpansionTile(
              initiallyExpanded: true,
              title: Text('Support', style: textStyle),
              iconColor: GetColors.grey,
              children: <Widget>[
                getListTile('     Help', onTap: () => Navigator.pushNamed(context, Routes.help)),
                getListTile('     Terms and conditions', icon: Icons.open_in_new),
                getListTile('     Privacy policy', icon: Icons.open_in_new),
              ],
            ),
            getDivider(),
            getListTile('App version', icon: null),
            getDivider(),
            ListTile(
              onTap: () => onLogout(bloc, context),
              title: Center(
                  child: Text("Logout", style: TextStyle(fontSize: 20, color: GetColors.red))),
            )
          ],
        ),
      );
    });
  }

  onLogout(DashboardProvider bloc, context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.scale,
      title: 'Logout',
      desc: 'Are you sure you want to sign out of the application?',
      btnCancelOnPress: () => Navigator.popUntil(context, ModalRoute.withName(Routes.dashboard)),
      btnOkOnPress: () async {
        await FirebaseAuth.instance.signOut();
        bloc.reset();
        Navigator.popUntil(context, ModalRoute.withName(Routes.login));
      },
    ).show();
  }

  getListTile(text, {IconData? icon = Icons.navigate_next, onTap}) {
    return ListTile(
      onTap: onTap,
      title: Text(text, style: textStyle),
      trailing: icon == null ? Text('1.0.0', style: textStyle) : Icon(icon, size: 28),
    );
  }

  getDivider() {
    return const Divider(thickness: 1, color: GetColors.black87, height: 10);
  }
}
