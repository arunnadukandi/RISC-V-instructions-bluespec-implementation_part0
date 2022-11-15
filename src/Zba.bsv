//Function to left shift bit by 1 and add to rs2
function Bit#(XLEN) fn_sh1add(Bit#(XLEN) rs1,Bit#(XLEN) rs2);
    Bit# (XLEN) outputs=0;
    outputs = rs2 + (rs1 << 1);
   return outputs ;
  endfunction
  
  //Function to left shift bit by 2 and add to rs2
  function Bit#(XLEN) fn_sh2add(Bit#(XLEN) rs1,Bit#(XLEN) rs2);
    Bit# (XLEN) outputs=0;
    outputs = rs2 + (rs1 << 2);
   return outputs ;
  endfunction
  
  //Function to left shift bit by 2 and add to rs2
  function Bit#(XLEN) fn_sh3add(Bit#(XLEN) rs1,Bit#(XLEN) rs2);
    Bit# (XLEN) outputs=0;
    outputs = rs2 + (rs1 << 3);
   return outputs ;
  endfunction
  
  //Function for adduw
  function Bit#(XLEN) fn_adduw(Bit#(XLEN) rs1,Bit#(XLEN) rs2);
    Bit#(XLEN) outputs = 0;
    for (Integer i = 32 ; i < 64 ; i = i+1)
      rs1[i] = 0;
    outputs = rs1 + rs2;
    return outputs;
  endfunction
  
  //Function for sh1adduw
  function Bit#(XLEN) fn_sh1adduw(Bit#(XLEN) rs1,Bit#(XLEN) rs2);
    Bit#(XLEN) outputs = 0;
   // Bit#(XLEN) temp;
    Bit#(XLEN) temp2 = rs2;
    for (Integer j = 0 ; j < 64 ; j = j+1)
     rs2[j] = 0;
   // Integer k=0;
    for (Integer i = 0 ; i < 32 ; i = i+1)
     rs2[i] = rs1[i];
     // k = k+1;
   rs2 = rs2 << 1;
   outputs = rs2 + temp2;
   return outputs;
  endfunction
  
  //Function for sh2adduw
  function Bit#(XLEN) fn_sh2adduw(Bit#(XLEN) rs1,Bit#(XLEN) rs2);
    Bit#(XLEN) outputs = 0;
   // Bit#(XLEN) temp;
    Bit#(XLEN) temp2 = rs2;
    for (Integer j = 0 ; j < 64 ; j = j+1)
     rs2[j] = 0;
   // Integer k=0;
    for (Integer i = 0 ; i < 32 ; i = i+1)
     rs2[i] = rs1[i];
     // k = k+1;
   rs2 = rs2 << 2;
   outputs = rs2 + temp2;
   return outputs;
  endfunction
  
  //Function for sh3adduw
  function Bit#(XLEN) fn_sh3adduw(Bit#(XLEN) rs1,Bit#(XLEN) rs2);
    Bit#(XLEN) outputs = 0;
    //Bit#(XLEN) temp;
    Bit#(XLEN) temp2 = rs2;
    for (Integer j = 0 ; j < 64 ; j = j+1)
     rs2[j] = 0;
   // Integer k=0;
    for (Integer i = 0 ; i < 32 ; i = i+1)
     rs2[i] = rs1[i];
     // k = k+1;
   rs2 = rs2 << 3;
   outputs = rs2 + temp2;
   return outputs;
  endfunction

  // Function to implement Shift -left unsigned word -- slli.uw

  // Function to implement slliuw
function Bit#(XLEN) fn_slliuw(Bit#(XLEN) rs1, Bit#(32) instr);
  Bit#(32) temp = truncate(rs1);  // truncate MSB
  let shamt = instr;
  Bit#(XLEN) temp1 = zeroExtend(temp);
  Bit#(XLEN) result ;
  result = temp1 << shamt;
  return result;
endfunction
