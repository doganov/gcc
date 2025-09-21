/* Test method return of a float type on a nil receiver.  */

/* { dg-do run } */
/* { dg-skip-if "" { *-*-* } { "-fnext-runtime" } { "" } } */
#import "../../objc-obj-c++-shared/TestsuiteObject.m"

extern void abort (void);

@interface Foo : TestsuiteObject
- (float) floatValue;
@end

@implementation Foo
- (float) floatValue
{
  return 42.6;
}
@end

int
main (void)
{
  Foo *some = [Foo new];
  Foo *none = nil;
  float valSome __attribute__ ((unused)) = [some floatValue];
  float valNone = [none floatValue];

  if (valNone)
    abort ();

  return 0;
}
