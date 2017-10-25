def parse_data(json, column_labels):
	extractedInformation = []
	iteration = 0
	arraySize = len(column_labels)
	for current in range(0, arraySize):
		innerArray = len(column_labels[current])
		if (innerArray == 1):
			extractedInformation.append(json.get(column_labels[current][0],{}))
			iteration+=1
		else:
			extractedInformation.append(json.get(column_labels[current][0],{}).get(column_labels[current][1]))
			iteration+=1
		if ( isinstance(extractedInformation[iteration-1], list)):
			temp = extractedInformation[iteration-1]
			extractedInformation.remove(temp)
			iteration-=1
			count=len(temp)
			for element in range(0, count):
				extractedInformation.append(temp[element])
				iteration+=1
	print extractedInformation
	return extractedInformation
