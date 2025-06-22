class Pair<A, B> {
  A a;
  B b;

  @override
  String toString(){
    return a.toString() + b.toString();
  }

  Pair(this.a, this.b);
}