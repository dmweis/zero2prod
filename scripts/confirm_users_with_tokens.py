#!/usr/bin/env python3


"""
You can get `pending_confirmation` by running the following sql query

SELECT subscription_tokens.subscription_token
FROM subscriptions
INNER JOIN subscription_tokens
ON subscriptions.id = subscription_tokens.subscriber_id
WHERE subscriptions.status = ('pending_confirmation');
"""


import requests
import sys
import pathlib

if len(sys.argv) > 1:
    url = sys.argv[1]
else:
    print("Please provide URL as first argument")
    exit()
print(f"URL is: {url}")

if len(sys.argv) > 2:
    file_path = sys.argv[2]
else:
    path = pathlib.Path(__file__).parent.resolve() / "unconfirmed_subscriptions.csv"
    file_path = str(path)
    response = input(f"No file path argument detected\nWrite [yes] + Enter to run on {file_path}\nPress Enter to exit\n> ")
    if response.lower() != "yes":
        print("exiting")
        exit()

print(f"Running for file {file_path}")

with open(file_path, "r") as file:
    for line in file.readlines():
        token = line.replace("\"", "").strip()
        if token:
            print(f"Send confirmation with token: {token}")
            res = requests.get(f'{url}/subscriptions/confirm', params = {'subscription_token':token})
            if res.status_code == 200:
                print("Success")
            else:
                print(f"Request returned with error code: {res.status_code}")
