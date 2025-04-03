import 'package:get_localization/get_localization.dart';

abstract class BaseLocalization extends Localization {
  BaseLocalization({
    required String code,
    required String name,
    String? country,
  }) : super(
          code: code,
          name: name,
          country: country,
        );

  static BaseLocalization currentLocalization() =>
      Localization.currentLocalization as BaseLocalization;
  String get appName;
  String get cancelApiRequestError;
  String get connectionTimeoutApiRequestError;
  String get sendTimeoutApiRequestError;
  String get receiveTimeoutApiRequestError;
  String get invalidStatusApiRequestError;
  String get commonApiError;

  String get errorTitle;
  String get errorRetry;
  String get noItem;
  String get noInternetConnection;
  String get dynamicText;
  String get users;
  String get theme;
  String get nextScreen;
  String get back;
  String get splashText;
  String get whoAreYou;
  String get chooseRoleToStart;
  String get serviceProvider;
  String get serviceProviderDesc;

  String get animalOwner;
  String get animalOwnerDesc;
  String get lblContinue;
  String get getStarted;
  String get loginDescription;
  String get phone;
  String get enterYourPhone;
  String get pleaseEnterPhone;
  String get enterValidPhone;
  String get continueAgreeTo;
  String get termsAndCondition;
  String get continueAsGuest;
  String get verification;
  String get otpDescription;
  String get lblCode;
  String get didNotGetCode;
  String get resend;
  String get verify;


  String get createAccountTitle;
  String get createAccountDescription;
  String get addressDetails;
  String get addressDetailsDesc;
  String get fillAddressFromMap;
  String get openMap;
  String get saveAddressAs;
  String get home;
  String get apartment;
  String get farm;
  String get desert;
  String get villa;
  String get shelter;
  String get other;
  String get city;
  String get select;
  String get district;
  String get street;
  String get enterFullName;
  String get enterYourFullName;
  String get enterStreetName;
  String get buildingType;
  String get buildingNumber;
  String get floorNumber;
  String get apartmentNumber;
  String get abbreviationName;
  String get enterAbbreviationName;
  String get bookings;
  String get chat;
  String get profile;


  String get searchYourKeyword;
  String get veterinaryVisit;
  String get veterinaryCare;
  String get consultation;
  String get bookVisit;
  String get getCare;
  String get consultNow;
  String get upcomingVisit;
  String get all;
  String get updateThisWeek;
  String get upcomingBookings;
  String get pastBookings;
  String get allSmall;
  String get visit;
  String get care;
  String get edit;


  String get unknown;
  String get addresses;
  String get aboutUs;
  String get privacyPolicy;
  String get faqs;
  String get contactUs;
  String get logout;
  String get deleteAccount;
  String get chooseAnimalType;
  String get selectAnimalForBetterResult;
  String get language;





  String get reviews;
  String get confirmed;
  String get numberOfAnimals;
  String get visitType;
  String get complaintOrSymptoms;
  String get invoiceDetails;
  String get animal;
  String get serviceCharge;
  String get platformCharge;
  String get total;
  String get sar;
  String get cancelBooking;
  String get bookingInformation;
  String get time;
  String get pendingApproval;
  String get cancelBookingRequest;
  String get pendingPayment;
  String get paymentNow;
  String get rejected;
  String get rejectionNote;
  String get addReview;
  String get place;
  String get about;
  String get reviewAndRating;
  String get bookAnAppointment;
  String get veterinaryCareSingle;














}
