import sys
import bisect

line = open('data.tmp').readline()
labels = []
extra=sys.argv[1]+"+"+sys.argv[2]+"+"
sbj_id_position = -1

word = ""

for i, letter in enumerate(line):
	if letter == '\t' or i == (len(line)-1):
		if word[0] == '+':
			word = word[1:]

		if word[len(word)-1] == '+':
			word = word[:-1]
		
		if word == "Subject_ID":
			sbj_id_position = i
		
		elif extra in word:
			word = word[len(extra):]

		labels.append(word)
		word = ''

	elif letter == ' ':
		word += '_'

	elif letter == '\\' or letter == '/':
		word += '+'

	else:
		word += letter

for i, label in enumerate(labels):
	for j, letter in enumerate(reversed(label)):
		if letter == "+":
			d = {label[:-j-1] : label[-j:]}
			labels[i] = d
			break
			
for label in labels:
	print(label)


