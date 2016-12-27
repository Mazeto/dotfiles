#!/usr/bin/sh

# colors fg_bg
whi_blk="#[fg=7,bg=0]";
whi_red="#[fg=7,bg=1]";
whi_gre="#[fg=7,bg=2]";

std_col="#[fg=7,bg=0]";
mem_col=$std_col;
tmp_col=$std_col;
bat_col=$std_col;

# vars
mem_low=150;
tmp_hot=90;
bat_low=10;
mb="mB";

# Get values

vol=$(pamixer --get-volume);

mem=$(cat /proc/meminfo | grep "MemAvailable" | grep -o "[0-9]*");
mem=$(echo "$mem 1000 /p" | dc);

tmp=$(echo `echo -n $(cat /sys/class/thermal/thermal_zone0/temp) 1000 /p | dc`); # 80

bat_stat=`echo -n $(cat /sys/class/power_supply/BAT0/status)`;
bat_caps=`echo -n $(cat /sys/class/power_supply/BAT0/capacity)`;

hour=`echo -n $(date "+%H:%M")`;

date=`echo -n $(date "+%d.%m.%y(%a)")`;

# set colours
if [ $mem -lt $mem_low ]; then
  mem_col=$whi_red;
fi;

if [ $tmp -ge $tmp_hot ];then
  tmp_col=$whi_red;
fi;

if [ $bat_caps -lt $bat_low ];then
  bat_col=$whi_red;
fi;

if [ $bat_caps -eq 100 ] && [ $bat_stat != "Discharging" ];then
  bat_col=$whi_gre;
fi;

# Echo status bar string
echo " vol:$vol% |$mem_col mem:$mem$mb $std_col|$tmp_col tmp:$tmp°C $std_col|$bat_col $bat_stat:$bat_caps% $std_col| $date | $hour ";

