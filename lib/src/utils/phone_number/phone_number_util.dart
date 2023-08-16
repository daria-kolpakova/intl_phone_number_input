import 'package:intl_phone_number_input/src/utils/phone_number.dart';

/// A wrapper class [PhoneNumberUtil] that basically switch between plugin available for `Web` or `Android or IOS` and `Other platforms` when available.
class PhoneNumberUtil {
  /// [isValidNumber] checks if a [phoneNumber] is valid.
  /// Accepts [phoneNumber] and [isoCode]
  /// Returns [Future<bool>].
  static Future<bool?> isValidNumber({required String phoneNumber, required String isoCode}) async {
    if (phoneNumber.length < 2) {
      return false;
    }
    return true;
  }

  /// [normalizePhoneNumber] normalizes a string of characters representing a phone number
  /// Accepts [phoneNumber] and [isoCode]
  /// Returns [Future<String>]
  static Future<String?> normalizePhoneNumber({required String phoneNumber, required String dealCode}) async {
    return dealCode + phoneNumber;
  }

  /// Accepts [phoneNumber] and [isoCode]
  /// Returns [Future<RegionInfo>] of all information available about the [phoneNumber]
  static Future<RegionInfo> getRegionInfo({
    required String phoneNumber,
    required String isoCode,
    required String regionPrefix,
  }) async {
    return RegionInfo(regionPrefix: regionPrefix, formattedPhoneNumber: phoneNumber, isoCode: isoCode);
  }

  /// Accepts [phoneNumber] and [isoCode]
  /// Returns [Future<PhoneNumberType>] type of phone number
  static Future<PhoneNumberType> getNumberType() async {
    return PhoneNumberType.MOBILE;
  }

  /// [formatAsYouType] uses Google's libphonenumber input format as you type.
  /// Accepts [phoneNumber] and [isoCode]
  /// Returns [Future<String>]
  static Future<String?> formatAsYouType({required String phoneNumber, required String dealCode}) async {
    for (int i = dealCode.length, j = 0; i < phoneNumber.length; i++, j++) {
      if (j == 4 || j == 8) {
        phoneNumber = phoneNumber.replaceRange(i, i + 1, ' ' + phoneNumber[i]);
      }
    }
    return phoneNumber;
  }
}

/// [RegionInfo] contains regional information about a phone number.
/// [isoCode] current region/country code of the phone number
/// [regionPrefix] dialCode of the phone number
/// [formattedPhoneNumber] national level formatting rule apply to the phone number
class RegionInfo {
  String? regionPrefix;
  String? isoCode;
  String? formattedPhoneNumber;

  RegionInfo({this.regionPrefix, this.isoCode, this.formattedPhoneNumber});

  RegionInfo.fromJson(Map<String, dynamic> json) {
    regionPrefix = json['regionCode'];
    isoCode = json['isoCode'];
    formattedPhoneNumber = json['formattedPhoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['regionCode'] = this.regionPrefix;
    data['isoCode'] = this.isoCode;
    data['formattedPhoneNumber'] = this.formattedPhoneNumber;
    return data;
  }

  @override
  String toString() {
    return '[RegionInfo prefix=$regionPrefix, iso=$isoCode, formatted=$formattedPhoneNumber]';
  }
}

/// [PhoneNumberTypeUtil] helper class for `PhoneNumberType`
class PhoneNumberTypeUtil {
  /// Returns [PhoneNumberType] for index [value]
  static PhoneNumberType getType(int? value) {
    switch (value) {
      case 0:
        return PhoneNumberType.FIXED_LINE;
      case 1:
        return PhoneNumberType.MOBILE;
      case 2:
        return PhoneNumberType.FIXED_LINE_OR_MOBILE;
      case 3:
        return PhoneNumberType.TOLL_FREE;
      case 4:
        return PhoneNumberType.PREMIUM_RATE;
      case 5:
        return PhoneNumberType.SHARED_COST;
      case 6:
        return PhoneNumberType.VOIP;
      case 7:
        return PhoneNumberType.PERSONAL_NUMBER;
      case 8:
        return PhoneNumberType.PAGER;
      case 9:
        return PhoneNumberType.UAN;
      case 10:
        return PhoneNumberType.VOICEMAIL;
      default:
        return PhoneNumberType.UNKNOWN;
    }
  }
}
