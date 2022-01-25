import requests
import time
import argparse

parser = argparse.ArgumentParser(description='Create ssl log.')

parser.add_argument('--endpoint', type=str, required=True)
parser.add_argument('--domain-id', type=str, required=True)
parser.add_argument('--exit-code', type=int, required=True)
args = parser.parse_args()

enum = {
    'success': 1,
    'failed': 2
}

while True:
    t = time.localtime()
    current_time = time.strftime("%d/%m/%Y %H:%M:%S", t)

    body = {
        'domain_id': args.domain_id,
        'status': enum['success'] if args.exit_code == 0 else enum['failed']
    }
    
    resp = requests.post(args.endpoint, json=body)

    if resp.ok:
        print(f'{current_time} => {resp.json()}')
        break
    else:
        time.sleep(2 * 60) # Sleep for 2 minutes