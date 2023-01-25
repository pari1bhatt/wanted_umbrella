import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../routes.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';

class GIftPayment extends StatefulWidget {
  const GIftPayment({Key? key}) : super(key: key);

  @override
  State<GIftPayment> createState() => _GIftPaymentState();
}

class _GIftPaymentState extends State<GIftPayment> {
  int? currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Payment")),
      body: getPaymentPage(),
    );
  }

  getPaymentPage() {
    switch (currentPage) {
      case 0:
        return paymentOptions();
      case 1:
        return paymentDetail();
      case 2:
        return paymentEmail();
    }
  }

  paymentOptions() {
    return Column(
      children: [
        ListTile(
          onTap: () => setState(() => currentPage = 1),
          leading: Icon(Icons.radio_button_off, color: GetColors.black),
          title: Text('ATM Card/ Debit Card / Credit Card'),
        ),
        getDivider(),
        ListTile(
          leading: Icon(Icons.radio_button_off, color: GetColors.grey),
          title: InkWell(
            onTap: () {},
            child: Text('Cash on Delivery', style: TextStyle(color: GetColors.grey)),
          ),
          subtitle: Text('(not applicable)', style: TextStyle(color: GetColors.grey)),
        ),
        getDivider()
      ],
    );
  }

  paymentDetail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Enter card details',
              style: TextStyle(fontSize: 20, color: GetColors.black, fontWeight: FontWeight.w500)),
          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                  flex: 4,
                  child:
                      Text("Card number", style: TextStyle(fontSize: 16, color: GetColors.black))),
              Expanded(
                flex: 6,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: Utils.validateText,
                  decoration: const InputDecoration(hintText: 'Enter card number', isDense: true),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                  flex: 4,
                  child:
                      Text("Holder name", style: TextStyle(fontSize: 16, color: GetColors.black))),
              Expanded(
                flex: 6,
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))],
                  validator: Utils.validateText,
                  decoration: const InputDecoration(hintText: 'Enter Holder name', isDense: true),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                  flex: 4,
                  child: Text("CVV", style: TextStyle(fontSize: 16, color: GetColors.black))),
              Expanded(
                flex: 6,
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3)
                  ],
                  validator: Utils.validateText,
                  decoration: const InputDecoration(
                      hintText: 'Enter CVV', isDense: true, counter: SizedBox()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                  flex: 4,
                  child: Text("Exp. Date", style: TextStyle(fontSize: 16, color: GetColors.black))),
              Expanded(
                flex: 6,
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                    CardMonthInputFormatter(),
                  ],
                  validator: Utils.validateText,
                  decoration:
                      const InputDecoration(hintText: 'MM/YY', isDense: true, counter: SizedBox()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Center(
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: GetColors.purple),
              onPressed: () => setState(() => currentPage = 2),
              child: const Text('Next', style: TextStyle(fontSize: 20, color: GetColors.white)),
            ),
          )
        ],
      ),
    );
  }

  paymentEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Enter valid Email-ID',
              style: TextStyle(fontSize: 20, color: GetColors.black, fontWeight: FontWeight.w500)),
          const SizedBox(height: 30),
          TextFormField(
            keyboardType: TextInputType.name,
            validator: Utils.validateText,
            decoration:
            const InputDecoration(border: OutlineInputBorder(),
                hintText: 'abcd12@gmasil.com', isDense: true, counter: SizedBox()),
          ),
          const SizedBox(height: 50),
          Center(
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: GetColors.purple),
              onPressed: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  animType: AnimType.scale,
                  dismissOnTouchOutside: false,
                  title: 'Thank you for shopping',
                  desc: 'I hope you had a good payment experience. Wanted Umbrella wish you luck !!',
                  btnCancel: null,
                  btnOkOnPress: () => Navigator.popUntil(context, ModalRoute.withName(Routes.dashboard)),
                ).show();
              },
              child: const Text('Make Payment', style: TextStyle(fontSize: 20, color: GetColors.white)),
            ),
          )

        ],
      ),
    );
  }

  getDivider() {
    return const Divider(thickness: 1, color: GetColors.black87, height: 10);
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string, selection: TextSelection.collapsed(offset: string.length));
  }
}
