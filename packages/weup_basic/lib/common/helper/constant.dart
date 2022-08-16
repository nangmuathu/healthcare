class AppConstant {
  static const String APP_NAME = 'Nhất Nam Y Viện';
  // static const String BASE_URL = 'http://192.168.1.40:8201/api/v1';
  static const String BASE_URL = 'https://nhatnam.weuptech.vn/cms/api/v1';
  static const String BASE_URL_IMAGE = 'https://nhatnam.weuptech.vn/cms/api';
  // static const String BASE_URL = 'http://192.168.1.40:8201/api/v1';
  static const String SLOGAN = 'Tâm huyết với nghề y - Hết lòng vì người bệnh';
  static const String ADDRESS = 'Biệt thự 16, Ngõ 168 Nguyễn Khánh Toàn, Cầu Giấy, Hà Nội';
  static const String PHONE_NUMBER = '024.8585.1102';
  static const String EMAIL = 'lienhe@nhatnamyvien.com';
  static const String WEBSITE = 'nhatnamyvien.com';
  static const String CODE = 'NNYV';
  static const int LIMIT = 20;
  static const String API_MAP_KEY = 'AIzaSyBFmc4ZEFaWiriBP0P3HDcCM1eEgao9PJk';
  static const String POSITION_STACK_ACCESS_KEY = '0945d0829018e6c33dcb347baa7fbcda';
  static const List<double> LAT_LNG = [21.0391868, 105.7997354];

}

class HttpConstant {
  static const String CONNECT_ERROR = 'Không có kết nối. Vui lòng thử lại sau';
  static const String UNKNOWN = 'Đã có lỗi xảy ra. Vui lòng thử lại sau';
  static const String INTERNAL_ERROR = 'Lỗi máy chủ nội bộ. Vui lòng thử lại sau';
  static const String TIME_OUT = 'Hết hạn yêu cầu. Vui lòng thử lại sau';
  static const String BAD_GATEWAY = 'Server bận. Vui lòng thử lại sau';

  static const String NOT_FOUND = 'Không tìm thấy nội dung yêu cầu. Vui lòng thử lại sau';
  static const String FORBIDDEN = 'Truy cập bị hạn chế. Vui lòng thử lại sau';
  static const String TOKEN_EXPIRED = 'Phiên làm việc đã hết hạn. Vui lòng đăng nhập lại';
}

class LanguageCodeConstant {
  static const String VI = 'vi';
  static const String EN = 'en';
}

class LanguageCountryConstant {
  static const String VI = 'VN';
  static const String EN = 'US';
}

class ThemeModeConstant {
  static const String DARK = 'dark';
  static const String LIGHT  = 'light';
}
