Return-Path: <SRS0=M5O5=7S=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linus.walleij@linaro.org,
	lorenzo.bianconi@st.com,
	devicetree@vger.kernel.org
Subject: [PATCH 0/5] Add support to LIS2DW12 accel sensor
Date: Wed, 16 Aug 2017 21:13:11 +0200
Message-Id: <20170816191316.11469-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Modify management of drdy line and status register in order to support
LIS2DW12 device
This patchset is based on 'Add support to LIS2MDL magnetometer sensor'
patchset

Lorenzo Bianconi (5):
  iio: st_sensors: decouple irq1 configuration parameters from the irq2
    ones
  iio: st_sensors: do not always write enable_axis register
  iio: st_sensors: add register mask for status register
  iio: accel: add support to LIS2DW12
  dt-bindings: iio: accel: add LIS2DW12 sensor device binding

 .../devicetree/bindings/iio/st-sensors.txt         |   1 +
 drivers/iio/accel/st_accel.h                       |   2 +
 drivers/iio/accel/st_accel_core.c                  | 180 +++++++++++++++++----
 drivers/iio/accel/st_accel_i2c.c                   |   5 +
 drivers/iio/accel/st_accel_spi.c                   |   5 +
 drivers/iio/common/st_sensors/st_sensors_core.c    |  33 ++--
 drivers/iio/common/st_sensors/st_sensors_trigger.c |  16 +-
 drivers/iio/gyro/st_gyro_core.c                    |  33 ++--
 drivers/iio/magnetometer/st_magn_core.c            |  11 +-
 drivers/iio/pressure/st_pressure_core.c            |  50 ++++--
 include/linux/iio/common/st_sensors.h              |  23 ++-
 11 files changed, 271 insertions(+), 88 deletions(-)

-- 
2.14.0
