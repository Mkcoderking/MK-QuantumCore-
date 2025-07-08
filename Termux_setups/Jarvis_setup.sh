# === MK KING LOGIN FORM STYLE ===
clear
echo -e "\e[1;36m"
figlet -f slant "MK KING LOGIN" | lolcat
echo -e "\e[1;33m---------------------------------------------"
echo -e "         🔐 Welcome to MK KING Terminal"
echo -e "     Please verify yourself to continue..."
echo -e "---------------------------------------------\e[0m"

# Input form
read -p $'\e[1;32m👤 Username:\e[0m ' user
read -sp $'\e[1;33m🔒 Password:\e[0m ' pass
echo

if [[ "$user" != "king" || "$pass" != "12345" ]]; then
  echo -e "\e[1;31m❌ ACCESS DENIED: Incorrect credentials!\e[0m"
  sleep 1
  espeak -s 150 -p 60 -a 150 "Access denied. Please try again." 2>/dev/null
  exit
else
  echo -e "\e[1;32m✅ ACCESS GRANTED: Welcome $user!\e[0m"
  espeak -s 150 -p 60 -a 150 "Access granted. Welcome back Sir." 2>/dev/null
  sleep 1
fi


# === COLORS ===
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
NC='\033[0m'

# === PROMPT ===
parse_git_branch() {
  git branch 2>/dev/null | grep '*' | sed 's/* //'
}
export PS1="\[\033[1;35m\]╭─[\[\033[1;36m\]MK\[\033[1;35m\]]─(\[\033[1;32m\]\w\[\033[1;35m\])[\[\033[1;33m\]\A\[\033[1;35m\]]\[\033[1;34m\]\>

# === BANNER ===
clear
for i in 1 2 3; do
  clear
  echo -e "${CYAN}"
  figlet -f slant "JARVIS"
  echo -e "${NC}"
  sleep 0.2
done

# === TIME + DATE (Visual Only) ===
HOUR=$(date +"%H")
MIN=$(date +"%M")
TIME_STR=$(date +"%I:%M %p")
DATE_STR=$(date +"%A, %d %B %Y")

if [ "$HOUR" -ge 4 ] && [ "$HOUR" -lt 12 ]; then
  GREET="Good Morning"
elif [ "$HOUR" -ge 12 ] && [ "$HOUR" -lt 17 ]; then
  GREET="Good Afternoon"
elif [ "$HOUR" -ge 17 ] && [ "$HOUR" -lt 21 ]; then
  GREET="Good Evening"
else
  GREET="Good Night"
fi

echo -e "${YELLOW}Welcome back, Mehboob Sir"
echo -e "${BLUE}📅 Date: ${DATE_STR}"
echo -e "${GREEN}⏰ Time: ${TIME_STR}"
echo -e "${CYAN}🧠 $GREET, Mehboob!${NC}"

# === APP LAUNCHER ===
function open() {
  case "$1" in
    instagram) am start -a android.intent.action.VIEW -d https://instagram.com && espeak "Opening Instagram";;
    youtube) am start -a android.intent.action.VIEW -d https://youtube.com && espeak "Opening YouTube";;
    whatsapp) am start -a android.intent.action.VIEW -d https://whatsapp.com && espeak "Opening WhatsApp";;
    facebook) am start -a android.intent.action.VIEW -d https://facebook.com && espeak "Opening Facebook";;
    chrome) am start -a android.intent.action.VIEW -d https://google.com && espeak "Opening Chrome";;
    settings) am start -a android.settings.SETTINGS && espeak "Opening Settings";;
    gallery) am start -a android.intent.action.VIEW -d file:///sdcard/DCIM/Camera/ && espeak "Opening Gallery";;
    contacts) am start -a android.intent.action.VIEW -d content://contacts/people/ && espeak "Opening Contacts";;
    camera) am start -a android.media.action.IMAGE_CAPTURE && espeak "Opening Camera";;
    *) echo -e "${RED}⚠️ App '$1' not found.${NC}"; espeak "App $1 not found";;
  esac
}

# === VOICE FEEDBACK FOR VALID COMMANDS ===
smart_jarvis_command() {
  case "$1" in
    ls) espeak "Listing files and folders" 2>/dev/null ;;
    cd) espeak "Changing directory" 2>/dev/null ;;
    mkdir) espeak "Creating a new folder" 2>/dev/null ;;
    nano) espeak "Opening the nano editor" 2>/dev/null ;;
    clear) espeak "Clearing the screen" 2>/dev/null ;;
    rm) espeak "Deleting file or folder" 2>/dev/null ;;
    touch) espeak "Creating a new file" 2>/dev/null ;;
    figlet) espeak "Generating styled text" 2>/dev/null ;;
    ping) espeak "Pinging the network" 2>/dev/null ;;
    curl) espeak "Fetching from the internet" 2>/dev/null ;;
    apt|pkg) espeak "Managing packages" 2>/dev/null ;;
    *) ;;
  esac
}
PROMPT_COMMAND='LAST_CMD=$(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//"); smart_jarvis_command "$(echo $LAST_CMD | cut -d" " -f1)"'

# === SPEAK ON WRONG COMMAND ===
command_not_found_handle() {
  echo -e "${RED}❌ '$1' is not a valid command.${NC}"
  espeak "Sir, the command $1 is not valid." 2>/dev/null
}

# === HOURLY VOICE BACKGROUND RUN ===
bash ~/.jarvis_hourly.sh > /dev/null 2>&1 &
bash ~/jarvis_reminder.sh > /dev/null 2>&1 &
bash ~/weather_alert.sh > /dev/null 2>&1 &
