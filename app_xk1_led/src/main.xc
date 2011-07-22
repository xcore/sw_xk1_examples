// Copyright (c) 2011, XMOS Ltd., All rights reserved
// This software is freely distributable under a derivative of the
// University of Illinois/NCSA Open Source License posted in
// LICENSE.txt and at <http://github.xcore.com/>

/*
 ============================================================================
 Name        : $(sourceFile)
 Description : Illuminate an LED on the XK-1 card 
 ============================================================================
 */

#include <xs1.h>

out port led = XS1_PORT_4F;

int main() {
  led <: 0x1;
  while(1)
    ;
  return 0;
}

