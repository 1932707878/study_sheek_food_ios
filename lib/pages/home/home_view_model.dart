// ignore_for_file: public_member_api_docs, sort_constructors_first
class HomeViewModel {
  String id;
  String title;
  String intro;
  List<String> tags;
  int kCalorie;
  double order;
  double cook;
  String img;

  HomeViewModel({
    required this.id,
    required this.title,
    required this.intro,
    this.tags = const [],
    required this.kCalorie,
    required this.order,
    required this.cook,
    required this.img,
  });

  static HomeViewModel initData() {
    return HomeViewModel(
      id: '1',
      title: 'Pan-Seared Chicken',
      intro: 'Pan-seared chicken in a sweetend mustard sauce.',
      tags: ['CHICKEN'],
      kCalorie: 257,
      order: 12,
      cook: 9,
      img: 'img',
    );
  }
}
