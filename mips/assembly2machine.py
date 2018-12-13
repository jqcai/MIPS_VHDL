import re

op_dict_r = {
    'add':1,
    'sub':3,
    'and':5,
    'or':7,
    'nor':9}

op_dict_i = {
    'addi':1,
    'subi':2,
    'andi':3,
    'ori':4,
    'shr':5,
    'lb':7,
    'sb':8,
    'blt':9,
    'beq':10,
    'bne':11}

op_dict_j = {
    'jmp':12,
    'jump':12,
    'hal':63
}



# parse int to binary, int x, length y
parse_binary = lambda x,y : ''.join(reversed( [str((((x + 2 ** y)%(2 ** y)) >> i) & 1) for i in range(y)] ) )


def get_rtype_string(ins):
    op_code = '000000'
    func_code = parse_binary(op_dict_r[ins[0]], 6)
    sht = '00000'
    rs = parse_binary(int(ins[1][1:]), 5)
    rt = parse_binary(int(ins[2][1:]), 5)
    rd = parse_binary(int(ins[3][1:]), 5)
    return op_code + rs + rt + rd + sht + func_code
    

def get_itype_string(ins):
    op_code = parse_binary(op_dict_i[ins[0]], 6)
    rs = parse_binary(int(ins[1][1:]), 5)
    rt = parse_binary(int(ins[2][1:]), 5)
    imm = parse_binary(int(ins[3]), 16)

    return op_code + rs + rt + imm

def get_jtype_string(ins):
    op_code = parse_binary(op_dict_j[ins[0]], 6)
    address = parse_binary(int(ins[1]), 26) if ins[0] != 'hal' else '00000000000000000000000000'
    return op_code + address
    

if __name__ == '__main__':
    read_file = "in_file.mips"
    write_file = "out_file.mips"
    read_from = open(read_file)
    write_to = open(write_file, 'w')
    ins_num = 0
    

    lines = read_from.readlines()
    for l in lines:
        l = l.lower()
        l = l.replace(',', ' ')
        l = l.split('--')[0]
        l = l.split('#')[0]
        ins = l.split()
        if(len(ins) < 1):
            continue
        print(ins)
        ins_machine = ''
        # R type
        if(ins[0] in op_dict_r):
            ins_machine = get_rtype_string(ins)
        # I type
        elif(ins[0] in op_dict_i):
            ins_machine = get_itype_string(ins)
        elif(ins[0] in op_dict_j):
            ins_machine = get_jtype_string(ins)
            # print(ins)
            # print(ins_machine)
        else:
            raise Exception('invalid input %s', ins)
        write_to.write('"')
        write_to.write(ins_machine)
        write_to.write('",\n')
    read_from.close()
    write_to.close()
