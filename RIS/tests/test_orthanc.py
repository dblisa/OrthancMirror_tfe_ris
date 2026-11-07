import requests

ORTHANC_URL = "http://localhost:8042"

response = requests.get(
    f"{ORTHANC_URL}/system",
    timeout=5
)

print("Status:", response.status_code)
print(response.json())