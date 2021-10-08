// class MovieData {
//   String id;
//   String title;
//   String year;
//   String length;
//   String rating;
//   String ratingVotes;
//   String poster;
//   String plot;

//   MovieData({
//     required this.id,
//     required this.title,
//     required this.year,
//     required this.length,
//     required this.rating,
//     required this.ratingVotes,
//     required this.poster,
//     required this.plot,
//   });

//   MovieData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     year = json['year'];
//     length = json['length'];
//     rating = json['rating'];
//     ratingVotes = json['rating_votes'];
//     poster = json['poster'];
//     plot = json['plot'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['year'] = this.year;
//     data['length'] = this.length;
//     data['rating'] = this.rating;
//     data['rating_votes'] = this.ratingVotes;
//     data['poster'] = this.poster;
//     data['plot'] = this.plot;
//     return data;
//   }
// }
