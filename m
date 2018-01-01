Return-Path: <SRS0=bAY2=D4=redhat.com=lorenzo.bianconi@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: [PATCH 0/3] add regmap API support to st_lsm6dsx iio driver
Date: Mon,  1 Jan 2018 19:54:41 +0100
Message-Id: <20180101185444.22045-1-lorenzo.bianconi@redhat.com>
List-ID: <linux-iio@vger.kernel.org>

Lorenzo Bianconi (3):
  iio: imu: st_lsm6dsx: fix endianness in st_lsm6dsx_read_oneshot()
  iio: imu: st_lsm6dsx: introduce conf_lock mutex
  iio: imu: st_lsm6dsx: add regmap API support

 drivers/iio/imu/st_lsm6dsx/Kconfig             |   2 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        |  33 ++------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 102 +++++++++++++++--------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 111 +++++++++++--------------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c    |  55 ++++--------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c    |  70 ++++------------
 6 files changed, 153 insertions(+), 220 deletions(-)

-- 
2.15.1
