import os
import base64
import requests
import json
from itertools import zip_longest
import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

# --------------- Agent Data -----------------------
AGENT_IDS = {
    "a3bfb853-43b2-7238-a4f1-ad90e9e46bcc": "Reyna",
    "1dbf2edd-4729-0984-3115-daa5eed44993": "Clove",
    "add6443a-41bd-e414-f6ad-e58d267f4e95": "Jett",
    "8e253930-4c05-31dd-1b6c-968525494517": "Omen",
    "569fdd95-4d10-43ab-ca70-79becc718b46": "Sage",
    "320b2a48-4d9b-a075-30f1-1f93a9b638fa": "Sova",
    "e370fa57-4757-3604-3648-499e1f642d3f": "Gekko",
    "bb2a4828-46eb-8cd1-e765-15848195d751": "Neon",
    "f94c3b30-42be-e959-889c-5aa313dba261": "Raze",
    "b444168c-4e35-8076-db47-ef9bf368f384": "Tejo",
    "117ed9e3-49f3-6512-3ccf-0cada7e3823b": "Cypher",
    "22697a3d-45bf-8dd7-4fec-84a9e28c69d7": "Chamber",
    "1e58de9c-4950-5125-93e9-a0aee9f98746": "Killjoy",
    "eb93336a-449b-9c1b-0a54-a891f7921d69": "Phoenix",
    "6f2a04ca-43e0-be17-7f36-b3908627744d": "Skye",
    "9f0d8ba9-4140-b941-57d3-a7ad57c6b417": "Brimstone",
    "5f8d3a7f-467b-97f3-062c-13acf203c006": "Breach",
    "dade69b4-4f5a-8528-247b-219e5a1facd6": "Fade",
    "7f94d92c-4234-0a36-9646-3a87eb8b5c89": "Yoru",
    "601dbbe7-43ce-be57-2a40-4abd24953621": "Kayo",
    "41fb69c1-4189-7b37-f117-bcaf1e96f1bf": "Astra",
    "707eab51-4836-f488-046a-cda6bf494859": "Viper",
    "95b78ed7-4637-86d9-7e41-71ba8c293152": "Harbor",
    "cc8b64c8-4b25-4ff9-6e7f-37b4da43d235": "Deadlock",
    "0e38b510-41a8-5780-5e8f-568b2a4f2d6c": "Iso",
    "efba5359-4016-a1e5-7626-b1ae76895940": "Vyse",
    "df1cb487-4902-002e-5c17-d28e83e78588": "Waylay"
}

# --------------- Lockfile Data -----------------------
path = os.path.expandvars(r"%LocalAppData%\Riot Games\Riot Client\Config\lockfile")

with open(path, "r") as lockfile:
    content = lockfile.read()

parts = content.split(":")
name, pid, port, password, protocol = parts
region = "na"
shard = "na"
auth_string = f"riot:{password}"
b64_auth = base64.b64encode(auth_string.encode()).decode()

client_platform = {
    "platformType": "PC",
    "platformOS": "Windows",
    "platformOSVersion": "10.0.26100.1.256.64bit", # Hardcoded, replace X.X.X.1.256.64bit with "Version" from System Information
    "platformChipset": "Unknown"
}

client_platform_json = json.dumps(client_platform)
client_platform_b64 = base64.b64encode(client_platform_json.encode('utf-8')).decode('utf-8') # Dict --> JSON String --> bytes --> base64 bytes --> base64 string

# --------------- Getting Client Version -----------------------
response = requests.get("https://valorant-api.com/v1/version")
data = response.json()
client_version = data["data"]["riotClientVersion"]
print("Client version:", client_version)

#If that endpoint goes down, can look for this from ShooterGame.log: CI server version: release-10.09-3-3470802

# --------------- Getting PUUID, Token, Access Token -----------------------
getEntitlementToken = f"https://127.0.0.1:{port}/entitlements/v1/token"
headers = {
    "X-Riot-ClientPlatform": client_platform_b64,
    "X-Riot-ClientVersion": client_version,
    "Authorization": f"Basic {b64_auth}",
}
response = requests.request("GET", getEntitlementToken, headers=headers, verify=False)
data = response.json()
access_token = data["accessToken"]
entitlement_token = data["token"]
callerPuuid = data["subject"]

headers = {
    "X-Riot-ClientPlatform": client_platform_b64,
    "X-Riot-ClientVersion": client_version,
    "X-Riot-Entitlements-JWT": entitlement_token,
    "Authorization": f"Bearer {access_token}",
}


def get_match_data(region, shard, callerPuuid, headers):
    # Attempt pregame
    url_pregame_player = f"https://glz-{region}-1.{shard}.a.pvp.net/pregame/v1/players/{callerPuuid}"
    response = requests.get(url_pregame_player, headers=headers, verify=False)
    if response.status_code == 200:
        player_data = response.json()
        current_match_id = player_data.get("MatchID")
        if current_match_id:
            url_pregame_match = f"https://glz-{region}-1.{shard}.a.pvp.net/pregame/v1/matches/{current_match_id}"
            match_response = requests.get(url_pregame_match, headers=headers, verify=False)
            if match_response.status_code == 200:
                print("Using pregame data")
                return match_response.json()

    # Fallback to coregame
    url_core_player = f"https://glz-{region}-1.{shard}.a.pvp.net/core-game/v1/players/{callerPuuid}"
    response = requests.get(url_core_player, headers=headers, verify=False)
    if response.status_code == 200:
        player_data = response.json()
        current_match_id = player_data.get("MatchID")
        if current_match_id:
            url_core_match = f"https://glz-{region}-1.{shard}.a.pvp.net/core-game/v1/matches/{current_match_id}"
            match_response = requests.get(url_core_match, headers=headers, verify=False)
            if match_response.status_code == 200:
                print("Using coregame data")
                return match_response.json()

    # If both fail
    return None


def extract_players(match_data):
    if not match_data:
        return []

    if "Players" in match_data:
        players = match_data.get("Players", [])
        result = []
        for player in players:
            team_id = player.get("TeamID")
            puuid = player.get("Subject")
            character_id = player.get("CharacterID")
            if team_id and puuid:
                result.append((team_id, puuid, character_id))
        return result

    elif "Teams" in match_data:
        result = []
        teams = match_data.get("Teams", [])
        for team in teams:
            team_id = team.get("TeamID")
            players = team.get("Players", [])
            for player in players:
                puuid = player.get("Subject")
                character_id = player.get("CharacterID")
                if team_id and puuid:
                    result.append((team_id, puuid, character_id))
        return result

    return []

match_data = get_match_data(region, shard, callerPuuid, headers)
playerTuple = extract_players(match_data)

# --------------- Using Name Service to associate name with PUUID  -----------------------
puuids = [tup[1] for tup in playerTuple]

url = f"https://pd.{shard}.a.pvp.net/name-service/v2/players"
response = requests.put(url, headers=headers, json=puuids, verify=False)

caller_team = None
for team_id, puuid, _ in playerTuple:
    if puuid == callerPuuid:
        caller_team = team_id
        break

if response.status_code == 200:
    name_data = response.json()
    puuid_to_name = {}
    for entry in name_data:
        puuid_to_name[entry["Subject"]] = f"{entry['GameName']}#{entry['TagLine']}"


    teammates = []
    enemies = []

    for team, puuid, char_id in playerTuple:
        agent_name = AGENT_IDS.get(char_id, "Unknown Agent")
        player_name = puuid_to_name.get(puuid, "Unknown Player")
        display = f"{player_name:<22} ({agent_name})"
        if team == caller_team:
            teammates.append(display)
        else:
            enemies.append(display)

    # --- Print in two-column table ---
    print(f"{'TEAMMATES':<40} | {'ENEMIES'}")
    print("-" * 80)
    for tm, em in zip_longest(teammates, enemies, fillvalue=""):
        print(f"{tm:<40} | {em}")


##print("Match details status:", match_response.status_code)
##print("Match details JSON:", json.dumps(match_response.json(), indent=2))


## ("Status Code:", response.status_code)
## ("Response JSON:", response.json())

## print("Port:", port)
## print("Password:", password)
## print("Auth string:", b64_auth)
## print("Status Code:", response.status_code)
## print("Response:", response.text)
##
## print("Access Token:", access_token)
## print("Entitlement Token:", entitlement_token)
## print("Puuid:", puuid)