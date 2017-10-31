class Pheno_Parser:
	def __init__(self, label_formats=''):
		self.set_format(label_formats)
	
	def set_format(self, label_formats):
		self.label_formats = label_formats

	def get_data(self, json):
		raise NotImplementedError("Subclass must implement abstract method")


class Direct_Value_Parser(Pheno_Parser):
	def get_data(self, json):
		data = []
		for label in self.label_formats:
			if (len(label) == 1):
				value = json.get(label[0],{})
				if value == {}:
					value = ''
				data.append(value)
			else:
				temp = json.get(label[0],{})
				for i in range(1, len(label)):
					temp = temp.get(label[i],{})
				if temp == {}:
					temp = ''
				data.append(temp)
		return data[:2] + data[1:]


class Structured_Value_Parser(Pheno_Parser):	
	def get_data(self, json):
		data = []		
		for labelset in self.label_formats:
			for label in labelset[0]:
				print "\n" + label
				body = json.get(label,{})
				data += self.break_down_json(body, labelset[1])
		return data
		
	def break_down_json(self, json, label):
		data = []
		for key in label:
			temp = []
			for entry in json:
				value = entry.get(key, {})
				if isinstance(value, unicode):
					temp.append(value)
				else:
					temp += self.break_down_json(value, label[key])
			print key + ": " + str(temp)
			if temp == []:
				temp = ''
			data.append(temp)
		return data
