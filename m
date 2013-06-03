Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:53868 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758127Ab3FCO7I (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jun 2013 10:59:08 -0400
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, frederic.pillon@stericsson.com,
	lee.jones@stericcson.com, Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 3/3] iio:pressure: Add STMicroelectronics pressures driver
Date: Mon,  3 Jun 2013 16:58:52 +0200
Message-Id: <1370271532-10194-4-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1370271532-10194-1-git-send-email-denis.ciocca@st.com>
References: <1370271532-10194-1-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds a generic pressure driver for STMicroelectronics
pressure sensors, currently it supports: LPS331AP.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/Kconfig                       |    1 +
 drivers/iio/Makefile                      |    1 +
 drivers/iio/pressure/Kconfig              |   35 ++++
 drivers/iio/pressure/Makefile             |   10 ++
 drivers/iio/pressure/st_pressure.h        |   39 +++++
 drivers/iio/pressure/st_pressure_buffer.c |  105 +++++++++++
 drivers/iio/pressure/st_pressure_core.c   |  272 +++++++++++++++++++++++++++++
 drivers/iio/pressure/st_pressure_i2c.c    |   77 ++++++++
 drivers/iio/pressure/st_pressure_spi.c    |   76 ++++++++
 9 files changed, 616 insertions(+)
 create mode 100644 drivers/iio/pressure/Kconfig
 create mode 100644 drivers/iio/pressure/Makefile
 create mode 100644 drivers/iio/pressure/st_pressure.h
 create mode 100644 drivers/iio/pressure/st_pressure_buffer.c
 create mode 100644 drivers/iio/pressure/st_pressure_core.c
 create mode 100644 drivers/iio/pressure/st_pressure_i2c.c
 create mode 100644 drivers/iio/pressure/st_pressure_spi.c

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index daa3ddd..9af763a 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -73,5 +73,6 @@ source "drivers/iio/magnetometer/Kconfig"
 if IIO_TRIGGER
    source "drivers/iio/trigger/Kconfig"
 endif #IIO_TRIGGER
+source "drivers/iio/pressure/Kconfig"
 
 endif # IIO
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index a349a96..7a3866c 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -22,3 +22,4 @@ obj-y += imu/
 obj-y += light/
 obj-y += magnetometer/
 obj-y += trigger/
+obj-y += pressure/
diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
new file mode 100644
index 0000000..9427f01
--- /dev/null
+++ b/drivers/iio/pressure/Kconfig
@@ -0,0 +1,35 @@
+#
+# Pressure drivers
+#
+menu "Pressure Sensors"
+
+config IIO_ST_PRESS
+	tristate "STMicroelectronics pressures Driver"
+	depends on (I2C || SPI_MASTER) && SYSFS
+	select IIO_ST_SENSORS_CORE
+	select IIO_ST_PRESS_I2C if (I2C)
+	select IIO_ST_PRESS_SPI if (SPI_MASTER)
+	select IIO_TRIGGERED_BUFFER if (IIO_BUFFER)
+	help
+	  Say yes here to build support for STMicroelectronics pressures:
+	  LPS331AP.
+
+	  This driver can also be built as a module. If so, will be created
+	  these modules:
+	  - st_pressure (core functions for the driver [it is mandatory]);
+	  - st_pressure_i2c (necessary for the I2C devices [optional*]);
+	  - st_pressure_spi (necessary for the SPI devices [optional*]);
+
+	  (*) one of these is necessary to do something.
+
+config IIO_ST_PRESS_I2C
+	tristate
+	depends on IIO_ST_PRESS
+	depends on IIO_ST_SENSORS_I2C
+
+config IIO_ST_PRESS_SPI
+	tristate
+	depends on IIO_ST_PRESS
+	depends on IIO_ST_SENSORS_SPI
+
+endmenu
diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
new file mode 100644
index 0000000..d4bb33e
--- /dev/null
+++ b/drivers/iio/pressure/Makefile
@@ -0,0 +1,10 @@
+#
+# Makefile for industrial I/O pressure drivers
+#
+
+obj-$(CONFIG_IIO_ST_PRESS) += st_pressure.o
+st_pressure-y := st_pressure_core.o
+st_pressure-$(CONFIG_IIO_BUFFER) += st_pressure_buffer.o
+
+obj-$(CONFIG_IIO_ST_PRESS_I2C) += st_pressure_i2c.o
+obj-$(CONFIG_IIO_ST_PRESS_SPI) += st_pressure_spi.o
diff --git a/drivers/iio/pressure/st_pressure.h b/drivers/iio/pressure/st_pressure.h
new file mode 100644
index 0000000..414e45a
--- /dev/null
+++ b/drivers/iio/pressure/st_pressure.h
@@ -0,0 +1,39 @@
+/*
+ * STMicroelectronics pressures driver
+ *
+ * Copyright 2013 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ * v. 1.0.0
+ * Licensed under the GPL-2.
+ */
+
+#ifndef ST_PRESS_H
+#define ST_PRESS_H
+
+#include <linux/types.h>
+#include <linux/iio/common/st_sensors.h>
+
+#define LPS331AP_PRESS_DEV_NAME		"lps331ap"
+
+int st_press_common_probe(struct iio_dev *indio_dev);
+void st_press_common_remove(struct iio_dev *indio_dev);
+
+#ifdef CONFIG_IIO_BUFFER
+int st_press_allocate_ring(struct iio_dev *indio_dev);
+void st_press_deallocate_ring(struct iio_dev *indio_dev);
+int st_press_trig_set_state(struct iio_trigger *trig, bool state);
+#define ST_PRESS_TRIGGER_SET_STATE (&st_press_trig_set_state)
+#else /* CONFIG_IIO_BUFFER */
+static inline int st_press_allocate_ring(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+
+static inline void st_press_deallocate_ring(struct iio_dev *indio_dev)
+{
+}
+#define ST_PRESS_TRIGGER_SET_STATE NULL
+#endif /* CONFIG_IIO_BUFFER */
+
+#endif /* ST_PRESS_H */
diff --git a/drivers/iio/pressure/st_pressure_buffer.c b/drivers/iio/pressure/st_pressure_buffer.c
new file mode 100644
index 0000000..f877ef8
--- /dev/null
+++ b/drivers/iio/pressure/st_pressure_buffer.c
@@ -0,0 +1,105 @@
+/*
+ * STMicroelectronics pressures driver
+ *
+ * Copyright 2013 STMicroelectronics Inc.
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
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#include <linux/iio/common/st_sensors.h>
+#include "st_pressure.h"
+
+int st_press_trig_set_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+
+	return st_sensors_set_dataready_irq(indio_dev, state);
+}
+
+static int st_press_buffer_preenable(struct iio_dev *indio_dev)
+{
+	int err;
+
+	err = st_sensors_set_enable(indio_dev, true);
+	if (err < 0)
+		goto st_press_set_enable_error;
+
+	err = iio_sw_buffer_preenable(indio_dev);
+
+st_press_set_enable_error:
+	return err;
+}
+
+static int st_press_buffer_postenable(struct iio_dev *indio_dev)
+{
+	int err;
+	struct st_sensor_data *pdata = iio_priv(indio_dev);
+
+	pdata->buffer_data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
+	if (pdata->buffer_data == NULL) {
+		err = -ENOMEM;
+		goto allocate_memory_error;
+	}
+
+	err = iio_triggered_buffer_postenable(indio_dev);
+	if (err < 0)
+		goto st_press_buffer_postenable_error;
+
+	return err;
+
+st_press_buffer_postenable_error:
+	kfree(pdata->buffer_data);
+allocate_memory_error:
+	return err;
+}
+
+static int st_press_buffer_predisable(struct iio_dev *indio_dev)
+{
+	int err;
+	struct st_sensor_data *pdata = iio_priv(indio_dev);
+
+	err = iio_triggered_buffer_predisable(indio_dev);
+	if (err < 0)
+		goto st_press_buffer_predisable_error;
+
+	err = st_sensors_set_enable(indio_dev, false);
+
+st_press_buffer_predisable_error:
+	kfree(pdata->buffer_data);
+	return err;
+}
+
+static const struct iio_buffer_setup_ops st_press_buffer_setup_ops = {
+	.preenable = &st_press_buffer_preenable,
+	.postenable = &st_press_buffer_postenable,
+	.predisable = &st_press_buffer_predisable,
+};
+
+int st_press_allocate_ring(struct iio_dev *indio_dev)
+{
+	return iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
+		&st_sensors_trigger_handler, &st_press_buffer_setup_ops);
+}
+
+void st_press_deallocate_ring(struct iio_dev *indio_dev)
+{
+	iio_triggered_buffer_cleanup(indio_dev);
+}
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics pressures buffer");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
new file mode 100644
index 0000000..9c343b4
--- /dev/null
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -0,0 +1,272 @@
+/*
+ * STMicroelectronics pressures driver
+ *
+ * Copyright 2013 STMicroelectronics Inc.
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
+#include <linux/iio/trigger.h>
+#include <linux/iio/buffer.h>
+#include <asm/unaligned.h>
+
+#include <linux/iio/common/st_sensors.h>
+#include "st_pressure.h"
+
+#define ST_PRESS_MBAR_TO_KPASCAL(x)		(x * 10)
+#define ST_PRESS_NUMBER_DATA_CHANNELS		1
+
+/* DEFAULT VALUE FOR SENSORS */
+#define ST_PRESS_DEFAULT_OUT_XL_ADDR		0x28
+#define ST_TEMP_DEFAULT_OUT_L_ADDR		0x2b
+
+/* FULLSCALE */
+#define ST_PRESS_FS_AVL_1260MB			1260
+
+/* CUSTOM VALUES FOR SENSOR 1 */
+#define ST_PRESS_1_WAI_EXP			0xbb
+#define ST_PRESS_1_ODR_ADDR			0x20
+#define ST_PRESS_1_ODR_MASK			0x70
+#define ST_PRESS_1_ODR_AVL_1HZ_VAL		0x01
+#define ST_PRESS_1_ODR_AVL_7HZ_VAL		0x05
+#define ST_PRESS_1_ODR_AVL_13HZ_VAL		0x06
+#define ST_PRESS_1_ODR_AVL_25HZ_VAL		0x07
+#define ST_PRESS_1_PW_ADDR			0x20
+#define ST_PRESS_1_PW_MASK			0x80
+#define ST_PRESS_1_FS_ADDR			0x23
+#define ST_PRESS_1_FS_MASK			0x30
+#define ST_PRESS_1_FS_AVL_1260_VAL		0x00
+#define ST_PRESS_1_FS_AVL_1260_GAIN		ST_PRESS_MBAR_TO_KPASCAL(244141)
+#define ST_PRESS_1_FS_AVL_TEMP_GAIN		2083000
+#define ST_PRESS_1_BDU_ADDR			0x20
+#define ST_PRESS_1_BDU_MASK			0x04
+#define ST_PRESS_1_DRDY_IRQ_ADDR		0x22
+#define ST_PRESS_1_DRDY_IRQ_MASK		0x04
+#define ST_PRESS_1_MULTIREAD_BIT		true
+#define ST_PRESS_1_TEMP_OFFSET			42500
+
+static const struct iio_chan_spec st_press_channels[] = {
+	ST_SENSORS_LSM_CHANNELS(IIO_PRESSURE,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_X, 0, IIO_NO_MOD, 'u', IIO_LE, 24, 24,
+			ST_PRESS_DEFAULT_OUT_XL_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_TEMP,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE) |
+						BIT(IIO_CHAN_INFO_OFFSET),
+			-1, 0, IIO_NO_MOD, 's', IIO_LE, 16, 16,
+			ST_TEMP_DEFAULT_OUT_L_ADDR),
+	IIO_CHAN_SOFT_TIMESTAMP(1)
+};
+
+static const struct st_sensors st_press_sensors[] = {
+	{
+		.wai = ST_PRESS_1_WAI_EXP,
+		.sensors_supported = {
+			[0] = LPS331AP_PRESS_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_press_channels,
+		.odr = {
+			.addr = ST_PRESS_1_ODR_ADDR,
+			.mask = ST_PRESS_1_ODR_MASK,
+			.odr_avl = {
+				{ 1, ST_PRESS_1_ODR_AVL_1HZ_VAL, },
+				{ 7, ST_PRESS_1_ODR_AVL_7HZ_VAL, },
+				{ 13, ST_PRESS_1_ODR_AVL_13HZ_VAL, },
+				{ 25, ST_PRESS_1_ODR_AVL_25HZ_VAL, },
+			},
+		},
+		.pw = {
+			.addr = ST_PRESS_1_PW_ADDR,
+			.mask = ST_PRESS_1_PW_MASK,
+			.value_on = ST_SENSORS_DEFAULT_POWER_ON_VALUE,
+			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
+		},
+		.fs = {
+			.addr = ST_PRESS_1_FS_ADDR,
+			.mask = ST_PRESS_1_FS_MASK,
+			.fs_avl = {
+				[0] = {
+					.num = ST_PRESS_FS_AVL_1260MB,
+					.value = ST_PRESS_1_FS_AVL_1260_VAL,
+					.gain = ST_PRESS_1_FS_AVL_1260_GAIN,
+					.gain2 = ST_PRESS_1_FS_AVL_TEMP_GAIN,
+				},
+			},
+		},
+		.bdu = {
+			.addr = ST_PRESS_1_BDU_ADDR,
+			.mask = ST_PRESS_1_BDU_MASK,
+		},
+		.drdy_irq = {
+			.addr = ST_PRESS_1_DRDY_IRQ_ADDR,
+			.mask = ST_PRESS_1_DRDY_IRQ_MASK,
+		},
+		.multi_read_bit = ST_PRESS_1_MULTIREAD_BIT,
+		.bootime = 2,
+	},
+};
+
+static int st_press_read_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *ch, int *val,
+							int *val2, long mask)
+{
+	int err;
+	struct st_sensor_data *pdata = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		err = st_sensors_read_info_raw(indio_dev, ch, val);
+		if (err < 0)
+			goto read_error;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+
+		switch (ch->type) {
+		case IIO_PRESSURE:
+			*val2 = pdata->current_fullscale->gain;
+			break;
+		case IIO_TEMP:
+			*val2 = pdata->current_fullscale->gain2;
+			break;
+		default:
+			err = -EINVAL;
+			goto read_error;
+		}
+
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_OFFSET:
+		switch (ch->type) {
+		case IIO_TEMP:
+			*val = 425;
+			*val2 = 10;
+			break;
+		default:
+			err = -EINVAL;
+			goto read_error;
+		}
+
+		return IIO_VAL_FRACTIONAL;
+	default:
+		return -EINVAL;
+	}
+
+read_error:
+	return err;
+}
+
+static ST_SENSOR_DEV_ATTR_SAMP_FREQ();
+static ST_SENSORS_DEV_ATTR_SAMP_FREQ_AVAIL();
+
+static struct attribute *st_press_attributes[] = {
+	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group st_press_attribute_group = {
+	.attrs = st_press_attributes,
+};
+
+static const struct iio_info press_info = {
+	.driver_module = THIS_MODULE,
+	.attrs = &st_press_attribute_group,
+	.read_raw = &st_press_read_raw,
+};
+
+#ifdef CONFIG_IIO_TRIGGER
+static const struct iio_trigger_ops st_press_trigger_ops = {
+	.owner = THIS_MODULE,
+	.set_trigger_state = ST_PRESS_TRIGGER_SET_STATE,
+};
+#define ST_PRESS_TRIGGER_OPS (&st_press_trigger_ops)
+#else
+#define ST_PRESS_TRIGGER_OPS NULL
+#endif
+
+int st_press_common_probe(struct iio_dev *indio_dev)
+{
+	int err;
+	struct st_sensor_data *pdata = iio_priv(indio_dev);
+
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &press_info;
+
+	err = st_sensors_check_device_support(indio_dev,
+				ARRAY_SIZE(st_press_sensors), st_press_sensors);
+	if (err < 0)
+		goto st_press_common_probe_error;
+
+	pdata->num_data_channels = ST_PRESS_NUMBER_DATA_CHANNELS;
+	pdata->multiread_bit = pdata->sensor->multi_read_bit;
+	indio_dev->channels = pdata->sensor->ch;
+	indio_dev->num_channels = ARRAY_SIZE(st_press_channels);
+
+	pdata->current_fullscale = (struct st_sensor_fullscale_avl *)
+						&pdata->sensor->fs.fs_avl[0];
+	pdata->odr = pdata->sensor->odr.odr_avl[0].hz;
+
+	err = st_sensors_init_sensor(indio_dev);
+	if (err < 0)
+		goto st_press_common_probe_error;
+
+	if (pdata->get_irq_data_ready(indio_dev) > 0) {
+		err = st_press_allocate_ring(indio_dev);
+		if (err < 0)
+			goto st_press_common_probe_error;
+
+		err = st_sensors_allocate_trigger(indio_dev,
+							ST_PRESS_TRIGGER_OPS);
+		if (err < 0)
+			goto st_press_probe_trigger_error;
+	}
+
+	err = iio_device_register(indio_dev);
+	if (err)
+		goto st_press_device_register_error;
+
+	return err;
+
+st_press_device_register_error:
+	if (pdata->get_irq_data_ready(indio_dev) > 0)
+		st_sensors_deallocate_trigger(indio_dev);
+st_press_probe_trigger_error:
+	if (pdata->get_irq_data_ready(indio_dev) > 0)
+		st_press_deallocate_ring(indio_dev);
+st_press_common_probe_error:
+	return err;
+}
+EXPORT_SYMBOL(st_press_common_probe);
+
+void st_press_common_remove(struct iio_dev *indio_dev)
+{
+	struct st_sensor_data *pdata = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	if (pdata->get_irq_data_ready(indio_dev) > 0) {
+		st_sensors_deallocate_trigger(indio_dev);
+		st_press_deallocate_ring(indio_dev);
+	}
+	iio_device_free(indio_dev);
+}
+EXPORT_SYMBOL(st_press_common_remove);
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics pressures driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
new file mode 100644
index 0000000..7cebcc7
--- /dev/null
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -0,0 +1,77 @@
+/*
+ * STMicroelectronics pressures driver
+ *
+ * Copyright 2013 STMicroelectronics Inc.
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
+
+#include <linux/iio/common/st_sensors.h>
+#include <linux/iio/common/st_sensors_i2c.h>
+#include "st_pressure.h"
+
+static int st_press_i2c_probe(struct i2c_client *client,
+						const struct i2c_device_id *id)
+{
+	struct iio_dev *indio_dev;
+	struct st_sensor_data *pdata;
+	int err;
+
+	indio_dev = iio_device_alloc(sizeof(*pdata));
+	if (indio_dev == NULL) {
+		err = -ENOMEM;
+		goto iio_device_alloc_error;
+	}
+
+	pdata = iio_priv(indio_dev);
+	pdata->dev = &client->dev;
+
+	st_sensors_i2c_configure(indio_dev, client, pdata);
+
+	err = st_press_common_probe(indio_dev);
+	if (err < 0)
+		goto st_press_common_probe_error;
+
+	return 0;
+
+st_press_common_probe_error:
+	iio_device_free(indio_dev);
+iio_device_alloc_error:
+	return err;
+}
+
+static int st_press_i2c_remove(struct i2c_client *client)
+{
+	st_press_common_remove(i2c_get_clientdata(client));
+
+	return 0;
+}
+
+static const struct i2c_device_id st_press_id_table[] = {
+	{ LPS331AP_PRESS_DEV_NAME },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, st_press_id_table);
+
+static struct i2c_driver st_press_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "st-press-i2c",
+	},
+	.probe = st_press_i2c_probe,
+	.remove = st_press_i2c_remove,
+	.id_table = st_press_id_table,
+};
+module_i2c_driver(st_press_driver);
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics pressures i2c driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
new file mode 100644
index 0000000..17a1490
--- /dev/null
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -0,0 +1,76 @@
+/*
+ * STMicroelectronics pressures driver
+ *
+ * Copyright 2013 STMicroelectronics Inc.
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
+
+#include <linux/iio/common/st_sensors.h>
+#include <linux/iio/common/st_sensors_spi.h>
+#include "st_pressure.h"
+
+static int st_press_spi_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct st_sensor_data *pdata;
+	int err;
+
+	indio_dev = iio_device_alloc(sizeof(*pdata));
+	if (indio_dev == NULL) {
+		err = -ENOMEM;
+		goto iio_device_alloc_error;
+	}
+
+	pdata = iio_priv(indio_dev);
+	pdata->dev = &spi->dev;
+
+	st_sensors_spi_configure(indio_dev, spi, pdata);
+
+	err = st_press_common_probe(indio_dev);
+	if (err < 0)
+		goto st_press_common_probe_error;
+
+	return 0;
+
+st_press_common_probe_error:
+	iio_device_free(indio_dev);
+iio_device_alloc_error:
+	return err;
+}
+
+static int st_press_spi_remove(struct spi_device *spi)
+{
+	st_press_common_remove(spi_get_drvdata(spi));
+
+	return 0;
+}
+
+static const struct spi_device_id st_press_id_table[] = {
+	{ LPS331AP_PRESS_DEV_NAME },
+	{},
+};
+MODULE_DEVICE_TABLE(spi, st_press_id_table);
+
+static struct spi_driver st_press_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "st-press-spi",
+	},
+	.probe = st_press_spi_probe,
+	.remove = st_press_spi_remove,
+	.id_table = st_press_id_table,
+};
+module_spi_driver(st_press_driver);
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics pressures spi driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5

