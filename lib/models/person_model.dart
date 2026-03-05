class Person {
  final String name;
  final String height;
  final String mass;
  final String birthYear;
  final String created;
  final List films;

  Person({
    required this.name,
    required this.height,
    required this.mass,
    required this.birthYear,
    required this.created,
    required this.films,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'],
      height: json['height'],
      mass: json['mass'],
      birthYear: json['birth_year'],
      created: json['created'],
      films: json['films'],
    );
  }
}