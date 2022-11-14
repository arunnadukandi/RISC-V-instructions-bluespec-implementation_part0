//See LICENSE.iitm for license details
/*

Author : Mouna Krishna
Email id : mounakrishna@mindgrovetech.in
Details: The top function which calls the required function depending 
         on the instruction.

--------------------------------------------------------------------------------------------------
*/

/****** Imports *******/
`include "bbox.defines"
import bbox_types :: *;
//`include "Zba.bsv"
`include "Zbb.bsv"
//`include "Zbc.bsv"
`include "Zbs.bsv"
/*********************/


/*doc: function: The top function where depending on the instruction the 
  required function is called, get the result and return it.
  The input argument and return type should not be changed. 
  Other than this, all the other code can be changed as per needs.

  As an example the instruction ANDN of the Zbb group has been implemented.
  NOTE: The value of ANDN in bbox.defines is a temp value, it needed to be 
  changed according to spec.
  The complete Zbb group and all the other groups is expected to be implemented 
  and verified.
*/
function BBoxOutput fn_compute(BBoxInput inp);
  Bit#(XLEN) result;
  Bit#(XLEN_BY_2) result_32;
  //Integer int_result;
  Bool valid;
  case(inp.instr) matches
    `ANDN: begin
      result = fn_andn(inp.rs1, inp.rs2);    // fn to do AND with negated operand
      valid = True;
    end
    // `ANDN_32: begin
    //   result_32 = fn_andn_32(inp.rs1, inp.rs2);    // fn to do AND with negated operand
    //   valid = True;
    // end
    `ORN: begin
      result = fn_orn(inp.rs1,inp.rs2);   // fn to do OR with inverted operand
      valid = True;
    end
    `XNOR: begin
      result = fn_xnor(inp.rs1,inp.rs2);  // fn to do XNOR
      valid = True;
    end
    `CPOP: begin
      result = fn_cpop(inp.rs1);      // fn to do pop count in source register
      valid = True;
    end
    `CPOPW: begin                 
      result = fn_cpopw(inp.rs1);    // fn to count pop count in word
      valid = True;
    end
    `CLZ: begin                 
      result = fn_clz(inp.rs1);    // fn to count leading zeros in source register
      valid = True;
    end
    `CLZW: begin                 
      result = fn_clzw(inp.rs1);    // fn to count leading zeros in word
      valid = True;
    end
    `CTZ: begin                 
      result = fn_ctz(inp.rs1);    // fn to count trailing zeros in source register
      valid = True;
    end
    `CTZW: begin
      result = fn_ctzw(inp.rs1);   // fn to count trailing zero in word
      valid = True;
    end
    `MAX: begin                 
      result = fn_max(inp.rs1, inp.rs2);    // fn to find max amongst two signed numbers
      valid = True;
    end
    `MAXU: begin                 
      result = fn_maxU(inp.rs1, inp.rs2);    // fn to find max amongst two Unsigned numbers
      valid = True;
    end
    `MIN: begin                 
      result = fn_min(inp.rs1, inp.rs2);    // fn to find min amongst two Unsigned numbers
      valid = True;
    end
    `MINU: begin                 
      result = fn_minU(inp.rs1, inp.rs2);    // fn to find min amongst two Unsigned numbers
      valid = True;
    end
    `BCLR: begin
      result = fn_bclr(inp.rs1, inp.rs2);    // fn to do bit clear (register)
      valid =True;
    end
    `BCLRI: begin
      result = fn_bclri(inp.instr, inp.rs1);    // fn to do bit clear (immediate)
      valid =True;
    end
    `BEXT: begin
      result = fn_bext(inp.rs1 , inp.rs1);    // fn to extract single bit (register) - bext
      valid = True;
    end 
    `BEXTI: begin
      result = fn_bexti(inp.instr, inp.rs1);    // fn to do bit extract (immediate)
      valid =True;
    end
    `BINVI: begin
      result = fn_binvi(inp.instr, inp.rs1);    // fn to do bit invert (immediate)
      valid =True;
    end
    `BSET: begin
      result = fn_bset(inp.rs1, inp.rs2);    // fn to do bit set (Register)
      valid =True;
    end
    `BSETI: begin
      result = fn_bseti(inp.instr,inp.rs1);   // fn to do bit set (immediate)
      valid = True;
    end 




      default: begin
      result = 0;
      valid = False;
    end
  endcase
  
  return BBoxOutput{valid: valid, data: result};
endfunction
