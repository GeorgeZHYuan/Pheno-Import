import requests

def phenotips_REST(phenotips, args):
	base_url = 'http://'+phenotips.ADDRESS+'/rest/'
	r = requests.get(base_url + args, auth=(phenotips.USER, phenotips.PWD))
	if r.status_code != 200:
		return r.status_code
	else:
		return r.json()
