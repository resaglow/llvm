#include <stdio.h>

constexpr int N = 16777216 * 4;
int a[N], b[N], c[N];

int main() {
  long n;
  scanf("%ld", &n);
  for (int i = 0; i < n; i++) {
    a[i] = b[i] + c[i];
  }
}