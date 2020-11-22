import 'dart:async';
import 'dart:convert';
import 'package:encdec_obfus_sample_app/apis/api.dart';
import 'package:encdec_obfus_sample_app/models/cc_card_details_model.dart';
import 'package:encdec_obfus_sample_app/utils/encryption_decryption_utils.dart';
import 'package:encdec_obfus_sample_app/views/cc_credit_card_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_client_helper/http_client_helper.dart' as httpClient;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _nameFieldController = TextEditingController();
  CCCardDetailsModel _creditCard;
  httpClient.CancellationToken cancellationToken;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _handleGetResponses() {
    cancellationToken = new httpClient.CancellationToken();
    for (var i = 0; i < 50; i++) {
      _handleGetResponse();
      if (i == 5) {
        _handleCancel();
        // print("Hello");
      }
    }
  }

  _handleGetResponse() async {
    String question = _nameFieldController.text?.trim();

    if (question == null || question.length == 0) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Name cannot be empty. Please enter a name.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    try {
      String key = AesCryptHelper.generateAesKey();
      print(key);
      final response = await httpClient.HttpClientHelper.post(
        Api.getCreditCard,
        body: AesCryptHelper.encryptData(getRequestBody(), key),
        headers: getHeaderMap(key),
        cancelToken: cancellationToken,
        timeRetry: Duration(seconds: 2),
        retries: 3,
        timeLimit: Duration(seconds: 30),
      );

      if (response.statusCode == 200 && response.body != null) {
        String decryptedResponse =
            AesCryptHelper.decryptData(response.body, key);
        print(decryptedResponse);
        Map<String, dynamic> responseBody = json.decode(decryptedResponse);
        CCCardDetailsModel creditCard =
            CCCardDetailsModel.fromMap(responseBody);
        setState(() {
          _creditCard = creditCard;
        });
      } else {
        print(response.statusCode);
      }
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
    }
  }

  getRequestBody() {
    final data = {'name': _nameFieldController.text.toString()};
    return data.toString();
  }

  getHeaderMap(String key) {
    return <String, String>{
      'Authorization':
          'Bearer eyJhbGciOiJSU0EtT0FFUC0yNTYiLCJlbmMiOiJBMjU2Q0JDLUhTNTEyIn0.VZKhmwoWIypOPDHK2-hOnS38YVcvO09fMpxnEMzdyWQy0PZgC57LcIRmDOTfgwGuiCMj_GGw7dnMia20DUn_bOfpXvWeOZM5csGn1WWFN-sv3-RFp_F9Ap97hVhJPhdecpUzhkfD67tWFU5BB2kPhMU5hS1CiEcwSL_rEuIPr_5ssvcdhTRUAqMP34j8hMUPnhQodwyrljwD7Y0hvpi1yTdhtTfw1U_sLdc9pUFAq4WdRzlUkMVX-bjEsUtvzAPTYmgtOzd1a163ioxvXPW9Yie2AeSFOeari7xe3IujAjgMNDEtJ_LMyoUc-mYfSsoBiQMpjaR1V6DUNVz7qu4BAA.q8nc-pBLEnfWTymGWBf3IQ._VInoTLuCqBFJaF09AlCMNrF-ttL89sbJEIZibDC_aJR6N34EPGIO90JGqR1wDX9K82XKKG3H8hUL7wQZKgCyTE2xKGgO0ID3RMWmI3liR3GF4fjRFL618csuO52Nqym8tZlHY7mFzBfzBPcSuO2OA.DoqpLAATXvpbQjohzn-VCaUZ-ZH_mcZ_Cx9-UB-q1DE',
      'IOS_RR1AS9LA97': AesCryptHelper.encryptKey(key),
      'device_type': 'web'
    };
  }

  void _handleReset() {
    _nameFieldController.text = " ";
    setState(() {
      _creditCard = null;
    });
  }

  void _handleCancel() {
    cancellationToken?.cancel();
  }

  // FutureOr _handleTimeout() {
  //   print('Timed Out');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Sample App"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 0.5 *
                    MediaQuery.of(context)
                        .size
                        .width, // Obtain screen size and the fractional value states how much of the screen size should the widget size be
                child: TextField(
                  controller: _nameFieldController,
                  decoration: InputDecoration(
                    labelText: "Enter your name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              if (_creditCard != null)
                CCCreditCardItem(creditCard: _creditCard),
              if (_creditCard != null)
                SizedBox(
                  height: 16,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RaisedButton(
                    child: Text(
                      "Get Credit Card",
                    ),
                    onPressed: _handleGetResponses,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RaisedButton(
                    child: Text(
                      "Cancel",
                    ),
                    onPressed: _handleCancel,
                    color: Colors.white,
                    textColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RaisedButton(
                    child: Text(
                      "Reset",
                    ),
                    onPressed: _handleReset,
                    color: Colors.white,
                    textColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
