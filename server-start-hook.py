import requests
import time
import argparse

parser = argparse.ArgumentParser(description='Server start hook.')

parser.add_argument('--endpoint', type=str, required=True)
parser.add_argument('--api-key', type=str, required=True)
args = parser.parse_args()

while True:
    t = time.localtime()
    current_time = time.strftime("%d/%m/%Y %H:%M:%S", t)
    
    resp = requests.get(args.endpoint, { 'api-key': args.api_key })

    if resp.ok:
        print(f'{current_time} => {resp.json()}')
        break
    else:
        time.sleep(2 * 60) # Sleep for 10 minutes