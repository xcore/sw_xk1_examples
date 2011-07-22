// Copyright (c) 2011, XMOS Ltd., All rights reserved
// This software is freely distributable under a derivative of the
// University of Illinois/NCSA Open Source License posted in
// LICENSE.txt and at <http://github.xcore.com/>

/*
 ============================================================================
 Name        : $(sourceFile)
 Description : Flashing LED program for the XK-1 board 
 ============================================================================
 */

#include <xs1.h>
#define FLASH_PERIOD 20000000

out port led = XS1_PORT_4F;

int main(void) {
  timer tmr;
  int t;
  tmr :> t;

  while (1) {
    led <: 0x1;
    t += FLASH_PERIOD;
    tmr when timerafter(t) :> void;
    led <: 0x0;
    t += FLASH_PERIOD;
    tmr when timerafter(t) :> void;
  }
  return 0;
}
