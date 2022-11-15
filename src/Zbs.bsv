// Function to clear bit based on index - bclr

function Bit#(XLEN) fn_bclr(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
    Bit#(XLEN) result;
    let index = rs2 & (fromInteger(valueOf(XLEN)-1));
    result = rs1 & ~(1 << index);
  
    return result;
  endfunction
  
  // Function to bit clear (immediate) bclri
  function Bit#(XLEN) fn_bclri(Bit#(32) instr , Bit#(XLEN) rs1);
    let shamt = instr;
    Bit#(XLEN) result;
    let index = shamt & (fromInteger(valueOf(XLEN)-1));
    result = rs1 & ~(1 << index);
    return result;
  endfunction

  // Function to extract single-bit (Register) -- bext
  function Bit#(XLEN) fn_bext(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
    Bit#(XLEN) result;
    let index = rs2 & (fromInteger(valueOf(XLEN)-1));
    result = (rs1 >> index) & 1;

    return result;
  endfunction

  // Function to bit extract (immediate) bexti
  function Bit#(XLEN) fn_bexti(Bit#(32) instr , Bit#(XLEN) rs1);
    let shamt = instr;
    Bit#(XLEN) result;
    let index = shamt & (fromInteger(valueOf(XLEN)-1));
    result = (rs1 >> index) & 1;
    return result;
  endfunction

  // Function to bit invert (immediate) binvi
  function Bit#(XLEN) fn_binvi(Bit#(32) instr , Bit#(XLEN) rs1);
    let shamt = instr;
    Bit#(XLEN) result;
    let index = shamt & (fromInteger(valueOf(XLEN)-1));
    result = rs1 ^ (1 << index);
    return result;
  endfunction 

  // Function for single-bit set (Register) -- bset
  function Bit#(XLEN) fn_bset(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
    Bit#(XLEN) result;
    let index = rs2 & (fromInteger(valueOf(XLEN)-1));
    result = rs1 | (1 << index);
    return result;
  endfunction

   // Function to bit set (immediate) bseti
   function Bit#(XLEN) fn_bseti(Bit#(32) instr , Bit#(XLEN) rs1);
    let shamt = instr;
    Bit#(XLEN) result;
    let index = shamt & (fromInteger(valueOf(XLEN)-1));
    result = rs1 | (1 << index);
    return result;
  endfunction 

  





