/* Test method return of a large struct (passed via memory on many targets) on a
   nil receiver.  */

/* { dg-do run } */
/* { dg-skip-if "" { *-*-* } { "-fnext-runtime" } { "" } } */
#import "../../objc-obj-c++-shared/TestsuiteObject.m"

extern void abort (void);

struct large
{
  int i;
  long l;
  unsigned int u;
  char *p;
  float f1;
  float f2;
  double d1;
  double d2;
};

@interface Foo : TestsuiteObject
- (struct large) structValue;
@end

@implementation Foo
- (struct large) structValue
{
  return (struct large) { -1, 1, 42, "c", -1.5, 42.6, 3.14, -3.14 };
}
@end

int
main (void)
{
  Foo *some = [Foo new];
  Foo *none = nil;
  struct large valSome __attribute__ ((unused)) = [some structValue];
  struct large valNone = [none structValue];

  if (valNone.i || valNone.l || valNone.u || valNone.p
      || valNone.f1 || valNone.f2 || valNone.d1 || valNone.d2)
    abort ();

  return 0;
}
