import json
import os

state_path = "../../terraform/stage/"
output_file = "inventory.json"

state_file = os.path.join(state_path, "terraform.tfstate")

with open(state_file, 'r') as state_file:
    terraform_state = json.load(state_file)

external_ip_address_app = terraform_state["outputs"]["external_ip_address_app"]["value"]
external_ip_address_db = terraform_state["outputs"]["external_ip_address_db"]["value"]

inventory = {
    "app": {"hosts": [external_ip_address_app]},
    "db": {"hosts": [external_ip_address_db]}
}

with open(output_file, 'w') as output_file:
    json.dump(inventory, output_file, indent=4)
