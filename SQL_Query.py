import subprocess
import sys

class SQL_Query:
	def execute (self, statement, args={}):
		try :
			return subprocess.check_output("psql -U $USER -d transmart -c \"" + statement + "\"", shell=True)
		except:
			sys.exit("Cannot process statement: " + statement)
	

	def __empty (self, end=-1, start=0):
		values=["", "", "", [], []]		
		if end == -1:
			end=len(values)
		return values[start:end]

	
	def __filter (self, table, **args):
		del table[1]
		del table[-2]
		del table[-1]


	def generate_map (self, table):
		sql_map = {}
		for i, c_label in enumerate(table[0]):
			column_temp=[]		
			for j in range (1, len(table)):
				column_temp.append(table[j][i])
			sql_map[c_label] = column_temp
		return sql_map


	def extract_values (self, response):
		blanks, text, word = "", "", ""
		row, table = [], []
		for letter in response:			
			if letter == '\n':
				word += text
				row.append(word)
				table.append(row)
				blanks, text, word, row = self.__empty (4)
			elif letter == '|':
				word += text
				row.append(word)
				blanks, text, word = self.__empty (3)
			elif letter == ' ':
				blanks += ' '
				word += text
				text = ""
			else:
				if word != "":
					word += blanks
				text += letter
				blanks = ""
		self.__filter(table)
		return table	


	def extract_values_old (self, response):
		response = response.replace(" ", "")
		response = response.replace("\t","")		
		table = []
		line=[]
		word = ""
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
		self.__filter(table)
		return table


	def query (self, statement, args={}):
		response = self.execute(statement, args)
		command = (str(statement).split(' ', 1)[0]).upper()
		if command == 'SELECT':
			if 'raw' in args:
				return response
			else:
				table_values = self.extract_values(response)
				if 'table' in args:
					return table_values
				else:
					return self.generate_map(table_values)
		else:
			return response


