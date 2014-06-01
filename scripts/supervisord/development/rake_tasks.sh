#!/bin/bash

# scripts
scripts=(
	wishd_serv_str
	wishd_serv_stp
)

# superivsord shell script helper for snapw routine scripts
svisor="sudo supervisorctl"
if [ -z "$1" ]
then
	printf "Usage: ./rake_tasks.sh (update|start|stop|status)\n"
else
	case "$1" in
    "update")
        printf "updating... \n"
        
        for i in "${scripts[@]}"
		do
		   ${svisor} stop $i
		done
		sudo rm /var/log/wishd*.*.log
		sudo cp etc/supervisor/conf.d/wish_det.conf /etc/supervisor/conf.d/wish_det.conf
		${svisor} reread
		${svisor} update
        for i in "${scripts[@]}"
		do
		   ${svisor} start $i
		done
        for i in "${scripts[@]}"
		do
		   ${svisor} status $i
		done
		cat /var/log/wishd*.out.log
		cat /var/log/wishd*.err.log
        ;;
    "start")
    	printf "starting... \n"
        for i in "${scripts[@]}"
		do
		   ${svisor} start $i
		done
    	;;
    "stop")
        printf "stopping... \n"
        for i in "${scripts[@]}"
		do
		   ${svisor} stop $i
		done
        ;;
    "restart")
        printf "stopping... \n"
        for i in "${scripts[@]}"
		do
		   ${svisor} stop $i
		done
    	printf "starting... \n"
        for i in "${scripts[@]}"
		do
		   ${svisor} start $i
		done		
        ;;
    "status")
        printf "status... \n"
        for i in "${scripts[@]}"
		do
		   ${svisor} status $i
		done
        ;;
    "tail")
        printf "tail... \n"
        for i in "${scripts[@]}"
		do
		   ${svisor} tail $i
		done
        ;;
    "logs")
        printf "logs... \n"
    	cat /var/log/wishd*.out.log
		cat /var/log/wishd*.err.log
    	;;        
    *)
	esac
fi