#Title:Geogoo
#Auhor:neobot
#Contact:ebsoft@live.com
#Version:1.0.0

import requests
import urllib.parse

def geocodificar():
    address = input("Introduce la direccion que deseas geocodificar: ")

    # 1. Formatear la dirección para la URL (Encoding)
    formatted_address = urllib.parse.quote(address)
    
    # 2. Definir URL y User-Agent
    # NOTA: Nominatim requiere un User-Agent identificado para no bloquearte
    url = f"https://nominatim.openstreetmap.org/search?q={formatted_address}&format=json"
    headers = {
        'User-Agent': 'MiGeocodificadorPython/1.0'
    }

    try:
        # 3. Hacer la solicitud HTTP
        response = requests.get(url, headers=headers)
        data = response.json()

        # 4. Verificar si hay resultados
        if len(data) > 0:
            location = data[0]
            lat = location['lat']
            lon = location['lon']
            print(f"\n? Coordenadas encontradas:")
            print(f"Latitud: {lat}")
            print(f"Longitud: {lon}")
        else:
            print("\n? No se encontraron resultados para esa direccion.")
            
    except Exception as e:
        print(f"Hubo un error en la conexión: {e}")

if __name__ == "__main__":
    geocodificar()
