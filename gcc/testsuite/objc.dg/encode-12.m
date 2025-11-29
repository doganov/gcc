/* { dg-do run } */
/* { dg-skip-if "" { *-*-* } { "-fnext-runtime" } { "" } } */
#include <objc/objc.h>

extern void _exit(int);
extern int strcmp(const char *, const char *);

typedef struct {
  BOOL objc: 1;
  _Bool c: 1;
} anonymous;

#if (CHAR_MIN == 0)
#define C "C"
#else
#define C "c"
#endif

int main (void) {
  if (strcmp (@encode (BOOL), C))
    _exit (-(__LINE__));

  if (strcmp (@encode (_Bool), "B"))
    _exit (-(__LINE__));

  if (strcmp (@encode (anonymous), "{?=b0C1b1B1}"))
    _exit (-(__LINE__));

  return 0;
}
