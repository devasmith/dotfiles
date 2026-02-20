function bat-full --description "Set battery charge limit to 100%"
    echo 0 | sudo tee /sys/class/power_supply/BAT0/charge_control_start_threshold >/dev/null
    echo 100 | sudo tee /sys/class/power_supply/BAT0/charge_control_end_threshold >/dev/null
end
