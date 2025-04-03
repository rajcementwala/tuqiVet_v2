import '../../localizations/base_localization.dart';
import 'images.dart';

T enumFromString<T>(Iterable<T> values, String value, T defaultValue) {
  return values.firstWhere((type) => type.toString().split('.').last == value,
      orElse: () => defaultValue);
}

enum TextFieldType {
  divider,
  borderBox,
  borderOnly,
}

enum ServiceType {
  all,
  visit,
  care,
  consultation,
}

extension ServiceTypeExtention on ServiceType {
  String get stringFromEnum {
    switch (this) {

      case ServiceType.all:
        return BaseLocalization.currentLocalization().allSmall;
      case ServiceType.visit:
        return BaseLocalization.currentLocalization().visit;
      case ServiceType.care:
        return BaseLocalization.currentLocalization().care;

      case ServiceType.consultation:
        return BaseLocalization.currentLocalization().consultation;

    }
  }

}

enum AddressType {
  home,
  apartment,
  farm,
  desert,
  villa,
  shelter,
  other,
}

enum AppTab { home, bookings, chat, profile }

extension AppTabExtention on AppTab {
  String get tabTitle {
    switch (this) {
      case AppTab.home:
        return BaseLocalization.currentLocalization().home;

      case AppTab.bookings:
        return BaseLocalization.currentLocalization().bookings;

      case AppTab.chat:
        return BaseLocalization.currentLocalization().chat;

      case AppTab.profile:
        return BaseLocalization.currentLocalization().profile;
    }
  }

  String get activeImage {
    switch (this) {
      case AppTab.home:
        return AppSvgImage.icHomeSelected;
      case AppTab.bookings:
        return AppSvgImage.icBookingSelected;

      case AppTab.chat:
        return AppSvgImage.icChatSelected;

      case AppTab.profile:
        return AppSvgImage.icProfileSelected;
    }
  }

  String get inactiveImage {
    switch (this) {

      case AppTab.home:
        return AppSvgImage.icHome;
      case AppTab.bookings:
        return AppSvgImage.icBooking;
      case AppTab.chat:
        return AppSvgImage.icChat;
      case AppTab.profile:
        return AppSvgImage.icProfile;
    }
  }
}

extension AddressTypeExtention on AddressType {
  String get stringFromEnum {
    switch (this) {
      case AddressType.home:
        return BaseLocalization.currentLocalization().home;
      case AddressType.apartment:
        return BaseLocalization.currentLocalization().apartment;
      case AddressType.farm:
        return BaseLocalization.currentLocalization().farm;
      case AddressType.desert:
        return BaseLocalization.currentLocalization().desert;
      case AddressType.villa:
        return BaseLocalization.currentLocalization().villa;
      case AddressType.shelter:
        return BaseLocalization.currentLocalization().shelter;
      case AddressType.other:
        return BaseLocalization.currentLocalization().other;
    }
  }

  String get iconFromEnum {
    switch (this) {
      case AddressType.home:
        return AppSvgImage.icHomeLocation;
      case AddressType.apartment:
        return AppSvgImage.icApartmentLocation;
      case AddressType.farm:
        return AppSvgImage.icFarmLocation;
      case AddressType.desert:
        return AppSvgImage.icDesertLocation;
      case AddressType.villa:
        return AppSvgImage.icVillaLocation;
      case AddressType.shelter:
        return AppSvgImage.icShelterLocation;
      case AddressType.other:
        return AppSvgImage.icOtherLocation;
    }
  }
}

enum ImageType { uri, local }

enum UserType { serviceProvider, animalOwner }

extension UserTypeExtension on UserType {
  static UserType enumFromString(String value) {
    if (value.toLowerCase() == 'Service Provider') {
      return UserType.serviceProvider;
    }

    return UserType.animalOwner;
  }

  String get stringFromEnum {
    if (this == UserType.serviceProvider) {
      return 'Service Provider';
    }
    return 'Animal Owner';
  }

  int get getUserTypeId {
    if (this == UserType.serviceProvider) {
      return 3;
    }
    return 4;
  }
}

enum Gender { male, female, other, none }

extension GenderExtension on Gender {
  static Gender enumFromString(String value) {
    if (value.toLowerCase() == 'male') {
      return Gender.male;
    }
    if (value.toLowerCase() == 'female') {
      return Gender.female;
    }
    return Gender.other;
  }

  String get stringFromEnum {
    if (this == Gender.male) {
      return 'male';
    }
    if (this == Gender.female) {
      return 'female';
    }
    return 'other';
  }
}

enum FeedType { image, video }

extension FeedTypeExtension on FeedType {
  static FeedType enumFromString(String value) {
    if (value.toLowerCase() == 'image') {
      return FeedType.image;
    }
    return FeedType.video;
  }

  String get stringFromEnum {
    if (this == FeedType.image) {
      return 'Image';
    }
    return 'Video';
  }
}

enum BusinessProvider { google, square, unknown }

extension BusinessTypeExtension on BusinessProvider {
  String get getStringValue {
    switch (this) {
      case BusinessProvider.google:
        return 'google';
      case BusinessProvider.square:
        return 'square';
      case BusinessProvider.unknown:
        return '';
    }
  }
}

extension StringExtension on String {
  BusinessProvider get parseBusinessType {
    switch (this) {
      case 'square':
        return BusinessProvider.square;
      case 'google':
        return BusinessProvider.google;
      default:
        return BusinessProvider.unknown;
    }
  }

  WeekDay get parseWeekDaysType {
    switch (this) {
      case 'SUN':
      case 'Sunday':
        return WeekDay.sun;
      case 'MON':
      case 'Monday':
        return WeekDay.mon;
      case 'TUE':
      case 'Tuesday':
        return WeekDay.tue;
      case 'WED':
      case 'Wednesday':
        return WeekDay.wed;
      case 'THU':
      case 'Thursday':
        return WeekDay.thu;
      case 'FRI':
      case 'Friday':
        return WeekDay.fri;
      case 'SAT':
      case 'Saturday':
        return WeekDay.sat;
      default:
        return WeekDay.unknown;
    }
  }

  DineInRequest get parseDineInRequest {
    switch (this) {
      case 'accepted':
      case 'Accepted':
        return DineInRequest.accepted;
      case 'rejected':
      case 'Rejected':
        return DineInRequest.rejected;
      case 'countered':
      case 'Countered':
        return DineInRequest.countered;
      default:
        return DineInRequest.initial;
    }
  }
}

enum TimeSlot { am7, am11, pm5 }

extension TimeSlotExtension on TimeSlot {
  String get getStringValue {
    switch (this) {
      case TimeSlot.am7:
        return '7 AM';
      case TimeSlot.am11:
        return '11 AM';
      case TimeSlot.pm5:
        return '5 PM';
    }
  }
}

enum LocationPermissionState {
  enable,
  disable,
  denied,
  deniedForever,
  unableToDetermine,
}

enum WeekDay { sun, mon, tue, wed, thu, fri, sat, unknown }

extension WeekDaysExtension on WeekDay {
  String get getStringValue {
    switch (this) {
      case WeekDay.sun:
        return 'SUN';
      case WeekDay.mon:
        return 'MON';
      case WeekDay.tue:
        return 'TUE';
      case WeekDay.wed:
        return 'WED';
      case WeekDay.thu:
        return 'THU';
      case WeekDay.fri:
        return 'FRI';
      case WeekDay.sat:
        return 'SAT';
      case WeekDay.unknown:
        return '';
    }
  }

  String get getFullStringValue {
    switch (this) {
      case WeekDay.sun:
        return 'Sunday';
      case WeekDay.mon:
        return 'Monday';
      case WeekDay.tue:
        return 'Tuesday';
      case WeekDay.wed:
        return 'Wednesday';
      case WeekDay.thu:
        return 'Thursday';
      case WeekDay.fri:
        return 'Friday';
      case WeekDay.sat:
        return 'Saturday';
      case WeekDay.unknown:
        return '';
    }
  }
}

enum DineInRequest { initial, accepted, rejected, countered }

extension DineInRequestExtension on DineInRequest {
  String get getStringValue {
    switch (this) {
      case DineInRequest.initial:
        return '';
      case DineInRequest.accepted:
        return 'Accepted';
      case DineInRequest.rejected:
        return 'Rejected';
      case DineInRequest.countered:
        return 'Countered';
    }
  }
}


enum OwnerProfileOptions {
  addresses, aboutUs, termsAndCondition, privacyPolicy,faqs,contactUs,logout,deleteAccount
}


extension OwnerProfileOptionsExtension on OwnerProfileOptions {
  String get getStringValue {
    switch (this) {

      case OwnerProfileOptions.addresses:
      return BaseLocalization.currentLocalization().addresses;
      case OwnerProfileOptions.aboutUs:
        return BaseLocalization.currentLocalization().aboutUs;
      case OwnerProfileOptions.termsAndCondition:
        return BaseLocalization.currentLocalization().termsAndCondition;

      case OwnerProfileOptions.privacyPolicy:
        return BaseLocalization.currentLocalization().privacyPolicy;

      case OwnerProfileOptions.faqs:
        return BaseLocalization.currentLocalization().faqs;

      case OwnerProfileOptions.contactUs:
        return BaseLocalization.currentLocalization().contactUs;
      case OwnerProfileOptions.logout:
        return BaseLocalization.currentLocalization().logout;
      case OwnerProfileOptions.deleteAccount:
        return BaseLocalization.currentLocalization().deleteAccount;
    }
  }
  String get getIcon {
    switch (this) {

      case OwnerProfileOptions.addresses:
        return AppSvgImage.icAddresses;
      case OwnerProfileOptions.aboutUs:
        return AppSvgImage.icAboutUs;
      case OwnerProfileOptions.termsAndCondition:
        return AppSvgImage.icTermsAndCondition;
      case OwnerProfileOptions.privacyPolicy:
        return AppSvgImage.icPrivacyPolicy;
      case OwnerProfileOptions.faqs:
        return AppSvgImage.icFaqs;
      case OwnerProfileOptions.contactUs:
        return AppSvgImage.contactUs;
      case OwnerProfileOptions.logout:
        return AppSvgImage.icLogout;
      case OwnerProfileOptions.deleteAccount:
        return AppSvgImage.icDeleteAccount;
    }
  }
}



enum ShareAppType {
  customer,
  business,
}
