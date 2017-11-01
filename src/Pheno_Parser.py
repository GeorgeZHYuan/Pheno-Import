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
				if temp == {} or temp == [] or temp == 'None' or temp == None:
					temp = ''
				data.append(temp)
		return data


class Structured_Value_Parser(Pheno_Parser):	
	def get_data(self, json):
		data = []		
		for labelset in self.label_formats:
			for label in labelset[0]:
				body = json.get(label,{})
				data += self.break_down_json(body, labelset[1])
		return data

	def break_down_json(self, json, label):
		data = []
		if isinstance(json, unicode):
			return [json]
		for key in label:
			temp = []
			for entry in json:
				value = entry.get(key, {})
				if isinstance(value, unicode):
					temp.append(value)
				elif isinstance(value, list):
					for item in value:
						temp += self.break_down_json(item, label[key])
				else:
					temp += self.break_down_json(value, label[key])
			if temp == []:
				temp = ''
			data.append(temp)
		return data


class Split_Value_Parser(Pheno_Parser):
	def get_data(self, json):
		data = []
		types = {}	
		for labelset in self.label_formats:
			body = json.get(labelset[0],{})
			filtered_body = []
			for entry in body:
				if entry.get('type', {}) == (labelset[1])['type']:
					filtered_body.append(entry)
			data += self.break_down_json(filtered_body, labelset[2])
		for i, element in enumerate(data):
			if element == []:
				data[i] = ''	
		return data

	def break_down_json(self, json, label):
		data = []
		types = {}
		counter = 0
		for key in label:
			value = label[key]
			if not isinstance(value, dict):
				data.append([])
				types[key] = counter
				counter += 1
			else:
				for key2 in value:
					data.append([])
					types[key+':'+key2] = counter
					counter += 1
		for key in label:
			for entry in json:
				value = entry.get(key, {})
				if not isinstance(value, list) and not isinstance(value, dict):
					data[types[key]].append(value)	
				else:
					for entry2 in value:
						for key2 in label[key]:
							data[types[key+":"+key2]].append(entry2[key2])
		return data



				
					


