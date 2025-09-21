/* Test method return of a simple struct (passed via registers on many targets)
   on a nil receiver.  */

/* { dg-do run } */
/* { dg-skip-if "" { *-*-* } { "-fnext-runtime" } { "" } } */
#import "../../objc-obj-c++-shared/TestsuiteObject.m"

extern void abort (void);

struct simple
{
  float f;
  double d;
};

@interface Foo : TestsuiteObject
- (struct simple) structValue;
@end

@implementation Foo
- (struct simple) structValue
{
  return (struct simple) { 42.6, 3.14 };
}
@end

int
main (void)
{
  Foo *some = [Foo new];
  Foo *none = nil;
  struct simple valSome __attribute__ ((unused)) = [some structValue];
  struct simple valNone = [none structValue];

  if (valNone.f || valNone.d)
    abort ();

  return 0;
}
