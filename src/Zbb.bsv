function Bit#(XLEN) fn_andn(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return rs1 & ~rs2;
endfunction

// ANDN function for 32 bit

function Bit#(XLEN_BY_2) fn_andn_32(Bit#(XLEN_BY_2) rs1, Bit#(XLEN_BY_2) rs2);
  return rs1 & ~rs2;
endfunction

function Bit#(XLEN) fn_orn(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return rs1 | ~rs2;
endfunction

function Bit#(XLEN) fn_xnor(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return ~(rs1 ^ rs2);
endfunction

// Function to count set bits in source register - cpop

function Bit#(XLEN) fn_cpop(Bit#(XLEN) rs1);
  //provisos(Bits#(Bit,szTD));
  Bit#(XLEN) bitcount = 0;
  /* valueof(or valueOf()) -  convert a numeric type into the corresponding 
  Integer value.
  fromInteger - Converts from an Integer type to any type defined in the
Literal type class */

  for (Integer i = 0 ; i < fromInteger(valueof(XLEN)) ; i = i+1)
    if(rs1[i] == 1) begin
      bitcount = bitcount +1;
    end

  return bitcount;
endfunction

// Function to count set bits in a word - cpopw

function Bit#(XLEN) fn_cpopw(Bit#(XLEN) rs1);
  Bit#(XLEN) bitcount = 0;
  /* valueof(or valueOf()) -  convert a numeric type into the corresponding 
  Integer value.
  fromInteger - Converts from an Integer type to any type defined in the
Literal type class */

  for (Integer i = 0 ; i < fromInteger(valueof(XLEN_BY_2)) ; i = i+1)
    if(rs1[i] == 1) begin
      bitcount = bitcount +1;
    end

  return bitcount;
endfunction

// Function to count leading zero bits - clz
function Bit#(XLEN) fn_clz(Bit#(XLEN) rs1);
  Bit#(XLEN) index = 0;
  Bit#(XLEN) result;
  for (Bit#(XLEN) i = 0 ; i < fromInteger(valueof(XLEN)) ; i = i+1)
    if(rs1[i] == 1) begin
      index = i;
    end
  result = (fromInteger(valueOf(XLEN))-1) - index;
  return result;

 endfunction 

 // Function to count leading zero bits in word -  clzw
function Bit#(XLEN) fn_clzw(Bit#(XLEN) rs1);
  Bit#(XLEN) index = 0;
  Bit#(XLEN) result;
  for (Bit#(XLEN) i = 0 ; i < fromInteger(valueof(XLEN_BY_2)) ; i = i+1)
    if(rs1[i] == 1) begin
      index = i;
    end
  result = (fromInteger(valueOf(XLEN_BY_2))-1) - index;
  return result;
endfunction 

// Function to count trailing zeros in source register
function Bit#(XLEN) fn_ctz(Bit#(XLEN) rs1);
  Bit#(XLEN) index =0 ;
  Bit#(XLEN) result = 5;
  Bool set = False;
  for ( Bit#(XLEN)  i = fromInteger(valueof(XLEN)) -1  ; i > 0  ; i = i-1)
    if(rs1[i] == 1) begin
      index = i;
    end
  if(rs1[0] == 1) begin
    index = 0;
  end     
  result =  index;
  return result;
endfunction

// Function to count trailing zeros in word
function Bit#(XLEN) fn_ctzw(Bit#(XLEN) rs1);
  Bit#(XLEN) index =0 ;
  Bit#(XLEN) result;
  Bool set = False;
  for ( Bit#(XLEN)  i = fromInteger(valueof(XLEN_BY_2)) -1  ; i > 0  ; i = i-1)
    if(rs1[i] == 1) begin
      index = i;
    end
  if(rs1[0] == 1) begin
    index = 0;
  end     
  result =  index;
  return result;
endfunction

// function to find maximum of two Signed numbers
function Bit#(XLEN) fn_max(Bit#(XLEN) rs1,Bit#(XLEN) rs2);
  // Bit#(XLEN) res = (unpack(rs1)<unpack(rs2)) ? rs2 : rs1;
  Bit#(XLEN) result=0,max_rs1=0 ,max_rs2=0;
  Bit#(XLEN) neg_rs1= 0,neg_rs2 = 0;
  if( rs1 < 0 && rs2 < 0) begin
    neg_rs1 = ~rs1;   // negating the input value
    neg_rs2 = ~rs2;   // negating the input values
    max_rs1 = (rs1 < neg_rs1) ? neg_rs1 : rs1;    // assigning the max amongst rs1 and ~rs1 to max_rs1
    max_rs2 = (rs2 < neg_rs2) ? neg_rs2 : rs2;    // assigning the max amongst rs2 and ~rs2 to max_rs2

    result = (max_rs1 < max_rs2) ? max_rs2 : max_rs1;  // largest among max_rs1 and max_rs2 assigned to result
  end

  if(rs1 > 0 && rs2 > 0) begin
    result = ( rs1 < rs2 ) ? rs2 : rs1;
  end

  if(rs1 < 0 && rs2 > 0) begin
    neg_rs1 = ~rs1;   // negating the input value
    max_rs1 = (rs1 < neg_rs1) ? neg_rs1 : rs1;    // assigning the max amongst rs1 and ~rs1 to max_rs1
    
    result = (max_rs1 < rs2) ? rs2 : max_rs1;   // assigning largest
  end
  
    return result;
endfunction

  // function to find maximum of two UnSigned numbers
function Bit#(XLEN) fn_maxU(Bit#(XLEN) rs1,Bit#(XLEN) rs2);
  // Bit#(XLEN) res = (unpack(rs1)<unpack(rs2)) ? rs2 : rs1;
  Bit#(XLEN) result;
  if(rs1 < rs2) begin
    result = rs2;
  end
  else begin
    result = rs1;
  end
  return result;
endfunction

// function to find minimum of two Signed numbers
function Bit#(XLEN) fn_min(Bit#(XLEN) rs1,Bit#(XLEN) rs2);
  // Bit#(XLEN) res = (unpack(rs1)<unpack(rs2)) ? rs2 : rs1;
  // Bit#(XLEN) result;
  // if(rs1 < rs2) begin
  //   result = rs1;
  // end
  // else begin
  //   result = rs2;
  // end

  Bit#(XLEN) result=0,min_rs1=0 ,min_rs2=0;
  Bit#(XLEN) neg_rs1= 0,neg_rs2 = 0;
  if( rs1 < 0 && rs2 < 0) begin
    neg_rs1 = ~rs1;   // negating the input value
    neg_rs2 = ~rs2;   // negating the input values
    min_rs1 = (rs1 > neg_rs1) ? neg_rs1 : rs1;    // assigning the max amongst rs1 and ~rs1 to max_rs1
    min_rs2 = (rs2 > neg_rs2) ? neg_rs2 : rs2;    // assigning the max amongst rs2 and ~rs2 to max_rs2

    result = (min_rs1 > min_rs2) ? min_rs2 : min_rs1;  // largest among max_rs1 and max_rs2 assigned to result
  end

  if(rs1 > 0 && rs2 > 0) begin
    result = ( rs1 > rs2 ) ? rs2 : rs1;
  end

  if(rs1 < 0 && rs2 > 0) begin
    neg_rs1 = ~rs1;   // negating the input value
    min_rs1 = (rs1 > neg_rs1) ? neg_rs1 : rs1;    // assigning the max amongst rs1 and ~rs1 to max_rs1
    
    result = (min_rs1 > rs2) ? rs2 : min_rs1;   // assigning largest
  end



  
  return result;
endfunction

  // function to find minimum of two UnSigned numbers
function Bit#(XLEN) fn_minU(Bit#(XLEN) rs1,Bit#(XLEN) rs2);
  // Bit#(XLEN) res = (unpack(rs1)<unpack(rs2)) ? rs2 : rs1;
  Bit#(XLEN) result;
  if(rs1 < rs2) begin
    result = rs1;
  end
  else begin
    result = rs2;
  end
  return result;
endfunction

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

  
