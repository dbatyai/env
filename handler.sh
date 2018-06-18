#!/bin/bash
# Default acpi script that takes an entry for all actions

case "$1" in
    button/power)
        case "$2" in
            PBTN|PWRF)
                logger 'PowerButton pressed'
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
        ;;
    button/sleep)
        case "$2" in
            SLPB|SBTN)
                logger 'SleepButton pressed'
                echo -n mem >/sys/power/state
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
        ;;
    ac_adapter)
        case "$2" in
            AC|ACAD|ADP0)
                case "$4" in
                    00000000)
                        logger 'AC unpluged'
                        ;;
                    00000001)
                        logger 'AC pluged'
                        ;;
                esac
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
        ;;
    battery)
        case "$2" in
            BAT0)
                case "$4" in
                    00000000)
                        logger 'Battery online'
                        ;;
                    00000001)
                        logger 'Battery offline'
                        ;;
                esac
                ;;
            CPU0)
                ;;
            *)  logger "ACPI action undefined: $2" ;;
        esac
        ;;
    button/lid)
        case "$3" in
            close)
                logger 'LID closed'
                #echo -n mem >/sys/power/state
                ;;
            open)
                logger 'LID opened'
                ;;
            *)
                logger "ACPI action undefined: $3"
                ;;
        esac
        ;;
    video/brightnessdown)
        case "$2" in
            BRTDN)
                max=`cat /sys/class/backlight/intel_backlight/max_brightness`
                curr=`cat /sys/class/backlight/intel_backlight/brightness`
                step=`expr $max / 10`
                new=`expr $curr - $step`
                clamped=`echo -e "$new\n$step" | sort -g | tail -n 1`
                echo "$clamped" > /sys/class/backlight/intel_backlight/brightness
                logger "Brightness down $clamped"
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
        ;;
    video/brightnessup)
        case "$2" in
            BRTUP)
                max=`cat /sys/class/backlight/intel_backlight/max_brightness`
                curr=`cat /sys/class/backlight/intel_backlight/brightness`
                step=`expr $max / 10`
                new=`expr $curr + $step`
                clamped=`echo -e "$new\n$max" | sort -g | head -n 1`
                echo "$clamped" > /sys/class/backlight/intel_backlight/brightness
                logger "Brightness up $clamped"
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
        ;;
    video/displayoff)
        case "$2" in
            DOFF)
                current=`cat /sys/class/backlight/intel_backlight/bl_power`
                new=`expr 1 - $current`
                echo $new > /sys/class/backlight/intel_backlight/bl_power
                logger "Display on/off"
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
        ;;
    *)
        logger "ACPI group/action undefined: $1 / $2"
        ;;
esac

# vim:set ts=4 sw=4 ft=sh et:
