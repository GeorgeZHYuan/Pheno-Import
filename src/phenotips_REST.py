import requests
from global_vars import PH

def phenotips_REST(args):
	base_url = 'http://'+PH.ADDRESS+'/rest/'
	r = requests.get(base_url + args, auth=(PH.USER, PH.PWD))
	if r.status_code != 200:
		return r.status_code
	else:
		return r.json()
