#!/bin/bash

echo "STARTING PROCESS"
echo "....................................."
echo "....................................."
echo "....................................."
echo "....................................."

echo "getting the name of the attached disk"
DISK_NAME=$(lsblk -o NAME,SIZE -nr | grep "256G" | awk '{print $1}')
echo "Name of attached disk is ${DISK_NAME}"

echo "....................................."
echo "....................................."
echo "....................................."
echo "....................................."

echo "Formatting and creating partition on ${DISK_NAME}"
sudo parted /dev/${DISK_NAME} --script mklabel gpt mkpart xfspart xfs 0% 100%
sudo mkfs.xfs -f /dev/${DISK_NAME}
sudo partprobe /dev/${DISK_NAME}

echo "....................................."
echo "....................................."
echo "....................................."
echo "....................................."

echo "Mounting disk ${DISK_NAME}"
sudo mkdir /datadrive
sudo mount /dev/${DISK_NAME} /datadrive
echo "${DISK_NAME} disk mounted to /datadrive"

echo "....................................."
echo "....................................."
echo "....................................."
echo "....................................."

echo "Adding ${DISK_NAME} mount to fstab"
echo "....................................."
DISK_UUID=$(sudo blkid /dev/${DISK_NAME} | awk '{print $2}' | sed 's/UUID="//;s/"//' | sed 's/[[:space:]]*$//')
echo "UUID=$DISK_UUID /datadrive    xfs   defaults,nofail 1 2" | sudo tee -a /etc/fstab


echo "....................................."
echo "....................................."
echo "....................................."
echo "....................................."
echo "COMPLETED"


