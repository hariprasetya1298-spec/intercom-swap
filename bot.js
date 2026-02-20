	mport os
from web3 import Web3
from dotenv import load_dotenv

# Load data dari .env
load_dotenv()

# Konfigurasi
RPC_URL = "ISI_RPC_URL_MU"
PRIVATE_KEY = "ISI_PRIVATE_KEY_MU"
RECIPIENT = "ALAMAT_TUJUAN" # Bisa alamat sendiri

w3 = Web3(Web3.HTTPProvider(RPC_URL))
account = w3.eth.account.from_key(PRIVATE_KEY)

def send_tx():
    try:
        # 1. Siapkan Transaksi
        tx = {
            'nonce': w3.eth.get_transaction_count(account.address),
            'to': RECIPIENT,
            'value': w3.to_wei(0.0001, 'ether'), # Jumlah kirim
            'gas': 21000,
            'gasPrice': w3.eth.gas_price,
            'chainId': w3.eth.chain_id
        }

        # 2. Tanda Tangan & Kirim
        signed_tx = w3.eth.account.sign_transaction(tx, PRIVATE_KEY)
        tx_hash = w3.eth.send_raw_transaction(signed_tx.raw_transaction)
        
        print(f"✅ Berhasil! Hash: {w3.to_hex(tx_hash)}")
    except Exception as e:
        print(f"❌ Gagal: {e}")

if __name__ == "__main__":
    send_tx()

