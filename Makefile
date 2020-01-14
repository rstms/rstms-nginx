# makefile for rstms-awx

run:
	ansible-playbook \
  	-i awx.rstms.net, \
  	-e enable_nginx=False \
  	-e enable_certbot=False \
  	-e enable_registry=True \
  	site.yml
