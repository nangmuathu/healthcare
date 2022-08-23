
import '../../app/app_utils.dart';

class ConfigModel {
  String? linkMessage;
  String? writeDate;
  String? linkZalo;
  String? hotline1;
  String? hotline2;
  String? chPlayLink;
  String? appStoreLink;
  String? companyName;
  String? slogan;
  String? address;
  String? websiteLink;
  String? apiMapCode;
  String? apiMapKey;
  String? email;
  String? baseUrl;
  String? apiImage;
  int? limit;
  String? appVersion;
  String? isMaintenance;
  String? isPopup;
  String? homepageMessage;
  String? latLng;

  ConfigModel({
    this.linkMessage,
    this.writeDate,
    this.linkZalo,
    this.hotline1,
    this.hotline2,
    this.companyName,
    this.appStoreLink,
    this.chPlayLink,
    this.email,
    this.address,
    this.apiMapCode,
    this.apiMapKey,
    this.slogan,
    this.websiteLink,
    this.baseUrl,
    this.apiImage,
    this.limit,
    this.appVersion,
    this.isMaintenance,
    this.isPopup,
    this.homepageMessage,
    this.latLng,
  });

  ConfigModel.fromJson(Map<String, dynamic> json) {
    linkMessage = json['link_message'] ?? '';
    writeDate = json['write_date'] ?? '';
    linkZalo = json['link_zalo'] ?? '';
    hotline1 = json['hotline_1'] ?? '';
    hotline2 = json['hotline_2'] ?? '';
    chPlayLink = json['ch_play_link'] ?? '';
    appStoreLink = json['app_store_link'] ?? '';
    companyName = json['company_name'] ?? '';
    slogan = json['slogan'] ?? '';
    address = json['address'] ?? '';
    websiteLink = json['website_link'] ?? '';
    apiMapCode = json['api_map_key'] ?? '';
    apiMapKey = json['api_map_code'] ?? '';
    email = json['email'] ?? '';
    baseUrl = json['base_url'] ?? '';
    apiImage = json['api_image'] ?? '';
    limit = !empty(json['limit'])
        ? (json['limit'] is String
            ? int.tryParse(json['limit'])
            : json['limit'])
        : null;
    appVersion = json['app_version'] ?? '';
    isMaintenance = json['is_maintenance'] ?? '';
    isPopup = json['is_popup'] ?? '';
    homepageMessage = json['homepage_message'] ?? '';
    latLng = json['lat_lng'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['link_message'] = linkMessage;
    data['write_date'] = writeDate;
    data['link_zalo'] = linkZalo;
    data['hotline_1'] = hotline1;
    data['hotline_2'] = hotline2;
    data['ch_play_link'] = chPlayLink;
    data['app_store_link'] = appStoreLink;
    data['company_name'] = companyName;
    data['slogan'] = slogan;
    data['address'] = address;
    data['website_link'] = websiteLink;
    data['api_map_key'] = apiMapCode;
    data['api_map_code'] = apiMapKey;
    data['email'] = email;
    data['base_url'] = baseUrl;
    data['api_image'] = apiImage;
    data['limit'] = limit;
    data['app_version'] = appVersion;
    data['is_maintenance'] = isMaintenance;
    data['is_popup'] = isPopup;
    data['homepage_message'] = homepageMessage;
    data['lat_lng'] = latLng;
    return data;
  }
}
