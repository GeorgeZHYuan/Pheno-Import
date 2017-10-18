import subprocess
import sys

def pySQL (query, args=[]):
	try :
		response = subprocess.check_output("psql -U $USER -d transmart -c \"" + query + "\"", shell=True)
	except:
		sys.exit("Cannot process query: " + query)

	response = response.replace(" ", "")
	response = response.replace("\t","")		

	table = []
	line=[]
	word=""
	for letter in response:
		if letter == "\n":
			line.append(word)
			table.append(line)
			word = ""
			line = []
		elif letter == "|":
			line.append(word)
			word = ""
		else:
			word+=letter

	del table[1]
	del table[-2]
	del table[-1]
		
	sql_map = {}
	for i, c_label in enumerate(table[0]):
		column_temp=[]		
		for j in range (1, len(table)-1):
			column_temp.append(table[j][i])
		sql_map[c_label] = column_temp

	return sql_map

