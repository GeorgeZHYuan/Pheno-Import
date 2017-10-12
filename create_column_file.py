import sys
import bisect

line = open(sys.argv[4]).readline()
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

column_file_text = [['FILENAME', 'CATEGORY_CD', 'COL_NBR', 'DATA_LABEL', 'ALT_DATA_LABEL', 'CTRL_VOCAB_CODE']]
for i, label in enumerate(labels):
	row = [sys.argv[3],'\t',str(i+1), str(label), '\t','\t']
	for j, letter in enumerate(reversed(label)):
		if letter == "+":
			row[1] = str(label[:-j-1])
			row[3] = str(label[-j:])
			break
	column_file_text.append(row)

with open(sys.argv[3], 'a') as column_file:
	for row in column_file_text:
		for word in row:
			column_file.write(word + '\t')
		column_file.write('\n')



