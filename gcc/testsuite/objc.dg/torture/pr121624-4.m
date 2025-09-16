/* Test evaluation order of ObjC method arguments.  */

/* { dg-do run } */
/* { dg-skip-if "" { *-*-* } { "-fnext-runtime" } { "" } } */
#import "../../objc-obj-c++-shared/TestsuiteObject.m"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char actual[1000] = "";

id
n (const char *i)
{
  strcat (actual, i);
  return nil;
}

@interface Foo : TestsuiteObject
- (id) a: (id) a b: (id) b n: (const char *) i;
@end

@implementation Foo
- (id) a: (id) a b: (id) b n: (const char *) i
{
  return n (i);
}
@end

/*  Returns an int that can't be easily optimized away.  */
int
rt_int (const char *s, const char *i)
{
  n (i);
  return atoi (s);
}

int
main (void)
{
  Foo *some = [Foo new];

  [[some a: n ("0") b: n ("1") n: "2"]
	a: n ("3")
	b: [n ("4")
	       a: [some a: n ("5") b: n ("6") n: "7"]
	       b: (rt_int ("0", "8")
		   ? [n ("A") a: n ("B") b: n ("C") n: "D"]
		   : n ("9"))
	       n: "E"]
	n: "F"];

  char expected[] = "0123456789";

  if (strcmp (expected, actual))
    {
      printf ("expected order: %s\n", expected);
      printf ("  actual order: %s\n", actual);
      fflush (stdout);
      abort ();
    }

  return 0;
}
