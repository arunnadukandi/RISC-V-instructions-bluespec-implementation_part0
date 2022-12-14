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
`include "Zba.bsv"
`include "Zbb.bsv"
`include "Zbc.bsv"
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
    `SH1ADD: begin
      result = fn_sh1add(inp.rs1,inp.rs2); // fn to shift left bit by 1 and add to rs2
      valid = True;
    end
    `SH2ADD: begin
      result = fn_sh2add(inp.rs1,inp.rs2); // fn to shift left bit by 2 and add to rs2
      valid = True;
    end
    `SH3ADD: begin
      result = fn_sh3add(inp.rs1,inp.rs2); // fn to shift left bit by 3 and add to rs2
      valid = True;
    end
    `ADDUW: begin
      result = fn_adduw(inp.rs1,inp.rs2); // clear 32 bits of rs1 and add to rs2
      valid = True;
    end
    `SH1ADDUW: begin
      result = fn_sh1adduw(inp.rs1,inp.rs2); // fn to extract 32 bits from rs1 and shift by 1 and add yo rs2
      valid = True;
    end
    `SH2ADDUW: begin
      result = fn_sh2adduw(inp.rs1,inp.rs2); // fn to extract 32 bits from rs1 and shift by 2 and add yo rs2
      valid = True;
    end
    `SH3ADDUW: begin
      result = fn_sh3adduw(inp.rs1,inp.rs2); // fn to extract 32 bits from rs1 and shift by 3 and add yo rs2
      valid = True;
    end
    `CLMUL: begin
      result = fn_clmul(inp.rs1,inp.rs2); // fn to find carry less multiplication (lower 16 bit)
      valid = True;
    end
    `CLMULH: begin
      result = fn_clmulh(inp.rs1,inp.rs2); // fn to find carry less multiplication (higher 16 bit)
      valid = True;
    end
    `ROL: begin
      result = fn_rol(inp.rs1,inp.rs2);   // fn to rotate left
      valid = True;
    end
    `ROR: begin
      result = fn_ror(inp.rs1,inp.rs2);   // fn to rotate right
      valid = True;
    end
    `ZEXTH: begin
      result = fn_zexth(inp.rs1);   // fn to zero extend
      valid = True;
    end
    `SLLIUW: begin
      result = fn_slliuw(inp.rs1,inp.instr);   // fn to do slliuw
      valid = True;
    end
    `SEXTB: begin
      result = fn_sextb(inp.rs1);   // fn to do slliuw
      valid = True;
    end
      default: begin
      result = 0;
      valid = False;
    end
  endcase
  
  return BBoxOutput{valid: valid, data: result};
endfunction
