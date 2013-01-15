Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:50006 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753554Ab3AOIbS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Jan 2013 03:31:18 -0500
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org
Cc: Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 2/9] iio:accel: Add STMicroelectronics accelerometers driver
Date: Tue, 15 Jan 2013 09:30:58 +0100
Message-Id: <1358238660-14929-3-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1358238660-14929-1-git-send-email-denis.ciocca@st.com>
References: <1358238660-14929-1-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds generic accelerometer driver for STMicroelectronics
accelerometers, currently it supports:
LSM303DLH, LSM303DLHC, LIS3DH, LSM330D, LSM330DL, LSM330DLC,
LIS331DLH, LSM303DL, LSM303DLM, LSM330.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/accel/Kconfig           |   41 +++
 drivers/iio/accel/Makefile          |    6 +
 drivers/iio/accel/st_accel_buffer.c |  119 +++++++
 drivers/iio/accel/st_accel_core.c   |  652 +++++++++++++++++++++++++++++++++++
 drivers/iio/accel/st_accel_i2c.c    |   87 +++++
 drivers/iio/accel/st_accel_spi.c    |   86 +++++
 include/linux/iio/accel/st_accel.h  |   52 +++
 7 files changed, 1043 insertions(+), 0 deletions(-)
 create mode 100644 drivers/iio/accel/st_accel_buffer.c
 create mode 100644 drivers/iio/accel/st_accel_core.c
 create mode 100644 drivers/iio/accel/st_accel_i2c.c
 create mode 100644 drivers/iio/accel/st_accel_spi.c
 create mode 100644 include/linux/iio/accel/st_accel.h

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 05e996f..ab67379 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -14,4 +14,45 @@ config HID_SENSOR_ACCEL_3D
 	  Say yes here to build support for the HID SENSOR
 	  accelerometers 3D.
 
+config IIO_ST_ACCEL_3AXIS
+	tristate "STMicroelectronics accelerometers 3-Axis Driver"
+	depends on (I2C || SPI_MASTER) && SYSFS
+	select IIO_ST_SENSORS_CORE
+	help
+	  Say yes here to build support for STMicroelectronics accelerometers:
+	  LSM303DLH, LSM303DLHC, LIS3DH, LSM330D, LSM330DL, LSM330DLC,
+	  LIS331DLH, LSM303DL, LSM303DLM, LSM330.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called st_accel.
+
+config IIO_ST_ACCEL_3AXIS_I2C
+	tristate "support I2C bus connection"
+	depends on IIO_ST_ACCEL_3AXIS && I2C
+	select IIO_ST_SENSORS_I2C
+	help
+	  Say yes here to build I2C support for STMicroelectronics accelerometers.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called st_accel_i2c.
+
+config IIO_ST_ACCEL_3AXIS_SPI
+	tristate "support SPI bus connection"
+	depends on IIO_ST_ACCEL_3AXIS && SPI_MASTER
+	select IIO_ST_SENSORS_SPI
+	help
+	  Say yes here to build SPI support for STMicroelectronics accelerometers.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called st_accel_spi.
+
+config IIO_ST_ACCEL_3AXIS_TRIGGERED_BUFFER
+	tristate "support triggered buffer"
+	depends on IIO_ST_ACCEL_3AXIS
+	select IIO_TRIGGERED_BUFFER
+	select IIO_BUFFER
+	select IIO_ST_SENSORS_TRIGGERED_BUFFER
+	help
+	  Default trigger and buffer for STMicroelectronics accelerometers driver.
+
 endmenu
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 5bc6855..bb1fa7e 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -3,3 +3,9 @@
 #
 
 obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
+
+st_accel-y := st_accel_core.o
+obj-$(CONFIG_IIO_ST_ACCEL_3AXIS_I2C) += st_accel_i2c.o
+obj-$(CONFIG_IIO_ST_ACCEL_3AXIS_SPI) += st_accel_spi.o
+obj-$(CONFIG_IIO_ST_ACCEL_3AXIS_TRIGGERED_BUFFER) += st_accel_buffer.o
+obj-$(CONFIG_IIO_ST_ACCEL_3AXIS) += st_accel.o
diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
new file mode 100644
index 0000000..4764d21
--- /dev/null
+++ b/drivers/iio/accel/st_accel_buffer.c
@@ -0,0 +1,119 @@
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
+#include <linux/iio/accel/st_accel.h>
+#include <linux/iio/common/st_sensors.h>
+
+
+int st_accel_trig_set_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *indio_dev = trig->private_data;
+	return st_accel_set_dataready_irq(indio_dev, state);
+}
+EXPORT_SYMBOL(st_accel_trig_set_state);
+
+static int st_accel_buffer_preenable(struct iio_dev *indio_dev)
+{
+	int err;
+
+	err = st_accel_set_enable(indio_dev, true);
+	if (err < 0)
+		goto st_accel_set_enable_error;
+
+	err = iio_sw_buffer_preenable(indio_dev);
+
+st_accel_set_enable_error:
+	return err;
+}
+
+static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
+{
+	int err;
+	struct st_sensor_data *adata = iio_priv(indio_dev);
+
+	adata->buffer_data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
+	if (adata->buffer_data == NULL) {
+		err = -ENOMEM;
+		goto allocate_memory_error;
+	}
+
+	err = st_accel_set_axis_enable(indio_dev,
+					(u8)indio_dev->active_scan_mask[0]);
+	if (err < 0)
+		goto st_accel_buffer_postenable_error;
+
+	err = iio_triggered_buffer_postenable(indio_dev);
+	if (err < 0)
+		goto st_accel_buffer_postenable_error;
+
+	return err;
+
+st_accel_buffer_postenable_error:
+	kfree(adata->buffer_data);
+allocate_memory_error:
+	return err;
+}
+
+static int st_accel_buffer_predisable(struct iio_dev *indio_dev)
+{
+	int err;
+	struct st_sensor_data *adata = iio_priv(indio_dev);
+
+	err = iio_triggered_buffer_predisable(indio_dev);
+	if (err < 0)
+		goto st_accel_buffer_predisable_error;
+
+	err = st_accel_set_axis_enable(indio_dev,
+						ST_SENSORS_ENABLE_ALL_CHANNELS);
+	if (err < 0)
+		goto st_accel_buffer_predisable_error;
+
+	err = st_accel_set_enable(indio_dev, false);
+
+st_accel_buffer_predisable_error:
+	kfree(adata->buffer_data);
+	return err;
+}
+
+static const struct iio_buffer_setup_ops st_accel_buffer_setup_ops = {
+	.preenable = &st_accel_buffer_preenable,
+	.postenable = &st_accel_buffer_postenable,
+	.predisable = &st_accel_buffer_predisable,
+};
+
+int st_accel_allocate_ring(struct iio_dev *indio_dev)
+{
+	return iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
+		&st_sensors_trigger_handler, &st_accel_buffer_setup_ops);
+}
+EXPORT_SYMBOL(st_accel_allocate_ring);
+
+void st_accel_deallocate_ring(struct iio_dev *indio_dev)
+{
+	iio_triggered_buffer_cleanup(indio_dev);
+}
+EXPORT_SYMBOL(st_accel_deallocate_ring);
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics accelerometers buffer");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
new file mode 100644
index 0000000..4e7108a
--- /dev/null
+++ b/drivers/iio/accel/st_accel_core.c
@@ -0,0 +1,652 @@
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
+#include <linux/delay.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/buffer.h>
+
+#include <linux/iio/accel/st_accel.h>
+#include <linux/iio/common/st_sensors.h>
+
+
+/* DEFAULT VALUE FOR SENSORS */
+#define ST_ACCEL_DEFAULT_OUT_X_L_ADDR		0x28
+#define ST_ACCEL_DEFAULT_OUT_Y_L_ADDR		0x2a
+#define ST_ACCEL_DEFAULT_OUT_Z_L_ADDR		0x2c
+
+/* FULLSCALE */
+#define ST_ACCEL_FS_AVL_2G			2
+#define ST_ACCEL_FS_AVL_4G			4
+#define ST_ACCEL_FS_AVL_6G			6
+#define ST_ACCEL_FS_AVL_8G			8
+#define ST_ACCEL_FS_AVL_16G			16
+
+/* CUSTOM VALUES FOR SENSOR 1 */
+#define ST_ACCEL_1_WAI_EXP			0x33
+#define ST_ACCEL_1_ODR_ADDR			0x20
+#define ST_ACCEL_1_ODR_MASK			0xf0
+#define ST_ACCEL_1_ODR_N_BIT			4
+#define ST_ACCEL_1_ODR_AVL_1HZ_VAL		0x01
+#define ST_ACCEL_1_ODR_AVL_10HZ_VAL		0x02
+#define ST_ACCEL_1_ODR_AVL_25HZ_VAL		0x03
+#define ST_ACCEL_1_ODR_AVL_50HZ_VAL		0x04
+#define ST_ACCEL_1_ODR_AVL_100HZ_VAL		0x05
+#define ST_ACCEL_1_ODR_AVL_200HZ_VAL		0x06
+#define ST_ACCEL_1_ODR_AVL_400HZ_VAL		0x07
+#define ST_ACCEL_1_ODR_AVL_1600HZ_VAL		0x08
+#define ST_ACCEL_1_FS_N_BIT			2
+#define ST_ACCEL_1_FS_ADDR			0x23
+#define ST_ACCEL_1_FS_MASK			0x30
+#define ST_ACCEL_1_FS_AVL_2_VAL			0x00
+#define ST_ACCEL_1_FS_AVL_4_VAL			0x01
+#define ST_ACCEL_1_FS_AVL_8_VAL			0x02
+#define ST_ACCEL_1_FS_AVL_16_VAL		0x03
+#define ST_ACCEL_1_FS_AVL_2_GAIN		IIO_G_TO_M_S_2(1000)
+#define ST_ACCEL_1_FS_AVL_4_GAIN		IIO_G_TO_M_S_2(2000)
+#define ST_ACCEL_1_FS_AVL_8_GAIN		IIO_G_TO_M_S_2(4000)
+#define ST_ACCEL_1_FS_AVL_16_GAIN		IIO_G_TO_M_S_2(12000)
+#define ST_ACCEL_1_BDU_ADDR			0x23
+#define ST_ACCEL_1_BDU_MASK			0x80
+#define ST_ACCEL_1_DRDY_IRQ_ADDR		0x22
+#define ST_ACCEL_1_DRDY_IRQ_MASK		0x10
+#define ST_ACCEL_1_MULTIREAD_BIT		true
+
+/* CUSTOM VALUES FOR SENSOR 2 */
+#define ST_ACCEL_2_WAI_EXP			0x32
+#define ST_ACCEL_2_ODR_ADDR			0x20
+#define ST_ACCEL_2_ODR_MASK			0x18
+#define ST_ACCEL_2_ODR_N_BIT			2
+#define ST_ACCEL_2_ODR_AVL_50HZ_VAL		0x00
+#define ST_ACCEL_2_ODR_AVL_100HZ_VAL		0x01
+#define ST_ACCEL_2_ODR_AVL_400HZ_VAL		0x02
+#define ST_ACCEL_2_ODR_AVL_1000HZ_VAL		0x03
+#define ST_ACCEL_2_PW_ADDR			0x20
+#define ST_ACCEL_2_PW_MASK			0xe0
+#define ST_ACCEL_2_PW_N_BIT			3
+#define ST_ACCEL_2_FS_N_BIT			2
+#define ST_ACCEL_2_FS_ADDR			0x23
+#define ST_ACCEL_2_FS_MASK			0x30
+#define ST_ACCEL_2_FS_AVL_2_VAL			0X00
+#define ST_ACCEL_2_FS_AVL_4_VAL			0X01
+#define ST_ACCEL_2_FS_AVL_8_VAL			0x03
+#define ST_ACCEL_2_FS_AVL_2_GAIN		IIO_G_TO_M_S_2(1000)
+#define ST_ACCEL_2_FS_AVL_4_GAIN		IIO_G_TO_M_S_2(2000)
+#define ST_ACCEL_2_FS_AVL_8_GAIN		IIO_G_TO_M_S_2(3900)
+#define ST_ACCEL_2_BDU_ADDR			0x23
+#define ST_ACCEL_2_BDU_MASK			0x80
+#define ST_ACCEL_2_DRDY_IRQ_ADDR		0x22
+#define ST_ACCEL_2_DRDY_IRQ_MASK		0x02
+#define ST_ACCEL_2_MULTIREAD_BIT		true
+
+/* CUSTOM VALUES FOR SENSOR 3 */
+#define ST_ACCEL_3_WAI_EXP			0x40
+#define ST_ACCEL_3_ODR_ADDR			0x20
+#define ST_ACCEL_3_ODR_MASK			0xf0
+#define ST_ACCEL_3_ODR_N_BIT			4
+#define ST_ACCEL_3_ODR_AVL_3HZ_VAL		0x01
+#define ST_ACCEL_3_ODR_AVL_6HZ_VAL		0x02
+#define ST_ACCEL_3_ODR_AVL_12HZ_VAL		0x03
+#define ST_ACCEL_3_ODR_AVL_25HZ_VAL		0x04
+#define ST_ACCEL_3_ODR_AVL_50HZ_VAL		0x05
+#define ST_ACCEL_3_ODR_AVL_100HZ_VAL		0x06
+#define ST_ACCEL_3_ODR_AVL_200HZ_VAL		0x07
+#define ST_ACCEL_3_ODR_AVL_400HZ_VAL		0x08
+#define ST_ACCEL_3_ODR_AVL_800HZ_VAL		0x09
+#define ST_ACCEL_3_ODR_AVL_1600HZ_VAL		0x0a
+#define ST_ACCEL_3_FS_N_BIT			3
+#define ST_ACCEL_3_FS_ADDR			0x24
+#define ST_ACCEL_3_FS_MASK			0x38
+#define ST_ACCEL_3_FS_AVL_2_VAL			0X00
+#define ST_ACCEL_3_FS_AVL_4_VAL			0X01
+#define ST_ACCEL_3_FS_AVL_6_VAL			0x02
+#define ST_ACCEL_3_FS_AVL_8_VAL			0x03
+#define ST_ACCEL_3_FS_AVL_16_VAL		0x04
+#define ST_ACCEL_3_FS_AVL_2_GAIN		IIO_G_TO_M_S_2(61)
+#define ST_ACCEL_3_FS_AVL_4_GAIN		IIO_G_TO_M_S_2(122)
+#define ST_ACCEL_3_FS_AVL_6_GAIN		IIO_G_TO_M_S_2(183)
+#define ST_ACCEL_3_FS_AVL_8_GAIN		IIO_G_TO_M_S_2(244)
+#define ST_ACCEL_3_FS_AVL_16_GAIN		IIO_G_TO_M_S_2(732)
+#define ST_ACCEL_3_BDU_ADDR			0x20
+#define ST_ACCEL_3_BDU_MASK			0x08
+#define ST_ACCEL_3_DRDY_IRQ_ADDR		0x23
+#define ST_ACCEL_3_DRDY_IRQ_MASK		0x80
+#define ST_ACCEL_3_IG1_EN_ADDR			0x23
+#define ST_ACCEL_3_IG1_EN_MASK			0x08
+#define ST_ACCEL_3_MULTIREAD_BIT		false
+
+static const struct iio_chan_spec st_accel_12bit_channels[] = {
+	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL, ST_SENSORS_SCAN_X, IIO_MOD_X, IIO_LE,
+		ST_SENSORS_DEFAULT_12_REALBITS, ST_ACCEL_DEFAULT_OUT_X_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL, ST_SENSORS_SCAN_Y, IIO_MOD_Y, IIO_LE,
+		ST_SENSORS_DEFAULT_12_REALBITS, ST_ACCEL_DEFAULT_OUT_Y_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL, ST_SENSORS_SCAN_Z, IIO_MOD_Z, IIO_LE,
+		ST_SENSORS_DEFAULT_12_REALBITS, ST_ACCEL_DEFAULT_OUT_Z_L_ADDR),
+	IIO_CHAN_SOFT_TIMESTAMP(3)
+};
+
+static const struct iio_chan_spec st_accel_16bit_channels[] = {
+	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL, ST_SENSORS_SCAN_X, IIO_MOD_X, IIO_LE,
+		ST_SENSORS_DEFAULT_16_REALBITS, ST_ACCEL_DEFAULT_OUT_X_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL, ST_SENSORS_SCAN_Y, IIO_MOD_Y, IIO_LE,
+		ST_SENSORS_DEFAULT_16_REALBITS, ST_ACCEL_DEFAULT_OUT_Y_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL, ST_SENSORS_SCAN_Z, IIO_MOD_Z, IIO_LE,
+		ST_SENSORS_DEFAULT_16_REALBITS, ST_ACCEL_DEFAULT_OUT_Z_L_ADDR),
+	IIO_CHAN_SOFT_TIMESTAMP(3)
+};
+
+static const struct st_sensors st_accel_sensors[] = {
+	{
+		.wai = ST_ACCEL_1_WAI_EXP,
+		.sensors_supported = {
+			[0] = LIS3DH_ACCEL_DEV_NAME,
+			[1] = LSM303DLH_ACCEL_DEV_NAME,
+			[2] = LSM303DLHC_ACCEL_DEV_NAME,
+			[3] = LSM330D_ACCEL_DEV_NAME,
+			[4] = LSM330DL_ACCEL_DEV_NAME,
+			[5] = LSM330DLC_ACCEL_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
+		.odr = {
+			.addr = ST_ACCEL_1_ODR_ADDR,
+			.mask = ST_ACCEL_1_ODR_MASK,
+			.num_bit = ST_ACCEL_1_ODR_N_BIT,
+			.odr_avl = {
+				{ 1, ST_ACCEL_1_ODR_AVL_1HZ_VAL, },
+				{ 10, ST_ACCEL_1_ODR_AVL_10HZ_VAL, },
+				{ 25, ST_ACCEL_1_ODR_AVL_25HZ_VAL, },
+				{ 50, ST_ACCEL_1_ODR_AVL_50HZ_VAL, },
+				{ 100, ST_ACCEL_1_ODR_AVL_100HZ_VAL, },
+				{ 200, ST_ACCEL_1_ODR_AVL_200HZ_VAL, },
+				{ 400, ST_ACCEL_1_ODR_AVL_400HZ_VAL, },
+				{ 1600, ST_ACCEL_1_ODR_AVL_1600HZ_VAL, },
+			},
+		},
+		.pw = {
+			.addr = ST_ACCEL_1_ODR_ADDR,
+			.mask = ST_ACCEL_1_ODR_MASK,
+			.num_bit = ST_ACCEL_1_ODR_N_BIT,
+			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
+		},
+		.enable_axis = {
+			.addr = ST_SENSORS_DEFAULT_AXIS_ADDR,
+			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
+		},
+		.fs = {
+			.addr = ST_ACCEL_1_FS_ADDR,
+			.mask = ST_ACCEL_1_FS_MASK,
+			.num_bit = ST_ACCEL_1_FS_N_BIT,
+			.fs_avl = {
+				[0] = {
+					.num = ST_ACCEL_FS_AVL_2G,
+					.value = ST_ACCEL_1_FS_AVL_2_VAL,
+					.gain = ST_ACCEL_1_FS_AVL_2_GAIN,
+				},
+				[1] = {
+					.num = ST_ACCEL_FS_AVL_4G,
+					.value = ST_ACCEL_1_FS_AVL_4_VAL,
+					.gain = ST_ACCEL_1_FS_AVL_4_GAIN,
+				},
+				[2] = {
+					.num = ST_ACCEL_FS_AVL_8G,
+					.value = ST_ACCEL_1_FS_AVL_8_VAL,
+					.gain = ST_ACCEL_1_FS_AVL_8_GAIN,
+				},
+				[3] = {
+					.num = ST_ACCEL_FS_AVL_16G,
+					.value = ST_ACCEL_1_FS_AVL_16_VAL,
+					.gain = ST_ACCEL_1_FS_AVL_16_GAIN,
+				},
+			},
+		},
+		.bdu = {
+			.addr = ST_ACCEL_1_BDU_ADDR,
+			.mask = ST_ACCEL_1_BDU_MASK,
+		},
+		.drdy_irq = {
+			.addr = ST_ACCEL_1_DRDY_IRQ_ADDR,
+			.mask = ST_ACCEL_1_DRDY_IRQ_MASK,
+		},
+		.multi_read_bit = ST_ACCEL_1_MULTIREAD_BIT,
+		.bootime = 2,
+	},
+	{
+		.wai = ST_ACCEL_2_WAI_EXP,
+		.sensors_supported = {
+			[0] = LIS331DLH_ACCEL_DEV_NAME,
+			[1] = LSM303DL_ACCEL_DEV_NAME,
+			[2] = LSM303DLM_ACCEL_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
+		.odr = {
+			.addr = ST_ACCEL_2_ODR_ADDR,
+			.mask = ST_ACCEL_2_ODR_MASK,
+			.num_bit = ST_ACCEL_2_ODR_N_BIT,
+			.odr_avl = {
+				{ 50, ST_ACCEL_2_ODR_AVL_50HZ_VAL, },
+				{ 100, ST_ACCEL_2_ODR_AVL_100HZ_VAL, },
+				{ 400, ST_ACCEL_2_ODR_AVL_400HZ_VAL, },
+				{ 1000, ST_ACCEL_2_ODR_AVL_1000HZ_VAL, },
+			},
+		},
+		.pw = {
+			.addr = ST_ACCEL_2_PW_ADDR,
+			.mask = ST_ACCEL_2_PW_MASK,
+			.num_bit = ST_ACCEL_2_PW_N_BIT,
+			.value_on = ST_SENSORS_DEFAULT_POWER_ON_VALUE,
+			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
+		},
+		.enable_axis = {
+			.addr = ST_SENSORS_DEFAULT_AXIS_ADDR,
+			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
+		},
+		.fs = {
+			.addr = ST_ACCEL_2_FS_ADDR,
+			.mask = ST_ACCEL_2_FS_MASK,
+			.num_bit = ST_ACCEL_2_FS_N_BIT,
+			.fs_avl = {
+				[0] = {
+					.num = ST_ACCEL_FS_AVL_2G,
+					.value = ST_ACCEL_2_FS_AVL_2_VAL,
+					.gain = ST_ACCEL_2_FS_AVL_2_GAIN,
+				},
+				[1] = {
+					.num = ST_ACCEL_FS_AVL_4G,
+					.value = ST_ACCEL_2_FS_AVL_4_VAL,
+					.gain = ST_ACCEL_2_FS_AVL_4_GAIN,
+				},
+				[2] = {
+					.num = ST_ACCEL_FS_AVL_8G,
+					.value = ST_ACCEL_2_FS_AVL_8_VAL,
+					.gain = ST_ACCEL_2_FS_AVL_8_GAIN,
+				},
+			},
+		},
+		.bdu = {
+			.addr = ST_ACCEL_2_BDU_ADDR,
+			.mask = ST_ACCEL_2_BDU_MASK,
+		},
+		.drdy_irq = {
+			.addr = ST_ACCEL_2_DRDY_IRQ_ADDR,
+			.mask = ST_ACCEL_2_DRDY_IRQ_MASK,
+		},
+		.multi_read_bit = ST_ACCEL_2_MULTIREAD_BIT,
+		.bootime = 2,
+	},
+	{
+		.wai = ST_ACCEL_3_WAI_EXP,
+		.sensors_supported = {
+			[0] = LSM330_ACCEL_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_accel_16bit_channels,
+		.odr = {
+			.addr = ST_ACCEL_3_ODR_ADDR,
+			.mask = ST_ACCEL_3_ODR_MASK,
+			.num_bit = ST_ACCEL_3_ODR_N_BIT,
+			.odr_avl = {
+				{ 3, ST_ACCEL_3_ODR_AVL_3HZ_VAL },
+				{ 6, ST_ACCEL_3_ODR_AVL_6HZ_VAL, },
+				{ 12, ST_ACCEL_3_ODR_AVL_12HZ_VAL, },
+				{ 25, ST_ACCEL_3_ODR_AVL_25HZ_VAL, },
+				{ 50, ST_ACCEL_3_ODR_AVL_50HZ_VAL, },
+				{ 100, ST_ACCEL_3_ODR_AVL_100HZ_VAL, },
+				{ 200, ST_ACCEL_3_ODR_AVL_200HZ_VAL, },
+				{ 400, ST_ACCEL_3_ODR_AVL_400HZ_VAL, },
+				{ 800, ST_ACCEL_3_ODR_AVL_800HZ_VAL, },
+				{ 1600, ST_ACCEL_3_ODR_AVL_1600HZ_VAL, },
+			},
+		},
+		.pw = {
+			.addr = ST_ACCEL_3_ODR_ADDR,
+			.mask = ST_ACCEL_3_ODR_MASK,
+			.num_bit = ST_ACCEL_3_ODR_N_BIT,
+			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
+		},
+		.enable_axis = {
+			.addr = ST_SENSORS_DEFAULT_AXIS_ADDR,
+			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
+		},
+		.fs = {
+			.addr = ST_ACCEL_3_FS_ADDR,
+			.mask = ST_ACCEL_3_FS_MASK,
+			.num_bit = ST_ACCEL_3_FS_N_BIT,
+			.fs_avl = {
+				[0] = {
+					.num = ST_ACCEL_FS_AVL_2G,
+					.value = ST_ACCEL_3_FS_AVL_2_VAL,
+					.gain = ST_ACCEL_3_FS_AVL_2_GAIN,
+				},
+				[1] = {
+					.num = ST_ACCEL_FS_AVL_4G,
+					.value = ST_ACCEL_3_FS_AVL_4_VAL,
+					.gain = ST_ACCEL_3_FS_AVL_4_GAIN,
+				},
+				[2] = {
+					.num = ST_ACCEL_FS_AVL_6G,
+					.value = ST_ACCEL_3_FS_AVL_6_VAL,
+					.gain = ST_ACCEL_3_FS_AVL_6_GAIN,
+				},
+				[3] = {
+					.num = ST_ACCEL_FS_AVL_8G,
+					.value = ST_ACCEL_3_FS_AVL_8_VAL,
+					.gain = ST_ACCEL_3_FS_AVL_8_GAIN,
+				},
+				[4] = {
+					.num = ST_ACCEL_FS_AVL_16G,
+					.value = ST_ACCEL_3_FS_AVL_16_VAL,
+					.gain = ST_ACCEL_3_FS_AVL_16_GAIN,
+				},
+			},
+		},
+		.bdu = {
+			.addr = ST_ACCEL_3_BDU_ADDR,
+			.mask = ST_ACCEL_3_BDU_MASK,
+		},
+		.drdy_irq = {
+			.addr = ST_ACCEL_3_DRDY_IRQ_ADDR,
+			.mask = ST_ACCEL_3_DRDY_IRQ_MASK,
+			.ig1 = {
+				.en_addr = ST_ACCEL_3_IG1_EN_ADDR,
+				.en_mask = ST_ACCEL_3_IG1_EN_MASK,
+			},
+		},
+		.multi_read_bit = ST_ACCEL_3_MULTIREAD_BIT,
+		.bootime = 2,
+	},
+};
+
+static int st_accel_read_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *ch, int *val,
+							int *val2, long mask)
+{
+	int err;
+	struct st_sensor_data *adata = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&indio_dev->mlock);
+		if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+			err = -EBUSY;
+			goto read_error;
+		} else {
+			err = st_sensors_set_enable(indio_dev,
+					&st_accel_sensors[adata->index], true);
+			if (err < 0)
+				goto read_error;
+
+			msleep((st_accel_sensors[adata->index].bootime * 1000)
+								/ adata->odr);
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
+		*val2 = adata->current_fullscale->gain;
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
+static int st_accel_write_raw(struct iio_dev *indio_dev,
+		struct iio_chan_spec const *chan, int val, int val2, long mask)
+{
+	int err;
+	struct st_sensor_data *adata = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		err = st_sensors_set_fullscale_by_gain(indio_dev,
+					&st_accel_sensors[adata->index], val2);
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	return err;
+}
+
+int st_accel_set_dataready_irq(struct iio_dev *indio_dev, bool state)
+{
+	struct st_sensor_data *adata = iio_priv(indio_dev);
+
+	return st_sensors_set_dataready_irq(indio_dev,
+					&st_accel_sensors[adata->index], state);
+}
+EXPORT_SYMBOL(st_accel_set_dataready_irq);
+
+int st_accel_set_axis_enable(struct iio_dev *indio_dev, u8 active_bit)
+{
+	struct st_sensor_data *adata = iio_priv(indio_dev);
+
+	return st_sensors_set_axis_enable(indio_dev,
+				&st_accel_sensors[adata->index], active_bit);
+}
+EXPORT_SYMBOL(st_accel_set_axis_enable);
+
+static int st_accel_check_device_support(struct iio_dev *indio_dev)
+{
+	int i, n, err;
+	u8 wai;
+	struct st_sensor_data *adata = iio_priv(indio_dev);
+
+	err = adata->tf->read_byte(&adata->tb, adata->dev,
+					ST_SENSORS_DEFAULT_WAI_ADDRESS, &wai);
+	if (err < 0) {
+		dev_err(&indio_dev->dev, "failed to read Who-Am-I register.\n");
+		goto read_wai_error;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(st_accel_sensors); i++) {
+		if (st_accel_sensors[i].wai == wai)
+			break;
+	}
+	if (i == ARRAY_SIZE(st_accel_sensors))
+		goto device_not_supported;
+
+	for (n = 0; n < ARRAY_SIZE(st_accel_sensors[i].sensors_supported);
+									n++) {
+		if (strcmp(indio_dev->name,
+			&st_accel_sensors[i].sensors_supported[n][0]) == 0)
+			break;
+	}
+	if (n == ARRAY_SIZE(st_accel_sensors[i].sensors_supported)) {
+		dev_err(&indio_dev->dev, "device name and WhoAmI mismatch.\n");
+		goto sensor_name_mismatch;
+	}
+
+	adata->index = i;
+
+	return i;
+
+device_not_supported:
+	dev_err(&indio_dev->dev, "device not supported: WhoAmI (0x%x).\n", wai);
+sensor_name_mismatch:
+	err = -ENODEV;
+read_wai_error:
+	return err;
+}
+
+int st_accel_set_enable(struct iio_dev *indio_dev, bool enable)
+{
+	struct st_sensor_data *adata = iio_priv(indio_dev);
+
+	return st_sensors_set_enable(indio_dev,
+				&st_accel_sensors[adata->index], enable);
+}
+EXPORT_SYMBOL(st_accel_set_enable);
+
+static ssize_t st_accel_sysfs_set_sampling_frequency(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t size)
+{
+	int err;
+	unsigned int odr;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct st_sensor_data *adata = iio_priv(indio_dev);
+
+	err = kstrtoint(buf, 10, &odr);
+	if (err < 0)
+		goto conversion_error;
+
+	mutex_lock(&indio_dev->mlock);
+	err = st_sensors_set_odr(indio_dev,
+					&st_accel_sensors[adata->index], odr);
+	mutex_unlock(&indio_dev->mlock);
+
+conversion_error:
+	return err < 0 ? err : size;
+}
+
+static ssize_t st_accel_sysfs_get_sampling_frequency(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct st_sensor_data *adata = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", adata->odr);
+}
+
+static ssize_t st_accel_sysfs_scale_avail(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct st_sensor_data *adata = iio_priv(indio_dev);
+
+	return st_sensors_get_scale_avl(indio_dev,
+			st_accel_sensors[adata->index].fs.fs_avl, buf);
+}
+
+static ssize_t st_accel_sysfs_sampling_frequency_avail(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct st_sensor_data *adata = iio_priv(indio_dev);
+
+	return st_sensors_get_sampling_frequency_avl(indio_dev,
+			st_accel_sensors[adata->index].odr.odr_avl, buf);
+}
+
+static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(st_accel_sysfs_sampling_frequency_avail);
+
+static IIO_DEVICE_ATTR(in_accel_scale_available, S_IRUGO,
+					st_accel_sysfs_scale_avail, NULL , 0);
+
+static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
+			st_accel_sysfs_get_sampling_frequency,
+					st_accel_sysfs_set_sampling_frequency);
+
+static struct attribute *st_accel_attributes[] = {
+	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_in_accel_scale_available.dev_attr.attr,
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group st_accel_attribute_group = {
+	.attrs = st_accel_attributes,
+};
+
+static const struct iio_info accel_info = {
+	.driver_module = THIS_MODULE,
+	.attrs = &st_accel_attribute_group,
+	.read_raw = &st_accel_read_raw,
+	.write_raw = &st_accel_write_raw,
+};
+
+int st_accel_common_probe(struct iio_dev *indio_dev)
+{
+	int err;
+	struct st_sensor_data *adata = iio_priv(indio_dev);
+
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &accel_info;
+
+	err = st_accel_check_device_support(indio_dev);
+	if (err < 0)
+		goto st_accel_common_probe_error;
+
+	adata->multiread_bit = st_accel_sensors[adata->index].multi_read_bit;
+	indio_dev->channels = st_accel_sensors[adata->index].ch;
+	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
+
+	adata->current_fullscale = (struct st_sensor_fullscale_avl *)
+				&st_accel_sensors[adata->index].fs.fs_avl[0];
+	adata->odr = st_accel_sensors[adata->index].odr.odr_avl[0].hz;
+
+	err = st_sensors_init_sensor(indio_dev,
+					&st_accel_sensors[adata->index]);
+	if (err < 0)
+		goto st_accel_common_probe_error;
+
+	if (adata->get_irq_data_ready(indio_dev) > 0) {
+		err = st_accel_allocate_ring(indio_dev);
+		if (err < 0)
+			goto st_accel_common_probe_error;
+
+		err = st_sensors_allocate_trigger(indio_dev,
+						&st_accel_trig_set_state, NULL);
+		if (err < 0)
+			goto st_accel_probe_trigger_error;
+	}
+
+	err = iio_device_register(indio_dev);
+	if (err)
+		goto st_accel_device_register_error;
+
+	return err;
+
+st_accel_device_register_error:
+	if (adata->get_irq_data_ready(indio_dev) > 0)
+		st_sensors_deallocate_trigger(indio_dev);
+st_accel_probe_trigger_error:
+	if (adata->get_irq_data_ready(indio_dev) > 0)
+		st_accel_deallocate_ring(indio_dev);
+st_accel_common_probe_error:
+	return err;
+}
+EXPORT_SYMBOL(st_accel_common_probe);
+
+void st_accel_common_remove(struct iio_dev *indio_dev)
+{
+	struct st_sensor_data *adata = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	if (adata->get_irq_data_ready(indio_dev) > 0) {
+		st_sensors_deallocate_trigger(indio_dev);
+		st_accel_deallocate_ring(indio_dev);
+	}
+	iio_device_free(indio_dev);
+}
+EXPORT_SYMBOL(st_accel_common_remove);
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics accelerometers driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
new file mode 100644
index 0000000..d1000e8
--- /dev/null
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -0,0 +1,87 @@
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
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+
+#include <linux/iio/accel/st_accel.h>
+#include <linux/iio/common/st_sensors.h>
+
+
+static int st_accel_i2c_probe(struct i2c_client *client,
+						const struct i2c_device_id *id)
+{
+	struct iio_dev *indio_dev;
+	struct st_sensor_data *adata;
+	int err;
+
+	indio_dev = iio_device_alloc(sizeof(*adata));
+	if (indio_dev == NULL) {
+		err = -ENOMEM;
+		goto iio_device_alloc_error;
+	}
+
+	adata = iio_priv(indio_dev);
+	adata->dev = &client->dev;
+
+	st_sensors_i2c_configure(indio_dev, client, adata);
+
+	err = st_accel_common_probe(indio_dev);
+	if (err < 0)
+		goto st_accel_common_probe_error;
+
+	return 0;
+
+st_accel_common_probe_error:
+	iio_device_free(indio_dev);
+iio_device_alloc_error:
+	return err;
+}
+
+static int st_accel_i2c_remove(struct i2c_client *client)
+{
+	st_accel_common_remove(i2c_get_clientdata(client));
+
+	return 0;
+}
+
+static const struct i2c_device_id st_accel_id_table[] = {
+	{ LSM303DLH_ACCEL_DEV_NAME },
+	{ LSM303DLHC_ACCEL_DEV_NAME },
+	{ LIS3DH_ACCEL_DEV_NAME },
+	{ LSM330D_ACCEL_DEV_NAME },
+	{ LSM330DL_ACCEL_DEV_NAME },
+	{ LSM330DLC_ACCEL_DEV_NAME },
+	{ LIS331DLH_ACCEL_DEV_NAME },
+	{ LSM303DL_ACCEL_DEV_NAME },
+	{ LSM303DLM_ACCEL_DEV_NAME },
+	{ LSM330_ACCEL_DEV_NAME },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
+
+static struct i2c_driver st_accel_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "st-accel-i2c",
+	},
+	.probe = st_accel_i2c_probe,
+	.remove = st_accel_i2c_remove,
+	.id_table = st_accel_id_table,
+};
+module_i2c_driver(st_accel_driver);
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics accelerometers i2c driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
new file mode 100644
index 0000000..011cc58
--- /dev/null
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -0,0 +1,86 @@
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
+#include <linux/spi/spi.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+
+#include <linux/iio/accel/st_accel.h>
+#include <linux/iio/common/st_sensors.h>
+
+
+static int st_accel_spi_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct st_sensor_data *adata;
+	int err;
+
+	indio_dev = iio_device_alloc(sizeof(*adata));
+	if (indio_dev == NULL) {
+		err = -ENOMEM;
+		goto iio_device_alloc_error;
+	}
+
+	adata = iio_priv(indio_dev);
+	adata->dev = &spi->dev;
+
+	st_sensors_spi_configure(indio_dev, spi, adata);
+
+	err = st_accel_common_probe(indio_dev);
+	if (err < 0)
+		goto st_accel_common_probe_error;
+
+	return 0;
+
+st_accel_common_probe_error:
+	iio_device_free(indio_dev);
+iio_device_alloc_error:
+	return err;
+}
+
+static int st_accel_spi_remove(struct spi_device *spi)
+{
+	st_accel_common_remove(spi_get_drvdata(spi));
+
+	return 0;
+}
+
+static const struct spi_device_id st_accel_id_table[] = {
+	{ LSM303DLH_ACCEL_DEV_NAME },
+	{ LSM303DLHC_ACCEL_DEV_NAME },
+	{ LIS3DH_ACCEL_DEV_NAME },
+	{ LSM330D_ACCEL_DEV_NAME },
+	{ LSM330DL_ACCEL_DEV_NAME },
+	{ LSM330DLC_ACCEL_DEV_NAME },
+	{ LIS331DLH_ACCEL_DEV_NAME },
+	{ LSM303DL_ACCEL_DEV_NAME },
+	{ LSM303DLM_ACCEL_DEV_NAME },
+	{ LSM330_ACCEL_DEV_NAME },
+	{},
+};
+MODULE_DEVICE_TABLE(spi, st_accel_id_table);
+
+static struct spi_driver st_accel_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "st-accel-spi",
+	},
+	.probe = st_accel_spi_probe,
+	.remove = st_accel_spi_remove,
+	.id_table = st_accel_id_table,
+};
+module_spi_driver(st_accel_driver);
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics accelerometers spi driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/iio/accel/st_accel.h b/include/linux/iio/accel/st_accel.h
new file mode 100644
index 0000000..5bcbecc
--- /dev/null
+++ b/include/linux/iio/accel/st_accel.h
@@ -0,0 +1,52 @@
+/*
+ * STMicroelectronics accelerometers driver
+ *
+ * Copyright 2012 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ * v. 1.0.0
+ * Licensed under the GPL-2.
+ */
+
+#ifndef ST_ACCEL_H
+#define ST_ACCEL_H
+
+#include <linux/types.h>
+#include "../common/st_sensors.h"
+
+#define LSM303DLH_ACCEL_DEV_NAME	"lsm303dlh_accel"
+#define LSM303DLHC_ACCEL_DEV_NAME	"lsm303dlhc_accel"
+#define LIS3DH_ACCEL_DEV_NAME		"lis3dh"
+#define LSM330D_ACCEL_DEV_NAME		"lsm330d_accel"
+#define LSM330DL_ACCEL_DEV_NAME		"lsm330dl_accel"
+#define LSM330DLC_ACCEL_DEV_NAME	"lsm330dlc_accel"
+#define LIS331DLH_ACCEL_DEV_NAME	"lis331dlh"
+#define LSM303DL_ACCEL_DEV_NAME		"lsm303dl_accel"
+#define LSM303DLM_ACCEL_DEV_NAME	"lsm303dlm_accel"
+#define LSM330_ACCEL_DEV_NAME		"lsm330_accel"
+
+int st_accel_common_probe(struct iio_dev *indio_dev);
+void st_accel_common_remove(struct iio_dev *indio_dev);
+int st_accel_set_dataready_irq(struct iio_dev *indio_dev, bool state);
+int st_accel_set_axis_enable(struct iio_dev *indio_dev, u8 active_bit);
+int st_accel_set_enable(struct iio_dev *indio_dev, bool enable);
+
+#ifdef CONFIG_IIO_ST_ACCEL_3AXIS_TRIGGERED_BUFFER
+int st_accel_allocate_ring(struct iio_dev *indio_dev);
+void st_accel_deallocate_ring(struct iio_dev *indio_dev);
+int st_accel_trig_set_state(struct iio_trigger *trig, bool state);
+#else /* CONFIG_IIO_ST_ACCEL_3AXIS_TRIGGERED_BUFFER */
+static inline int st_accel_allocate_ring(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+static inline void st_accel_deallocate_ring(struct iio_dev *indio_dev)
+{
+}
+static inline int st_accel_trig_set_state(struct iio_trigger *trig, bool state)
+{
+	return 0;
+}
+#endif /* CONFIG_IIO_ST_ACCEL_3AXIS_TRIGGERED_BUFFER */
+
+#endif /* ST_ACCEL_H */
-- 
1.7.0.4

