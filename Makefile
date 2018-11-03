.PHONY: docs clean

default:
	@echo 'Targets: clean compile test'

clean:
	-rm -rf ./chains
	-rm -rf ./build
	-rm -rf ./.pytest_cache/
	-rm -rf ./node_modules

requirements:
	pip install -r requirements.txt
	npm install

compile:
	populus compile

test: compile
	#pytest --disable-pytest-warnings tests
	pytest -p no:warnings 2> /dev/null

chain_init:
	populus chain new horton
	chains/horton/./init_chain.sh

chain_run:
	chains/horton/./run_chain.sh

chain_deploy:
	populus deploy --chain tester --no-wait-for-sync

chain_attach:
	geth attach chains/horton/chain_data/geth.ipc

docs:
	npx solidity-docgen . contracts .

test_docs:
	cd website && yarn start
