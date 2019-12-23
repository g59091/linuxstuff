alias ahelp='echo "avl cmds: bat, c, cpuget, d, datenow, e, 
ipget, memget, randpass, sag, sagu, svrtst, timenow, 
untar, ziphelp. ahelp for this message again."'
alias bat='upower -i /org/freedesktop/UPower/devices/battery_BAT1| grep -E "state|to\ full|percentage"'
alias c='clear'
alias cpuget='lscpu'
alias d='ls -aF'
alias datenow='echo "The date is now: "; date +"%A, %B %d %Y."'
alias e='exit'
alias ipget='curl ipinfo.io/ip'
alias memget='free -m -l -t'
alias randpass='openssl rand -base64 12'
alias sag='sudo apt-get'
alias sagu='sudo apt-get update && sudo apt-get upgrade'
alias svrtst='speedtest-cli'
alias timenow='echo "The time is now: "; date +"%I:%M:%S %P."'
alias untar='tar -zxvf'
alias ziphelp='echo "to open up zip files:
//unzip myzip.zip 
to close zip files: 
//zip myzip.zip
to open tar files: 
//tar xvf filename.tar
to open gz files: 
//gunzip filename_tar.gz
//tar xvf filename_tar"'

# rewriting commnads
alias wget='wget -c'

ahelp