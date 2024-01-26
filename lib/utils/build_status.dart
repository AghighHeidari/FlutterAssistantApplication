// ignore_for_file: constant_identifier_names

extension BuildStatusMessage on String {
  String get convertStatus {
    switch (this) {
      case "init":
        return 'آماده‌سازی';
      case "started":
        return 'در حال شروع';
      case "creating_thread":
        return 'در حال ساخت ترد';
      case "generating_code":
        return 'در حال ساخت کد';
      case "creating_flutter_project":
        return 'در حال ایجاد پروژه';
      case "updating_code":
        return 'در حال آپدیت کد';
      case "analyzing_project":
        return 'در حال آنالیز کد';
      case "building_project":
        return 'در حال نهایی‌کردن پروژه';
      case "moving_project":
        return 'در حال انتقال پروژه';
      case "creating_nginx_config":
        return 'در حال تنظیم NginX';
      case "adding_dns_record":
        return 'در حال تنظیم DNS';
      case "handling_ssl_certificate":
        return 'در حال تنظیم SSL';
      case "finished":
        return 'کامل شد!';
      case "error":
        return 'به مشکل خورد!';
      default:
        return this;
    }
  }
}
