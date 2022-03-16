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
    
    try:
        resp = requests.get(args.endpoint, { 'api-key': args.api_key })

        if resp.ok:
            print(f'SUCCESS {current_time} => {resp.json()}')
            break
        else:
            print(f'FAILED {current_time} => Status Code {resp.status_code}')
    except Exception as e:
        print(f'ERROR {current_time} => {e}')
        
    time.sleep(2 * 60) # Sleep for 2 minutes