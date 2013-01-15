Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:42219 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753562Ab3AOIbS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Jan 2013 03:31:18 -0500
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org
Cc: Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 4/9] iio:magnetometer: Add STMicroelectronics magnetometers driver
Date: Tue, 15 Jan 2013 09:31:00 +0100
Message-Id: <1358238660-14929-5-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1358238660-14929-1-git-send-email-denis.ciocca@st.com>
References: <1358238660-14929-1-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds generic magnetometer driver for STMicroelectronics
magnetometers, currently it supports:
LSM303DLHC, LSM303DLM, LIS3MDL.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/magnetometer/Kconfig          |   40 +++
 drivers/iio/magnetometer/Makefile         |    6 +
 drivers/iio/magnetometer/st_magn_buffer.c |  102 ++++++
 drivers/iio/magnetometer/st_magn_core.c   |  526 +++++++++++++++++++++++++++++
 drivers/iio/magnetometer/st_magn_i2c.c    |   81 +++++
 drivers/iio/magnetometer/st_magn_spi.c    |   80 +++++
 include/linux/iio/magnetometer/st_magn.h  |   47 +++
 7 files changed, 882 insertions(+), 0 deletions(-)
 create mode 100644 drivers/iio/magnetometer/st_magn_buffer.c
 create mode 100644 drivers/iio/magnetometer/st_magn_core.c
 create mode 100644 drivers/iio/magnetometer/st_magn_i2c.c
 create mode 100644 drivers/iio/magnetometer/st_magn_spi.c
 create mode 100644 include/linux/iio/magnetometer/st_magn.h

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index ff11d68..02e1273 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -14,4 +14,44 @@ config HID_SENSOR_MAGNETOMETER_3D
 	  Say yes here to build support for the HID SENSOR
 	  Magnetometer 3D.
 
+config IIO_ST_MAGN_3AXIS
+	tristate "STMicroelectronics magnetometers 3-Axis Driver"
+	depends on (I2C || SPI_MASTER) && SYSFS
+	select IIO_ST_SENSORS_CORE
+	help
+	  Say yes here to build support for STMicroelectronics magnetometers:
+	  LSM303DLHC, LSM303DLM, LIS3MDL.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called st_magn.
+
+config IIO_ST_MAGN_3AXIS_I2C
+	tristate "support I2C bus connection"
+	depends on IIO_ST_MAGN_3AXIS && I2C
+	select IIO_ST_SENSORS_I2C
+	help
+	  Say yes here to build I2C support for STMicroelectronics magnetometers.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called st_magn_i2c.
+
+config IIO_ST_MAGN_3AXIS_SPI
+	tristate "support SPI bus connection"
+	depends on IIO_ST_MAGN_3AXIS && SPI_MASTER
+	select IIO_ST_SENSORS_SPI
+	help
+	  Say yes here to build SPI support for STMicroelectronics magnetometers.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called st_magn_spi.
+
+config IIO_ST_MAGN_3AXIS_TRIGGERED_BUFFER
+	tristate "support triggered buffer"
+	depends on IIO_ST_MAGN_3AXIS
+	select IIO_TRIGGERED_BUFFER
+	select IIO_BUFFER
+	select IIO_ST_SENSORS_TRIGGERED_BUFFER
+	help
+	  Default trigger and buffer for STMicroelectronics magnetometers driver.
+
 endmenu
diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
index 60dc4f2..33d42e5 100644
--- a/drivers/iio/magnetometer/Makefile
+++ b/drivers/iio/magnetometer/Makefile
@@ -3,3 +3,9 @@
 #
 
 obj-$(CONFIG_HID_SENSOR_MAGNETOMETER_3D) += hid-sensor-magn-3d.o
+
+st_magn-y := st_magn_core.o
+obj-$(CONFIG_IIO_ST_MAGN_3AXIS_I2C) += st_magn_i2c.o
+obj-$(CONFIG_IIO_ST_MAGN_3AXIS_SPI) += st_magn_spi.o
+obj-$(CONFIG_IIO_ST_MAGN_3AXIS_TRIGGERED_BUFFER) += st_magn_buffer.o
+obj-$(CONFIG_IIO_ST_MAGN_3AXIS) += st_magn.o
diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
new file mode 100644
index 0000000..2a59d86
--- /dev/null
+++ b/drivers/iio/magnetometer/st_magn_buffer.c
@@ -0,0 +1,102 @@
+/*
+ * STMicroelectronics magnetometers driver
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
+#include <linux/delay.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#include <linux/iio/magnetometer/st_magn.h>
+#include <linux/iio/common/st_sensors.h>
+
+
+static int st_magn_buffer_preenable(struct iio_dev *indio_dev)
+{
+	int err;
+
+	err = st_magn_set_enable(indio_dev, true);
+	if (err < 0)
+		goto st_magn_set_enable_error;
+
+	err = iio_sw_buffer_preenable(indio_dev);
+
+st_magn_set_enable_error:
+	return err;
+}
+
+static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
+{
+	int err;
+	struct st_sensor_data *mdata = iio_priv(indio_dev);
+
+	mdata->buffer_data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
+	if (mdata->buffer_data == NULL) {
+		err = -ENOMEM;
+		goto allocate_memory_error;
+	}
+
+	err = iio_triggered_buffer_postenable(indio_dev);
+	if (err < 0)
+		goto st_magn_buffer_postenable_error;
+
+	return err;
+
+st_magn_buffer_postenable_error:
+	kfree(mdata->buffer_data);
+allocate_memory_error:
+	return err;
+}
+
+static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
+{
+	int err;
+	struct st_sensor_data *mdata = iio_priv(indio_dev);
+
+	err = iio_triggered_buffer_predisable(indio_dev);
+	if (err < 0)
+		goto st_magn_buffer_predisable_error;
+
+	err = st_magn_set_enable(indio_dev, false);
+
+st_magn_buffer_predisable_error:
+	kfree(mdata->buffer_data);
+	return err;
+}
+
+static const struct iio_buffer_setup_ops st_magn_buffer_setup_ops = {
+	.preenable = &st_magn_buffer_preenable,
+	.postenable = &st_magn_buffer_postenable,
+	.predisable = &st_magn_buffer_predisable,
+};
+
+int st_magn_allocate_ring(struct iio_dev *indio_dev)
+{
+	return iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
+		&st_sensors_trigger_handler, &st_magn_buffer_setup_ops);
+}
+EXPORT_SYMBOL(st_magn_allocate_ring);
+
+void st_magn_deallocate_ring(struct iio_dev *indio_dev)
+{
+	iio_triggered_buffer_cleanup(indio_dev);
+}
+EXPORT_SYMBOL(st_magn_deallocate_ring);
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics magnetometers buffer");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
new file mode 100644
index 0000000..0dd7f0c
--- /dev/null
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -0,0 +1,526 @@
+/*
+ * STMicroelectronics magnetometers driver
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
+#include <linux/delay.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/buffer.h>
+
+#include <linux/iio/magnetometer/st_magn.h>
+#include <linux/iio/common/st_sensors.h>
+
+
+/* DEFAULT VALUE FOR SENSORS */
+#define ST_MAGN_DEFAULT_OUT_X_L_ADDR		0X04
+#define ST_MAGN_DEFAULT_OUT_Y_L_ADDR		0X08
+#define ST_MAGN_DEFAULT_OUT_Z_L_ADDR		0X06
+
+/* FULLSCALE */
+#define ST_MAGN_FS_AVL_1300MG			1300
+#define ST_MAGN_FS_AVL_1900MG			1900
+#define ST_MAGN_FS_AVL_2500MG			2500
+#define ST_MAGN_FS_AVL_4000MG			4000
+#define ST_MAGN_FS_AVL_4700MG			4700
+#define ST_MAGN_FS_AVL_5600MG			5600
+#define ST_MAGN_FS_AVL_8000MG			8000
+#define ST_MAGN_FS_AVL_8100MG			8100
+#define ST_MAGN_FS_AVL_10000MG			10000
+
+/* CUSTOM VALUES FOR SENSOR 1 */
+#define ST_MAGN_1_WAI_EXP			0x3c
+#define ST_MAGN_1_ODR_ADDR			0x00
+#define ST_MAGN_1_ODR_MASK			0x1c
+#define ST_MAGN_1_ODR_N_BIT			3
+#define ST_MAGN_1_ODR_AVL_1HZ_VAL		0x00
+#define ST_MAGN_1_ODR_AVL_2HZ_VAL		0x01
+#define ST_MAGN_1_ODR_AVL_3HZ_VAL		0x02
+#define ST_MAGN_1_ODR_AVL_8HZ_VAL		0x03
+#define ST_MAGN_1_ODR_AVL_15HZ_VAL		0x04
+#define ST_MAGN_1_ODR_AVL_30HZ_VAL		0x05
+#define ST_MAGN_1_ODR_AVL_75HZ_VAL		0x06
+#define ST_MAGN_1_ODR_AVL_220HZ_VAL		0x07
+#define ST_MAGN_1_PW_ADDR			0x02
+#define ST_MAGN_1_PW_MASK			0x03
+#define ST_MAGN_1_PW_N_BIT			2
+#define ST_MAGN_1_PW_ON				0x00
+#define ST_MAGN_1_PW_OFF			0x03
+#define ST_MAGN_1_FS_N_BIT			3
+#define ST_MAGN_1_FS_ADDR			0x01
+#define ST_MAGN_1_FS_MASK			0xe0
+#define ST_MAGN_1_FS_AVL_1300_VAL		0x01
+#define ST_MAGN_1_FS_AVL_1900_VAL		0x02
+#define ST_MAGN_1_FS_AVL_2500_VAL		0x03
+#define ST_MAGN_1_FS_AVL_4000_VAL		0x04
+#define ST_MAGN_1_FS_AVL_4700_VAL		0x05
+#define ST_MAGN_1_FS_AVL_5600_VAL		0x06
+#define ST_MAGN_1_FS_AVL_8100_VAL		0x07
+#define ST_MAGN_1_FS_AVL_1300_GAIN_XY		1100
+#define ST_MAGN_1_FS_AVL_1900_GAIN_XY		855
+#define ST_MAGN_1_FS_AVL_2500_GAIN_XY		670
+#define ST_MAGN_1_FS_AVL_4000_GAIN_XY		450
+#define ST_MAGN_1_FS_AVL_4700_GAIN_XY		400
+#define ST_MAGN_1_FS_AVL_5600_GAIN_XY		330
+#define ST_MAGN_1_FS_AVL_8100_GAIN_XY		230
+#define ST_MAGN_1_FS_AVL_1300_GAIN_Z		980
+#define ST_MAGN_1_FS_AVL_1900_GAIN_Z		760
+#define ST_MAGN_1_FS_AVL_2500_GAIN_Z		600
+#define ST_MAGN_1_FS_AVL_4000_GAIN_Z		400
+#define ST_MAGN_1_FS_AVL_4700_GAIN_Z		355
+#define ST_MAGN_1_FS_AVL_5600_GAIN_Z		295
+#define ST_MAGN_1_FS_AVL_8100_GAIN_Z		205
+#define ST_MAGN_1_MULTIREAD_BIT			false
+
+/* CUSTOM VALUES FOR SENSOR 2 */
+#define ST_MAGN_2_WAI_EXP			0x3d
+#define ST_MAGN_2_ODR_ADDR			0x20
+#define ST_MAGN_2_ODR_MASK			0x1c
+#define ST_MAGN_2_ODR_N_BIT			3
+#define ST_MAGN_2_ODR_AVL_1HZ_VAL		0x00
+#define ST_MAGN_2_ODR_AVL_2HZ_VAL		0x01
+#define ST_MAGN_2_ODR_AVL_3HZ_VAL		0x02
+#define ST_MAGN_2_ODR_AVL_5HZ_VAL		0x03
+#define ST_MAGN_2_ODR_AVL_10HZ_VAL		0x04
+#define ST_MAGN_2_ODR_AVL_20HZ_VAL		0x05
+#define ST_MAGN_2_ODR_AVL_40HZ_VAL		0x06
+#define ST_MAGN_2_ODR_AVL_80HZ_VAL		0x07
+#define ST_MAGN_2_PW_ADDR			0x22
+#define ST_MAGN_2_PW_MASK			0x03
+#define ST_MAGN_2_PW_N_BIT			2
+#define ST_MAGN_2_PW_ON				0x00
+#define ST_MAGN_2_PW_OFF			0x03
+#define ST_MAGN_2_FS_N_BIT			2
+#define ST_MAGN_2_FS_ADDR			0x21
+#define ST_MAGN_2_FS_MASK			0x60
+#define ST_MAGN_2_FS_AVL_4000_VAL		0x00
+#define ST_MAGN_2_FS_AVL_8000_VAL		0x01
+#define ST_MAGN_2_FS_AVL_10000_VAL		0x02
+#define ST_MAGN_2_FS_AVL_4000_GAIN		430
+#define ST_MAGN_2_FS_AVL_8000_GAIN		230
+#define ST_MAGN_2_FS_AVL_10000_GAIN		230
+#define ST_MAGN_2_MULTIREAD_BIT			false
+#define ST_MAGN_2_OUT_X_L_ADDR			0x28
+#define ST_MAGN_2_OUT_Y_L_ADDR			0x2a
+#define ST_MAGN_2_OUT_Z_L_ADDR			0x2c
+
+static const struct iio_chan_spec st_magn_16bit_channels[] = {
+	ST_SENSORS_LSM_CHANNELS(IIO_MAGN, ST_SENSORS_SCAN_X, IIO_MOD_X, IIO_LE,
+		ST_SENSORS_DEFAULT_16_REALBITS, ST_MAGN_DEFAULT_OUT_X_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_MAGN, ST_SENSORS_SCAN_Y, IIO_MOD_Y, IIO_LE,
+		ST_SENSORS_DEFAULT_16_REALBITS, ST_MAGN_DEFAULT_OUT_Y_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_MAGN, ST_SENSORS_SCAN_Z, IIO_MOD_Z, IIO_LE,
+		ST_SENSORS_DEFAULT_16_REALBITS, ST_MAGN_DEFAULT_OUT_Z_L_ADDR),
+	IIO_CHAN_SOFT_TIMESTAMP(3)
+};
+
+static const struct iio_chan_spec st_magn_2_16bit_channels[] = {
+	ST_SENSORS_LSM_CHANNELS(IIO_MAGN, ST_SENSORS_SCAN_X, IIO_MOD_X, IIO_LE,
+		ST_SENSORS_DEFAULT_16_REALBITS, ST_MAGN_2_OUT_X_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_MAGN, ST_SENSORS_SCAN_Y, IIO_MOD_Y, IIO_LE,
+		ST_SENSORS_DEFAULT_16_REALBITS, ST_MAGN_2_OUT_Y_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_MAGN, ST_SENSORS_SCAN_Z, IIO_MOD_Z, IIO_LE,
+		ST_SENSORS_DEFAULT_16_REALBITS, ST_MAGN_2_OUT_Z_L_ADDR),
+	IIO_CHAN_SOFT_TIMESTAMP(3)
+};
+
+static const struct st_sensors st_magn_sensors[] = {
+	{
+		.wai = ST_MAGN_1_WAI_EXP,
+		.ch = (struct iio_chan_spec *)st_magn_16bit_channels,
+		.odr = {
+			.addr = ST_MAGN_1_ODR_ADDR,
+			.mask = ST_MAGN_1_ODR_MASK,
+			.num_bit = ST_MAGN_1_ODR_N_BIT,
+			.odr_avl = {
+				{ 1, ST_MAGN_1_ODR_AVL_1HZ_VAL, },
+				{ 2, ST_MAGN_1_ODR_AVL_2HZ_VAL, },
+				{ 3, ST_MAGN_1_ODR_AVL_3HZ_VAL, },
+				{ 8, ST_MAGN_1_ODR_AVL_8HZ_VAL, },
+				{ 15, ST_MAGN_1_ODR_AVL_15HZ_VAL, },
+				{ 30, ST_MAGN_1_ODR_AVL_30HZ_VAL, },
+				{ 75, ST_MAGN_1_ODR_AVL_75HZ_VAL, },
+				{ 220, ST_MAGN_1_ODR_AVL_220HZ_VAL, },
+			},
+		},
+		.pw = {
+			.addr = ST_MAGN_1_PW_ADDR,
+			.mask = ST_MAGN_1_PW_MASK,
+			.num_bit = ST_MAGN_1_PW_N_BIT,
+			.value_on = ST_MAGN_1_PW_ON,
+			.value_off = ST_MAGN_1_PW_OFF,
+		},
+		.fs = {
+			.addr = ST_MAGN_1_FS_ADDR,
+			.mask = ST_MAGN_1_FS_MASK,
+			.num_bit = ST_MAGN_1_FS_N_BIT,
+			.fs_avl = {
+				[0] = {
+					.num = ST_MAGN_FS_AVL_1300MG,
+					.value = ST_MAGN_1_FS_AVL_1300_VAL,
+					.gain = ST_MAGN_1_FS_AVL_1300_GAIN_XY,
+					.gain2 = ST_MAGN_1_FS_AVL_1300_GAIN_Z,
+				},
+				[1] = {
+					.num = ST_MAGN_FS_AVL_1900MG,
+					.value = ST_MAGN_1_FS_AVL_1900_VAL,
+					.gain = ST_MAGN_1_FS_AVL_1900_GAIN_XY,
+					.gain2 = ST_MAGN_1_FS_AVL_1900_GAIN_Z,
+				},
+				[2] = {
+					.num = ST_MAGN_FS_AVL_2500MG,
+					.value = ST_MAGN_1_FS_AVL_2500_VAL,
+					.gain = ST_MAGN_1_FS_AVL_2500_GAIN_XY,
+					.gain2 = ST_MAGN_1_FS_AVL_2500_GAIN_Z,
+				},
+				[3] = {
+					.num = ST_MAGN_FS_AVL_4000MG,
+					.value = ST_MAGN_1_FS_AVL_4000_VAL,
+					.gain = ST_MAGN_1_FS_AVL_4000_GAIN_XY,
+					.gain2 = ST_MAGN_1_FS_AVL_4000_GAIN_Z,
+				},
+				[4] = {
+					.num = ST_MAGN_FS_AVL_4700MG,
+					.value = ST_MAGN_1_FS_AVL_4700_VAL,
+					.gain = ST_MAGN_1_FS_AVL_4700_GAIN_XY,
+					.gain2 = ST_MAGN_1_FS_AVL_4700_GAIN_Z,
+				},
+				[5] = {
+					.num = ST_MAGN_FS_AVL_5600MG,
+					.value = ST_MAGN_1_FS_AVL_5600_VAL,
+					.gain = ST_MAGN_1_FS_AVL_5600_GAIN_XY,
+					.gain2 = ST_MAGN_1_FS_AVL_5600_GAIN_Z,
+				},
+				[6] = {
+					.num = ST_MAGN_FS_AVL_8100MG,
+					.value = ST_MAGN_1_FS_AVL_8100_VAL,
+					.gain = ST_MAGN_1_FS_AVL_8100_GAIN_XY,
+					.gain2 = ST_MAGN_1_FS_AVL_8100_GAIN_Z,
+				},
+			},
+		},
+		.multi_read_bit = ST_MAGN_1_MULTIREAD_BIT,
+		.bootime = 2,
+	},
+	{
+		.wai = ST_MAGN_2_WAI_EXP,
+		.ch = (struct iio_chan_spec *)st_magn_2_16bit_channels,
+		.odr = {
+			.addr = ST_MAGN_2_ODR_ADDR,
+			.mask = ST_MAGN_2_ODR_MASK,
+			.num_bit = ST_MAGN_2_ODR_N_BIT,
+			.odr_avl = {
+				{ 1, ST_MAGN_2_ODR_AVL_1HZ_VAL, },
+				{ 2, ST_MAGN_2_ODR_AVL_2HZ_VAL, },
+				{ 3, ST_MAGN_2_ODR_AVL_3HZ_VAL, },
+				{ 5, ST_MAGN_2_ODR_AVL_5HZ_VAL, },
+				{ 10, ST_MAGN_2_ODR_AVL_10HZ_VAL, },
+				{ 20, ST_MAGN_2_ODR_AVL_20HZ_VAL, },
+				{ 40, ST_MAGN_2_ODR_AVL_40HZ_VAL, },
+				{ 80, ST_MAGN_2_ODR_AVL_80HZ_VAL, },
+			},
+		},
+		.pw = {
+			.addr = ST_MAGN_2_PW_ADDR,
+			.mask = ST_MAGN_2_PW_MASK,
+			.num_bit = ST_MAGN_2_PW_N_BIT,
+			.value_on = ST_MAGN_2_PW_ON,
+			.value_off = ST_MAGN_2_PW_OFF,
+		},
+		.fs = {
+			.addr = ST_MAGN_2_FS_ADDR,
+			.mask = ST_MAGN_2_FS_MASK,
+			.num_bit = ST_MAGN_2_FS_N_BIT,
+			.fs_avl = {
+				[0] = {
+					.num = ST_MAGN_FS_AVL_4000MG,
+					.value = ST_MAGN_2_FS_AVL_4000_VAL,
+					.gain = ST_MAGN_2_FS_AVL_4000_GAIN,
+				},
+				[1] = {
+					.num = ST_MAGN_FS_AVL_8000MG,
+					.value = ST_MAGN_2_FS_AVL_8000_VAL,
+					.gain = ST_MAGN_2_FS_AVL_8000_GAIN,
+				},
+				[2] = {
+					.num = ST_MAGN_FS_AVL_10000MG,
+					.value = ST_MAGN_2_FS_AVL_10000_VAL,
+					.gain = ST_MAGN_2_FS_AVL_10000_GAIN,
+				},
+			},
+		},
+		.multi_read_bit = ST_MAGN_2_MULTIREAD_BIT,
+		.bootime = 2,
+	},
+};
+
+static int st_magn_read_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *ch, int *val,
+							int *val2, long mask)
+{
+	int err;
+	struct st_sensor_data *mdata = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&indio_dev->mlock);
+		if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+			err = -EBUSY;
+			goto read_error;
+		} else {
+			err = st_sensors_set_enable(indio_dev,
+					&st_magn_sensors[mdata->index], true);
+			if (err < 0)
+				goto read_error;
+
+			msleep((st_magn_sensors[mdata->index].bootime * 1000)
+								/ mdata->odr);
+			err = st_sensors_read_axis_data(indio_dev,
+							ch->address, val);
+			if (err < 0)
+				goto read_error;
+
+			*val = *val >> ch->scan_type.shift;
+		}
+		mutex_unlock(&indio_dev->mlock);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		if (ch->scan_index != ST_SENSORS_SCAN_Z)
+			*val2 = mdata->current_fullscale->gain;
+		else
+			*val2 = mdata->current_fullscale->gain2;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+
+read_error:
+	mutex_unlock(&indio_dev->mlock);
+	return err;
+}
+
+static int st_magn_write_raw(struct iio_dev *indio_dev,
+		struct iio_chan_spec const *chan, int val, int val2, long mask)
+{
+	int err;
+	struct st_sensor_data *mdata = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		err = st_sensors_set_fullscale_by_gain(indio_dev,
+					&st_magn_sensors[mdata->index], val2);
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	return err;
+}
+
+int st_magn_set_axis_enable(struct iio_dev *indio_dev, u8 active_bit)
+{
+	return 0;
+}
+EXPORT_SYMBOL(st_magn_set_axis_enable);
+
+static int st_magn_check_device_support(struct iio_dev *indio_dev)
+{
+	int i, err;
+	u8 wai;
+	struct st_sensor_data *mdata = iio_priv(indio_dev);
+
+	err = mdata->tf->read_byte(&mdata->tb, mdata->dev,
+					ST_SENSORS_DEFAULT_WAI_ADDRESS, &wai);
+	if (err < 0) {
+		dev_err(&indio_dev->dev, "failed to read Who-Am-I register.\n");
+		goto read_wai_error;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(st_magn_sensors); i++) {
+		if (st_magn_sensors[i].wai == wai)
+			break;
+	}
+	if (i == ARRAY_SIZE(st_magn_sensors))
+		goto check_device_error;
+
+	mdata->index = i;
+
+	return i;
+
+check_device_error:
+	dev_err(&indio_dev->dev, "device not supported -> wai (0x%x).\n", wai);
+	err = -ENODEV;
+read_wai_error:
+	return err;
+}
+
+int st_magn_set_enable(struct iio_dev *indio_dev, bool enable)
+{
+	struct st_sensor_data *mdata = iio_priv(indio_dev);
+
+	return st_sensors_set_enable(indio_dev,
+				&st_magn_sensors[mdata->index], enable);
+}
+EXPORT_SYMBOL(st_magn_set_enable);
+
+static ssize_t st_magn_sysfs_set_sampling_frequency(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t size)
+{
+	int err;
+	unsigned int odr;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct st_sensor_data *mdata = iio_priv(indio_dev);
+
+	err = kstrtoint(buf, 10, &odr);
+	if (err < 0)
+		goto conversion_error;
+
+	mutex_lock(&indio_dev->mlock);
+	err = st_sensors_set_odr(indio_dev,
+					&st_magn_sensors[mdata->index], odr);
+	mutex_unlock(&indio_dev->mlock);
+
+conversion_error:
+	return err < 0 ? err : size;
+}
+
+static ssize_t st_magn_sysfs_get_sampling_frequency(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct st_sensor_data *mdata = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", mdata->odr);
+}
+
+static ssize_t st_magn_sysfs_scale_available(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct st_sensor_data *mdata = iio_priv(indio_dev);
+
+	return st_sensors_get_scale_avl(indio_dev,
+				st_magn_sensors[mdata->index].fs.fs_avl, buf);
+}
+
+static ssize_t st_magn_sysfs_sampling_frequency_available(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct st_sensor_data *mdata = iio_priv(indio_dev);
+
+	return st_sensors_get_sampling_frequency_avl(indio_dev,
+				st_magn_sensors[mdata->index].odr.odr_avl, buf);
+}
+
+static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(st_magn_sysfs_sampling_frequency_available);
+
+static IIO_DEVICE_ATTR(in_magn_scale_available, S_IRUGO,
+				st_magn_sysfs_scale_available, NULL , 0);
+
+static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
+			st_magn_sysfs_get_sampling_frequency,
+					st_magn_sysfs_set_sampling_frequency);
+
+static struct attribute *st_magn_attributes[] = {
+	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_in_magn_scale_available.dev_attr.attr,
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group st_magn_attribute_group = {
+	.attrs = st_magn_attributes,
+};
+
+static const struct iio_info magn_info = {
+	.driver_module = THIS_MODULE,
+	.attrs = &st_magn_attribute_group,
+	.read_raw = &st_magn_read_raw,
+	.write_raw = &st_magn_write_raw,
+};
+
+int st_magn_common_probe(struct iio_dev *indio_dev)
+{
+	int err;
+	struct st_sensor_data *mdata = iio_priv(indio_dev);
+
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &magn_info;
+
+	err = st_magn_check_device_support(indio_dev);
+	if (err < 0)
+		goto st_magn_common_probe_error;
+
+	mdata->multiread_bit = st_magn_sensors[mdata->index].multi_read_bit;
+	indio_dev->channels = st_magn_sensors[mdata->index].ch;
+	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
+
+	mdata->current_fullscale = (struct st_sensor_fullscale_avl *)
+				&st_magn_sensors[mdata->index].fs.fs_avl[0];
+	mdata->odr = st_magn_sensors[mdata->index].odr.odr_avl[0].hz;
+
+	err = st_sensors_init_sensor(indio_dev,
+					&st_magn_sensors[mdata->index]);
+	if (err < 0)
+		goto st_magn_common_probe_error;
+
+	if (mdata->get_irq_data_ready(indio_dev) > 0) {
+		err = st_magn_allocate_ring(indio_dev);
+		if (err < 0)
+			goto st_magn_common_probe_error;
+		err = st_sensors_allocate_trigger(indio_dev, NULL, NULL);
+		if (err < 0)
+			goto st_magn_probe_trigger_error;
+	}
+
+	err = iio_device_register(indio_dev);
+	if (err)
+		goto st_magn_device_register_error;
+
+	return err;
+
+st_magn_device_register_error:
+	if (mdata->get_irq_data_ready(indio_dev) > 0)
+		st_sensors_deallocate_trigger(indio_dev);
+st_magn_probe_trigger_error:
+	if (mdata->get_irq_data_ready(indio_dev) > 0)
+		st_magn_deallocate_ring(indio_dev);
+st_magn_common_probe_error:
+	return err;
+}
+EXPORT_SYMBOL(st_magn_common_probe);
+
+void st_magn_common_remove(struct iio_dev *indio_dev)
+{
+	struct st_sensor_data *mdata = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	if (mdata->get_irq_data_ready(indio_dev) > 0) {
+		st_sensors_deallocate_trigger(indio_dev);
+		st_magn_deallocate_ring(indio_dev);
+	}
+	iio_device_free(indio_dev);
+}
+EXPORT_SYMBOL(st_magn_common_remove);
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics magnetometers driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
new file mode 100644
index 0000000..d090104
--- /dev/null
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -0,0 +1,81 @@
+/*
+ * STMicroelectronics magnetometers driver
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
+#include <linux/iio/magnetometer/st_magn.h>
+#include <linux/iio/common/st_sensors.h>
+
+
+static int st_magn_i2c_probe(struct i2c_client *client,
+						const struct i2c_device_id *id)
+{
+	struct iio_dev *indio_dev;
+	struct st_sensor_data *mdata;
+	int err;
+
+	indio_dev = iio_device_alloc(sizeof(*mdata));
+	if (indio_dev == NULL) {
+		err = -ENOMEM;
+		goto iio_device_alloc_error;
+	}
+
+	mdata = iio_priv(indio_dev);
+	mdata->dev = &client->dev;
+
+	st_sensors_i2c_configure(indio_dev, client, mdata);
+
+	err = st_magn_common_probe(indio_dev);
+	if (err < 0)
+		goto st_magn_common_probe_error;
+
+	return 0;
+
+st_magn_common_probe_error:
+	iio_device_free(indio_dev);
+iio_device_alloc_error:
+	return err;
+}
+
+static int st_magn_i2c_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	st_magn_common_remove(indio_dev);
+
+	return 0;
+}
+
+static const struct i2c_device_id st_magn_id_table[] = {
+	{ LSM303DLHC_MAGN_DEV_NAME },
+	{ LSM303DLM_MAGN_DEV_NAME },
+	{ LIS3MDL_MAGN_DEV_NAME },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, st_magn_id_table);
+
+static struct i2c_driver st_magn_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "st-magn-i2c",
+	},
+	.probe = st_magn_i2c_probe,
+	.remove = st_magn_i2c_remove,
+	.id_table = st_magn_id_table,
+};
+module_i2c_driver(st_magn_driver);
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics magnetometers i2c driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
new file mode 100644
index 0000000..3d3cdc7
--- /dev/null
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -0,0 +1,80 @@
+/*
+ * STMicroelectronics magnetometers driver
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
+#include <linux/iio/magnetometer/st_magn.h>
+#include <linux/iio/common/st_sensors.h>
+
+
+static int st_magn_spi_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct st_sensor_data *mdata;
+	int err;
+
+	indio_dev = iio_device_alloc(sizeof(*mdata));
+	if (indio_dev == NULL) {
+		err = -ENOMEM;
+		goto iio_device_alloc_error;
+	}
+
+	mdata = iio_priv(indio_dev);
+	mdata->dev = &spi->dev;
+
+	st_sensors_spi_configure(indio_dev, spi, mdata);
+
+	err = st_magn_common_probe(indio_dev);
+	if (err < 0)
+		goto st_magn_common_probe_error;
+
+	return 0;
+
+st_magn_common_probe_error:
+	iio_device_free(indio_dev);
+iio_device_alloc_error:
+	return err;
+}
+
+static int st_magn_spi_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	st_magn_common_remove(indio_dev);
+
+	return 0;
+}
+
+static const struct spi_device_id st_magn_id_table[] = {
+	{ LSM303DLHC_MAGN_DEV_NAME },
+	{ LSM303DLM_MAGN_DEV_NAME },
+	{ LIS3MDL_MAGN_DEV_NAME },
+	{},
+};
+MODULE_DEVICE_TABLE(spi, st_magn_id_table);
+
+static struct spi_driver st_magn_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "st-magn-spi",
+	},
+	.probe = st_magn_spi_probe,
+	.remove = st_magn_spi_remove,
+	.id_table = st_magn_id_table,
+};
+module_spi_driver(st_magn_driver);
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics magnetometers spi driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/iio/magnetometer/st_magn.h b/include/linux/iio/magnetometer/st_magn.h
new file mode 100644
index 0000000..bba0d1d
--- /dev/null
+++ b/include/linux/iio/magnetometer/st_magn.h
@@ -0,0 +1,47 @@
+/*
+ * STMicroelectronics magnetometers driver
+ *
+ * Copyright 2012 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ * v. 1.0.0
+ * Licensed under the GPL-2.
+ */
+
+#ifndef ST_MAGN_H
+#define ST_MAGN_H
+
+#include <linux/types.h>
+#include "../common/st_sensors.h"
+
+#define LSM303DLHC_MAGN_DEV_NAME	"lsm303dlhc_magn"
+#define LSM303DLM_MAGN_DEV_NAME		"lsm303dlm_magn"
+#define LIS3MDL_MAGN_DEV_NAME		"lis3mdl"
+
+int st_magn_common_probe(struct iio_dev *indio_dev);
+void st_magn_common_remove(struct iio_dev *indio_dev);
+int st_magn_set_axis_enable(struct iio_dev *indio_dev, u8 active_bit);
+int st_magn_set_enable(struct iio_dev *indio_dev, bool enable);
+
+#ifdef CONFIG_IIO_ST_MAGN_3AXIS_TRIGGERED_BUFFER
+int st_magn_allocate_ring(struct iio_dev *indio_dev);
+void st_magn_deallocate_ring(struct iio_dev *indio_dev);
+#else /* CONFIG_IIO_ST_MAGN_3AXIS_TRIGGERED_BUFFER */
+static inline int st_magn_probe_trigger(struct iio_dev *indio_dev, int irq)
+{
+	return 0;
+}
+static inline void st_magn_remove_trigger(struct iio_dev *indio_dev, int irq)
+{
+	return;
+}
+static inline int st_magn_allocate_ring(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+static inline void st_magn_deallocate_ring(struct iio_dev *indio_dev)
+{
+}
+#endif /* CONFIG_IIO_ST_MAGN_3AXIS_TRIGGERED_BUFFER */
+
+#endif /* ST_MAGN_H */
-- 
1.7.0.4

