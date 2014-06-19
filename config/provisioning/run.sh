#!/bin/sh

ansible-playbook recepto.yml --connection=local \
  --inventory=environments/development/inventory.local
