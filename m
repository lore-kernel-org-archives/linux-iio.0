Return-Path: <SRS0=7t/v=EB=redhat.com=lorenzo.bianconi@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: [PATCH 0/2] fix sparse warnings in st_lsm6dsx
Date: Sat,  6 Jan 2018 23:23:23 +0100
Message-Id: <20180106222325.17442-1-lorenzo.bianconi@redhat.com>
List-ID: <linux-iio@vger.kernel.org>

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: pre-allocate read buffer at bootstrap
  iio: imu: st_lsm6dsx: remove st_lsm6dsx_write_with_mask() declaration

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        | 6 ++++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 7 +++----
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 4 ++++
 3 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.15.1
