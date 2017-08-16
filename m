Return-Path: <SRS0=M5O5=7S=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linus.walleij@linaro.org,
	lorenzo.bianconi@st.com
Subject: [PATCH 0/4] Add support to LIS2MDL magnetometer sensor
Date: Wed, 16 Aug 2017 19:02:49 +0200
Message-Id: <20170816170253.8382-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Fix two interrupt issues for LSM303AGR magn sensor

Lorenzo Bianconi (4):
  iio: magnetometer: st_magn: fix status register address for LSM303AGR
  iio: magnetometer: st_magn: remove ihl property for LSM303AGR
  iio: magnetometer: add support to LIS2MDL
  dt-bindings: iio: magn: add LIS2MDL sensor device binding

 Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
 drivers/iio/magnetometer/st_magn.h                   | 1 +
 drivers/iio/magnetometer/st_magn_core.c              | 5 ++---
 drivers/iio/magnetometer/st_magn_i2c.c               | 5 +++++
 drivers/iio/magnetometer/st_magn_spi.c               | 5 +++++
 5 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.14.0
