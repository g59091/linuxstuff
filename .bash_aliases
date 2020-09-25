## variables
PGRMFLDR="$HOME/lpgrms/"

## aliases
## can be found using 'alias' command
alias fs='ls -aF --color=auto'
alias c='clear'
alias cfs='c;fs'
alias ipnow='curl ipinfo.io/ip'
alias sag='sudo apt-get'
alias sagi='sudo apt-get install'
alias sagr='sudo apt-get remove'
alias sagp='sudo apt-get purge'
alias saga='sudo apt-get autoremove'
alias rm='rm -rv'
alias mv='mv -i'
alias nv='nvim'
alias sagu='sudo apt-get update'
alias saguu='sudo apt-get update && sudo apt-get upgrade'
alias rb='. ~/.bashrc; clear'
alias eb='nvim ~/.bash_aliases'
alias ei3='nvim ~/.config/i3/config'
alias ebl='nvim ~/.config/i3blocks/config'
alias apan='dpkg --list | wc --lines'
alias debi='sudo dpkg -i' 
alias untarg='tar -xvzf'
alias untarx='tar -xvf'
alias untarb='tar -xvjf'

## functions
## can be found using 'aliasf' command

wdesi() # mounts my external hard drive drive to /mnt
{
  espath=$(lsblk | grep '3.7T' | grep 'part' | awk '{print $1}' | tr -dc '[:alnum:]\n\r' | sed 's/.*/\/dev\/&/')
  sudo -i mount $espath /mnt && echo "Disk mounted to /mnt." || echo "Error mounting $espath to /mnt."
}

wdeso() # unmounts my external hard drive from /mnt
{
  sudo -i umount /mnt && echo "Disk unmounted from /mnt." || echo "Error unmounting from /mnt."
}

starwars() # a new hope
{
  telnet towel.blinkenlights.nl
}

fss() # [1] (directory or file) calculates size of either directory or file inputted 
{
  if [[ -d $1 ]]; then
    echo "Dir. size is $(du -hs $1 | cut -f 1)."
  elif [[ -f $1 ]]; then
    echo "File size is $(ls -l --b=M $1 | cut -d " " -f5)."
  elif [ $# -eq 0 ]; then
    echo "Dir. size is $(du -hs . | cut -f 1)." 
  else
    echo "$1 is not valid parameter to check size of."
  fi
}

trash() # [1] (file/dir) safer rm 
{
  minrsize="1048576"
  rsize=$(wc -c <"$1")
  if [[ $risze -ge $minrsize ]]; then
    echo "Are you sure you want to trash $1? You will delete $rsize amount of files."
  fi
}

tcd() # [1] (Xh:Xm:Xs) text countdown clock with seconds, minutes, and hours input 
{
  termdown -ab "$1"
}

tsw() # text stopwatch to count time
{ 
  termdown -a
}

clc() # [1] (math expression) uses the bc command as a calculator, up to 4 digits floating point
{
  bc -l <<< "scale=4; $1"
}

psn() # [1] (process name) search up process with name
{
  ps aux | grep -i "$1"
}

fsc() # [~1] (dir) changes path to directory and views files inside
{
  cd "$1"
  fs
}

fsa() # [~1] (dir) counts the amount of files inside a directory
{
  echo $((`ls -1a $1 | wc -l` - 2))
}

fst() # [1, ~2] (filetype, dir) displays files in directory of filetype provided
{
  # fs | grep --color=always ".$1$"
  if [[ $# -eq 2 ]]; then
    find $2 -iname "*.$1" | cut -c 3-
  elif [[ $# -eq 1 ]]; then
    find . -iname "*.$1" | cut -c 3-
  else
    echo "Error. File type not supplied."
  fi
} 

rnf() # [2] (file, newname) renames file to have newname 
{
  if [[ ! -f "$1" ]]; then
    echo "Error: file type arg must be present."
    return
  fi
  scrpath="$( cd "$(dirname "$1")" >/dev/null 2>&1 ; pwd -P )"
  rdl=$(readlink -f "$1")
  extens=$([[ "$rdl" = *.* ]] && echo ".${rdl##*.}" || echo '')
  rsf=$(echo "$scrpath/$2$extens")
  #echo $scrpath
  #echo $extens
  #echo $rsf
  #echo $rdl
  #echo "mv '$rdl' '$rsf'"
  echo "File renamed to $2$extens."
  mv "$rdl" "$rsf"
}

whm() # [2] (URL, name) makes html link to open url at a later time with specific name
{
  if [[ $# -eq 2 ]]; then
    printf "<html>\n<head>\n<meta http-equiv='refresh' content='0; url=$1' />\n</head>\n<body>\n</body>\n</html>" >> $2.html
  else
    echo "Please specify two params (url, name)."
  fi
}

om() # [1] (file) opens either image, gif, video, or text document based on its file type
{
  if [[ $1 =~ (\.jpe?g|\.png|\.ppm|\.pgm)$ ]]; then
    (feh "$1" </dev/null &>/dev/null &)
  elif [[ $1 =~ (\.gif|\.svg|\.tiff)$ ]]; then
    (imvr "$1" </dev/null &>/dev/null &)
  elif [[ $1 =~ (\.mp4|\.mp3|\.mkv|\.mka|\.ogg|\.flac|\.webm|\.mov|\.wmv|\.wav|\.m4a|\.mpe?g|\.aac)$ ]]; then
    (vlc "$1" </dev/null &>/dev/null &) 
    # echo "vlc filetype = $1"
  elif [[ $1 =~ (\.docx?|\.xlsx?|\.pptx?|\.odt|\.ods|\.odp|\.rtf)$ ]]; then
    (libreoffice "$1" </dev/null &>/dev/null &) 
  elif [[ $1 =~ (\.pdf|\.djvu)$ ]]; then
    (zathura "$1" </dev/null &>/dev/null &)
  elif [[ $1 =~ (\.html)$ ]]; then
    (chromium "$1" </dev/null &>/dev/null &)
  else
    echo "File type error. Please try again."
  fi
}

omt() # [1] (file) checks how long (in hh:mm:ss.ms) a video file is 
{
  ffmpeg -i $1 2>&1 | grep "Duration"| cut -d ' ' -f 4 | sed s/,//
}

pgen() # [1] (number) creates password with length 'number' and copies to clipboard.
{
  pass=$(date +%s | sha256sum | base64 | head -c $1)
  xclip -selection clipboard <<< "$pass"
  echo "$pass generated to clipboard."
}

prand() # creates password with length 12.
{
  openssl rand -base64 12
}

mtcp() # [1] (text) copies text to clipboard.
{
  xclip -selection clipboard <<< "$1"
  echo "$1 clipped to clipboard."
}

voluma() # [~1] (volume percent) shows & controls audio.
{ 
  # provided by intika and phoxis on stackoverflow
  if [ $# -eq 0 ]
  then
    vol=$(amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }')
    echo "Master volume is at $vol."
  else
    amixer set 'Master' $1% > /dev/null
    echo "Master volume set to $1%."
  fi
}

volumapr() # [~1] (process name) shows & controls audio for indiv. processes.
{
  if [ $# -eq 0 ]; then
    "$PGRMFLDR"pa_volume/pa_volume | sed 's/client: //; s/[0-9]*%/: &/; s/ *:/:/'
  elif [ $# -eq 1 ]; then 
    "$PGRMFLDR"pa_volume/pa_volume "$1" | sed 's/client: //; s/[0-9]*%/: &/; s/ *:/:/' 
  else 
    "$PGRMFLDR"pa_volume/pa_volume "$1" "$2"; echo "$1 has been set to $2% volume."
  fi
}

sleepn() # suspends the pc
{ 
  systemctl suspend
}

hibernaten() # hibernates the pc
{
  systemctl hibernate
}

shutdownn() # shuts down pc and unmounts usb if mounted
{
  sudo shutdown -h now
}

godotge() # launches the godot game engine
{
  "$PGRMFLDR"Godot_v3.2.1-stable_mono_x11_64/Godot_v3.2.1-stable_mono_x11.64 </dev/null &>/dev/null &
}

iaip() # [1] (package) shows if certain package is installed in system
{
  dpkg -l "$1" &> /dev/null && echo "'$1' is installed currently." || echo "'$1' isn't installed currently."
}

iavp() # [1] (package) shows if package is available on debian databases {apt-cache}
{
  cche=$(apt-cache show "$1" 2> /dev/null)
  # () &> /dev/null
  # test if [ "${$(apt-cache show git):0:1}" = \N ]
  [[ "${cche:0:1}" == "P" ]] && echo "'$1' is available currently." || echo "'$1' isn't available currently."
}

aliasf() # displays alias function help
{
  # based on Gilles 'SO- stop being evil''s code
  # https://unix.stackexchange.com/questions/260627/how-do-you-list-all-functions-and-aliases-in-a-specific-script
  grep -E '^[[:space:]]*([[:alnum:]_]+[[:space:]]*\(\)|function[[:space:]]+[[:alnum:]_]+)' ~/.bash_aliases | sort
}

tclk() # text 24hr clock
{
  termdown -z -Z "%H:%M:%S"
}

## memes
bruh() # bruh.
{
  echo " _                _    "
  echo "| |__  _ __ _   _| |__  "
  echo "| '_ \| '__| | | | '_ \ "
  echo "| |_) | |  | |_| | | | |"
  echo "|_.__/|_|   \__,_|_| |_|"
}

