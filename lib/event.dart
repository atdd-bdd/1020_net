// import 'dart:html';
// import 'dart:typed_data';
//
// class MyEvent {
//   var uuid = UUID();
//   var id = "000000001";
//   var title ="";
//   var startDate = MyDateTime.now();
//   var endDate = MyDateTime.now();
//   var location = "1 Apple Lane, Somewhere, VT";
//   var geoLocation = MyGeoLocation(0.0,0.0);
//   var description = "Something";
//   var tags ="#tag";
//   var linkString = "https://1020.net";
//   var imageString = "https://1020.net";
//   var thumbnailString = "https://1020.net";
//   MyEvent({id= 0.0, title="Default Title",
//       MyDateTime? startDateIn, MyDateTime? endDateIn,
//       location ="",
//       MyGeoLocation? geoLocationIn,
//       description ="", tags =""}):
//         startDate  = startDateIn ?? MyDateTime.now(),
//         endDate = endDateIn ?? MyDateTime.now(),
//         geoLocation = geoLocationIn ?? MyGeoLocation.here(),
//         id = id,
//         title = title,
//         tags = tags,
//         description = description
//      {
//   }
// }
// class MyDateTime {
//   var dateTime = DateTime(2024);
//
//   MyDateTime(DateTime dt) {
//     this.dateTime = dt;
//   }
//   static now()
//   {
//     return MyDateTime(DateTime.now());
//   }
//
// }
//
// class MyGeoLocation {
//   double latitude = 0.0; // Latitude, in degrees
//   double longitude = 0.0; // Longitude, in degrees
//   MyGeoLocation(this.latitude, this.longitude);
//   static here()
//   {
//     return MyGeoLocation(0.0,0.0);
//   }
// }
//
// class UUID {
//   var value = ByteData(16);
// }