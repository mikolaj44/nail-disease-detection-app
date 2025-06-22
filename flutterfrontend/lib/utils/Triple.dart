class Triple<A, B, C> {
  A a;
  B b;
  C c;

  @override
  String toString(){
    return a.toString() + b.toString() + c.toString();
  }

  Triple(this.a, this.b, this.c);
}