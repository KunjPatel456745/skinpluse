class AppConstants {
  static const int maxScanPhotoDimension = 1024;
  static const int scanPhotoJpegQuality = 80;
  static const int chatHistoryWindowSize = 20;
  
  static const int maxDailyScansFree = 3; // Note: plan.md says 3 scans per month for free plan
  static const int maxDailyChatMessagesFree = 20; // Note: plan.md says 20 chat messages per month for free plan
  static const int maxDailyScansProPerDay = 30; // Note: plan.md says 30 scans per month for pro
  
  static const int maxProductSuggestionsFree = 1;
  static const int maxProductSuggestionsPro = 5;
  
  static const int otpResendCooldownSeconds = 60;
  static const int maxOtpSendAttempts = 5;
  static const int maxWrongOtpEntries = 5;
  static const int otpLockoutMinutes = 15;
  static const int scanAutoSaveMaxRetries = 3;
}
