// Copyright (c) 2011, XMOS Ltd., All rights reserved
// This software is freely distributable under a derivative of the
// University of Illinois/NCSA Open Source License posted in
// LICENSE.txt and at <http://github.xcore.com/>

/*
 ============================================================================
 Name        : $(sourceFile)
 Description : Flash and cycle LEDs at different rates and respond to buttons 
 ============================================================================
*/

#include <xs1.h>

out port p_leds_3_0 = XS1_PORT_4F;
in port p_button_0 = XS1_PORT_1K;
in port p_button_1 = XS1_PORT_1L;

void flashLeds(out port leds, chanend c);
void buttonListener(in port button, chanend c);

int main()
{
  chan c;
  par
  {
    flashLeds(p_leds_3_0, c);
    buttonListener(p_button_0, c);
  }
  return 0;
}

void flashLeds(out port leds, chanend c)
{  
  timer t;
  unsigned int time;
  int ledVal = 1;
  int isOn = 1;

  t :> time;

  leds <: ledVal;
  while (1)
  {
    
    select
    {
      case t when timerafter(time) :> void:
      {
        if (isOn)
          leds <: ledVal;
        else
          leds <: 0;
        
        isOn = !isOn;
        
        time += 50000000;
        break;
      }
      
      case c :> ledVal :
      {
        break;
      }
    }
  }
}

void buttonListener(in port button, chanend c)
{
  int led = 1;
  while (1)
  {
    select
    {
      case button when pinseq(0) :> void:
      {
        c <: led;
        led = (led + 1) & 0xF;
        
        button when pinseq(1) :> void;
        
        break;
      }
    }
  }
}
