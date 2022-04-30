class User {
  final int counter;
  User(this.counter);
  User copyWith({int? count}) {
    return User(count ?? counter);
  }
}
