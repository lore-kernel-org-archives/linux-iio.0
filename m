Return-Path: <SRS0=PE8Z=A4=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: [PATCH 0/4] rework st_lsm6dsx driver to support more devices
Date: Wed, 27 Sep 2017 21:29:24 +0200
Message-Id: <20170927192928.16160-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

This is the first patchset that reworks st_lsm6dsx driver to properly
support more devices

Lorenzo Bianconi (4):
  iio: imu: st_lsm6dsx: convert max_fifo_size in fifo words
  iio: imu: st_lsm6dsx: split fifo mode and fifo odr configuration
  iio: imu: st_lsm6dsx: move decimator info in
    st_lsm6dsx_sensor_settings
  iio: imu: st_lsm6dsx: add FIFO ops data structure

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        | 33 +++++++++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 72 ++++++++++++------------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 78 ++++++++++++++++++++++----
 3 files changed, 133 insertions(+), 50 deletions(-)

-- 
2.14.1
