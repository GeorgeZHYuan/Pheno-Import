import requests
from global_vars import pheno

def phenotips_REST(args):
	base_url = 'http://'+pheno.HOST+':'+pheno.PORT+'/rest/'
	r = requests.get(base_url + args, auth=(pheno.USER, pheno.PWD))

	if r.status_code != 200:
		return r.status_code
	else:
		return r.json()
