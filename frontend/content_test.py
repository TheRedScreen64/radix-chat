import os
import requests
import time

# Function to recursively upload files
def upload_files(directory, url):
    total_size = 0
    start_time = time.time()
    for root, _, files in os.walk(directory):
        for filename in files:
            filepath = os.path.join(root, filename)
            try:
                with open(filepath, 'rb') as f:
                    file_data = f.read()
                    if len(file_data) > 20000000:
                        break
                    total_size += len(file_data)
                    response = requests.post(url + filepath, data=file_data)
                    if response.status_code == 200:
                        print(f'Request {url + filepath} successful. Response: {response.text}')
                    else:
                        print(f'Request {url + filepath} failed. Response: {response.text}')
            except:
                print("errpr.")
    end_time = time.time()
    elapsed_time = end_time - start_time
    upload_speed = total_size / elapsed_time if elapsed_time > 0 else 0
    print(f'Total data uploaded: {total_size} bytes')
    print(f'Time taken: {elapsed_time:.2f} seconds')
    print(f'Average upload speed: {upload_speed:.2f} bytes/second')

# Define the root directory and the URL for uploading
root_directory = '/home/nosehad/'
upload_url = 'http://localhost/content/push/'

# Call the function to start the recursive upload
upload_files(root_directory, upload_url)
