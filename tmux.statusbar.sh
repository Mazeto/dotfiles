#!/usr/bin/sh

vol=$(pamixer --get-volume);
mem=$(cat /proc/meminfo);
mem=$(echo $mem | grep "MemAvailable");
#mem=$(echo `cat /proc/meminfo` | grep "MemAvailable" | grep -Eo "[0-9]+");
#mem=$(echo -n $(echo -n $(cat /proc/meminfo | grep Available | grep [0-9]+) 1000 /p | dc)); # 1400
echo "$vol | $mem";
mem_low=150;
#tmp=$(echo `echo -n $(cat /sys/class/thermal/termal_zone0/temp) 1000 /p | dc`); # 80
#bat_stat=`echo -n $(cat /sys/class/power_supply/BAT0/status)`;
#bat_caps=`echo -n $(cat /sys/class/power_supply/BAT0/capacity)`;
#date=`echo -n $(date "+%d.%m.%y(%a)")`;
#hour=`echo -n $(date "+%H:%M")`;

# colors fg_bg
whi_blk="#[fg=7,bg=0]";
whi_red="#[fg=7,bg=1]";
whi_gre="#[fg=7,bg=2]";

#mem_col=$(if [ $mem -lt $mem_low ]; then echo -n "$whi_red"; fi);
#tmp_col=$(if [ $tmp -gt 89 ]; then echo -n "$whi_red"; fi);
#bat_col=$(if [ $bat_stat == 'Full' ]; then echo -n "$whi_gre"; elif [ $bat_stat == 'Charging' ]; then echo -n "$whi_blk"; elif [ $bat_caps -lt 6 ]; echo -n "$whi_red"; fi);

#echo -n " vol:$vol% |$mem_col mem:$mem $whi_blk|$tmp_col tmp:$tem $whi_blk|$bat_col $bat_stat:$bat_caps% $whi_blk| $date | $hour ";

#set -g status-right " vol:#(exec pamixer --get-volume)% |
#(exec echo -n $(if [ $(cat /proc/meminfo | grep Available | grep -Eo '[0-9]+') -lt 150000 ];
#then echo '#[fg=7,bg=1]\n'; fi))
#mem:#(exec
#echo $(cat /proc/meminfo | grep Available | grep -o '[0-9]*') 1000 /p | dc)MB #[fg=7,bg=0]|
#(exec echo $(if [ $(cat /sys/class/thermal/thermal_zone0/temp) -gt 90000 ];
#then echo '#[fg=7,bg=1]';fi))
#tmp:#(exec echo $(cat /sys/class/thermal/thermal_zone0/temp) 1000 / p | dc )C° #[fg=7,bg=0]|

#(exec echo $( if [ $(cat /sys/class/power_supply/BAT0/status) == 'Full' ];
#then echo '#[fg=7,bg=2]'; elif [ $(cat /sys/class/power_supply/BAT0/status) == 'Charging' ];
#then echo '#[fg=7,bg=0]'; elif [ $(cat /sys/class/power_supply/BAT0/capacity) -lt 6 ];
#then echo '#[fg=7,bg=1]'; fi)) #(exec cat /sys/class/power_supply/BAT0/status):
#(exec cat /sys/class/power_supply/BAT0/capacity)% #[fg=7,bg=0]| %d.%m.%y(%a) | %H:%M "
