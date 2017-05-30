int func()
{
  float x = 5;
  float y = x / x * 5 / x / x;
  return y;
}

int main()
{
  for (int i = 0; i < 10; i++)
  {
    func();
  }
}
