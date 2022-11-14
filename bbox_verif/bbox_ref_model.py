#See LICENSE.iitm for license details
'''

Author   : Santhosh Pavan
Email id : santhosh@mindgrovetech.in
Details  : This file consists reference model which is used in verifying the bbox design (DUT).

--------------------------------------------------------------------------------------------------
'''
'''
TODO:
Task Description: Add logic for all instructions. One instruction is implemented as an example. 
                  Note - The value of instr (ANDN) is a temp value, it needed to be changed according to spec.

Note - if instr has single operand, take rs1 as an operand
'''

import test_bbox as tb    # importing test_bbox module to use the dictionary defined in the module


def twos_complement(val, nbits):
    """Compute the 2's complement of int value val"""
    if val < 0:
        val = (1 << nbits) + val
        res = (val)
    else:
        
        # if (val & (1 << (nbits))) != 0: 
        #     val = val - (1 << nbits)
        #     res = val
        if(val > 0):
            length = len(bin(val)) - 2
            temp = '{:064b}'.format(val) 
            print(len(temp)-length)
            for i in range((len(temp)-length)):
                res = temp.replace('0','1')
            print("beore",res)
            res = res[:60] + bin(val)[2:]
            print(res)
    
    return res



#Reference model
def bbox_rm(instr, rs1, rs2, XLEN):
    values = list(tb.specs.values())   # returns values of dict as type dic_values , convert and store as list
        
    if instr == values[0]:
        res = rs1 & ~rs2 
        
        valid = '1'
    ## logic for all other instr starts 

    elif instr == values[1]:
        res = rs1 | (~rs2 + 2**64 ) 
        
        valid = '1'

    elif instr == values[2]:
        res = ~(rs1 ^ rs2) + 2**64
        #print(bin(res), bin(rs1) , bin(~rs2))
        valid = '1'

    # logic for counting population  - cpop
    elif instr == values[3]:
        bitcount = 0
        bin_rs1 = ('{:64b}'.format(rs1)) # rs1 of type int , converting it to 64 bit binary
        for i in reversed(range(XLEN)):
            if(bin_rs1[i] == '1'):
                bitcount+=1
            elif(bin_rs1[i] == " "):
                break
        res = bitcount  
        valid = '1'
        
    # logic for counting population in word - cpopw
    elif instr == values[4]:
        bitcount = 0
        bin_rs1 = ('{:064b}'.format(rs1)) # rs1 of type int , converting it to 64 bit binary
        for i in range((XLEN//2),XLEN):  # Iterate from 32 to 64 i.e the LSB     
            if(bin_rs1[i] == '1'):
                bitcount+=1
            elif(bin_rs1[i] == " "):
                break
        res = bitcount  
        valid = '1'

    # logic for counting leading zero bits - clz
    elif instr == values[5]:
        zero_count = 0
        bin_rs1 = '{:064b}'.format(rs1)
        #print(bin_rs1)
        for i in (range(XLEN)):
            
            if(bin_rs1[i] == "1"):
                index = i
                break
            elif(bin_rs1[i] == "0"):
                index = XLEN-1
        res = index
        valid = '1'
    
    # logic for counting leading zero bits in a word
    
    elif instr == values[6]:
        index = 0
        bin_rs1 = '{:064b}'.format(rs1)
        for i in (range(XLEN//2,XLEN)):    # Iterate from 32 to 64 
            if(bin_rs1[i] == "1"):
                break
            elif(bin_rs1[i] == "0"):
                index+=1
        res = index
        valid = '1'
    
    # logic for counting trailing zeros in source register

    elif instr == values[7]:
        
        bin_rs1 = '{:064b}'.format(rs1)
        for i in reversed(range(len(bin_rs1))):
            if(bin_rs1[i] == '1'):
                res = (XLEN-1)-i
                break
            elif(bin_rs1[i] == '0'):
                res = XLEN
        valid ='1'
    
    # logic for counting trailing zeros in word

    elif instr == values[8]:
        
        bin_rs1 = '{:064b}'.format(rs1)
        for i in reversed(range(XLEN//2,XLEN)):  # strarting from 64 and going till 32 --> lsb
            if(bin_rs1[i] == '1'):
                res = (XLEN-1)-i
                break
            elif(bin_rs1[i] == '0'):
                res = XLEN-1
        valid ='1'
    
    # logic for finding max of two signed numbers
    elif instr == values[9]:
        if(rs1 < 0 and rs2 < 0):  # if both are negative(signed) 

            largest = max(rs1 ,rs2)   # find the max amongst the inputs
            length_largest = len('{:064b}'.format(largest))  # calculating the length of the max number
            res = twos_complement(largest,length_largest)  # call fn to convert to equivlanet 2sc
        
        if (rs1 > 0 and rs2 > 0):   # if both are +ve value
            res = max(rs1,rs2)
        
        if( rs1 <0 and rs2 >0):   # if rs1 is negative
            length_rs1 = len('{:064b}'.format(rs1))   # calculate length of rs1
            length_rs2 = len('{:064b}'.format(rs2))
            neg_rs1 = twos_complement(rs1,length_rs1) # calculate 2sc of rs1
            neg_rs2 = twos_complement(rs2,length_rs2)
            res = max(neg_rs1,int(neg_rs2,2))
        valid='1'

    # logic for finding max of two Unsigned numbers
    elif instr == values[10]:
        if(rs1 < 0 and rs2 < 0):  # if both are negative(signed) 

            largest = max(rs1 ,rs2)   # find the max amongst the inputs
            length_largest = len('{:064b}'.format(largest))  # calculating the length of the max number
            res = twos_complement(largest,length_largest)  # call fn to convert to equivlanet 2sc
        
        if (rs1 > 0 and rs2 > 0):   # if both are +ve value
            res = max(rs1,rs2)
        
        if( rs1 <0 and rs2 >0):   # if rs1 is negative
            length_rs1 = len('{:064b}'.format(rs1))   # calculate length of rs1
            length_rs2 = len('{:064b}'.format(rs2))
            neg_rs1 = twos_complement(rs1,length_rs1) # calculate 2sc of rs1
            neg_rs2 = twos_complement(rs2,length_rs2)
            res = max(neg_rs1,int(neg_rs2,2))
        valid='1'
        # res = max(rs1,rs2)
        # valid ='1'

    # logic for finding min of two signed numbers
    elif instr == values[11]:
    #     res = min(rs1,rs2)
    #     valid ='1'

        if(rs1 < 0 and rs2 < 0):  # if both are negative(signed) 

            largest = min(rs1 ,rs2)   # find the max amongst the inputs
            length_largest = len('{:064b}'.format(largest))  # calculating the length of the max number
            res = twos_complement(largest,length_largest)  # call fn to convert to equivlanet 2sc
        
        if (rs1 > 0 and rs2 > 0):   # if both are +ve value
            res = min(rs1,rs2)
        
        if( rs1 <0 and rs2 >0):   # if rs1 is negative
            length_rs1 = len('{:064b}'.format(rs1))   # calculate length of rs1
            length_rs2 = len('{:064b}'.format(rs2))
            neg_rs1 = twos_complement(rs1,length_rs1) # calculate 2sc of rs1
            # neg_rs2 = twos_complement(rs2,length_rs2)
            res = min(neg_rs1,rs2)
        valid='1'


    # logic for finding min of two Unsigned numbers
    elif instr == values[12]:
        res = min(rs1,rs2)
        valid ='1'

    # logic for bclr (register)
    elif instr == values[13]:
        index = rs2 & (XLEN-1)
        res = rs1 & ~(1 << index)
        valid ='1'
    
    # logic implemeting bclri (immediate)

    elif instr == values[14]:
        shamt = instr
        index = rs2 & (XLEN-1)
        res = rs1 & ~(1 << index)
        valid ='1'

    # logic for bext 
    elif instr == values[15]:
        index = rs2 & (XLEN-1)
        res = (rs1 >> index) & 1
        valid ='1'

    # logic for bexti 
    elif instr == values[16]:
        shamt = instr
        index = shamt & (XLEN-1)
        res = (rs1 >> index) & 1
        valid ='1'
    
    # logic for binvi 
    elif instr == values[17]:
        shamt = instr
        index = shamt & (XLEN-1)
        res = rs1 ^ (1 << index)
        valid ='1'
    
    # logic for  single bit set (Register) - bset
    elif instr == values[18]:
        index = rs2 & (XLEN-1)
        res = rs1 | (1 << index)
        valid ='1'
    
    # Logic for Single-set (immediate) - bseti
    elif instr == values[19]:
        shamt = instr
        index = shamt & (XLEN-1)
        res = rs1 | (1 << index)
        valid ='1'


    ## logic for all other instr ends
    else:
        res = 0
        valid = '0'

    if XLEN == 32:
        result = '{:032b}'.format(res)
    elif XLEN == 64:
        if(len(str(res))<XLEN):
            result = '{:064b}'.format(res)
        else:
            result = res
    return valid+result

