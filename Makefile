# makefile for rstms-awx


.PHONY: run clean verify rebuild

run:
	ansible-playbook -vv \
  	-i awx.rstms.net, \
  	-e enable_nginx=True \
  	-e enable_certbot=True \
  	-e enable_registry=True \
  	-e enable_fileserver=True \
  	site.yml

verify:
	@reply=$$(bash -c 'read -n 1 -p "Are you sure? [Y/n] " reply; echo $$reply');echo;[ "$$reply" != "$${reply#[Yy]}" ]

rebuild: 
	@echo "This will DESTROY the current cloud instance and rebuild it."
	@$(MAKE) -s verify
	@echo ok, rebuiding...
	ansible-playbook -i localhost, rebuild.yml
	@$(MAKE) -s run

digital_ocean.py: 
	wget https://github.com/ansible/ansible/raw/devel/contrib/inventory/digital_ocean.py
	chmod +x digital_ocean.py

clean:
	rm -f *.retry
	rm -f *.cache
