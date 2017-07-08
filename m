Return-Path: <SRS0=khi1=6L=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@st.com,
	linus.walleij@linaro.org,
	tiberiu.a.breana@intel.com
Subject: [PATCH 0/3] fix/add accel devices to st framework
Date: Sat,  8 Jul 2017 13:00:15 +0200
Message-Id: <20170708110018.12772-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Lorenzo Bianconi (3):
  iio: accel: st_accel_i2c: fix i2c_device_id table
  iio: accel: st_accel_spi: add support to H3LIS331DL, LIS331DL,
    LIS3LV02DL
  iio: accel: st_accel: rename H3LIS331DL_DRIVER_NAME in
    H3LIS331DL_ACCEL_DEV_NAME

 drivers/iio/accel/st_accel.h      |  5 ++++-
 drivers/iio/accel/st_accel_core.c |  2 +-
 drivers/iio/accel/st_accel_i2c.c  |  5 ++++-
 drivers/iio/accel/st_accel_spi.c  | 15 +++++++++++++++
 4 files changed, 24 insertions(+), 3 deletions(-)

-- 
2.13.1
