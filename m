Return-Path: <giuseppe.barba@st.com>
From: Giuseppe Barba <giuseppe.barba@st.com>
To: <linux-iio@vger.kernel.org>
CC: <denis.ciocca@st.com>, <jic23@kernel.org>,
        Giuseppe Barba
	<giuseppe.barba@st.com>
Subject: [PATCH V2 0/5] Added ST LSM303AGR sensor
Date: Mon, 20 Jul 2015 16:20:24 +0200
Message-ID: <1437402029-29786-1-git-send-email-giuseppe.barba@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This patch set add support for STMicroelectronics LSM303AGR device,
which embeds an accelerometer and a magnetometer sensors.
These patches have been rebased on iio repo testing branch and tested on Panda
board.

Giuseppe Barba (5):
  iio: st-sensors: add configuration for WhoAmI address
  iio: st-sensors: add support for single full scale device
  iio: st_magn: Add irq trigger handling
  iio: st-accel: add support for lsm303agr accelerometer
  iio: st-magn: add support for lsm303agr magnetometer

 .../devicetree/bindings/iio/st-sensors.txt         |  2 +
 drivers/iio/accel/st_accel.h                       |  1 +
 drivers/iio/accel/st_accel_core.c                  |  6 ++
 drivers/iio/accel/st_accel_i2c.c                   |  5 ++
 drivers/iio/accel/st_accel_spi.c                   |  1 +
 drivers/iio/common/st_sensors/st_sensors_core.c    | 40 +++++----
 drivers/iio/gyro/st_gyro_core.c                    |  3 +
 drivers/iio/magnetometer/st_magn.h                 |  3 +
 drivers/iio/magnetometer/st_magn_buffer.c          |  7 ++
 drivers/iio/magnetometer/st_magn_core.c            | 98 +++++++++++++++++++++-
 drivers/iio/magnetometer/st_magn_i2c.c             |  5 ++
 drivers/iio/magnetometer/st_magn_spi.c             |  1 +
 drivers/iio/pressure/st_pressure_core.c            |  3 +
 include/linux/iio/common/st_sensors.h              |  2 +
 14 files changed, 158 insertions(+), 19 deletions(-)

-- 
1.9.1
