#!/bin/bash

# Create subvolumes
sudo btrfs subvolume create /mnt/sda2
sudo btrfs subvolume create /mnt/sdb5
sudo btrfs subvolume create /mnt/sdb6
sudo btrfs subvolume create /mnt/nvme1n1p2

# Mount NTFS partitions
sudo mount -t ntfs-3g /dev/sda2 /mnt/sda2
sudo mount -t ntfs-3g /dev/sdb5 /mnt/sdb5
sudo mount -t ntfs-3g /dev/sdb6 /mnt/sdb6
sudo mount -t ntfs-3g /dev/nvme1n1p2 /mnt/nvme1n1p2

# Change ownership and permissions of mount point directories
sudo chown parra:parra /mnt/sda2
sudo chown parra:parra /mnt/sdb5
sudo chown parra:parra /mnt/sdb6
sudo chown parra:parra /mnt/nvme1n1p2
sudo chmod 755 /mnt/sda2
sudo chmod 755 /mnt/sdb5
sudo chmod 755 /mnt/sdb6
sudo chmod 755 /mnt/nvme1n1p2

# Add entries to fstab file
echo "/mnt/sda2 /mnt/sda2 btrfs defaults 0 0" | sudo tee -a /etc/fstab
echo "/mnt/sdb5 /mnt/sdb5 btrfs defaults 0 0" | sudo tee -a /etc/fstab
echo "/mnt/sdb6 /mnt/sdb6 btrfs defaults 0 0" | sudo tee -a /etc/fstab
echo "/mnt/nvme1n1p2 /mnt/nvme1n1p2 btrfs defaults 0 0" | sudo tee -a /etc/fstab

# Add the main user to the disk group
sudo gpasswd -a parra disk
