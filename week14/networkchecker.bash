#!/bin/bash


myIP=$(bash myIP.bash)

function helpmenu(){
  echo "HELP MENU"
  echo "----"
  echo "-n: Add -n as an argument for this script to use nmap"
  echo "  -n external: External NMAP scan"
  echo "  -n internal: Internal NMAP scan"
  echo "-s: Add -s as an argument for this script to use ss"
  echo "  -s external: External ss(Netstat) scan"
  echo "  -s internal: Internal ss(Netstat) scan"
  echo ""
  echo "Usage: bash networkchecker.bash -n/-s external/internal"
  echo "----"
}

# Return ports that are serving to the network
function ExternalNmap(){
  rex=$(nmap "${myIP}" | awk -F"[/[:space:]]+" '/open/ {print $1,$4}' )
}

# Return ports that are serving to localhost
function InternalNmap(){
  rin=$(nmap localhost | awk -F"[/[:space:]]+" '/open/ {print $1,$4}' )
}


# Only IPv4 ports listening from network
function ExternalListeningPorts(){

  exlpo=$(ss -ltpn | awk -F"[[:space:]:(),]+" '!/127.0.0./ && /LISTEN/ {print $5,$9}' | tr -d "\"" | awk '$2!="*"')
}


# Only IPv4 ports listening from localhost
function InternalListeningPorts(){
ilpo=$(ss -ltpn | awk  -F"[[:space:]:(),]+" '/127.0.0./ {print $5,$9}' | tr -d "\"")
}






[ $# -ne 2 ] && helpmenu && exit 1




while getopts "n:s:" option; do
  case $option in
    n)
      if [[ "$OPTARG" == "external" ]]; then
        ExternalNmap
        echo "$rex"
      elif [[ "$OPTARG" == "internal" ]]; then
        InternalNmap
        echo "$rin"
      else
        helpmenu
      fi
      ;;
    s)
      if [[ "$OPTARG" == "external" ]]; then
        ExternalListeningPorts
        echo "$exlpo"
      elif [[ "$OPTARG" == "internal" ]]; then
        InternalListeningPorts
        echo "$ilpo"
      else
        helpmenu
      fi
      ;;
    *)
      helpmenu
      ;;
  esac
done
