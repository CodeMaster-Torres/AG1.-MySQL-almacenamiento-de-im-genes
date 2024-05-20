class Book {
  final int id;
  final String titulo;
  final String autor;
  final String agno;
  final String genero;
  final String editorial;
  final String paginas;
  final String image;

  Book({required this.id, required this.titulo, required this.autor, required this.image});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      titulo: json['titulo'],
      autor: json['autor'],
      editorial: json['editorial'],
      paginas: json['paginas'],
      agno: json['agno'],
      genero: json['genero'],
      image: json['image'],

    );
  }
}
