const int N = 9999999;
int G[N];

__attribute__((noinline))
void example8(int x)
{;
    // for (int i = 0; i < N; i++) {
        if (__builtin_expect(x == 44, 0)) {
            G[0] = 22;
        } else {
            G[0] = 11;
        }
    // }
}

int main()
{
    for (int i = 0; i < 1; i++)
    {
        example8(5);
    }
}
