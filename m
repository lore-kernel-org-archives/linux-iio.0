Return-Path: <SRS0=ZnXk=5Y=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: robert.dolca@intel.com,
	denis.ciocca@st.com,
	linus.walleij@linaro.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: [PATCH 0/2] fix L3GD20H gyroscope sensor support
Date: Mon, 19 Jun 2017 22:04:29 +0200
Message-Id: <20170619200431.9615-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Lorenzo Bianconi (2):
  iio: gyro: st_gyro: fix L3GD20H support
  dt-bindings: iio: gyro: add L3GD20H sensor device binding

 Documentation/devicetree/bindings/iio/st-sensors.txt |  1 +
 drivers/iio/gyro/st_gyro.h                           |  1 +
 drivers/iio/gyro/st_gyro_core.c                      | 13 +++++++------
 drivers/iio/gyro/st_gyro_i2c.c                       |  5 +++++
 drivers/iio/gyro/st_gyro_spi.c                       |  1 +
 5 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.13.1
