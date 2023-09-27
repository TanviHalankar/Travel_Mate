// class Place{
//   final int pid;
//   final  String pname;
//   final String time;
//   final int itid;
//
//   Place({required this.pid, required this.pname, required this.time, required this.itid});
//
//   factory Place.fromJson(Map<String, dynamic> json) {
//     return Place(
//       pid: int.parse(json["pid"]),
//       pname: json["pname"],
//       time: json["time"],
//       itid: int.parse(json["itid"]),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "pid": this.pid,
//       "pname": this.pname,
//       "time": this.time,
//       "itid": this.itid,
//     };
//   }
// //
//   //
//   // factory Place.fromJson(Map<String, dynamic> json) {
//   //   return Place(
//   //     pid: json["pid"],
//   //     pname: json["pname"],
//   //     time: json["time"],
//   //     itid: json["itid"],
//   //   );
//   // }
// //
// }