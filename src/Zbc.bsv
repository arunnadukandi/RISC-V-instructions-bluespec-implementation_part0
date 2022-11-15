// Function to find carry less multiplication(lower 16 bit)
function Bit#(XLEN) fn_clmul(Bit#(XLEN) rs1,Bit#(XLEN) rs2);
    Bit# (XLEN) outputs=0;
    Bit# (XLEN) temp=65535;
    for(Integer i=0; i<valueof(XLEN)-1; i=i+1)
      if(rs2!=0)begin
        outputs = outputs ^ (rs1 * (rs2 & 1));
        rs1 = rs1 << 1;
        rs2 = rs2 >> 1;
        end
      outputs = outputs & temp;
      return outputs;
  endfunction
  
  // Function to find carry less multiplication(Higher 16 bit)
  function Bit#(XLEN) fn_clmulh(Bit#(XLEN) rs1,Bit#(XLEN) rs2);
    Bit# (XLEN) outputs=0;
    Bit# (XLEN) temp=2147418112;
    for(Integer i=0; i<valueof(XLEN)-1; i=i+1)
      if(rs2!=0)begin
        outputs = outputs ^ (rs1 * (rs2 & 1));
        rs1 = rs1 << 1;
        rs2 = rs2 >> 1;
        end
      outputs = outputs & temp;
      return outputs;
  endfunction