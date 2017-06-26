Return-Path: <SRS0=E+Nj=57=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lorenzo.bianconi@st.com,
	linus.walleij@linaro.org
Subject: [PATCH v3 0/4] Add OF support to ST sensor framework
Date: Tue, 27 Jun 2017 00:53:42 +0200
Message-Id: <20170626225346.12019-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Changes since v2:
- fix LIS302DL support

Changes since v1:
- add missing devices to {accel, magn, gyro, press} of_device_id table

Lorenzo Bianconi (4):
  iio: accel: st_accel_spi: add OF capability to st_accel_spi
  iio: magnetometer: st_magn_spi: add OF capability to st_magn_spi
  iio: gyro: st_gyro_spi: add OF capability to st_gyro_spi
  iio: pressure: st_pressure_spi: add OF capability to st_pressure_spi

 drivers/iio/accel/st_accel_spi.c       | 69 ++++++++++++++++++++++++++++++----
 drivers/iio/gyro/st_gyro_spi.c         | 53 ++++++++++++++++++++++++++
 drivers/iio/magnetometer/st_magn_spi.c | 25 ++++++++++++
 drivers/iio/pressure/st_pressure_spi.c | 33 ++++++++++++++++
 4 files changed, 172 insertions(+), 8 deletions(-)

-- 
2.13.1
