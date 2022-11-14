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
    // let shamt = fromInteger(instr);
    return result;
  endfunction