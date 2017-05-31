int fun(int x) {
  int a = 0, b = 0;
  switch (x) {
  case 1:
    a = 5;
    break;
  case 2:
    a = 10;
    break;
  }
  return a;
}

int main() {
  fun(5);
}