Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: rdunlap@infradead.org,
	denis.ciocca@st.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/2] iio:st_sensors more fixes when !IIO_CONFIG_TRIGGER
Date: Sat,  9 Feb 2013 10:49:25 +0000
Message-Id: <1360406967-25026-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Here is how I would suggest dealing with the issues pointed out by
Randy when buildling without trigger support.

Jonathan

Jonathan Cameron (2):
  iio:triggers Protect functions in triggers.h from use when not
    compiled
  iio:st_sensors fix build when !CONFIG_IIO_TRIGGER

 drivers/iio/accel/st_accel_core.c       | 9 +++++++--
 drivers/iio/accel/st_accel_i2c.c        | 1 -
 drivers/iio/accel/st_accel_spi.c        | 1 -
 drivers/iio/gyro/st_gyro_core.c         | 9 +++++++--
 drivers/iio/gyro/st_gyro_i2c.c          | 1 -
 drivers/iio/gyro/st_gyro_spi.c          | 1 -
 drivers/iio/magnetometer/st_magn_core.c | 1 -
 drivers/iio/magnetometer/st_magn_i2c.c  | 1 -
 drivers/iio/magnetometer/st_magn_spi.c  | 1 -
 include/linux/iio/trigger.h             | 5 +++++
 10 files changed, 19 insertions(+), 11 deletions(-)

-- 
1.8.1.1
