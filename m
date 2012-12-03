Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Denis Ciocca <denis.ciocca@gmail.com>,
	Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	Pavel Machek <pavel@denx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"burman.yan@gmail.com" <burman.yan@gmail.com>
Date: Mon, 3 Dec 2012 17:40:42 +0100
Subject: STMicroelectronics driver
Message-ID: <50BCE41A.8000707@st.com>
References: <5072F3B9.4050309@st.com> <507338B5.60307@metafoo.de>
 <665718a4-de6b-4d09-ba80-35705fcf2595@email.android.com>
 <CAEE_umojW5OyB3yGgE54wH7_k__dBu9=Yew_0tCCf5--=C2g5g@mail.gmail.com>
 <507D9EA3.4070009@metafoo.de> <5085128C.7020507@st.com>
 <50858B44.2080006@kernel.org> <5087E2A8.4070304@st.com>
 <508A7DA6.7050505@metafoo.de> <508E4492.8080000@st.com>
 <508E48D1.3000703@metafoo.de> <508E5978.5000907@st.com>
 <508E5AD5.1040907@metafoo.de> <50914366.4090000@st.com>
 <5091546D.9000601@metafoo.de>
 <CAEE_umoKvv9ciBfUSahDqsmcbHi9W=93o5YSpE-vxUduCmqWSQ@mail.gmail.com>
 <50982F71.3060606@kernel.org> <5098F065.1090009@st.com>
 <50A12D8C.6040207@st.com> <50A14485.2060902@kernel.org>
 <50A26967.4050102@st.com> <50A8E083.1050908@kernel.org>
 <50AFA000.3040906@st.com> <50B0F495.6040409@kernel.org>
 <50B4DDEC.9030903@st.com> <50B73017.8080706@metafoo.de>
 <F8B002B1B3BA5342BA0E4153603A884DDEBE245AE0@SAFEX1MAIL1.st.com>
 <50B88C20.4080402@metafoo.de> <50B8AF59.9080906@kernel.org>
In-Reply-To: <50B8AF59.9080906@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Lars-Peter & Jonathan,

in according to your previous emails, I have modified the accelerometers
driver to support all the sensors without code repetition.
In order to follow my company requests I need to submit at least the IIO
accelerometers driver in next kernel release.
I'll do my best to finalise enclosed solution on time for next release,
otherwise I have to submit Accelometer driver first and then patch it
for gyroscope and magnetometer.
Thanks for your feedback.

Denis



 From 5b63bcd8934ab3b18edf71c71e7671a70922f043 Mon Sep 17 00:00:00 2001
From: Denis Ciocca <denis.ciocca@st.com>
Date: Tue, 27 Nov 2012 16:20:40 +0100
Subject: [PATCH] iio:common: Add STMicroelectronics common driver

This patch adds generic common code driver for STMicroelectronics
accelerometers, gyroscopes, currently it supports:
LSM303DLH, LSM303DLHC, LIS3DH, LIS331DLH, LSM303DL, LSM303DLM,
L3G4200D, LSM330DL, L3GD20, L3GD20H, LSM330D, LSM330DLC, LSM9DS0,
L3G4IS, LSM330
---
  Documentation/ABI/testing/sysfs-bus-iio-accel-st   |    7 +
  Documentation/ABI/testing/sysfs-bus-iio-gyro-st    |    7 +
  drivers/iio/accel/Kconfig                          |   14 +
  drivers/iio/accel/Makefile                         |    1 +
  drivers/iio/accel/st_accel.c                       |  493 +++++++++++++++=
+
  drivers/iio/common/Kconfig                         |    1 +
  drivers/iio/common/Makefile                        |    1 +
  drivers/iio/common/st-sensors/Kconfig              |   17 +
  drivers/iio/common/st-sensors/Makefile             |    6 +
  drivers/iio/common/st-sensors/st_sensors.h         |  259 +++++++++
  drivers/iio/common/st-sensors/st_sensors_buffer.c  |  178 ++++++
  drivers/iio/common/st-sensors/st_sensors_core.c    |  589
++++++++++++++++++++
  drivers/iio/common/st-sensors/st_sensors_i2c.c     |  137 +++++
  drivers/iio/common/st-sensors/st_sensors_spi.c     |  183 ++++++
  drivers/iio/common/st-sensors/st_sensors_trigger.c |   83 +++
  drivers/iio/gyro/Kconfig                           |   14 +
  drivers/iio/gyro/Makefile                          |    1 +
  drivers/iio/gyro/st_gyro.c                         |  252 +++++++++
  18 files changed, 2243 insertions(+), 0 deletions(-)
  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-accel-st
  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-gyro-st
  create mode 100644 drivers/iio/accel/st_accel.c
  create mode 100644 drivers/iio/common/st-sensors/Kconfig
  create mode 100644 drivers/iio/common/st-sensors/Makefile
  create mode 100644 drivers/iio/common/st-sensors/st_sensors.h
  create mode 100644 drivers/iio/common/st-sensors/st_sensors_buffer.c
  create mode 100644 drivers/iio/common/st-sensors/st_sensors_core.c
  create mode 100644 drivers/iio/common/st-sensors/st_sensors_i2c.c
  create mode 100644 drivers/iio/common/st-sensors/st_sensors_spi.c
  create mode 100644 drivers/iio/common/st-sensors/st_sensors_trigger.c
  create mode 100644 drivers/iio/gyro/st_gyro.c

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-accel-st
b/Documentation/ABI/testing/sysfs-bus-iio-accel-st
new file mode 100644
index 0000000..f426c02
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-accel-st
@@ -0,0 +1,7 @@
+What:          /sys/bus/iio/devices/iio:deviceX/powerdown
+KernelVersion: 3.7.0
+Contact:       linux-iio@vger.kernel.org
+Description:
+               Reading returns either '1' or '0'.
+               '1' means that the device in question is off.
+               '0' means that the devices in question is on.
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-gyro-st
b/Documentation/ABI/testing/sysfs-bus-iio-gyro-st
new file mode 100644
index 0000000..f426c02
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-gyro-st
@@ -0,0 +1,7 @@
+What:          /sys/bus/iio/devices/iio:deviceX/powerdown
+KernelVersion: 3.7.0
+Contact:       linux-iio@vger.kernel.org
+Description:
+               Reading returns either '1' or '0'.
+               '1' means that the device in question is off.
+               '0' means that the devices in question is on.
diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index b2510c4..6e8a955 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -13,4 +13,18 @@ config HID_SENSOR_ACCEL_3D
          Say yes here to build support for the HID SENSOR
          accelerometers 3D.

+config ST_ACCEL_3D
+       tristate "STMicroelectronics accelerometers 3-Axis Driver"
+       depends on (I2C || SPI_MASTER) && SYSFS
+       select IIO_BUFFER
+       select IIO_TRIGGERED_BUFFER
+       select ST_SENSORS_IIO_COMMON
+       help
+         Say yes here to build support for STMicroelectronics acceleromete=
rs:
+         LSM303DLH, LSM303DLHC, LIS3DH, LSM330D, LSM330DL, LSM330DLC, LSM3=
03D,
+         LSM9DS0, LIS331DLH, LSM303DL, LSM303DLM, LSM330.
+
+         This driver can also be built as a module. If so, the module
+         will be called st_accel.
+
  endmenu
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 5bc6855..d3ce19a 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -3,3 +3,4 @@
  #

  obj-$(CONFIG_HID_SENSOR_ACCEL_3D) +=3D hid-sensor-accel-3d.o
+obj-$(CONFIG_ST_ACCEL_3D) +=3D st_accel.o
diff --git a/drivers/iio/accel/st_accel.c b/drivers/iio/accel/st_accel.c
new file mode 100644
index 0000000..02c9ff8
--- /dev/null
+++ b/drivers/iio/accel/st_accel.c
@@ -0,0 +1,493 @@
+/*
+ * STMicroelectronics accelerometers driver
+ *
+ * Copyright 2012 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/mutex.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/irq.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/buffer.h>
+
+#include "../common/st-sensors/st_sensors.h"
+
+
+/* FULLSCALE */
+#define ST_ACCEL_FS_AVL_2G                     2
+#define ST_ACCEL_FS_AVL_4G                     4
+#define ST_ACCEL_FS_AVL_6G                     6
+#define ST_ACCEL_FS_AVL_8G                     8
+#define ST_ACCEL_FS_AVL_16G                    16
+
+/* CUSTOM VALUES FOR SENSOR 1 */
+#define ST_ACCEL_1_WAI_EXP                     0x33
+#define ST_ACCEL_1_ODR_ADDR                    0x20
+#define ST_ACCEL_1_ODR_MASK                    0xf0
+#define ST_ACCEL_1_ODR_N_BIT                   4
+#define ST_ACCEL_1_ODR_AVL_1HZ_VAL             0x01
+#define ST_ACCEL_1_ODR_AVL_10HZ_VAL            0x02
+#define ST_ACCEL_1_ODR_AVL_25HZ_VAL            0x03
+#define ST_ACCEL_1_ODR_AVL_50HZ_VAL            0x04
+#define ST_ACCEL_1_ODR_AVL_100HZ_VAL           0x05
+#define ST_ACCEL_1_ODR_AVL_200HZ_VAL           0x06
+#define ST_ACCEL_1_ODR_AVL_400HZ_VAL           0x07
+#define ST_ACCEL_1_ODR_AVL_1600HZ_VAL          0x08
+#define ST_ACCEL_1_FS_N_BIT                    2
+#define ST_ACCEL_1_FS_ADDR                     0x23
+#define ST_ACCEL_1_FS_MASK                     0x30
+#define ST_ACCEL_1_FS_AVL_2_VAL                        0x00
+#define ST_ACCEL_1_FS_AVL_4_VAL                        0x01
+#define ST_ACCEL_1_FS_AVL_8_VAL                        0x02
+#define ST_ACCEL_1_FS_AVL_16_VAL               0x03
+#define ST_ACCEL_1_FS_AVL_2_GAIN               IIO_G_TO_M_S_2(1000)
+#define ST_ACCEL_1_FS_AVL_4_GAIN               IIO_G_TO_M_S_2(2000)
+#define ST_ACCEL_1_FS_AVL_8_GAIN               IIO_G_TO_M_S_2(4000)
+#define ST_ACCEL_1_FS_AVL_16_GAIN              IIO_G_TO_M_S_2(12000)
+#define ST_ACCEL_1_BDU_ADDR                    0x23
+#define ST_ACCEL_1_BDU_MASK                    0x80
+#define ST_ACCEL_1_DRDY_IRQ_ADDR               0x22
+#define ST_ACCEL_1_DRDY_IRQ_MASK               0x10
+#define ST_ACCEL_1_MULTIREAD_BIT               true
+
+/* CUSTOM VALUES FOR SENSOR 2 */
+#define ST_ACCEL_2_WAI_EXP                     0x49
+#define ST_ACCEL_2_ODR_ADDR                    0x20
+#define ST_ACCEL_2_ODR_MASK                    0xf0
+#define ST_ACCEL_2_ODR_N_BIT                   4
+#define ST_ACCEL_2_ODR_AVL_3HZ_VAL             0x01
+#define ST_ACCEL_2_ODR_AVL_6HZ_VAL             0x02
+#define ST_ACCEL_2_ODR_AVL_12HZ_VAL            0x03
+#define ST_ACCEL_2_ODR_AVL_25HZ_VAL            0x04
+#define ST_ACCEL_2_ODR_AVL_50HZ_VAL            0x05
+#define ST_ACCEL_2_ODR_AVL_100HZ_VAL           0x06
+#define ST_ACCEL_2_ODR_AVL_200HZ_VAL           0x07
+#define ST_ACCEL_2_ODR_AVL_400HZ_VAL           0x08
+#define ST_ACCEL_2_ODR_AVL_800HZ_VAL           0x09
+#define ST_ACCEL_2_ODR_AVL_1600HZ_VAL          0x0a
+#define ST_ACCEL_2_FS_N_BIT                    3
+#define ST_ACCEL_2_FS_ADDR                     0x21
+#define ST_ACCEL_2_FS_MASK                     0x38
+#define ST_ACCEL_2_FS_AVL_2_VAL                        0X00
+#define ST_ACCEL_2_FS_AVL_4_VAL                        0X01
+#define ST_ACCEL_2_FS_AVL_6_VAL                        0x02
+#define ST_ACCEL_2_FS_AVL_8_VAL                        0x03
+#define ST_ACCEL_2_FS_AVL_16_VAL               0x04
+#define ST_ACCEL_2_FS_AVL_2_GAIN               IIO_G_TO_M_S_2(61)
+#define ST_ACCEL_2_FS_AVL_4_GAIN               IIO_G_TO_M_S_2(122)
+#define ST_ACCEL_2_FS_AVL_6_GAIN               IIO_G_TO_M_S_2(183)
+#define ST_ACCEL_2_FS_AVL_8_GAIN               IIO_G_TO_M_S_2(244)
+#define ST_ACCEL_2_FS_AVL_16_GAIN              IIO_G_TO_M_S_2(732)
+#define ST_ACCEL_2_BDU_ADDR                    0x20
+#define ST_ACCEL_2_BDU_MASK                    0x08
+#define ST_ACCEL_2_DRDY_IRQ_ADDR               0x22
+#define ST_ACCEL_2_DRDY_IRQ_MASK               0x04
+#define ST_ACCEL_2_MULTIREAD_BIT               true
+
+/* CUSTOM VALUES FOR SENSOR 3 */
+#define ST_ACCEL_3_WAI_EXP                     0x32
+#define ST_ACCEL_3_ODR_ADDR                    0x20
+#define ST_ACCEL_3_ODR_MASK                    0x18
+#define ST_ACCEL_3_ODR_N_BIT                   2
+#define ST_ACCEL_3_ODR_AVL_50HZ_VAL            0x00
+#define ST_ACCEL_3_ODR_AVL_100HZ_VAL           0x01
+#define ST_ACCEL_3_ODR_AVL_400HZ_VAL           0x02
+#define ST_ACCEL_3_ODR_AVL_1000HZ_VAL          0x03
+#define ST_ACCEL_3_PW_ADDR                     0x20
+#define ST_ACCEL_3_PW_MASK                     0xe0
+#define ST_ACCEL_3_PW_N_BIT                    3
+#define ST_ACCEL_3_FS_N_BIT                    2
+#define ST_ACCEL_3_FS_ADDR                     0x23
+#define ST_ACCEL_3_FS_MASK                     0x30
+#define ST_ACCEL_3_FS_AVL_2_VAL                        0X00
+#define ST_ACCEL_3_FS_AVL_4_VAL                        0X01
+#define ST_ACCEL_3_FS_AVL_8_VAL                        0x03
+#define ST_ACCEL_3_FS_AVL_2_GAIN               IIO_G_TO_M_S_2(1000)
+#define ST_ACCEL_3_FS_AVL_4_GAIN               IIO_G_TO_M_S_2(2000)
+#define ST_ACCEL_3_FS_AVL_8_GAIN               IIO_G_TO_M_S_2(3900)
+#define ST_ACCEL_3_BDU_ADDR                    0x23
+#define ST_ACCEL_3_BDU_MASK                    0x80
+#define ST_ACCEL_3_DRDY_IRQ_ADDR               0x22
+#define ST_ACCEL_3_DRDY_IRQ_MASK               0x02
+#define ST_ACCEL_3_MULTIREAD_BIT               true
+
+/* CUSTOM VALUES FOR SENSOR 4 */
+#define ST_ACCEL_4_WAI_EXP                     0x40
+#define ST_ACCEL_4_ODR_ADDR                    0x20
+#define ST_ACCEL_4_ODR_MASK                    0xf0
+#define ST_ACCEL_4_ODR_N_BIT                   4
+#define ST_ACCEL_4_ODR_AVL_3HZ_VAL             0x01
+#define ST_ACCEL_4_ODR_AVL_6HZ_VAL             0x02
+#define ST_ACCEL_4_ODR_AVL_12HZ_VAL            0x03
+#define ST_ACCEL_4_ODR_AVL_25HZ_VAL            0x04
+#define ST_ACCEL_4_ODR_AVL_50HZ_VAL            0x05
+#define ST_ACCEL_4_ODR_AVL_100HZ_VAL           0x06
+#define ST_ACCEL_4_ODR_AVL_200HZ_VAL           0x07
+#define ST_ACCEL_4_ODR_AVL_400HZ_VAL           0x08
+#define ST_ACCEL_4_ODR_AVL_800HZ_VAL           0x09
+#define ST_ACCEL_4_ODR_AVL_1600HZ_VAL          0x0a
+#define ST_ACCEL_4_FS_N_BIT                    3
+#define ST_ACCEL_4_FS_ADDR                     0x24
+#define ST_ACCEL_4_FS_MASK                     0x38
+#define ST_ACCEL_4_FS_AVL_2_VAL                        0X00
+#define ST_ACCEL_4_FS_AVL_4_VAL                        0X01
+#define ST_ACCEL_4_FS_AVL_6_VAL                        0x02
+#define ST_ACCEL_4_FS_AVL_8_VAL                        0x03
+#define ST_ACCEL_4_FS_AVL_16_VAL               0x04
+#define ST_ACCEL_4_FS_AVL_2_GAIN               IIO_G_TO_M_S_2(61)
+#define ST_ACCEL_4_FS_AVL_4_GAIN               IIO_G_TO_M_S_2(122)
+#define ST_ACCEL_4_FS_AVL_6_GAIN               IIO_G_TO_M_S_2(183)
+#define ST_ACCEL_4_FS_AVL_8_GAIN               IIO_G_TO_M_S_2(244)
+#define ST_ACCEL_4_FS_AVL_16_GAIN              IIO_G_TO_M_S_2(732)
+#define ST_ACCEL_4_BDU_ADDR                    0x20
+#define ST_ACCEL_4_BDU_MASK                    0x08
+#define ST_ACCEL_4_DRDY_IRQ_ADDR               0x23
+#define ST_ACCEL_4_DRDY_IRQ_MASK               0x80
+#define ST_ACCEL_4_IG1_EN_ADDR                 0x23
+#define ST_ACCEL_4_IG1_EN_MASK                 0x08
+#define ST_ACCEL_4_MULTIREAD_BIT               false
+
+const struct iio_chan_spec st_accel_12bit_channels[] =3D {
+       ST_LSM_CHANNELS(IIO_ACCEL, ST_SENSORS_SCAN_X, IIO_MOD_X, IIO_LE,
+               ST_SENSORS_DEF_12_REALBITS, ST_SENSORS_DEF_OUT_X_L_ADDR),
+       ST_LSM_CHANNELS(IIO_ACCEL, ST_SENSORS_SCAN_Y, IIO_MOD_Y, IIO_LE,
+               ST_SENSORS_DEF_12_REALBITS, ST_SENSORS_DEF_OUT_Y_L_ADDR),
+       ST_LSM_CHANNELS(IIO_ACCEL, ST_SENSORS_SCAN_Z, IIO_MOD_Z, IIO_LE,
+               ST_SENSORS_DEF_12_REALBITS, ST_SENSORS_DEF_OUT_Z_L_ADDR),
+       IIO_CHAN_SOFT_TIMESTAMP(3)
+};
+
+const struct iio_chan_spec st_accel_16bit_channels[] =3D {
+       ST_LSM_CHANNELS(IIO_ACCEL, ST_SENSORS_SCAN_X, IIO_MOD_X, IIO_LE,
+               ST_SENSORS_DEF_16_REALBITS, ST_SENSORS_DEF_OUT_X_L_ADDR),
+       ST_LSM_CHANNELS(IIO_ACCEL, ST_SENSORS_SCAN_Y, IIO_MOD_Y, IIO_LE,
+               ST_SENSORS_DEF_16_REALBITS, ST_SENSORS_DEF_OUT_Y_L_ADDR),
+       ST_LSM_CHANNELS(IIO_ACCEL, ST_SENSORS_SCAN_Z, IIO_MOD_Z, IIO_LE,
+               ST_SENSORS_DEF_16_REALBITS, ST_SENSORS_DEF_OUT_Z_L_ADDR),
+       IIO_CHAN_SOFT_TIMESTAMP(3)
+};
+
+const struct st_sensors st_accel_sensors[] =3D {
+       {
+               .wai =3D ST_ACCEL_1_WAI_EXP,
+               .ch =3D (struct iio_chan_spec *)st_accel_12bit_channels,
+               .odr =3D {
+                       .addr =3D ST_ACCEL_1_ODR_ADDR,
+                       .mask =3D ST_ACCEL_1_ODR_MASK,
+                       .num_bit =3D ST_ACCEL_1_ODR_N_BIT,
+                       .odr_avl =3D {
+                               { 1, ST_ACCEL_1_ODR_AVL_1HZ_VAL, },
+                               { 10, ST_ACCEL_1_ODR_AVL_10HZ_VAL, },
+                               { 25, ST_ACCEL_1_ODR_AVL_25HZ_VAL, },
+                               { 50, ST_ACCEL_1_ODR_AVL_50HZ_VAL, },
+                               { 100, ST_ACCEL_1_ODR_AVL_100HZ_VAL, },
+                               { 200, ST_ACCEL_1_ODR_AVL_200HZ_VAL, },
+                               { 400, ST_ACCEL_1_ODR_AVL_400HZ_VAL, },
+                               { 1600, ST_ACCEL_1_ODR_AVL_1600HZ_VAL, },
+                       },
+               },
+               .pw =3D {
+                       .addr =3D ST_ACCEL_1_ODR_ADDR,
+                       .mask =3D ST_ACCEL_1_ODR_MASK,
+                       .num_bit =3D ST_ACCEL_1_ODR_N_BIT,
+                       .value_off =3D ST_SENSORS_DEF_POWER_OFF_VALUE,
+               },
+               .enable_axis =3D {
+                       .addr =3D ST_SENSORS_DEF_AXIS_ADDR,
+                       .mask =3D ST_SENSORS_DEF_AXIS_MASK,
+               },
+               .fs =3D {
+                       .addr =3D ST_ACCEL_1_FS_ADDR,
+                       .mask =3D ST_ACCEL_1_FS_MASK,
+                       .num_bit =3D ST_ACCEL_1_FS_N_BIT,
+                       .fs_avl =3D {
+                               [0] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_2G,
+                                       .value =3D ST_ACCEL_1_FS_AVL_2_VAL,
+                                       .gain =3D ST_ACCEL_1_FS_AVL_2_GAIN,
+                               },
+                               [1] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_4G,
+                                       .value =3D ST_ACCEL_1_FS_AVL_4_VAL,
+                                       .gain =3D ST_ACCEL_1_FS_AVL_4_GAIN,
+                               },
+                               [2] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_8G,
+                                       .value =3D ST_ACCEL_1_FS_AVL_8_VAL,
+                                       .gain =3D ST_ACCEL_1_FS_AVL_8_GAIN,
+                               },
+                               [3] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_16G,
+                                       .value =3D ST_ACCEL_1_FS_AVL_16_VAL=
,
+                                       .gain =3D ST_ACCEL_1_FS_AVL_16_GAIN=
,
+                               },
+                       },
+               },
+               .bdu =3D {
+                       .addr =3D ST_ACCEL_1_BDU_ADDR,
+                       .mask =3D ST_ACCEL_1_BDU_MASK,
+               },
+               .drdy_irq =3D {
+                       .addr =3D ST_ACCEL_1_DRDY_IRQ_ADDR,
+                       .mask =3D ST_ACCEL_1_DRDY_IRQ_MASK,
+               },
+               .multi_read_bit =3D ST_ACCEL_1_MULTIREAD_BIT,
+       },
+       {
+               .wai =3D ST_ACCEL_2_WAI_EXP,
+               .ch =3D (struct iio_chan_spec *)st_accel_16bit_channels,
+               .odr =3D {
+                       .addr =3D ST_ACCEL_2_ODR_ADDR,
+                       .mask =3D ST_ACCEL_2_ODR_MASK,
+                       .num_bit =3D ST_ACCEL_2_ODR_N_BIT,
+                       .odr_avl =3D {
+                               { 3, ST_ACCEL_2_ODR_AVL_3HZ_VAL, },
+                               { 6, ST_ACCEL_2_ODR_AVL_6HZ_VAL, },
+                               { 12, ST_ACCEL_2_ODR_AVL_12HZ_VAL, },
+                               { 25, ST_ACCEL_2_ODR_AVL_25HZ_VAL, },
+                               { 50, ST_ACCEL_2_ODR_AVL_50HZ_VAL, },
+                               { 100, ST_ACCEL_2_ODR_AVL_100HZ_VAL, },
+                               { 200, ST_ACCEL_2_ODR_AVL_200HZ_VAL, },
+                               { 400, ST_ACCEL_2_ODR_AVL_400HZ_VAL, },
+                               { 800, ST_ACCEL_2_ODR_AVL_800HZ_VAL, },
+                               { 1600, ST_ACCEL_2_ODR_AVL_1600HZ_VAL, },
+                       },
+               },
+               .pw =3D {
+                       .addr =3D ST_ACCEL_2_ODR_ADDR,
+                       .mask =3D ST_ACCEL_2_ODR_MASK,
+                       .num_bit =3D ST_ACCEL_2_ODR_N_BIT,
+                       .value_off =3D ST_SENSORS_DEF_POWER_OFF_VALUE,
+               },
+               .enable_axis =3D {
+                       .addr =3D ST_SENSORS_DEF_AXIS_ADDR,
+                       .mask =3D ST_SENSORS_DEF_AXIS_MASK,
+               },
+               .fs =3D {
+                       .addr =3D ST_ACCEL_2_FS_ADDR,
+                       .mask =3D ST_ACCEL_2_FS_MASK,
+                       .num_bit =3D ST_ACCEL_2_FS_N_BIT,
+                       .fs_avl =3D {
+                               [0] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_2G,
+                                       .value =3D ST_ACCEL_2_FS_AVL_2_VAL,
+                                       .gain =3D ST_ACCEL_2_FS_AVL_2_GAIN,
+                               },
+                               [1] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_4G,
+                                       .value =3D ST_ACCEL_2_FS_AVL_4_VAL,
+                                       .gain =3D ST_ACCEL_2_FS_AVL_4_GAIN,
+                               },
+                               [2] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_6G,
+                                       .value =3D ST_ACCEL_2_FS_AVL_6_VAL,
+                                       .gain =3D ST_ACCEL_2_FS_AVL_6_GAIN,
+                               },
+                               [3] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_8G,
+                                       .value =3D ST_ACCEL_2_FS_AVL_8_VAL,
+                                       .gain =3D ST_ACCEL_2_FS_AVL_8_GAIN,
+                               },
+                               [4] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_16G,
+                                       .value =3D ST_ACCEL_2_FS_AVL_16_VAL=
,
+                                       .gain =3D ST_ACCEL_2_FS_AVL_16_GAIN=
,
+                               },
+                       },
+               },
+               .drdy_irq =3D {
+                       .addr =3D ST_ACCEL_2_DRDY_IRQ_ADDR,
+                       .mask =3D ST_ACCEL_2_DRDY_IRQ_MASK,
+               },
+               .bdu =3D {
+                       .addr =3D ST_ACCEL_2_BDU_ADDR,
+                       .mask =3D ST_ACCEL_2_BDU_MASK,
+               },
+               .multi_read_bit =3D ST_ACCEL_2_MULTIREAD_BIT,
+       },
+       {
+               .wai =3D ST_ACCEL_3_WAI_EXP,
+               .ch =3D (struct iio_chan_spec *)st_accel_12bit_channels,
+               .odr =3D {
+                       .addr =3D ST_ACCEL_3_ODR_ADDR,
+                       .mask =3D ST_ACCEL_3_ODR_MASK,
+                       .num_bit =3D ST_ACCEL_3_ODR_N_BIT,
+                       .odr_avl =3D {
+                               { 50, ST_ACCEL_3_ODR_AVL_50HZ_VAL, },
+                               { 100, ST_ACCEL_3_ODR_AVL_100HZ_VAL, },
+                               { 400, ST_ACCEL_3_ODR_AVL_400HZ_VAL, },
+                               { 1000, ST_ACCEL_3_ODR_AVL_1000HZ_VAL, },
+                       },
+               },
+               .pw =3D {
+                       .addr =3D ST_ACCEL_3_PW_ADDR,
+                       .mask =3D ST_ACCEL_3_PW_MASK,
+                       .num_bit =3D ST_ACCEL_3_PW_N_BIT,
+                       .value_on =3D ST_SENSORS_DEF_POWER_ON_VALUE,
+                       .value_off =3D ST_SENSORS_DEF_POWER_OFF_VALUE,
+               },
+               .enable_axis =3D {
+                       .addr =3D ST_SENSORS_DEF_AXIS_ADDR,
+                       .mask =3D ST_SENSORS_DEF_AXIS_MASK,
+               },
+               .fs =3D {
+                       .addr =3D ST_ACCEL_3_FS_ADDR,
+                       .mask =3D ST_ACCEL_3_FS_MASK,
+                       .num_bit =3D ST_ACCEL_3_FS_N_BIT,
+                       .fs_avl =3D {
+                               [0] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_2G,
+                                       .value =3D ST_ACCEL_3_FS_AVL_2_VAL,
+                                       .gain =3D ST_ACCEL_3_FS_AVL_2_GAIN,
+                               },
+                               [1] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_4G,
+                                       .value =3D ST_ACCEL_3_FS_AVL_4_VAL,
+                                       .gain =3D ST_ACCEL_3_FS_AVL_4_GAIN,
+                               },
+                               [2] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_8G,
+                                       .value =3D ST_ACCEL_3_FS_AVL_8_VAL,
+                                       .gain =3D ST_ACCEL_3_FS_AVL_8_GAIN,
+                               },
+                       },
+               },
+               .bdu =3D {
+                       .addr =3D ST_ACCEL_3_BDU_ADDR,
+                       .mask =3D ST_ACCEL_3_BDU_MASK,
+               },
+               .drdy_irq =3D {
+                       .addr =3D ST_ACCEL_3_DRDY_IRQ_ADDR,
+                       .mask =3D ST_ACCEL_3_DRDY_IRQ_MASK,
+               },
+               .multi_read_bit =3D ST_ACCEL_3_MULTIREAD_BIT,
+       },
+       {
+               .wai =3D ST_ACCEL_4_WAI_EXP,
+               .ch =3D (struct iio_chan_spec *)st_accel_16bit_channels,
+               .odr =3D {
+                       .addr =3D ST_ACCEL_4_ODR_ADDR,
+                       .mask =3D ST_ACCEL_4_ODR_MASK,
+                       .num_bit =3D ST_ACCEL_4_ODR_N_BIT,
+                       .odr_avl =3D {
+                               { 3, ST_ACCEL_4_ODR_AVL_3HZ_VAL },
+                               { 6, ST_ACCEL_4_ODR_AVL_6HZ_VAL, },
+                               { 12, ST_ACCEL_4_ODR_AVL_12HZ_VAL, },
+                               { 25, ST_ACCEL_4_ODR_AVL_25HZ_VAL, },
+                               { 50, ST_ACCEL_4_ODR_AVL_50HZ_VAL, },
+                               { 100, ST_ACCEL_4_ODR_AVL_100HZ_VAL, },
+                               { 200, ST_ACCEL_4_ODR_AVL_200HZ_VAL, },
+                               { 400, ST_ACCEL_4_ODR_AVL_400HZ_VAL, },
+                               { 800, ST_ACCEL_4_ODR_AVL_800HZ_VAL, },
+                               { 1600, ST_ACCEL_4_ODR_AVL_1600HZ_VAL, },
+                       },
+               },
+               .pw =3D {
+                       .addr =3D ST_ACCEL_4_ODR_ADDR,
+                       .mask =3D ST_ACCEL_4_ODR_MASK,
+                       .num_bit =3D ST_ACCEL_4_ODR_N_BIT,
+                       .value_off =3D ST_SENSORS_DEF_POWER_OFF_VALUE,
+               },
+               .enable_axis =3D {
+                       .addr =3D ST_SENSORS_DEF_AXIS_ADDR,
+                       .mask =3D ST_SENSORS_DEF_AXIS_MASK,
+               },
+               .fs =3D {
+                       .addr =3D ST_ACCEL_4_FS_ADDR,
+                       .mask =3D ST_ACCEL_4_FS_MASK,
+                       .num_bit =3D ST_ACCEL_4_FS_N_BIT,
+                       .fs_avl =3D {
+                               [0] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_2G,
+                                       .value =3D ST_ACCEL_4_FS_AVL_2_VAL,
+                                       .gain =3D ST_ACCEL_4_FS_AVL_2_GAIN,
+                               },
+                               [1] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_4G,
+                                       .value =3D ST_ACCEL_4_FS_AVL_4_VAL,
+                                       .gain =3D ST_ACCEL_4_FS_AVL_4_GAIN,
+                               },
+                               [2] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_6G,
+                                       .value =3D ST_ACCEL_4_FS_AVL_6_VAL,
+                                       .gain =3D ST_ACCEL_4_FS_AVL_6_GAIN,
+                               },
+                               [3] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_8G,
+                                       .value =3D ST_ACCEL_4_FS_AVL_8_VAL,
+                                       .gain =3D ST_ACCEL_4_FS_AVL_8_GAIN,
+                               },
+                               [4] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_16G,
+                                       .value =3D ST_ACCEL_4_FS_AVL_16_VAL=
,
+                                       .gain =3D ST_ACCEL_4_FS_AVL_16_GAIN=
,
+                               },
+                       },
+               },
+               .bdu =3D {
+                       .addr =3D ST_ACCEL_4_BDU_ADDR,
+                       .mask =3D ST_ACCEL_4_BDU_MASK,
+               },
+               .drdy_irq =3D {
+                       .addr =3D ST_ACCEL_4_DRDY_IRQ_ADDR,
+                       .mask =3D ST_ACCEL_4_DRDY_IRQ_MASK,
+                       .ig1 =3D {
+                               .en_addr =3D ST_ACCEL_4_IG1_EN_ADDR,
+                               .en_mask =3D ST_ACCEL_4_IG1_EN_MASK,
+                       },
+               },
+               .multi_read_bit =3D ST_ACCEL_4_MULTIREAD_BIT,
+       },
+};
+
+static int st_accel_check_device_list(struct st_sensors_data *adata, u8
wai)
+{
+       int i;
+
+       for (i =3D 0; i < ARRAY_SIZE(st_accel_sensors); i++) {
+               if (st_accel_sensors[i].wai =3D=3D wai)
+                       break;
+       }
+       if (i =3D=3D ARRAY_SIZE(st_accel_sensors))
+               goto check_device_error;
+
+       adata->index =3D i;
+
+       return i;
+
+check_device_error:
+       return -ENODEV;
+}
+
+int st_accel_init_sensor(struct iio_dev *indio_dev, u8 wai)
+{
+       int err;
+       struct st_sensors_data *adata =3D iio_priv(indio_dev);
+
+       err =3D st_accel_check_device_list(adata, wai);
+       if (err < 0)
+               goto init_error;
+
+       adata->st_sensors =3D (const struct st_sensors *)st_accel_sensors;
+
+init_error:
+       return err;
+}
+EXPORT_SYMBOL(st_accel_init_sensor);
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics accelerometers driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/common/Kconfig b/drivers/iio/common/Kconfig
index ed45ee5..315632f 100644
--- a/drivers/iio/common/Kconfig
+++ b/drivers/iio/common/Kconfig
@@ -3,3 +3,4 @@
  #

  source "drivers/iio/common/hid-sensors/Kconfig"
+source "drivers/iio/common/st-sensors/Kconfig"
diff --git a/drivers/iio/common/Makefile b/drivers/iio/common/Makefile
index 8158400..f876ca5 100644
--- a/drivers/iio/common/Makefile
+++ b/drivers/iio/common/Makefile
@@ -7,3 +7,4 @@
  #

  obj-y +=3D hid-sensors/
+obj-y +=3D st-sensors/
diff --git a/drivers/iio/common/st-sensors/Kconfig
b/drivers/iio/common/st-sensors/Kconfig
new file mode 100644
index 0000000..5e17159
--- /dev/null
+++ b/drivers/iio/common/st-sensors/Kconfig
@@ -0,0 +1,17 @@
+#
+# STMicroelectronics sensors common modules
+#
+menu "STMicroelectronics Sensors IIO Common"
+
+config ST_SENSORS_IIO_COMMON
+       tristate "Common modules for all ST Sensors IIO drivers"
+       depends on (I2C || SPI_MASTER) && SYSFS
+       select IIO_TRIGGER if IIO_BUFFER
+       help
+         Say yes here to build support for HID sensor to use
+         HID sensor common processing for attributes and IIO triggers.
+         There are many attributes which can be shared among multiple
+         HID sensor drivers, this module contains processing for those
+         attributes.
+
+endmenu
diff --git a/drivers/iio/common/st-sensors/Makefile
b/drivers/iio/common/st-sensors/Makefile
new file mode 100644
index 0000000..5c517ff
--- /dev/null
+++ b/drivers/iio/common/st-sensors/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for the STMicroelectronics sensors common modules.
+#
+
+obj-$(CONFIG_ST_SENSORS_IIO_COMMON) +=3D st-sensors-iio-common.o
+st-sensors-iio-common-y :=3D st_sensors_core.o st_sensors_i2c.o
st_sensors_spi.o st_sensors_trigger.o st_sensors_buffer.o
diff --git a/drivers/iio/common/st-sensors/st_sensors.h
b/drivers/iio/common/st-sensors/st_sensors.h
new file mode 100644
index 0000000..5daadfa
--- /dev/null
+++ b/drivers/iio/common/st-sensors/st_sensors.h
@@ -0,0 +1,259 @@
+/*
+ * STMicroelectronics sensors driver
+ *
+ * Copyright 2012 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ * v. 1.0.0
+ * Licensed under the GPL-2.
+ */
+
+#ifndef ST_SENSORS_H
+#define ST_SENSORS_H
+
+#define LSM303DLH_ACCEL_DEV_NAME               "lsm303dlh_accel"
+#define LSM303DLHC_ACCEL_DEV_NAME              "lsm303dlhc_accel"
+#define LIS3DH_ACCEL_DEV_NAME                  "lis3dh"
+#define LSM330D_ACCEL_DEV_NAME                 "lsm330d_accel"
+#define LSM330DL_ACCEL_DEV_NAME                        "lsm330dl_accel"
+#define LSM330DLC_ACCEL_DEV_NAME               "lsm330dlc_accel"
+#define LSM303D_ACCEL_DEV_NAME                 "lsm303d"
+#define LSM9DS0_ACCEL_DEV_NAME                 "lsm9ds0"
+#define LIS331DLH_ACCEL_DEV_NAME               "lis331dlh"
+#define LSM303DL_ACCEL_DEV_NAME                        "lsm303dl_accel"
+#define LSM303DLM_ACCEL_DEV_NAME               "lsm303dlm_accel"
+#define LSM330_ACCEL_DEV_NAME                  "lsm330_accel"
+
+#define L3G4200D_GYRO_DEV_NAME                 "l3g4200d"
+#define LSM330DL_GYRO_DEV_NAME                 "lsm330dl_gyro"
+#define L3GD20_GYRO_DEV_NAME                   "l3gd20"
+#define L3GD20H_GYRO_DEV_NAME                  "l3gd20h"
+#define LSM330D_GYRO_DEV_NAME                  "lsm330d_gyro"
+#define LSM330DLC_GYRO_DEV_NAME                        "lsm330dlc_gyro"
+#define LSM9DS0_GYRO_DEV_NAME                  "lsm9ds0_gyro"
+#define L3G4IS_GYRO_DEV_NAME                   "l3g4is_ui"
+#define LSM330_GYRO_DEV_NAME                   "lsm330_gyro"
+
+#define ST_SENSORS_NUMBER_ALL_CHANNELS         4
+#define ST_SENSORS_NUMBER_DATA_CHANNELS                3
+#define ST_SENSORS_BYTE_4CHANNEL               2
+#define ST_SENSORS_SCAN_X                      0
+#define ST_SENSORS_SCAN_Y                      1
+#define ST_SENSORS_SCAN_Z                      2
+#define ST_SENSORS_TX_MAX_LENGHT               2
+#define ST_SENSORS_RX_MAX_LENGHT               6
+#define ST_SENSORS_FULLSCALE_AVL_MAX           5
+#define ST_SENSORS_ODR_LIST_MAX                        10
+#define ST_SENSORS_ENABLE_ALL_CHANNELS         0x07
+
+/* DEFAULT VALUES FOR SENSORS */
+#define ST_SENSORS_DEF_OUT_X_L_ADDR            0x28
+#define ST_SENSORS_DEF_OUT_X_H_ADDR            0x29
+#define ST_SENSORS_DEF_OUT_Y_L_ADDR            0x2a
+#define ST_SENSORS_DEF_OUT_Y_H_ADDR            0x2b
+#define ST_SENSORS_DEF_OUT_Z_L_ADDR            0x2c
+#define ST_SENSORS_DEF_OUT_Z_H_ADDR            0x2d
+#define ST_SENSORS_DEF_WAI_ADDRESS             0x0f
+#define ST_SENSORS_DEF_POWER_ON_VALUE          0x01
+#define ST_SENSORS_DEF_POWER_OFF_VALUE         0x00
+#define ST_SENSORS_DEF_12_REALBITS             12
+#define ST_SENSORS_DEF_16_REALBITS             16
+#define ST_SENSORS_DEF_AXIS_ADDR               0x20
+#define ST_SENSORS_DEF_AXIS_MASK               0x07
+#define ST_SENSORS_DEF_AXIS_N_BIT              3
+
+#define ST_LSM_CHANNELS(sensor_type, index, mod, endian, bits, addr) \
+{ \
+       .type =3D sensor_type, \
+       .modified =3D 1, \
+       .info_mask =3D IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
+                                       IIO_CHAN_INFO_SCALE_SEPARATE_BIT, \
+       .scan_index =3D index, \
+       .channel2 =3D mod, \
+       .address =3D addr, \
+       .scan_type =3D { \
+               .sign =3D 's', \
+               .realbits =3D bits, \
+               .shift =3D 16 - bits, \
+               .storagebits =3D 16, \
+               .endianness =3D endian, \
+       }, \
+}
+
+/**
+ * struct st_sensors_data - ST sensors device status
+ * @dev: Pointer to instance of struct device (I2C or SPI).
+ * @trig: The trigger in use by the core driver.
+ * @enabled: Status of the sensor (false->off, true->on).
+ * @multiread_bit: Use or not particular bit for [I2C/SPI] multiread.
+ * @index: Number used to point the sensor being used in the
+ *     st_sensors_sensors struct.
+ * @buffer_data: Data used by buffer part.
+ * @fullscale: Maximum range of measure by the sensor.
+ * @gain: Sensitivity of the sensor [m/s^2/LSB].
+ * @odr: Output data rate of the sensor [Hz].
+ * @buf_lock: Mutex to protect rx and tx buffers.
+ * @tx_buf: Buffer used by SPI transfer function to send data to the
sensors.
+ *     This buffer is used to avoid DMA not-aligned issue.
+ * @rx_buf: Buffer used by SPI transfer to receive data from sensors.
+ *     This buffer is used to avoid DMA not-aligned issue.
+ * @read_byte: Function used to read one byte.
+ * @write_byte: Function used to write one byte.
+ * @read_multiple_byte: Function used to read multiple byte.
+ */
+
+struct st_sensors_data {
+       struct device *dev;
+       struct iio_trigger *trig;
+       const struct st_sensors *st_sensors;
+
+       bool enabled;
+       bool multiread_bit;
+
+       short index;
+
+       char *buffer_data;
+
+       unsigned int fullscale;
+       unsigned int gain;
+       unsigned int odr;
+
+       struct mutex buf_lock;
+       u8 tx_buf[ST_SENSORS_TX_MAX_LENGHT] ____cacheline_aligned;
+       u8 rx_buf[ST_SENSORS_RX_MAX_LENGHT] ____cacheline_aligned;
+
+       int (*read_byte) (struct st_sensors_data *adata, u8 reg_addr,
+                                                               u8 *res_byt=
e);
+       int (*write_byte) (struct st_sensors_data *adata, u8 reg_addr, u8 d=
ata);
+       int (*read_multiple_byte) (struct st_sensors_data *adata, u8 reg_ad=
dr,
+                                                       int len, u8 *data);
+};
+
+struct st_sensors_odr_available {
+       unsigned int hz;
+       u8 value;
+};
+
+struct st_sensors_odr {
+       u8 addr;
+       u8 mask;
+       short num_bit;
+       struct st_sensors_odr_available odr_avl[ST_SENSORS_ODR_LIST_MAX];
+};
+
+struct st_sensors_power {
+       u8 addr;
+       u8 mask;
+       unsigned short num_bit;
+       u8 value_off;
+       u8 value_on;
+};
+
+struct st_sensors_axis {
+       u8 addr;
+       u8 mask;
+};
+
+struct st_sensors_fs_available {
+       unsigned int num;
+       u8 value;
+       unsigned int gain;
+};
+
+struct st_sensors_fullscale {
+       u8 addr;
+       u8 mask;
+       unsigned short num_bit;
+       struct st_sensors_fs_available fs_avl[ST_SENSORS_FULLSCALE_AVL_MAX]=
;
+};
+
+struct st_sensors_bdu {
+       u8 addr;
+       u8 mask;
+};
+
+struct st_sensors_interrupt_generator {
+       u8 en_addr;
+       u8 latch_mask_addr;
+       u8 en_mask;
+       u8 latching_mask;
+};
+
+struct st_sensors_data_ready_irq {
+       u8 addr;
+       u8 mask;
+       struct st_sensors_interrupt_generator ig1;
+};
+
+/**
+ * struct st_sensors - ST sensors list
+ * @wai: Contents of WhoAmI register.
+ * @ch: IIO channels for the sensor.
+ * @odr: Output data rate register and odr list available.
+ * @pw: Power register of the sensor.
+ * @enable_axis: Enable one or more axis of the sensor.
+ * @fs: Full scale register and fs list available.
+ * @bdu: Block data update register.
+ * @drdy_irq: Data ready register of the sensor.
+ * @multi_read_bit: Use or not particular bit for [I2C/SPI] multiread.
+ */
+
+struct st_sensors {
+       u8 wai;
+       struct iio_chan_spec *ch;
+       struct st_sensors_odr odr;
+       struct st_sensors_power pw;
+       struct st_sensors_axis enable_axis;
+       struct st_sensors_fullscale fs;
+       struct st_sensors_bdu bdu;
+       struct st_sensors_data_ready_irq drdy_irq;
+       bool multi_read_bit;
+};
+
+int st_sensors_iio_probe(struct iio_dev *indio_dev, int irq);
+void st_sensors_iio_remove(struct iio_dev *indio_dev, int irq);
+int st_sensors_set_dataready_irq(struct iio_dev *indio_dev, bool enable);
+int st_sensors_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable);
+
+#ifdef CONFIG_ST_ACCEL_3D
+int st_accel_init_sensor(struct iio_dev *indio_dev, u8 wai);
+#else /* CONFIG_ST_ACCEL_3D */
+static inline int st_accel_init_sensor(struct iio_dev *indio_dev, u8 wai)
+{
+       return -ENODEV;
+}
+#endif /* CONFIG_ST_ACCEL_3D */
+
+#ifdef CONFIG_ST_GYRO_3D
+int st_gyro_init_sensor(struct iio_dev *indio_dev, u8 wai);
+#else /* CONFIG_ST_GYRO_3D */
+static inline int st_gyro_init_sensor(struct iio_dev *indio_dev, u8 wai)
+{
+       return -ENODEV;
+}
+#endif /* CONFIG_ST_GYRO_3D */
+
+#ifdef CONFIG_IIO_BUFFER
+int st_sensors_probe_trigger(struct iio_dev *indio_dev, int irq);
+void st_sensors_remove_trigger(struct iio_dev *indio_dev, int irq);
+int st_sensors_allocate_ring(struct iio_dev *indio_dev);
+void st_sensors_deallocate_ring(struct iio_dev *indio_dev);
+#else /* CONFIG_IIO_BUFFER */
+static inline int st_sensors_probe_trigger(struct iio_dev *indio_dev,
int irq)
+{
+       return 0;
+}
+static inline void st_sensors_remove_trigger(struct iio_dev *indio_dev,
int irq)
+{
+       return;
+}
+static inline int st_sensors_allocate_ring(struct iio_dev *indio_dev)
+{
+       return 0;
+}
+static inline void st_sensors_deallocate_ring(struct iio_dev *indio_dev)
+{
+}
+#endif /* CONFIG_IIO_BUFFER */
+
+#endif /* ST_SENSORS_H */
diff --git a/drivers/iio/common/st-sensors/st_sensors_buffer.c
b/drivers/iio/common/st-sensors/st_sensors_buffer.c
new file mode 100644
index 0000000..b8d1cc3
--- /dev/null
+++ b/drivers/iio/common/st-sensors/st_sensors_buffer.c
@@ -0,0 +1,178 @@
+/*
+ * STMicroelectronics sensors driver
+ *
+ * Copyright 2012 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/stat.h>
+#include <linux/interrupt.h>
+#include <linux/byteorder/generic.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#include "st_sensors.h"
+
+
+#define ST_SENSORS_ENABLE_ALL_CHANNELS         0x07
+
+static int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8
*buf)
+{
+       int i, n, len;
+       u8 reg_addr[ST_SENSORS_NUMBER_DATA_CHANNELS];
+       struct st_sensors_data *adata =3D iio_priv(indio_dev);
+
+       for (i =3D 0; i < ST_SENSORS_NUMBER_DATA_CHANNELS; i++) {
+               if (test_bit(i, indio_dev->active_scan_mask)) {
+                       reg_addr[n] =3D indio_dev->channels[i].address;
+                       n++;
+               }
+       }
+       switch (n) {
+       case 1:
+               len =3D adata->read_multiple_byte(adata, reg_addr[0],
+                                       ST_SENSORS_BYTE_4CHANNEL, buf);
+               break;
+       case 2:
+               if ((reg_addr[1] - reg_addr[0]) =3D=3D ST_SENSORS_BYTE_4CHA=
NNEL) {
+                       len =3D adata->read_multiple_byte(adata, reg_addr[0=
],
+                                       ST_SENSORS_BYTE_4CHANNEL*n,
+                                       buf);
+               } else {
+                       u8 rx_array[ST_SENSORS_BYTE_4CHANNEL*
+                               ST_SENSORS_NUMBER_DATA_CHANNELS];
+                       len =3D adata->read_multiple_byte(adata, reg_addr[0=
],
+                               ST_SENSORS_BYTE_4CHANNEL*
+                               ST_SENSORS_NUMBER_DATA_CHANNELS,
+                               rx_array);
+                       if (len < 0)
+                               goto read_data_channels_error;
+
+                       for (i =3D 0; i < n * ST_SENSORS_NUMBER_DATA_CHANNE=
LS;
+                                                                       i++=
) {
+                               if (i < n)
+                                       buf[i] =3D rx_array[i];
+                               else
+                                       buf[i] =3D rx_array[n + i];
+                       }
+                       len =3D ST_SENSORS_BYTE_4CHANNEL*n;
+               }
+               break;
+       case 3:
+               len =3D adata->read_multiple_byte(adata, reg_addr[0],
+                       ST_SENSORS_BYTE_4CHANNEL*
+                       ST_SENSORS_NUMBER_DATA_CHANNELS,
+                       buf);
+               break;
+       default:
+               len =3D -EINVAL;
+               goto read_data_channels_error;
+       }
+       if (len !=3D ST_SENSORS_BYTE_4CHANNEL*n) {
+               len =3D -EIO;
+               goto read_data_channels_error;
+       }
+
+read_data_channels_error:
+       return len;
+}
+
+static irqreturn_t st_sensors_trigger_handler(int irq, void *p)
+{
+       int len;
+       struct iio_poll_func *pf =3D p;
+       struct iio_dev *indio_dev =3D pf->indio_dev;
+       struct st_sensors_data *adata =3D iio_priv(indio_dev);
+
+       len =3D st_sensors_get_buffer_element(indio_dev, adata->buffer_data=
);
+       if (len < 0)
+               goto st_sensors_get_buffer_element_error;
+
+       if (indio_dev->scan_timestamp)
+               *(s64 *)((u8 *)adata->buffer_data +
+                               ALIGN(len, sizeof(s64))) =3D pf->timestamp;
+
+       iio_push_to_buffers(indio_dev, adata->buffer_data);
+
+st_sensors_get_buffer_element_error:
+       iio_trigger_notify_done(indio_dev->trig);
+
+       return IRQ_HANDLED;
+}
+
+static int st_sensors_buffer_postenable(struct iio_dev *indio_dev)
+{
+       int err, i;
+       u8 active_bit =3D 0x00;
+       struct st_sensors_data *adata =3D iio_priv(indio_dev);
+
+       adata->buffer_data =3D kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
+       if (adata->buffer_data =3D=3D NULL) {
+               err =3D -ENOMEM;
+               goto allocate_memory_error;
+       }
+
+       for (i =3D 0; i < ST_SENSORS_NUMBER_DATA_CHANNELS; i++)
+               if (test_bit(i, indio_dev->active_scan_mask))
+                       active_bit |=3D (1 << i);
+
+       err =3D st_sensors_set_axis_enable(indio_dev, active_bit);
+       if (err < 0)
+               goto st_sensors_buffer_postenable_error;
+
+       err =3D iio_triggered_buffer_postenable(indio_dev);
+
+       return err;
+
+st_sensors_buffer_postenable_error:
+       kfree(adata->buffer_data);
+allocate_memory_error:
+       return err;
+}
+
+static int st_sensors_buffer_predisable(struct iio_dev *indio_dev)
+{
+       int err;
+       struct st_sensors_data *adata =3D iio_priv(indio_dev);
+
+       err =3D iio_triggered_buffer_predisable(indio_dev);
+       if (err < 0)
+               goto st_sensors_buffer_predisable_error;
+
+       err =3D st_sensors_set_axis_enable(indio_dev,
+                                               ST_SENSORS_ENABLE_ALL_CHANN=
ELS);
+       if (err < 0)
+               goto st_sensors_buffer_predisable_error;
+
+st_sensors_buffer_predisable_error:
+       kfree(adata->buffer_data);
+       return err;
+}
+
+static const struct iio_buffer_setup_ops st_sensors_buffer_setup_ops =3D {
+       .preenable =3D &iio_sw_buffer_preenable,
+       .postenable =3D &st_sensors_buffer_postenable,
+       .predisable =3D &st_sensors_buffer_predisable,
+};
+
+int st_sensors_allocate_ring(struct iio_dev *indio_dev)
+{
+       return iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_ti=
me,
+               &st_sensors_trigger_handler, &st_sensors_buffer_setup_ops);
+}
+EXPORT_SYMBOL(st_sensors_allocate_ring);
+
+void st_sensors_deallocate_ring(struct iio_dev *indio_dev)
+{
+       iio_triggered_buffer_cleanup(indio_dev);
+}
+EXPORT_SYMBOL(st_sensors_deallocate_ring);
diff --git a/drivers/iio/common/st-sensors/st_sensors_core.c
b/drivers/iio/common/st-sensors/st_sensors_core.c
new file mode 100644
index 0000000..9b9e951
--- /dev/null
+++ b/drivers/iio/common/st-sensors/st_sensors_core.c
@@ -0,0 +1,589 @@
+/*
+ * STMicroelectronics sensors driver
+ *
+ * Copyright 2012 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/mutex.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/irq.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/buffer.h>
+
+#include "st_sensors.h"
+
+
+static int st_sensors_write_data_with_mask(struct iio_dev *indio_dev,
+                               u8 reg_addr, u8 mask, short num_bit, u8 dat=
a)
+{
+       int err;
+       u8 new_data;
+       struct st_sensors_data *adata =3D iio_priv(indio_dev);
+
+       err =3D adata->read_byte(adata, reg_addr, &new_data);
+       if (err < 0)
+               goto st_sensors_write_data_with_mask_error;
+
+       new_data =3D ((new_data & (~mask)) | ((data << __ffs(mask)) & mask)=
);
+       err =3D adata->write_byte(adata, reg_addr, new_data);
+
+st_sensors_write_data_with_mask_error:
+       return err;
+}
+
+int st_sensors_match_odr(const struct st_sensors *sensor,
+               unsigned int odr, struct st_sensors_odr_available *odr_out)
+{
+       int i, ret =3D -EINVAL;
+
+       for (i =3D 0; i < ARRAY_SIZE(sensor->odr.odr_avl); i++) {
+               if (sensor->odr.odr_avl[i].hz =3D=3D odr) {
+                       odr_out->hz =3D sensor->odr.odr_avl[i].hz;
+                       odr_out->value =3D sensor->odr.odr_avl[i].value;
+                       ret =3D 0;
+                       break;
+               }
+       }
+
+       return ret;
+}
+
+int st_sensors_match_fs(const struct st_sensors *sensor,
+                       unsigned int fs, struct st_sensors_fs_available *fs=
_out)
+{
+       int i, ret =3D -EINVAL;
+
+       for (i =3D 0; i < ARRAY_SIZE(sensor->fs.fs_avl); i++) {
+               if (sensor->fs.fs_avl[i].num =3D=3D fs) {
+                       fs_out->num =3D sensor->fs.fs_avl[i].num;
+                       fs_out->gain =3D sensor->fs.fs_avl[i].gain;
+                       fs_out->value =3D sensor->fs.fs_avl[i].value;
+                       ret =3D 0;
+                       break;
+               }
+       }
+
+       return ret;
+}
+
+int st_sensors_match_scale(const struct st_sensors *sensor,
+                       int scale, struct st_sensors_fs_available *fs_out)
+{
+       int i, ret =3D -EINVAL;
+
+       for (i =3D 0; i < ARRAY_SIZE(sensor->fs.fs_avl); i++) {
+               if (sensor->fs.fs_avl[i].gain =3D=3D scale) {
+                       fs_out->num =3D sensor->fs.fs_avl[i].num;
+                       fs_out->gain =3D sensor->fs.fs_avl[i].gain;
+                       fs_out->value =3D sensor->fs.fs_avl[i].value;
+                       ret =3D 0;
+                       break;
+               }
+       }
+
+       return ret;
+}
+
+int st_sensors_set_dataready_irq(struct iio_dev *indio_dev, bool enable)
+{
+       int err;
+       struct st_sensors_data *adata;
+
+       adata =3D iio_priv(indio_dev);
+       if (adata->st_sensors[adata->index].drdy_irq.ig1.en_addr > 0) {
+               err =3D st_sensors_write_data_with_mask(indio_dev,
+                       adata->st_sensors[adata->index].drdy_irq.ig1.en_add=
r,
+                       adata->st_sensors[adata->index].drdy_irq.ig1.en_mas=
k, 1,
+                       (int)enable);
+               if (err < 0)
+                       goto st_sensors_set_dataready_irq_error;
+       }
+
+       if (adata->st_sensors[adata->index].drdy_irq.ig1.latch_mask_addr > =
0) {
+               err =3D st_sensors_write_data_with_mask(indio_dev,
+               adata->st_sensors[adata->index].drdy_irq.ig1.latch_mask_add=
r,
+               adata->st_sensors[adata->index].drdy_irq.ig1.latching_mask,=
 1,
+                       (int)enable);
+               if (err < 0)
+                       goto st_sensors_set_dataready_irq_error;
+       }
+
+       err =3D st_sensors_write_data_with_mask(indio_dev,
+               adata->st_sensors[adata->index].drdy_irq.addr,
+               adata->st_sensors[adata->index].drdy_irq.mask, 1, (int)enab=
le);
+
+st_sensors_set_dataready_irq_error:
+       return err;
+}
+EXPORT_SYMBOL(st_sensors_set_dataready_irq);
+
+static int st_sensors_set_bdu(struct iio_dev *indio_dev,
+                               const struct st_sensors_bdu *bdu, bool valu=
e)
+{
+       return st_sensors_write_data_with_mask(indio_dev, bdu->addr, bdu->m=
ask,
+                                                               1, (u8)valu=
e);
+}
+
+static int st_sensors_set_odr(struct iio_dev *indio_dev,
+                               struct st_sensors_odr_available *odr_availa=
ble)
+{
+       int err;
+       struct st_sensors_data *adata =3D iio_priv(indio_dev);
+
+       if ((adata->st_sensors[adata->index].odr.addr =3D=3D
+               adata->st_sensors[adata->index].pw.addr) &&
+               (adata->st_sensors[adata->index].odr.mask =3D=3D
+                               adata->st_sensors[adata->index].pw.mask)) {
+               if (adata->enabled =3D=3D true) {
+                       err =3D st_sensors_write_data_with_mask(indio_dev,
+                               adata->st_sensors[adata->index].odr.addr,
+                               adata->st_sensors[adata->index].odr.mask,
+                               adata->st_sensors[adata->index].odr.num_bit=
,
+                               odr_available->value);
+               } else {
+                       adata->odr =3D odr_available->hz;
+                       err =3D 0;
+               }
+       } else {
+               err =3D st_sensors_write_data_with_mask(indio_dev,
+                               adata->st_sensors[adata->index].odr.addr,
+                               adata->st_sensors[adata->index].odr.mask,
+                               adata->st_sensors[adata->index].odr.num_bit=
,
+                               odr_available->value);
+       }
+
+       return err;
+}
+
+int st_sensors_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable)
+{
+       int err;
+       struct st_sensors_data *adata =3D iio_priv(indio_dev);
+
+       err =3D st_sensors_write_data_with_mask(indio_dev,
+                       adata->st_sensors[adata->index].enable_axis.addr,
+                       adata->st_sensors[adata->index].enable_axis.mask,
+                       ST_SENSORS_DEF_AXIS_N_BIT, axis_enable);
+
+       return err;
+}
+EXPORT_SYMBOL(st_sensors_set_axis_enable);
+
+static int st_sensors_set_enable(struct iio_dev *indio_dev, bool enable)
+{
+       int err =3D -EINVAL;
+       bool found;
+       u8 tmp_value;
+       struct st_sensors_odr_available odr_out;
+       struct st_sensors_data *adata =3D iio_priv(indio_dev);
+
+       if (enable) {
+               found =3D false;
+               tmp_value =3D adata->st_sensors[adata->index].pw.value_on;
+               if ((adata->st_sensors[adata->index].odr.addr =3D=3D
+                               adata->st_sensors[adata->index].pw.addr) &&
+                       (adata->st_sensors[adata->index].odr.mask =3D=3D
+                               adata->st_sensors[adata->index].pw.mask)) {
+                       err =3D st_sensors_match_odr(
+                               &adata->st_sensors[adata->index], adata->od=
r,
+                                       &odr_out);
+                       if (err < 0)
+                               goto set_enable_error;
+                       tmp_value =3D odr_out.value;
+                       found =3D true;
+               }
+               err =3D st_sensors_write_data_with_mask(indio_dev,
+                               adata->st_sensors[adata->index].pw.addr,
+                               adata->st_sensors[adata->index].pw.mask,
+                               adata->st_sensors[adata->index].pw.num_bit,
+                               tmp_value);
+               if (err < 0)
+                       goto set_enable_error;
+               adata->enabled =3D true;
+               if (found)
+                       adata->odr =3D odr_out.hz;
+       } else {
+               err =3D st_sensors_write_data_with_mask(indio_dev,
+                               adata->st_sensors[adata->index].pw.addr,
+                               adata->st_sensors[adata->index].pw.mask,
+                               adata->st_sensors[adata->index].pw.num_bit,
+                               adata->st_sensors[adata->index].pw.value_of=
f);
+               if (err < 0)
+                       goto set_enable_error;
+               adata->enabled =3D false;
+       }
+
+set_enable_error:
+       return err;
+}
+
+static int st_sensors_set_fullscale(struct iio_dev *indio_dev,
+                                       struct st_sensors_fs_available *fs_=
avl)
+{
+       int err;
+       struct st_sensors_data *adata =3D iio_priv(indio_dev);
+
+       err =3D st_sensors_write_data_with_mask(indio_dev,
+                               adata->st_sensors[adata->index].fs.addr,
+                               adata->st_sensors[adata->index].fs.mask,
+                               adata->st_sensors[adata->index].fs.num_bit,
+                               fs_avl->value);
+       if (err < 0)
+               goto st_sensors_set_fullscale_error;
+
+       adata->fullscale =3D fs_avl->num;
+       adata->gain =3D fs_avl->gain;
+       return err;
+
+st_sensors_set_fullscale_error:
+       dev_err(&indio_dev->dev, "failed to set new fullscale.\n");
+       return err;
+}
+
+static int st_sensors_read_raw(struct iio_dev *indio_dev,
+                       struct iio_chan_spec const *ch, int *val,
+                                                       int *val2, long mas=
k)
+{
+       int err;
+       u8 outdata[ST_SENSORS_BYTE_4CHANNEL];
+       struct st_sensors_data *adata =3D iio_priv(indio_dev);
+
+       switch (mask) {
+       case IIO_CHAN_INFO_RAW:
+               mutex_lock(&indio_dev->mlock);
+               if (indio_dev->currentmode =3D=3D INDIO_BUFFER_TRIGGERED) {
+                       err =3D -EBUSY;
+                       goto read_error;
+               } else {
+                       if (!adata->enabled) {
+                               err =3D -EIO;
+                               goto read_error;
+                       } else {
+                               err =3D adata->read_multiple_byte(adata,
+                                       ch->address, ST_SENSORS_BYTE_4CHANN=
EL,
+                                       outdata);
+                               if (err < 0)
+                                       goto read_error;
+
+                               *val =3D ((s16)le16_to_cpup((u16 *)outdata)=
)
+                                                       >> ch->scan_type.sh=
ift;
+                       }
+               }
+               mutex_unlock(&indio_dev->mlock);
+               return IIO_VAL_INT;
+       case IIO_CHAN_INFO_SCALE:
+               *val =3D 0;
+               *val2 =3D adata->gain;
+               return IIO_VAL_INT_PLUS_MICRO;
+       default:
+               return -EINVAL;
+       }
+
+read_error:
+       mutex_unlock(&indio_dev->mlock);
+       return err;
+}
+
+static int st_sensors_write_raw(struct iio_dev *indio_dev,
+               struct iio_chan_spec const *chan, int val, int val2, long m=
ask)
+{
+       int err;
+       struct st_sensors_fs_available fs_out;
+       struct st_sensors_data *adata =3D iio_priv(indio_dev);
+
+       switch (mask) {
+       case IIO_CHAN_INFO_SCALE:
+               err =3D st_sensors_match_scale(&adata->st_sensors[adata->in=
dex],
+                                                               val2, &fs_o=
ut);
+               if (err < 0)
+                       goto write_error;
+
+               err =3D st_sensors_set_fullscale(indio_dev, &fs_out);
+               break;
+       default:
+               err =3D -EINVAL;
+       }
+
+write_error:
+       return err;
+}
+
+static ssize_t st_sensors_sysfs_set_sampling_frequency(struct device *dev,
+               struct device_attribute *attr, const char *buf, size_t size=
)
+{
+       int err;
+       unsigned int freq;
+       struct st_sensors_odr_available odr_out;
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct st_sensors_data *adata =3D iio_priv(indio_dev);
+
+       err =3D kstrtoint(buf, 10, &freq);
+       if (err < 0)
+               goto conversion_error;
+
+       mutex_lock(&indio_dev->mlock);
+       err =3D st_sensors_match_odr(&adata->st_sensors[adata->index],
+                                                               freq, &odr_=
out);
+       if (err < 0)
+               goto st_sensors_sysfs_set_sampling_frequency_error;
+
+       err =3D st_sensors_set_odr(indio_dev, &odr_out);
+       if (err < 0)
+               goto st_sensors_sysfs_set_sampling_frequency_error;
+
+       adata->odr =3D odr_out.hz;
+
+st_sensors_sysfs_set_sampling_frequency_error:
+       mutex_unlock(&indio_dev->mlock);
+conversion_error:
+       return err < 0 ? err : size;
+}
+
+static ssize_t st_sensors_sysfs_get_sampling_frequency(struct device *dev,
+                               struct device_attribute *attr, char *buf)
+{
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct st_sensors_data *adata =3D iio_priv(indio_dev);
+
+       return sprintf(buf, "%d\n", adata->odr);
+}
+
+static ssize_t st_sensors_sysfs_set_powerdown(struct device *dev,
+               struct device_attribute *attr, const char *buf, size_t size=
)
+{
+       int err;
+       bool powerdown;
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+
+       err =3D strtobool(buf, &powerdown);
+       if (err < 0)
+               goto set_enable_error;
+
+       mutex_lock(&indio_dev->mlock);
+       err =3D st_sensors_set_enable(indio_dev, !powerdown);
+       mutex_unlock(&indio_dev->mlock);
+
+set_enable_error:
+       return err < 0 ? err : size;
+}
+
+static ssize_t st_sensors_sysfs_get_powerdown(struct device *dev,
+                               struct device_attribute *attr, char *buf)
+{
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct st_sensors_data *adata =3D iio_priv(indio_dev);
+
+       return sprintf(buf, "%d\n", (int)(!adata->enabled));
+}
+
+static ssize_t st_sensors_sysfs_scale_available(struct device *dev,
+                               struct device_attribute *attr, char *buf)
+{
+       int i, len =3D 0;
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct st_sensors_data *adata =3D iio_priv(indio_dev);
+
+       mutex_lock(&indio_dev->mlock);
+       for (i =3D 0; i < ARRAY_SIZE(adata->st_sensors[adata->index].fs.fs_=
avl);
+                                                                       i++=
) {
+               if (adata->st_sensors[adata->index].fs.fs_avl[i].num =3D=3D=
 0)
+                       break;
+
+               len +=3D sprintf(buf+len, "0.%06u ",
+                       adata->st_sensors[adata->index].fs.fs_avl[i].gain);
+       }
+       mutex_unlock(&indio_dev->mlock);
+       buf[len-1] =3D '\n';
+
+       return len;
+}
+
+static ssize_t st_sensors_sysfs_sampling_frequency_available(struct
device *dev,
+                               struct device_attribute *attr, char *buf)
+{
+       int i, len =3D 0;
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct st_sensors_data *adata =3D iio_priv(indio_dev);
+
+       mutex_lock(&indio_dev->mlock);
+       for (i =3D 0; i < ARRAY_SIZE(adata->st_sensors[adata->index].odr.od=
r_avl);
+                                                                       i++=
) {
+               if (adata->st_sensors[adata->index].odr.odr_avl[i].hz =3D=
=3D 0)
+                       break;
+
+               len +=3D sprintf(buf + len, "%d ",
+                       adata->st_sensors[adata->index].odr.odr_avl[i].hz);
+       }
+       mutex_unlock(&indio_dev->mlock);
+       buf[len - 1] =3D '\n';
+
+       return len;
+}
+
+static IIO_DEVICE_ATTR(sampling_frequency_available, S_IRUGO,
+               st_sensors_sysfs_sampling_frequency_available, NULL , 0);
+
+static IIO_DEVICE_ATTR(in_sensors_scale_available, S_IRUGO,
+                               st_sensors_sysfs_scale_available, NULL , 0)=
;
+
+static IIO_DEVICE_ATTR(powerdown, S_IWUSR | S_IRUGO,
+               st_sensors_sysfs_get_powerdown,
+                                       st_sensors_sysfs_set_powerdown , 0)=
;
+
+static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
+                       st_sensors_sysfs_get_sampling_frequency,
+                               st_sensors_sysfs_set_sampling_frequency);
+
+static struct attribute *st_sensor_attributes[] =3D {
+       &iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+       &iio_dev_attr_in_sensors_scale_available.dev_attr.attr,
+       &iio_dev_attr_powerdown.dev_attr.attr,
+       &iio_dev_attr_sampling_frequency.dev_attr.attr,
+       NULL,
+};
+
+static const struct attribute_group st_sensor_attribute_group =3D {
+       .attrs =3D st_sensor_attributes,
+};
+
+static const struct iio_info sensor_info =3D {
+       .driver_module =3D THIS_MODULE,
+       .attrs =3D &st_sensor_attribute_group,
+       .read_raw =3D &st_sensors_read_raw,
+       .write_raw =3D &st_sensors_write_raw,
+};
+
+static int st_sensors_get_wai_device(struct iio_dev *indio_dev, u8
reg_addr,
+                                                               u8 *value)
+{
+       int ret;
+       struct st_sensors_data *adata =3D iio_priv(indio_dev);
+
+       ret =3D adata->read_byte(adata, reg_addr, value);
+       if (ret < 0)
+               goto read_byte_wai_error;
+
+       return 0;
+
+read_byte_wai_error:
+       dev_err(&indio_dev->dev,
+                       "failed to read WhoAmI (register 0x%x).\n", reg_add=
r);
+       return -EIO;
+}
+
+static int st_init_sensor(struct iio_dev *indio_dev, int wai)
+{
+       int err;
+
+       err =3D st_accel_init_sensor(indio_dev, wai);
+       if (err < 0)
+               err =3D st_gyro_init_sensor(indio_dev, wai);
+
+       if (err < 0)
+               dev_err(&indio_dev->dev,
+                               "device not supported -> wai (0x%x).\n", wa=
i);
+
+       return err;
+}
+
+int st_sensors_iio_probe(struct iio_dev *indio_dev, int irq)
+{
+       int err;
+       u8 wai;
+       struct st_sensors_odr_available odr_out;
+       struct st_sensors_fs_available fs_out;
+       struct st_sensors_data *adata =3D iio_priv(indio_dev);
+
+       indio_dev->modes =3D INDIO_DIRECT_MODE;
+
+       err =3D st_sensors_get_wai_device(indio_dev,
+                                       ST_SENSORS_DEF_WAI_ADDRESS, &wai);
+       if (err < 0)
+               goto st_sensors_iio_probe_error;
+
+       err =3D st_init_sensor(indio_dev, wai);
+       if (err < 0)
+               goto st_sensors_iio_probe_error;
+
+       indio_dev->info =3D &sensor_info;
+       adata->multiread_bit =3D adata->st_sensors[adata->index].multi_read=
_bit;
+       indio_dev->channels =3D adata->st_sensors[adata->index].ch;
+       indio_dev->num_channels =3D ST_SENSORS_NUMBER_ALL_CHANNELS;
+
+       adata->fullscale =3D adata->st_sensors[adata->index].fs.fs_avl[0].n=
um;
+       adata->odr =3D adata->st_sensors[adata->index].odr.odr_avl[0].hz;
+
+       err =3D st_sensors_set_enable(indio_dev, false);
+       if (err < 0)
+               goto st_sensors_iio_probe_error;
+
+       err =3D st_sensors_set_axis_enable(indio_dev,
+                                               ST_SENSORS_ENABLE_ALL_CHANN=
ELS);
+       if (err < 0)
+               goto st_sensors_iio_probe_error;
+
+       st_sensors_match_fs(&adata->st_sensors[adata->index],
+                                               adata->fullscale, &fs_out);
+       err =3D st_sensors_set_fullscale(indio_dev, &fs_out);
+       if (err < 0)
+               goto st_sensors_iio_probe_error;
+
+       st_sensors_match_odr(&adata->st_sensors[adata->index],
+                                                       adata->odr, &odr_ou=
t);
+       err =3D st_sensors_set_odr(indio_dev, &odr_out);
+       if (err < 0)
+               goto st_sensors_iio_probe_error;
+
+       err =3D st_sensors_set_bdu(indio_dev,
+                               &adata->st_sensors[adata->index].bdu, true)=
;
+
+       err =3D st_sensors_allocate_ring(indio_dev);
+       if (err < 0)
+               goto st_sensors_iio_probe_error;
+
+       if (irq > 0) {
+               err =3D st_sensors_probe_trigger(indio_dev, irq);
+               if (err < 0)
+                       goto acc_probe_trigger_error;
+       }
+
+       err =3D iio_device_register(indio_dev);
+       if (err)
+               goto iio_device_register_error;
+
+       return err;
+
+iio_device_register_error:
+       st_sensors_remove_trigger(indio_dev, irq);
+acc_probe_trigger_error:
+       st_sensors_deallocate_ring(indio_dev);
+st_sensors_iio_probe_error:
+       return err;
+}
+EXPORT_SYMBOL(st_sensors_iio_probe);
+
+void st_sensors_iio_remove(struct iio_dev *indio_dev, int irq)
+{
+       iio_device_unregister(indio_dev);
+       st_sensors_remove_trigger(indio_dev, irq);
+       st_sensors_deallocate_ring(indio_dev);
+       iio_device_free(indio_dev);
+}
+EXPORT_SYMBOL(st_sensors_iio_remove);
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics sensors core driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/common/st-sensors/st_sensors_i2c.c
b/drivers/iio/common/st-sensors/st_sensors_i2c.c
new file mode 100644
index 0000000..2d2d5ee
--- /dev/null
+++ b/drivers/iio/common/st-sensors/st_sensors_i2c.c
@@ -0,0 +1,137 @@
+/*
+ * STMicroelectronics sensors driver
+ *
+ * Copyright 2012 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+
+#include "st_sensors.h"
+
+#define ST_SENSORS_I2C_MULTIREAD               0x80
+
+static int st_sensors_i2c_read_byte(struct st_sensors_data *adata,
+                                               u8 reg_addr, u8 *res_byte)
+{
+       int err;
+
+       err =3D i2c_smbus_read_byte_data(to_i2c_client(adata->dev), reg_add=
r);
+       if (err < 0)
+               goto st_sensors_i2c_read_byte_error;
+
+       *res_byte =3D err & 0xff;
+
+st_sensors_i2c_read_byte_error:
+       return err < 0 ? err : 0;
+}
+
+static int st_sensors_i2c_read_multiple_byte(struct st_sensors_data *adata=
,
+                                               u8 reg_addr, int len, u8 *d=
ata)
+{
+       if (adata->multiread_bit =3D=3D true)
+               reg_addr |=3D ST_SENSORS_I2C_MULTIREAD;
+
+       return i2c_smbus_read_i2c_block_data(to_i2c_client(adata->dev),
+                                                       reg_addr, len, data=
);
+}
+
+static int st_sensors_i2c_write_byte(struct st_sensors_data *adata,
+                                                       u8 reg_addr, u8 dat=
a)
+{
+       return i2c_smbus_write_byte_data(to_i2c_client(adata->dev),
+                                                               reg_addr, d=
ata);
+}
+
+static int __devinit st_sensors_i2c_probe(struct i2c_client *client,
+                               const struct i2c_device_id *id)
+{
+       struct iio_dev *indio_dev;
+       struct st_sensors_data *adata;
+       int err;
+
+       indio_dev =3D iio_device_alloc(sizeof(*adata));
+       if (indio_dev =3D=3D NULL) {
+               err =3D -ENOMEM;
+               goto iio_device_alloc_error;
+       }
+
+       adata =3D iio_priv(indio_dev);
+       adata->dev =3D &client->dev;
+       i2c_set_clientdata(client, indio_dev);
+
+       indio_dev->dev.parent =3D &client->dev;
+       indio_dev->name =3D client->name;
+
+       adata->read_byte =3D st_sensors_i2c_read_byte;
+       adata->write_byte =3D st_sensors_i2c_write_byte;
+       adata->read_multiple_byte =3D st_sensors_i2c_read_multiple_byte;
+
+       err =3D st_sensors_iio_probe(indio_dev, client->irq);
+       if (err < 0)
+               goto acc_iio_default_error;
+
+       return 0;
+
+acc_iio_default_error:
+       iio_device_free(indio_dev);
+iio_device_alloc_error:
+       return err;
+}
+
+static int st_sensors_i2c_remove(struct i2c_client *client)
+{
+       struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
+       st_sensors_iio_remove(indio_dev, client->irq);
+
+       return 0;
+}
+
+static const struct i2c_device_id st_sensors_id_table[] =3D {
+       { LSM303DLH_ACCEL_DEV_NAME },
+       { LSM303DLHC_ACCEL_DEV_NAME },
+       { LIS3DH_ACCEL_DEV_NAME },
+       { LSM330D_ACCEL_DEV_NAME },
+       { LSM330DL_ACCEL_DEV_NAME },
+       { LSM330DLC_ACCEL_DEV_NAME },
+       { LSM303D_ACCEL_DEV_NAME },
+       { LSM9DS0_ACCEL_DEV_NAME },
+       { LIS331DLH_ACCEL_DEV_NAME },
+       { LSM303DL_ACCEL_DEV_NAME },
+       { LSM303DLM_ACCEL_DEV_NAME },
+       { LSM330_ACCEL_DEV_NAME },
+       { L3G4200D_GYRO_DEV_NAME },
+       { LSM330DL_GYRO_DEV_NAME },
+       { L3GD20_GYRO_DEV_NAME },
+       { L3GD20H_GYRO_DEV_NAME },
+       { LSM330D_GYRO_DEV_NAME },
+       { LSM330DLC_GYRO_DEV_NAME },
+       { LSM9DS0_GYRO_DEV_NAME },
+       { L3G4IS_GYRO_DEV_NAME },
+       { LSM330_GYRO_DEV_NAME },
+       {},
+};
+MODULE_DEVICE_TABLE(i2c, st_sensors_id_table);
+
+static struct i2c_driver st_sensors_driver =3D {
+       .driver =3D {
+               .owner =3D THIS_MODULE,
+               .name =3D "st-sensors-i2c",
+       },
+       .probe =3D st_sensors_i2c_probe,
+       .remove =3D st_sensors_i2c_remove,
+       .id_table =3D st_sensors_id_table,
+};
+module_i2c_driver(st_sensors_driver);
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics sensors i2c driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/common/st-sensors/st_sensors_spi.c
b/drivers/iio/common/st-sensors/st_sensors_spi.c
new file mode 100644
index 0000000..1df0c80
--- /dev/null
+++ b/drivers/iio/common/st-sensors/st_sensors_spi.c
@@ -0,0 +1,183 @@
+/*
+ * STMicroelectronics sensors driver
+ *
+ * Copyright 2012 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+
+#include "st_sensors.h"
+
+
+#define ST_SENSORS_SPI_READ            0x80;
+#define ST_SENSORS_SPI_MULTIREAD       0xc0
+
+static int st_sensors_spi_read(struct st_sensors_data *adata,
+                                               u8 reg_addr, int len, u8 *d=
ata)
+{
+       struct spi_message msg;
+       int err;
+
+       struct spi_transfer xfers[] =3D {
+               {
+                       .tx_buf =3D adata->tx_buf,
+                       .bits_per_word =3D 8,
+                       .len =3D 1,
+               },
+               {
+                       .rx_buf =3D adata->rx_buf,
+                       .bits_per_word =3D 8,
+                       .len =3D len,
+               }
+       };
+
+       mutex_lock(&adata->buf_lock);
+       if ((adata->multiread_bit =3D=3D true) && (len > 1))
+               adata->tx_buf[0] =3D reg_addr | ST_SENSORS_SPI_MULTIREAD;
+       else
+               adata->tx_buf[0] =3D reg_addr | ST_SENSORS_SPI_READ;
+
+       spi_message_init(&msg);
+       spi_message_add_tail(&xfers[0], &msg);
+       spi_message_add_tail(&xfers[1], &msg);
+       err =3D spi_sync(to_spi_device(adata->dev), &msg);
+       if (err)
+               goto acc_spi_read_error;
+
+       memcpy(data, adata->rx_buf, len*sizeof(u8));
+       mutex_unlock(&adata->buf_lock);
+       return len;
+
+acc_spi_read_error:
+       return err;
+}
+
+static int st_sensors_spi_read_byte(struct st_sensors_data *adata,
+                                               u8 reg_addr, u8 *res_byte)
+{
+       return st_sensors_spi_read(adata, reg_addr, 1, res_byte);
+}
+
+static int st_sensors_spi_read_multiple_byte(struct st_sensors_data *adata=
,
+                                               u8 reg_addr, int len, u8 *d=
ata)
+{
+       return st_sensors_spi_read(adata, reg_addr, len, data);
+}
+
+static int st_sensors_spi_write_byte(struct st_sensors_data *adata,
+                                                       u8 reg_addr, u8 dat=
a)
+{
+       struct spi_message msg;
+       int err;
+
+       struct spi_transfer xfers =3D {
+               .tx_buf =3D adata->tx_buf,
+               .bits_per_word =3D 8,
+               .len =3D 2,
+       };
+
+       mutex_lock(&adata->buf_lock);
+       adata->tx_buf[0] =3D reg_addr;
+       adata->tx_buf[1] =3D data;
+
+       spi_message_init(&msg);
+       spi_message_add_tail(&xfers, &msg);
+       err =3D spi_sync(to_spi_device(adata->dev), &msg);
+       mutex_unlock(&adata->buf_lock);
+
+       return err;
+}
+
+static int __devinit st_sensors_spi_probe(struct spi_device *spi)
+{
+       struct iio_dev *indio_dev;
+       struct st_sensors_data *adata;
+       int err;
+
+       indio_dev =3D iio_device_alloc(sizeof(*adata));
+       if (indio_dev =3D=3D NULL) {
+               err =3D -ENOMEM;
+               goto iio_device_alloc_error;
+       }
+
+       adata =3D iio_priv(indio_dev);
+       adata->dev =3D &spi->dev;
+       spi_set_drvdata(spi, indio_dev);
+
+       indio_dev->dev.parent =3D &spi->dev;
+       indio_dev->name =3D spi->modalias;
+
+       mutex_init(&adata->buf_lock);
+       adata->read_byte =3D st_sensors_spi_read_byte;
+       adata->write_byte =3D st_sensors_spi_write_byte;
+       adata->read_multiple_byte =3D st_sensors_spi_read_multiple_byte;
+
+       err =3D st_sensors_iio_probe(indio_dev, spi->irq);
+       if (err < 0)
+               goto acc_iio_default_error;
+
+       return 0;
+
+acc_iio_default_error:
+       iio_device_free(indio_dev);
+iio_device_alloc_error:
+       return err;
+}
+
+static int st_sensors_spi_remove(struct spi_device *spi)
+{
+       struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
+       st_sensors_iio_remove(indio_dev, spi->irq);
+
+       return 0;
+}
+
+static const struct spi_device_id st_sensors_id_table[] =3D {
+       { LSM303DLH_ACCEL_DEV_NAME },
+       { LSM303DLHC_ACCEL_DEV_NAME },
+       { LIS3DH_ACCEL_DEV_NAME },
+       { LSM330D_ACCEL_DEV_NAME },
+       { LSM330DL_ACCEL_DEV_NAME },
+       { LSM330DLC_ACCEL_DEV_NAME },
+       { LSM303D_ACCEL_DEV_NAME },
+       { LSM9DS0_ACCEL_DEV_NAME },
+       { LIS331DLH_ACCEL_DEV_NAME },
+       { LSM303DL_ACCEL_DEV_NAME },
+       { LSM303DLM_ACCEL_DEV_NAME },
+       { LSM330_ACCEL_DEV_NAME },
+       { L3G4200D_GYRO_DEV_NAME },
+       { LSM330DL_GYRO_DEV_NAME },
+       { L3GD20_GYRO_DEV_NAME },
+       { L3GD20H_GYRO_DEV_NAME },
+       { LSM330D_GYRO_DEV_NAME },
+       { LSM330DLC_GYRO_DEV_NAME },
+       { LSM9DS0_GYRO_DEV_NAME },
+       { L3G4IS_GYRO_DEV_NAME },
+       { LSM330_GYRO_DEV_NAME },
+       {},
+};
+MODULE_DEVICE_TABLE(spi, st_sensors_id_table);
+
+static struct spi_driver st_sensors_driver =3D {
+       .driver =3D {
+               .owner =3D THIS_MODULE,
+               .name =3D "st-sensors-spi",
+       },
+       .probe =3D st_sensors_spi_probe,
+       .remove =3D st_sensors_spi_remove,
+       .id_table =3D st_sensors_id_table,
+};
+module_spi_driver(st_sensors_driver);
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics sensors spi driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/common/st-sensors/st_sensors_trigger.c
b/drivers/iio/common/st-sensors/st_sensors_trigger.c
new file mode 100644
index 0000000..37dadc2
--- /dev/null
+++ b/drivers/iio/common/st-sensors/st_sensors_trigger.c
@@ -0,0 +1,83 @@
+/*
+ * STMicroelectronics sensors driver
+ *
+ * Copyright 2012 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/stat.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+
+#include "st_sensors.h"
+
+static int st_sensors_trig_acc_set_state(struct iio_trigger *trig, bool
state)
+{
+       struct iio_dev *indio_dev =3D trig->private_data;
+       return st_sensors_set_dataready_irq(indio_dev, state);
+}
+
+static const struct iio_trigger_ops st_sensors_trigger_ops =3D {
+       .owner =3D THIS_MODULE,
+       .set_trigger_state =3D &st_sensors_trig_acc_set_state,
+};
+
+int st_sensors_probe_trigger(struct iio_dev *indio_dev, int irq)
+{
+       int err;
+       struct st_sensors_data *adata =3D iio_priv(indio_dev);
+
+       adata->trig =3D iio_trigger_alloc("%s-trigger", indio_dev->name);
+       if (adata->trig =3D=3D NULL) {
+               err =3D -ENOMEM;
+               dev_err(&indio_dev->dev, "failed to allocate iio trigger.\n=
");
+               goto iio_trigger_alloc_error;
+       }
+
+       err =3D request_threaded_irq(irq,
+                       iio_trigger_generic_data_rdy_poll,
+                       NULL,
+                       IRQF_TRIGGER_RISING,
+                       adata->trig->name,
+                       adata->trig);
+       if (err)
+               goto request_irq_error;
+
+       adata->trig->private_data =3D indio_dev;
+       adata->trig->ops =3D &st_sensors_trigger_ops;
+       adata->trig->dev.parent =3D adata->dev;
+
+       err =3D iio_trigger_register(adata->trig);
+       if (err < 0) {
+               dev_err(&indio_dev->dev, "failed to register iio trigger.\n=
");
+               goto iio_trigger_register_error;
+       }
+       indio_dev->trig =3D adata->trig;
+
+       return 0;
+
+iio_trigger_register_error:
+       free_irq(irq, adata->trig);
+request_irq_error:
+       iio_trigger_free(adata->trig);
+iio_trigger_alloc_error:
+       return err;
+}
+EXPORT_SYMBOL(st_sensors_probe_trigger);
+
+void st_sensors_remove_trigger(struct iio_dev *indio_dev, int irq)
+{
+       struct st_sensors_data *adata =3D iio_priv(indio_dev);
+
+       iio_trigger_unregister(adata->trig);
+       free_irq(irq, adata->trig);
+       iio_trigger_free(adata->trig);
+}
+EXPORT_SYMBOL(st_sensors_remove_trigger);
diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index 21e27e2..3e8b746 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -13,4 +13,18 @@ config HID_SENSOR_GYRO_3D
          Say yes here to build support for the HID SENSOR
          Gyroscope 3D.

+config ST_GYRO_3D
+       tristate "STMicroelectronics gyroscopes 3-Axis Driver"
+       depends on (I2C || SPI_MASTER) && SYSFS
+       select IIO_BUFFER
+       select IIO_TRIGGERED_BUFFER
+       select ST_SENSORS_IIO_COMMON
+       help
+         Say yes here to build support for STMicroelectronics gyroscopes:
+         L3G4200D, LSM330DL, L3GD20, L3GD20H, LSM330D, LSM330DL, LSM330DLC=
,
+         LSM9DS0, L3G4IS, LSM330.
+
+         This driver can also be built as a module. If so, the module
+         will be called st_gyro.
+
  endmenu
diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
index 8a895d9..6a0a0d1 100644
--- a/drivers/iio/gyro/Makefile
+++ b/drivers/iio/gyro/Makefile
@@ -3,3 +3,4 @@
  #

  obj-$(CONFIG_HID_SENSOR_GYRO_3D) +=3D hid-sensor-gyro-3d.o
+obj-$(CONFIG_ST_GYRO_3D) +=3D st_gyro.o
diff --git a/drivers/iio/gyro/st_gyro.c b/drivers/iio/gyro/st_gyro.c
new file mode 100644
index 0000000..a483f19
--- /dev/null
+++ b/drivers/iio/gyro/st_gyro.c
@@ -0,0 +1,252 @@
+/*
+ * STMicroelectronics gyroscopes driver
+ *
+ * Copyright 2012 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/mutex.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/irq.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/buffer.h>
+
+#include "../common/st-sensors/st_sensors.h"
+
+
+/* FULLSCALE */
+#define ST_GYRO_FS_AVL_250DPS                  250
+#define ST_GYRO_FS_AVL_500DPS                  500
+#define ST_GYRO_FS_AVL_2000DPS                 2000
+
+/* CUSTOM VALUES FOR SENSOR 1 */
+#define ST_GYRO_1_WAI_EXP                      0xd3
+#define ST_GYRO_1_ODR_ADDR                     0x20
+#define ST_GYRO_1_ODR_MASK                     0xc0
+#define ST_GYRO_1_ODR_N_BIT                    2
+#define ST_GYRO_1_ODR_AVL_100HZ_VAL            0x00
+#define ST_GYRO_1_ODR_AVL_200HZ_VAL            0x01
+#define ST_GYRO_1_ODR_AVL_400HZ_VAL            0x02
+#define ST_GYRO_1_ODR_AVL_800HZ_VAL            0x03
+#define ST_GYRO_1_PW_ADDR                      0x20
+#define ST_GYRO_1_PW_MASK                      0x08
+#define ST_GYRO_1_PW_N_BIT                     1
+#define ST_GYRO_1_FS_N_BIT                     2
+#define ST_GYRO_1_FS_ADDR                      0x23
+#define ST_GYRO_1_FS_MASK                      0x30
+#define ST_GYRO_1_FS_AVL_250_VAL               0x00
+#define ST_GYRO_1_FS_AVL_500_VAL               0x01
+#define ST_GYRO_1_FS_AVL_2000_VAL              0x02
+#define ST_GYRO_1_FS_AVL_250_GAIN              IIO_DEGREE_TO_RAD(8750)
+#define ST_GYRO_1_FS_AVL_500_GAIN              IIO_DEGREE_TO_RAD(17500)
+#define ST_GYRO_1_FS_AVL_2000_GAIN             IIO_DEGREE_TO_RAD(70000)
+#define ST_GYRO_1_BDU_ADDR                     0x23
+#define ST_GYRO_1_BDU_MASK                     0x80
+#define ST_GYRO_1_DRDY_IRQ_ADDR                        0x22
+#define ST_GYRO_1_DRDY_IRQ_MASK                        0x08
+#define ST_GYRO_1_MULTIREAD_BIT                        true
+
+/* CUSTOM VALUES FOR SENSOR 2 */
+#define ST_GYRO_2_WAI_EXP                      0xd4
+#define ST_GYRO_2_ODR_ADDR                     0x20
+#define ST_GYRO_2_ODR_MASK                     0xc0
+#define ST_GYRO_2_ODR_N_BIT                    2
+#define ST_GYRO_2_ODR_AVL_95HZ_VAL             0x00
+#define ST_GYRO_2_ODR_AVL_190HZ_VAL            0x01
+#define ST_GYRO_2_ODR_AVL_380HZ_VAL            0x02
+#define ST_GYRO_2_ODR_AVL_760HZ_VAL            0x03
+#define ST_GYRO_2_PW_ADDR                      0x20
+#define ST_GYRO_2_PW_MASK                      0x08
+#define ST_GYRO_2_PW_N_BIT                     1
+#define ST_GYRO_2_FS_N_BIT                     2
+#define ST_GYRO_2_FS_ADDR                      0x23
+#define ST_GYRO_2_FS_MASK                      0x30
+#define ST_GYRO_2_FS_AVL_250_VAL               0x00
+#define ST_GYRO_2_FS_AVL_500_VAL               0x01
+#define ST_GYRO_2_FS_AVL_2000_VAL              0x02
+#define ST_GYRO_2_FS_AVL_250_GAIN              IIO_DEGREE_TO_RAD(8750)
+#define ST_GYRO_2_FS_AVL_500_GAIN              IIO_DEGREE_TO_RAD(17500)
+#define ST_GYRO_2_FS_AVL_2000_GAIN             IIO_DEGREE_TO_RAD(70000)
+#define ST_GYRO_2_BDU_ADDR                     0x23
+#define ST_GYRO_2_BDU_MASK                     0x80
+#define ST_GYRO_2_DRDY_IRQ_ADDR                        0x22
+#define ST_GYRO_2_DRDY_IRQ_MASK                        0x08
+#define ST_GYRO_2_MULTIREAD_BIT                        true
+
+const struct iio_chan_spec st_gyro_16bit_channels[] =3D {
+       ST_LSM_CHANNELS(IIO_ANGL_VEL, ST_SENSORS_SCAN_X, IIO_MOD_X, IIO_LE,
+               ST_SENSORS_DEF_16_REALBITS, ST_SENSORS_DEF_OUT_X_L_ADDR),
+       ST_LSM_CHANNELS(IIO_ANGL_VEL, ST_SENSORS_SCAN_Y, IIO_MOD_Y, IIO_LE,
+               ST_SENSORS_DEF_16_REALBITS, ST_SENSORS_DEF_OUT_Y_L_ADDR),
+       ST_LSM_CHANNELS(IIO_ANGL_VEL, ST_SENSORS_SCAN_Z, IIO_MOD_Z, IIO_LE,
+               ST_SENSORS_DEF_16_REALBITS, ST_SENSORS_DEF_OUT_Z_L_ADDR),
+       IIO_CHAN_SOFT_TIMESTAMP(3)
+};
+
+const struct st_sensors st_gyro_sensors[] =3D {
+       {
+               .wai =3D ST_GYRO_1_WAI_EXP,
+               .ch =3D (struct iio_chan_spec *)st_gyro_16bit_channels,
+               .odr =3D {
+                       .addr =3D ST_GYRO_1_ODR_ADDR,
+                       .mask =3D ST_GYRO_1_ODR_MASK,
+                       .num_bit =3D ST_GYRO_1_ODR_N_BIT,
+                       .odr_avl =3D {
+                               { 100, ST_GYRO_1_ODR_AVL_100HZ_VAL, },
+                               { 200, ST_GYRO_1_ODR_AVL_200HZ_VAL, },
+                               { 400, ST_GYRO_1_ODR_AVL_400HZ_VAL, },
+                               { 800, ST_GYRO_1_ODR_AVL_800HZ_VAL, },
+                       },
+               },
+               .pw =3D {
+                       .addr =3D ST_GYRO_1_PW_ADDR,
+                       .mask =3D ST_GYRO_1_PW_MASK,
+                       .num_bit =3D ST_GYRO_1_PW_N_BIT,
+                       .value_on =3D ST_SENSORS_DEF_POWER_ON_VALUE,
+                       .value_off =3D ST_SENSORS_DEF_POWER_OFF_VALUE,
+               },
+               .enable_axis =3D {
+                       .addr =3D ST_SENSORS_DEF_AXIS_ADDR,
+                       .mask =3D ST_SENSORS_DEF_AXIS_MASK,
+               },
+               .fs =3D {
+                       .addr =3D ST_GYRO_1_FS_ADDR,
+                       .mask =3D ST_GYRO_1_FS_MASK,
+                       .num_bit =3D ST_GYRO_1_FS_N_BIT,
+                       .fs_avl =3D {
+                               [0] =3D {
+                                       .num =3D ST_GYRO_FS_AVL_250DPS,
+                                       .value =3D ST_GYRO_1_FS_AVL_250_VAL=
,
+                                       .gain =3D ST_GYRO_1_FS_AVL_250_GAIN=
,
+                               },
+                               [1] =3D {
+                                       .num =3D ST_GYRO_FS_AVL_500DPS,
+                                       .value =3D ST_GYRO_1_FS_AVL_500_VAL=
,
+                                       .gain =3D ST_GYRO_1_FS_AVL_500_GAIN=
,
+                               },
+                               [2] =3D {
+                                       .num =3D ST_GYRO_FS_AVL_2000DPS,
+                                       .value =3D ST_GYRO_1_FS_AVL_2000_VA=
L,
+                                       .gain =3D ST_GYRO_1_FS_AVL_2000_GAI=
N,
+                               },
+                       },
+               },
+               .bdu =3D {
+                       .addr =3D ST_GYRO_1_BDU_ADDR,
+                       .mask =3D ST_GYRO_1_BDU_MASK,
+               },
+               .drdy_irq =3D {
+                       .addr =3D ST_GYRO_1_DRDY_IRQ_ADDR,
+                       .mask =3D ST_GYRO_1_DRDY_IRQ_MASK,
+               },
+               .multi_read_bit =3D ST_GYRO_1_MULTIREAD_BIT,
+       },
+       {
+               .wai =3D ST_GYRO_2_WAI_EXP,
+               .ch =3D (struct iio_chan_spec *)st_gyro_16bit_channels,
+               .odr =3D {
+                       .addr =3D ST_GYRO_2_ODR_ADDR,
+                       .mask =3D ST_GYRO_2_ODR_MASK,
+                       .num_bit =3D ST_GYRO_2_ODR_N_BIT,
+                       .odr_avl =3D {
+                               { 95, ST_GYRO_2_ODR_AVL_95HZ_VAL, },
+                               { 190, ST_GYRO_2_ODR_AVL_190HZ_VAL, },
+                               { 380, ST_GYRO_2_ODR_AVL_380HZ_VAL, },
+                               { 760, ST_GYRO_2_ODR_AVL_760HZ_VAL, },
+                       },
+               },
+               .pw =3D {
+                       .addr =3D ST_GYRO_2_PW_ADDR,
+                       .mask =3D ST_GYRO_2_PW_MASK,
+                       .num_bit =3D ST_GYRO_2_PW_N_BIT,
+                       .value_on =3D ST_SENSORS_DEF_POWER_ON_VALUE,
+                       .value_off =3D ST_SENSORS_DEF_POWER_OFF_VALUE,
+               },
+               .enable_axis =3D {
+                       .addr =3D ST_SENSORS_DEF_AXIS_ADDR,
+                       .mask =3D ST_SENSORS_DEF_AXIS_MASK,
+               },
+               .fs =3D {
+                       .addr =3D ST_GYRO_2_FS_ADDR,
+                       .mask =3D ST_GYRO_2_FS_MASK,
+                       .num_bit =3D ST_GYRO_2_FS_N_BIT,
+                       .fs_avl =3D {
+                               [0] =3D {
+                                       .num =3D ST_GYRO_FS_AVL_250DPS,
+                                       .value =3D ST_GYRO_2_FS_AVL_250_VAL=
,
+                                       .gain =3D ST_GYRO_2_FS_AVL_250_GAIN=
,
+                               },
+                               [1] =3D {
+                                       .num =3D ST_GYRO_FS_AVL_500DPS,
+                                       .value =3D ST_GYRO_2_FS_AVL_500_VAL=
,
+                                       .gain =3D ST_GYRO_2_FS_AVL_500_GAIN=
,
+                               },
+                               [2] =3D {
+                                       .num =3D ST_GYRO_FS_AVL_2000DPS,
+                                       .value =3D ST_GYRO_2_FS_AVL_2000_VA=
L,
+                                       .gain =3D ST_GYRO_2_FS_AVL_2000_GAI=
N,
+                               },
+                       },
+               },
+               .bdu =3D {
+                       .addr =3D ST_GYRO_2_BDU_ADDR,
+                       .mask =3D ST_GYRO_2_BDU_MASK,
+               },
+               .drdy_irq =3D {
+                       .addr =3D ST_GYRO_2_DRDY_IRQ_ADDR,
+                       .mask =3D ST_GYRO_2_DRDY_IRQ_MASK,
+               },
+               .multi_read_bit =3D ST_GYRO_2_MULTIREAD_BIT,
+       },
+};
+
+static int st_gyro_check_device_list(struct st_sensors_data *adata, u8 wai=
)
+{
+       int i;
+
+       for (i =3D 0; i < ARRAY_SIZE(st_gyro_sensors); i++) {
+               if (st_gyro_sensors[i].wai =3D=3D wai)
+                       break;
+       }
+       if (i =3D=3D ARRAY_SIZE(st_gyro_sensors))
+               goto check_device_error;
+
+       adata->index =3D i;
+
+       return i;
+
+check_device_error:
+       return -ENODEV;
+}
+
+int st_gyro_init_sensor(struct iio_dev *indio_dev, u8 wai)
+{
+       int err;
+       struct st_sensors_data *adata =3D iio_priv(indio_dev);
+
+       err =3D st_gyro_check_device_list(adata, wai);
+       if (err < 0)
+               goto init_error;
+
+       adata->st_sensors =3D (const struct st_sensors *)st_gyro_sensors;
+
+init_error:
+       return err;
+}
+EXPORT_SYMBOL(st_gyro_init_sensor);
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics gyroscopes driver");
+MODULE_LICENSE("GPL v2");
--
1.7.0.4
