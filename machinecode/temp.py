fp = open("file.txt", "rt")
data = fp.readlines()
for line in data:
    if line:
        print("\n".join([line[i : i + 5] for i in range(0, len(line), 5)]))
fp.close()
