
#!/bin/bash

partitions=(sda2 sdb5 sdb6 nvme1n1p2)

for partition in ${partitions[@]}
do
    cat > "/etc/systemd/system/mount-$partition.service" <<EOL
[Unit]
Description=Mount NTFS partition $partition

[Service]
Type=oneshot
ExecStart=/usr/bin/mount -t ntfs-3g /dev/$partition /mnt/$partition
ExecStop=/usr/bin/umount /mnt/$partition
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOL

    sudo systemctl enable "mount-$partition.service"
    sudo systemctl start "mount-$partition.service"
done
