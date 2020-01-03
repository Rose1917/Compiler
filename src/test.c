/*This is test comment*/
int gcd (int u, int v)
{  if (v == 0) return u;
else return v;
/* u-u/v*v == u mod v */
}
void main(void)
{  int x; int y;
x = input(); y = input();
output(gcd(x,y));
}

