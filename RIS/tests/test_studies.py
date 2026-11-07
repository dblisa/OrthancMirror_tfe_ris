import requests

ORTHANC_URL = "http://localhost:8042"
AUTH = ("orthanc", "orthanc")

response = requests.get(
    f"{ORTHANC_URL}/studies",
    auth=AUTH,
    timeout=5
)

response.raise_for_status()

studies = response.json()

print("Nombre d'études :", len(studies))
print("Études :", studies)
