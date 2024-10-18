import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

class MyPaymentHelper extends GetxController {
  Map<String,dynamic>? payementItentData;


  calculateAmount(String amount){
    final a = int.parse(amount);
      return a.toString();

  }


  createPayment(String amount, String currency) async{
    try {
      Map<String,dynamic> body = {
        'amount':calculateAmount(amount),
        'currency':currency,
        'payment_method_type[]':'card'
      };
      Map<String,dynamic> header = {
        'Authorization': "Bearer sk_test_51GQ8hTDVXOXIy9Uxm4xNL9B8TNe81JqkYxwM7is0MerO0x6UOaJJtqyCI9TBTG2CaTj5hIEx7TJpgc19OIj0YXPY00jMNVWtm8",
        'Content-Type': 'application/x-www-form-urlencoded'
      };

      var response = await http.post(Uri("https://api.stripe.com/v1/payments_intents"),header,body);
      return jsonDecode(response.body);


    }catch(e){
      print("afficher l'erreur : $e");
    }

  }



  Future <void> makePayment({required BuildContext context, required String amount, required String currency}) async {
    try {
      payementItentData = await createPayment(amount, currency);
      if(payementItentData != null){
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(

              applePay: PaymentSheetApplePay(merchantCountryCode: 'EUR'),
              googlePay: PaymentSheetGooglePay(merchantCountryCode: 'EUR'),
              merchantDisplayName: "Big Boss",

            )
        );
        await displayPaymentSheet();

      }
    }
    catch(e,s){
      print("afficher les exceptions: $e $s");
    }




  }


  displayPaymentSheet() async {
    try{
      await Stripe.instance.presentPaymentSheet();

    } on StripeException catch (e){
      print("erreur lors de l'afficahge");
    }

  }






}