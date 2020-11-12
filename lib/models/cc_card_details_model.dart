import 'dart:convert';

import 'package:flutter/foundation.dart';

class CCCardDetailsModel {
  final String cardPriorityType;
  final String cardTotalAmountHeading;
  final String currencyInCard;
  final double cardTotalAmount;
  final String cardNumber;
  final String cardHolderName;
  final String cardType;

  CCCardDetailsModel({
    @required this.cardPriorityType,
    @required this.cardTotalAmountHeading,
    @required this.currencyInCard,
    @required this.cardTotalAmount,
    @required this.cardNumber,
    @required this.cardHolderName,
    @required this.cardType,
  });

  CCCardDetailsModel copyWith({
    String cardPriorityType,
    String cardTotalAmountHeading,
    String currencyInCard,
    double cardTotalAmount,
    String cardNumber,
    String cardHolderName,
    String cardType,
  }) {
    return CCCardDetailsModel(
      cardPriorityType: cardPriorityType ?? this.cardPriorityType,
      cardTotalAmountHeading:
          cardTotalAmountHeading ?? this.cardTotalAmountHeading,
      currencyInCard: currencyInCard ?? this.currencyInCard,
      cardTotalAmount: cardTotalAmount ?? this.cardTotalAmount,
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      cardType: cardType ?? this.cardType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cardPriorityType': cardPriorityType,
      'cardTotalAmountHeading': cardTotalAmountHeading,
      'currencyInCard': currencyInCard,
      'cardTotalAmount': cardTotalAmount,
      'cardNumber': cardNumber,
      'cardHolderName': cardHolderName,
      'cardType': cardType,
    };
  }

  factory CCCardDetailsModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CCCardDetailsModel(
      cardPriorityType: map['cardPriorityType'],
      cardTotalAmountHeading: map['cardTotalAmountHeading'],
      currencyInCard: map['currencyInCard'],
      cardTotalAmount: map['cardTotalAmount'],
      cardNumber: map['cardNumber'],
      cardHolderName: map['cardHolderName'],
      cardType: map['cardType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CCCardDetailsModel.fromJson(String source) =>
      CCCardDetailsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CCCardDetailsModel(cardPriorityType: $cardPriorityType, cardTotalAmountHeading: $cardTotalAmountHeading, currencyInCard: $currencyInCard, cardTotalAmount: $cardTotalAmount, cardNumber: $cardNumber, cardHolderName: $cardHolderName, cardType: $cardType)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CCCardDetailsModel &&
        o.cardPriorityType == cardPriorityType &&
        o.cardTotalAmountHeading == cardTotalAmountHeading &&
        o.currencyInCard == currencyInCard &&
        o.cardTotalAmount == cardTotalAmount &&
        o.cardNumber == cardNumber &&
        o.cardHolderName == cardHolderName &&
        o.cardType == cardType;
  }

  @override
  int get hashCode {
    return cardPriorityType.hashCode ^
        cardTotalAmountHeading.hashCode ^
        currencyInCard.hashCode ^
        cardTotalAmount.hashCode ^
        cardNumber.hashCode ^
        cardHolderName.hashCode ^
        cardType.hashCode;
  }
}
