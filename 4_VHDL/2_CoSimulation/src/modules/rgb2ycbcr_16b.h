#ifndef _SCGENMOD_rgb2ycbcr_16b_
#define _SCGENMOD_rgb2ycbcr_16b_
 
#include "systemc.h"
 
 class rgb2ycbcr_16b : public sc_foreign_module
 {
 public:
     sc_in<sc_logic>    clk;
     sc_in<sc_lv<24> >  i_data;
     sc_out<sc_lv<24> > o_data;
     sc_in<sc_logic>    i_valid;
     sc_out<sc_logic>   o_valid;
 
     rgb2ycbcr_16b(sc_module_name nm, const char* hdl_name)
      : sc_foreign_module(nm),
        clk("clk"),
        i_data("i_data"),
        o_data("o_data"),
        i_valid("i_valid"),
        o_valid("o_valid")
     {
         elaborate_foreign_module(hdl_name);
     }
     ~rgb2ycbcr_16b()
     {}
 
 };
 
#endif
