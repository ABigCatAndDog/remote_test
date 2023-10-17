#!/bin/bash
#检查系统属于哪个软件包管理器
#
######################## 介绍 ##################################
#
echo "####################################################"
echo "# This script checks your Linux system for popular #"
echo "# packeage managers and application containers,    #"
echo "# lists what's available, and makes an educated    #"
echo "# guess on your distribution's base distro.......  #"
echo "####################################################"
echo
####################### Red Hat ################################
#
echo
echo "Checking for Red Hat-based package managers &application containers..."
#
if (which rpm &> /dev/null)
then
    item_rpm=1
    echo "you have the basic rpm utility."
#
else
    item_rpm=0
#
fi
#
if (which dnf &> /dev/null)
then
    item_dnfyum=1
    echo "you have the yum package manager."
#
else
    item_dnfyum=0
#
fi
#
if (which flatpak &> /dev/null)
then
    item_flatapk=1
    echo "you have the flatapk package manager."
#
else
    item_flatapk=0
#
fi
#
redhatscore=$[$item_dnfyum+$item_flatapk+$item_rpm]
#
#
################################## Debian Check ###############################
#
echo 
echo "Checking for Debian-based package managers & aplication containers"
#
if (which dpkg &> /dev/null)
then
    item_dpkg=1;
    echo "you have the basic dpkg utility."
#
else
    item_dpkg=0
#
fi
#
if (which apt &> /dev/null)
then
    item_aptaptget=1
    echo "you have the basic apt package utility."
#
elif (which apt-get &> /dev/null)
then
    item_aptaptget=1
    echo "you have the apt-get/apt-cache package manager."
#
else
    item_aptaptget=0
#
fi
#
if (which snap &> /dev/null)
then
    item_snap=1;
    echo "you have the basic snap application utility."
#
else
    item_snap=0
#
fi
#
debianscore=$[$item_aptaptget+$item_dpkg+$item_snap]
#
#
################################# Determine Distro ################################
#
echo
if [ $debianscore -gt $redhatscore ]
then
    echo "Most likely your linux distribution is Debian-based"
elif [ $debianscore -lt $redhatscore ]
then
    echo "Most likely your linux distribution is Red Hat-based"
else
    echo "Unable to determine linux distrubution base"
fi
#
echo
#
###################################################################################
#
exit
