#!/bin/bash

# Tìm dung lượng RAM hiện có
total_ram=$(free -m | awk '/^Mem:/{print $2}')

# Tạo swap với dung lượng gấp đôi RAM hiện có
dd if=/dev/zero of=/swapfile bs=1M count=$((2 * total_ram))

# Phân quyền cho file swap
chmod 600 /swapfile

# Định cấu hình file swap
mkswap /swapfile

# Kích hoạt swap
swapon /swapfile

# Thêm vào file /etc/fstab để swap tự động kích hoạt sau khi khởi động
echo '/swapfile   none    swap    sw    0   0' >> /etc/fstab

# Hiển thị thông tin về RAM và swap
free -h
