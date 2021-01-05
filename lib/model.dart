class Post {
  final String id;
  final String judul;
  final String penulis;
  final String isi;
  final String tgl;
  final String idkategori;
  final String namakategori;
  final String komentar;
  final String gambar;

  Post({
    this.id,
    this.judul,
    this.penulis,
    this.isi,
    this.tgl,
    this.idkategori,
    this.namakategori,
    this.komentar,
    this.gambar,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return new Post(
      id: json['id'],
      judul: json['judul'],
      penulis: json['penulis'],
      isi: json['isi'],
      tgl: json['tgl'],
      idkategori: json['idkategori'],
      namakategori: json['namakategori'],
      komentar: json['komentar'],
      gambar: json['gambar'],
    );
  }
}
