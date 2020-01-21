import sys

if len(sys.argv) == 1:
    sys.exit("ERROR: Path to file not provided")
else:
    with open(sys.argv[1], 'r') as mc:
        if len(sys.argv) == 3:
            out = open(sys.argv[2], "w+")
        else:
            out = open("a.out", "w+")

        for line in enumerate(mc):
            current = line[1];
            if "CMP" in current:
                stripl = line[1].rstrip()
                split = stripl.split(" ")
                out.write("0000" + split[2] + "1011" + split[1] + "\n")
                print split
            elif "AND" in current:
                stripl = line[1].rstrip()
                split = stripl.split(" ")
                out.write("0000" + split[2] + "0001" + split[1] + "\n")
                print split
            elif "OR" in current:
                stripl = line[1].rstrip()
                split = stripl.split(" ")
                out.write("0000" + split[2] + "0010" + split[1] + "\n")
                print split
            elif "XOR" in current:
                stripl = line[1].rstrip()
                split = stripl.split(" ")
                out.write("0000" + split[2] + "0011" + split[1] + "\n")
                print split
            elif "NOT" in current:
                stripl = line[1].rstrip()
                split = stripl.split(" ")
                out.write("0000" + split[2] + "1111" + split[1] + "\n")
                print split
            elif "LSH" in current:
                stripl = line[1].rstrip()
                split = stripl.split(" ")
                out.write("1000" + split[2] + "0100" + split[1] + "\n")
                print split
            elif "RSH" in current:
                stripl = line[1].rstrip()
                split = stripl.split(" ")
                out.write("0000" + split[2] + "1111" + split[1] + "\n")
                print split
            elif "SUBI" in current:
                stripl = line[1].rstrip()
                split = stripl.split(" ")
                out.write("1001" + split[2] + split[1] + "\n")
                print split
            elif "ADDCUI" in current:
                stripl = line[1].rstrip()
                split = stripl.split(" ")
                out.write("1011" + split[2] + split[1] + "\n")
                print split
            elif "ADDCU" in current:
                stripl = line[1].rstrip()
                split = stripl.split(" ")
                out.write("0000" + split[2] + "0100" + split[1] + "\n")
                print split
            elif "ADDUI" in current:
                stripl = line[1].rstrip()
                split = stripl.split(" ")
                out.write("0110" + split[2] + split[1] + "\n")
                print split
            elif "ADDCI" in current:
                stripl = line[1].rstrip()
                split = stripl.split(" ")
                out.write("0111" + split[2] + split[1] + "\n")
                print split
            elif "ADDC" in current:
                stripl = line[1].rstrip()
                split = stripl.split(" ")
                out.write("0000" + split[2] + "0111" + split[1] + "\n")
                print split
            elif "ADDU" in current:
                stripl = line[1].rstrip()
                split = stripl.split(" ")
                out.write("0000" + split[2] + "0110" + split[1] + "\n")
                print split
            elif "ADDI" in current:
                stripl = line[1].rstrip()
                split = stripl.split(" ")
                out.write("0101" + split[2] + split[1] + "\n")
                print split
            elif "ADD" in current:
                stripl = line[1].rstrip()
                split = stripl.split(" ")
                out.write("0000" + split[2] + "0101" + split[1] + "\n")
                print split
            elif "SUB" in current:
                stripl = line[1].rstrip()
                split = stripl.split(" ")
                out.write("0000" + split[2] + "1001" + split[1] + "\n")
                print split
        out.close()
