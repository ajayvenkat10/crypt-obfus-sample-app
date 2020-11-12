import 'package:encdec_obfus_sample_app/models/cc_card_details_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CCCreditCardItem extends StatelessWidget {
  final CCCardDetailsModel creditCard;
  final double cardElevation;

  const CCCreditCardItem({
    Key key,
    @required this.creditCard,
    this.cardElevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              creditCard.cardPriorityType,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue),
              ),
              child: Card(
                margin: EdgeInsets.all(5),
                elevation: cardElevation ?? 0,
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              creditCard.cardTotalAmountHeading,
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 6),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    getFormattedCurrencyText(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              // Expanded(
                              //   flex: 5,
                              //   child: Align(
                              //     alignment: Alignment.centerRight,
                              //     child: Text(
                              //       creditCard.cardNumber,
                              //       style: TextStyle(
                              //         fontSize: 14,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              creditCard.cardNumber,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 18),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    creditCard.cardHolderName,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    creditCard.cardType,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getFormattedCurrencyText() {
    return NumberFormat.simpleCurrency(locale: "kn")
        .format(creditCard.cardTotalAmount);
  }
}
