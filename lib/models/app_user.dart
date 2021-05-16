class AppUser {
  static const waterPerDayField = 'waterPerDay';
  static const waterNormField = 'waterNorm';

  AppUser(this.waterNorm);

  AppUser.temp() {
    this.waterNorm = 2000;
  }

  AppUser.fromDb(Map<String, dynamic> json) {
    this.waterNorm = json[waterNormField];
  }

  Map<String, dynamic> toJson() {
    return {
      waterNormField: this.waterNorm,
    };
  }

  int waterNorm;

  @override
  String toString() {
    return 'waterNorm: $waterNorm';
  }
}