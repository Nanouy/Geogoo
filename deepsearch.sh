# DeepSearch
# Created by Nanouy
# Version:1.05
# Date:08-02-2026
# Contact:ebsoft@aol.com


#!/bin/bash

prepare_query() {
    python3 -c "import sys, urllib.parse; print(urllib.parse.quote(sys.argv[1]))" "$*"
}

# Filtro Anti-IA
ANTI_AI="-intext:\"AI+generated\" -intext:\"language+model\" -intext:\"ChatGPT\" -intext:\"by+AI\""

# Colores
CYAN='\e[1;36m'
GREEN='\e[1;32m'
WHITE='\e[1;37m'
YELLOW='\e[1;33m'
RED='\e[1;31m'
NC='\e[0m'

if [ -n "$1" ]; then
    consulta="$*"
else
    clear
    echo -e "${CYAN}┌────────────────────────────────────────┐${NC}"
    echo -e "${CYAN}│        CENTRO DE BUSQUEDA OSINT        │${NC}"
    echo -e "${CYAN}└────────────────────────────────────────┘${NC}"
    echo -n "   🔍 Objetivo: "
    read consulta
fi

[ -z "$consulta" ] && exit 0

while true; do
    clear
    echo -e "${CYAN}┌────────────────────────────────────────┐${NC}"
    echo -e "${CYAN}│${WHITE}            MENU DE BUSQUEDAS           ${CYAN}│${NC}"
    echo -e "${CYAN}├────────────────────────────────────────┤${NC}"
    echo -e "${CYAN}│${YELLOW}  0) PERSONALIZADO (Elegir Extensión)   ${CYAN}│${NC}"
    echo -e "${CYAN}│${WHITE}  1) DOC (Textos y Ofimática)           ${CYAN}│${NC}"
    echo -e "${CYAN}│${WHITE}  2) PDF (Documentos Digitales)         ${CYAN}│${NC}"
    echo -e "${CYAN}│${WHITE}  3) IMG (Imágenes y Fotos)             ${CYAN}│${NC}"
    echo -e "${CYAN}│${WHITE}  4) MP  (Video y Audio)                ${CYAN}│${NC}"
    echo -e "${CYAN}│${WHITE}  5) SOC (Redes y Foros)                ${CYAN}│${NC}"
    echo -e "${CYAN}│${WHITE}  6) GEO (Satélite y Mapas)             ${CYAN}│${NC}"
    echo -e "${CYAN}├────────────────────────────────────────┤${NC}"
    echo -e "${CYAN}│${YELLOW}  7) CAMBIAR TARGET                     ${CYAN}│${NC}"
    echo -e "${CYAN}│${RED}  Q) FINALIZAR PROTOCOLO                ${CYAN}│${NC}"
    echo -e "${CYAN}└────────────────────────────────────────┘${NC}"
    
    echo -e "${WHITE} TARGET ACTIVO:${NC} ${GREEN}$consulta${NC}"
    echo -e "${CYAN} ────────────────────────────────────────${NC}"
    
    echo -n "   ⚡ Selecciona una opción: "
    read opcion

    # Validar salida con Q o q
    if [[ "$opcion" == "q" || "$opcion" == "Q" ]]; then
        echo -e "   ${YELLOW}👋 Saliendo...${NC}"
        break
    fi

    Q_ENCODED=$(prepare_query "$consulta")

    case $opcion in
        0) 
            echo -n "   📂 Escribe la extensión (ej: apk, xls, config): "
            read ext_personalizada
            URL="https://www.google.com/search?q=${Q_ENCODED}+filetype:${ext_personalizada}+${ANTI_AI}" 
            ;;
        1) ext="(filetype:doc OR filetype:docx OR filetype:txt)"; URL="https://www.google.com/search?q=${Q_ENCODED}+${ext}+${ANTI_AI}" ;;
        2) ext="filetype:pdf"; URL="https://www.google.com/search?q=${Q_ENCODED}+${ext}+${ANTI_AI}" ;;
        3) URL="https://www.google.com/search?tbm=isch&q=${Q_ENCODED}+${ANTI_AI}" ;;
        4) ext="(intitle:index.of OR inurl:ftp OR inurl:uploads) (mp4|mkv|mp3|avi)"; URL="https://www.google.com/search?q=${Q_ENCODED}+${ext}" ;;
        5) ext="(site:reddit.com OR site:twitter.com OR site:t.me)"; URL="https://www.google.com/search?q=${Q_ENCODED}+${ext}" ;;
        6) URL="https://www.google.com/maps/search/${Q_ENCODED}" ;;
        7) echo -n "   🔍 Nuevo Objetivo: "; read consulta; continue ;;
        *) echo -e "   ${RED}⚠️ No válido.${NC}"; sleep 1; continue ;;
    esac

    echo "[$(date '+%Y-%m-%d %H:%M')] Tarea: $consulta | Filtro: $opcion" >> "busquedas.log"
    xdg-open "$URL" >/dev/null 2>&1 &
    
    echo -e "\n   ${GREEN}🚀 Desplegado.${NC} Volviendo al menú..."
    sleep 1.2
done
