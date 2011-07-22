// Copyright (c) 2011, XMOS Ltd., All rights reserved
// This software is freely distributable under a derivative of the
// University of Illinois/NCSA Open Source License posted in
// LICENSE.txt and at <http://github.xcore.com/>

/*
 ============================================================================
 Name        : $(sourceFile)
 Description : Flash and cycle LEDs at different rates 
 ============================================================================
 */

#include <xs1.h>

#define FLASH_PERIOD 10000000
#define CYCLE_PERIOD 50000000

out port led = XS1_PORT_4F;

int main(void) {

  unsigned ledOn = 1;
  unsigned ledVal = 1;
  timer tmrF, tmrC;
  unsigned timeF, timeC;
  tmrF :> timeF;
  tmrC :> timeC;

  while (1) {
    select {
      case tmrF when timerafter(timeF) :> void:
        ledOn = !ledOn;
	if (ledOn) led <: ledVal;
	else led <: 0;
        timeF += FLASH_PERIOD;
        break;
      case tmrC when timerafter(timeC) :> void:
        ledVal <<= 1;
        if (ledVal == 0x10)
          ledVal = 1;
        timeC += CYCLE_PERIOD;
        break;
    }
  }
  return 0;
}
