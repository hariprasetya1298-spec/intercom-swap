import requests
import time

# --- KONFIGURASI ---
# Pastikan URL diapit tanda kutip yang benar
RPC_URL = "https://polygon-rpc.com"

ADDRESS = "0x1efD4DB8b7bFe247C75323dAE62B95f24b1cBAAfU"


def get_balance():
    payload = {
        "jsonrpc": "2.0",
        "method": "eth_getBalance",
        "params": [ADDRESS, "latest"],
        "id": 1
    }
    try:
        response = requests.post(RPC_URL, json=payload, timeout=10)
        result = response.json().get('result')
        if result:
            balance = int(result, 16) / 10**18
            print(f"✅ [{time.strftime('%H:%M:%S')}] Saldo: {balance:.5f} ETH/MATIC")
        else:
            print("❌ RPC merespon tapi data kosong.")
    except Exception as e:
        print(f"📡 Koneksi Gagal: {e}")

if __name__ == "__main__":
    print("🚀 Bot Monitoring Aktif")
    while True:
        get_balance()
        time.sleep(10)

