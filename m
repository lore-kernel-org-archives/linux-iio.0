Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Denis CIOCCA <denis.ciocca@st.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/6] iio: enable ST Sensors on Ux500
Date: Sun, 13 Apr 2014 21:08:57 +0200
Message-Id: <1397416143-4396-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

This series:
- Patches the ST sensor drivers to all announce their presence and
  grab regulators for vdd and vddio if need be
- Adds device tree bindings and probe path for device tree
- Registers the applicable sensors for Ux500 so you can see how it
  plays out.

All but the last patch should eventually be merged through the
IIO tree if we can agree upon the implementation. I will merge the
last patch through the Ux500 tree.

Linus Walleij (6):
  iio: st_sensors: announce registered sensors
  iio: st_sensors: move regulator retrieveal to core
  iio: st_sensors: get platform data from device tree
  iio: st_sensors: add device tree bindings
  iio: st_sensors: add devicetree probing support
  ARM: ux500: add misc sensors to the device trees

 .../devicetree/bindings/iio/st-sensors.txt         | 54 ++++++++++++++++
 arch/arm/boot/dts/ste-href.dtsi                    | 30 +++++++++
 arch/arm/boot/dts/ste-hrefv60plus.dtsi             | 15 ++++-
 arch/arm/boot/dts/ste-snowball.dts                 | 38 +++++++++++-
 drivers/iio/accel/st_accel.h                       | 47 ++++++++++++++
 drivers/iio/accel/st_accel_core.c                  |  7 +++
 drivers/iio/accel/st_accel_i2c.c                   |  2 +
 drivers/iio/common/st_sensors/st_sensors_core.c    | 72 +++++++++++++++++++++-
 drivers/iio/common/st_sensors/st_sensors_i2c.c     | 29 +++++++++
 drivers/iio/gyro/st_gyro.h                         | 35 +++++++++++
 drivers/iio/gyro/st_gyro_core.c                    |  7 +++
 drivers/iio/gyro/st_gyro_i2c.c                     |  2 +
 drivers/iio/magnetometer/st_magn.h                 | 19 ++++++
 drivers/iio/magnetometer/st_magn_core.c            |  7 +++
 drivers/iio/magnetometer/st_magn_i2c.c             |  2 +
 drivers/iio/pressure/st_pressure.h                 | 19 ++++++
 drivers/iio/pressure/st_pressure_core.c            | 42 ++-----------
 drivers/iio/pressure/st_pressure_i2c.c             |  2 +
 include/linux/iio/common/st_sensors.h              |  4 ++
 include/linux/iio/common/st_sensors_i2c.h          | 11 ++++
 20 files changed, 401 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/st-sensors.txt

-- 
1.9.0
