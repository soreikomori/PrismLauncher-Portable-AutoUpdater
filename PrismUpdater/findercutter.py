file = open("output.txt", "r")
line = file.readline()
cut = line[line.find("https"):len(line)].strip().strip("\"")
file.close()
with open("urlonly.txt", "w") as file2:
    file2.write(cut)