class Weathermodel{
  final String icon;
  final String durum;
  final String derece;
  final String min;
  final String nem;
  final String max;
  final String gece;
  final String date;

  Weathermodel(this.icon, this.durum, this.derece, this.min, this.nem, this.max, this.gece, this.date);

  Weathermodel.fromJson(Map<String,dynamic> json)
   :icon=json['icon'],
        durum=json['description'],
        derece= json['degree'],
        min=json['min'],
        max=json['max'],
        gece= json['night'],
        date=json['date'],
        nem=json['humidity'];

}