Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36779 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247AbbI1HaO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Sep 2015 03:30:14 -0400
Received: by pablk4 with SMTP id lk4so69871326pab.3
        for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2015 00:30:14 -0700 (PDT)
From: Suresh Rajashekara <sureshraj@google.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Suresh Rajashekara <sureshraj@google.com>
Subject: [PATCH] CHROMIUM: iio: Add Dyna-Image AP3223 ambient light and proximity driver
Date: Sun, 27 Sep 2015 22:00:01 -0700
Message-Id: <1443416401-20417-1-git-send-email-sureshraj@google.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Minimal implementation. This is based on the driver provided by
the vendor (which wasn't in the IIO framework). Authors of the
driver from the vendor included
* John Huang <john.huang@dyna-image.com>
* Templeton Tsai <templeton.tsai@dyna-image.com>
* Vic Lee <Vic_Lee@asus.com>

Signed-off-by: Suresh Rajashekara <sureshraj@google.com>
---
 .../devicetree/bindings/iio/light/ap3223.txt       |  18 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/light/Kconfig                          |  10 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/ap3223.c                         | 394 +++++++++++++++++++++
 drivers/iio/light/ap3223.h                         | 227 ++++++++++++
 6 files changed, 651 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ap3223.txt
 create mode 100644 drivers/iio/light/ap3223.c
 create mode 100644 drivers/iio/light/ap3223.h

diff --git a/Documentation/devicetree/bindings/iio/light/ap3223.txt b/Documentation/devicetree/bindings/iio/light/ap3223.txt
new file mode 100644
index 0000000..b255d27
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/ap3223.txt
@@ -0,0 +1,18 @@
+* Dyna Image AP3223 ambient light sensor and proximity sensor
+
+http://www.dyna-image.com/english/product/optical-sensor-detail.php?cpid=2&dpid=8
+
+Required properties:
+
+  - compatible : should be "dynaimage,ap3223"
+  - reg : the I2C address of the sensor
+
+Example:
+
+ap3223@1c {
+	compatible = "dynaimage,ap3223";
+	reg = <0x1c>;
+
+	pinctrl-0 = <&ap3223_pins>;
+	pinctrl-names = "default";
+};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 5f20add..704da45 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -46,6 +46,7 @@ digilent	Diglent, Inc.
 dlg	Dialog Semiconductor
 dlink	D-Link Corporation
 dmo	Data Modul AG
+dynaimage	Dyna-Image
 ebv	EBV Elektronik
 edt	Emerging Display Technologies
 elan	Elan Microelectronic Corp.
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index ae68c64..5255aa2 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -27,6 +27,16 @@ config AL3320A
 	 To compile this driver as a module, choose M here: the
 	 module will be called al3320a.
 
+config AP3223
+	tristate "AP3223 ambient light and proximity sensor"
+	depends on I2C
+	help
+	 Say Y here if you want to build a driver for the Dyna Image AP3223
+	 ambient light and proximity sensor.
+
+	 To compile this driver as a module, choose M here: the
+	 module will be called ap3223.
+
 config APDS9300
 	tristate "APDS9300 ambient light sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index b12a516..13a74f9 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -5,6 +5,7 @@
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ADJD_S311)		+= adjd_s311.o
 obj-$(CONFIG_AL3320A)		+= al3320a.o
+obj-$(CONFIG_AP3223)		+= ap3223.o
 obj-$(CONFIG_APDS9300)		+= apds9300.o
 obj-$(CONFIG_CM32181)		+= cm32181.o
 obj-$(CONFIG_CM3232)		+= cm3232.o
diff --git a/drivers/iio/light/ap3223.c b/drivers/iio/light/ap3223.c
new file mode 100644
index 0000000..55bbcdd
--- /dev/null
+++ b/drivers/iio/light/ap3223.c
@@ -0,0 +1,394 @@
+/*
+ * ap3223.c
+ *
+ * Copyright (C) 2015 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Note about the original authors:
+ *
+ * The driver for AP3223 was originally distributed by dyna image in a
+ * different framework. This driver uses code from that driver and converts
+ * it to iio framework. The non-iio driver from dyna image is not available
+ * online anywhere, so there is no reference for it here. However, that driver
+ * is also GPLv2. The following is part of the header found in that file
+ * (The GPL notice from the original header is removed)
+ *
+ * >> This file is part of the AP3223, AP3212C and AP3216C sensor driver.
+ * >> AP3426 is combined proximity and ambient light sensor.
+ * >> AP3216C is combined proximity, ambient light sensor and IRLED.
+ * >>
+ * >> Contact: John Huang <john.huang@dyna-image.com>
+ * >>	       Templeton Tsai <templeton.tsai@dyna-image.com>
+ *
+ * Another author initials mentioned in that file was just YC (and no name).
+ *
+ * Not sure for what kernel version the driver from dyna image was written for.
+ * Vic Lee <Vic_Lee@asus.com> made modifications to it to run on 3.14.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/of_gpio.h>
+#include <linux/timer.h>
+#include <linux/gpio.h>
+#include <linux/device.h>
+
+#include "ap3223.h"
+
+#define AP3223_DRV_NAME "ap3223"
+
+struct ap3223_data {
+	struct i2c_client *client;
+	u8 reg_cache[AP3223_NUM_CACHABLE_REGS];
+	int cali;
+};
+
+static u8 ap3223_regs[AP3223_NUM_CACHABLE_REGS] = {
+	0x00, 0x01, 0x02, 0x06, 0x0A,
+	0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+	0x10, 0x14, 0x1A, 0x1B, 0x1C,
+	0x1D, 0x20, 0x21, 0x22, 0x23,
+	0x24, 0x25, 0x26, 0x28, 0x29,
+	0x2A, 0x2B, 0x2C, 0x2D, 0x30,
+	0x32
+};
+
+static u8 init_reg_config[] = {
+	0x00, 0x03,
+	0x10, 0x20,
+	0X1A, 0xE8,
+	0x1B, 0x03,
+	0x1C, 0xD0,
+	0x1D, 0x07,
+	0x20, 0x04,
+	0x21, 0x03,
+	0x22, 0x01,
+	0x23, 0x03,
+	0x25, 0x0B,
+	0x2A, 0x64,
+	0x2C, 0xF4,
+	0x2D, 0x00
+};
+
+static int ap3223_range[] = { 65535, 16383, 4095, 1023 };
+
+#define FIND_REG_IDX(addr, regs, idx)	{ \
+	int i; \
+	for (i = 0; i < sizeof(ap3223_regs); i++) { \
+		if (addr == regs[i]) { \
+			idx = i; \
+			break; \
+		} \
+	} \
+}
+
+#define AP3223_LIGHT_CHANNEL {				\
+	.type = IIO_LIGHT,				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+}
+
+#define AP3223_PROXIMITY_CHANNEL {			\
+	.type = IIO_PROXIMITY,				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+}
+
+static const struct iio_chan_spec ap3223_channels[] = {
+	AP3223_LIGHT_CHANNEL,
+	AP3223_PROXIMITY_CHANNEL,
+};
+
+static int __ap3223_read_reg(struct i2c_client *client,
+			     u32 reg, u8 mask, u8 shift)
+{
+	struct ap3223_data *data = iio_priv(i2c_get_clientdata(client));
+	u8 idx = 0xff;
+
+	FIND_REG_IDX(reg, ap3223_regs, idx);
+
+	return (data->reg_cache[idx] & mask) >> shift;
+}
+
+static int __ap3223_write_reg(struct i2c_client *client,
+			      u32 reg, u8 mask, u8 shift, u8 val)
+{
+	struct ap3223_data *data = iio_priv(i2c_get_clientdata(client));
+	int ret = 0;
+	u8 tmp;
+	u8 idx = 0xff;
+
+	FIND_REG_IDX(reg, ap3223_regs, idx);
+
+	if (idx >= sizeof(ap3223_regs))
+		return -EINVAL;
+
+	tmp = data->reg_cache[idx];
+	tmp &= ~mask;
+	tmp |= val << shift;
+
+	ret = i2c_smbus_write_byte_data(client, reg, tmp);
+	if (!ret)
+		data->reg_cache[idx] = tmp;
+
+	return ret;
+}
+
+static int ap3223_get_mode(struct i2c_client *client)
+{
+	return __ap3223_read_reg(client, AP3223_REG_SYS_CONF,
+				 AP3223_REG_SYS_CONF_MASK,
+				 AP3223_REG_SYS_CONF_SHIFT);
+}
+
+static int ap3223_set_mode(struct i2c_client *client, int mode)
+{
+	return __ap3223_write_reg(client, AP3223_REG_SYS_CONF,
+				  AP3223_REG_SYS_CONF_MASK,
+				  AP3223_REG_SYS_CONF_SHIFT, mode);
+}
+
+static int ap3223_get_range(struct i2c_client *client)
+{
+	u8 idx = __ap3223_read_reg(client, AP3223_REG_ALS_CONF,
+				   AP3223_ALS_RANGE_MASK,
+				   AP3223_ALS_RANGE_SHIFT);
+	return ap3223_range[idx];
+}
+
+static int ap3223_set_range(struct i2c_client *client, int range)
+{
+	return __ap3223_write_reg(client, AP3223_REG_ALS_CONF,
+				  AP3223_ALS_RANGE_MASK,
+				  AP3223_ALS_RANGE_SHIFT, range);
+}
+
+static int ap3223_get_adc_value(struct i2c_client *client)
+{
+	unsigned int lsb, msb, val;
+	unsigned int tmp, range;
+	struct ap3223_data *data = iio_priv(i2c_get_clientdata(client));
+
+	lsb = i2c_smbus_read_byte_data(client, AP3223_REG_ALS_DATA_LOW);
+
+	if (lsb < 0)
+		return lsb;
+
+	msb = i2c_smbus_read_byte_data(client, AP3223_REG_ALS_DATA_HIGH);
+
+	if (msb < 0)
+		return msb;
+
+	range = ap3223_get_range(client);
+
+	tmp = (((msb << 8) | lsb) * range) >> 16;
+	tmp = tmp * data->cali / 100;
+	val = tmp;
+
+	return val;
+}
+
+static int ap3223_get_object(struct i2c_client *client)
+{
+	int val;
+
+	val = i2c_smbus_read_byte_data(client, AP3223_OBJ_COMMAND);
+	val &= AP3223_OBJ_MASK;
+
+	return val >> AP3223_OBJ_SHIFT;
+}
+
+/* Software Reset */
+static inline void ap3223_sw_reset(struct i2c_client *client)
+{
+	i2c_smbus_write_byte_data(client, 0x0, 0x4);
+}
+
+static int ap3223_init_client(struct i2c_client *client)
+{
+	struct ap3223_data *data = iio_priv(i2c_get_clientdata(client));
+	int i;
+
+	dev_dbg(&client->dev, "AP3223 : Initializing Client ..\n");
+
+	/* Read all the registers once to fill the cache.
+	 * Even if one of the read fails, we consider the init failed */
+	for (i = 0; i < sizeof(ap3223_regs); i++) {
+		int v = i2c_smbus_read_byte_data(client, ap3223_regs[i]);
+
+		if (v < 0)
+			return -ENODEV;
+
+		data->reg_cache[i] = v;
+	}
+
+	/* set defaults */
+	ap3223_set_range(client, AP3223_ALS_RANGE_0);
+	ap3223_set_mode(data->client, AP3223_SYS_DEV_DOWN);
+
+	return 0;
+}
+
+static int ap3223_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int *val,
+			   int *val2, long mask)
+{
+	struct ap3223_data *data = iio_priv(indio_dev);
+
+	switch (chan->type) {
+	case IIO_LIGHT:
+		switch (mask) {
+		case IIO_CHAN_INFO_RAW:
+			if (ap3223_get_mode(data->client) ==
+			    AP3223_SYS_DEV_DOWN) {
+				dev_err(&indio_dev->dev,
+					"Please power up first\n");
+				return -EINVAL;
+			}
+			*val = ap3223_get_adc_value(data->client);
+			return IIO_VAL_INT;
+		}
+		break;
+
+	case IIO_PROXIMITY:
+		switch (mask) {
+		case IIO_CHAN_INFO_RAW:
+			*val = ap3223_get_object(data->client);
+			dev_info(&data->client->dev,
+				 "%s\n", *val ? "Object Near" : "Object Far");
+			return IIO_VAL_INT;
+		}
+		break;
+
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
+static const struct iio_info ap3223_info = {
+	.driver_module  = THIS_MODULE,
+	.read_raw       = ap3223_read_raw,
+};
+
+static void ap3223_init_reg_config(struct i2c_client *client)
+{
+	int i;
+
+	for (i = 0; i < sizeof(init_reg_config); i += 2) {
+		__ap3223_write_reg(client, init_reg_config[i], 0xff,
+					 0, init_reg_config[i + 1]);
+	}
+}
+
+static int ap3223_init(struct ap3223_data *data)
+{
+	struct i2c_client *client = data->client;
+	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct iio_dev *indio_dev = i2c_get_clientdata(data->client);
+	int err = 0;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE)) {
+		err = -EIO;
+		goto exit_free_gpio;
+	}
+
+	ap3223_sw_reset(client);
+
+	err = ap3223_init_client(client);
+	if (err)
+		goto exit_free;
+
+	ap3223_init_reg_config(client);
+
+	dev_info(&client->dev, "%s : driver enabled\n", AP3223_DRV_NAME);
+
+	return 0;
+
+exit_free:
+	devm_iio_device_free(&client->dev, indio_dev);
+
+exit_free_gpio:
+	return err;
+}
+
+static int ap3223_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct ap3223_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+
+	data->cali = AP3223_DEFAULT_CAL;
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->info = &ap3223_info;
+	indio_dev->name = AP3223_DRV_NAME;
+	indio_dev->channels = ap3223_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ap3223_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = ap3223_init(data);
+	if (ret < 0) {
+		dev_err(&client->dev, "ap3223 chip init failed\n");
+		return ret;
+	}
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static int ap3223_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct ap3223_data *data = iio_priv(indio_dev);
+
+	ap3223_sw_reset(data->client);
+	ap3223_set_mode(data->client, 0);
+
+	devm_iio_device_unregister(&client->dev, indio_dev);
+	devm_iio_device_free(&client->dev, indio_dev);
+
+	return 0;
+}
+
+static const struct i2c_device_id ap3223_id[] = {
+	{AP3223_DRV_NAME, 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ap3223_id);
+
+static struct i2c_driver ap3223_driver = {
+	.driver = {
+		.name = AP3223_DRV_NAME,
+		.owner = THIS_MODULE,
+	},
+	.probe          = ap3223_probe,
+	.remove         = ap3223_remove,
+	.id_table       = ap3223_id,
+};
+
+module_i2c_driver(ap3223_driver);
+
+MODULE_AUTHOR("Suresh Rajashekara <sureshraj@google.com>");
+MODULE_DESCRIPTION("AP3223 Ambient Light and Proximity Sensor Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/light/ap3223.h b/drivers/iio/light/ap3223.h
new file mode 100644
index 0000000..0cc88e4
--- /dev/null
+++ b/drivers/iio/light/ap3223.h
@@ -0,0 +1,227 @@
+/*
+ * ap3223.h
+ *
+ * Copyright (C) 2015 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Note about the original authors:
+ *
+ * The driver for AP3223 was originally distributed by dyna image in a
+ * different framework. This driver uses code from that driver and converts
+ * it to iio framework. The non-iio driver from dyna image is not available
+ * online anywhere, so there is no reference for it here. However, that driver
+ * is also GPLv2. The following is part of the header found in that file
+ * (The GPL notice from the original header is removed)
+ *
+ * >> This file is part of the AP3223, AP3212C and AP3216C sensor driver.
+ * >> AP3426 is combined proximity and ambient light sensor.
+ * >> AP3216C is combined proximity, ambient light sensor and IRLED.
+ * >>
+ * >> Contact: John Huang <john.huang@dyna-image.com>
+ * >>	       Templeton Tsai <templeton.tsai@dyna-image.com>
+ *
+ * Another author initials mentioned in that file was just YC (and no name).
+ *
+ * Not sure for what kernel version the driver from dyna image was written for.
+ * Vic Lee <Vic_Lee@asus.com> made modifications to it to run on 3.14.
+ */
+
+#ifndef __AP3223_H__
+#define __AP3223_H__
+
+#include <linux/ioctl.h>
+
+#define AP3223_SUCCESS					0
+#define AP3223_ERR_I2C					-1
+#define AP3223_ERR_STATUS				-3
+#define AP3223_ERR_SETUP_FAILURE			-4
+#define AP3223_ERR_GETGSENSORDATA			-5
+#define AP3223_ERR_IDENTIFICATION			-6
+
+
+#define AP3223_NUM_CACHABLE_REGS	31
+
+/* No adjustment to lux value reading */
+#define AP3223_DEFAULT_CAL		100
+
+/* ap3223 control registers */
+#define AP3223_REG_SYS_CONF		0x00
+#define AP3223_REG_SYS_CONF_SHIFT	(0)
+#define AP3223_REG_SYS_CONF_MASK	0x07
+
+#define AP3223_REG_SYS_INTSTATUS	0x01
+#define AP3223_REG_SYS_INT_SHIFT	(0)
+#define AP3223_REG_SYS_INT_PS_SHIFT	(1)
+#define AP3223_REG_SYS_INT_LS_SHIFT	(0)
+#define AP3223_REG_SYS_INT_MASK		0x03
+#define AP3223_REG_SYS_INT_PMASK	0x02
+#define AP3223_REG_SYS_INT_AMASK	0x01
+
+#define AP3223_OBJ_COMMAND	0x01
+#define AP3223_OBJ_MASK		0x10
+#define AP3223_OBJ_SHIFT	(4)
+
+#define AP3223_REG_SYS_INTCTRL	   0x02
+#define AP3223_REG_SYS_WAITTIME    0x06
+
+/* ap3223 data registers */
+#define AP3223_REG_IR_DATA_LOW		0x0A
+#define AP3223_REG_IR_DATA_LOW_SHIFT	(0)
+#define AP3223_REG_IR_DATA_LOW_MASK	0xFF
+
+#define AP3223_REG_IR_DATA_HIGH		0x0B
+#define AP3223_REG_IR_DATA_HIGH_SHIFT	(0)
+#define AP3223_REG_IR_DATA_HIGH_MASK	0x03
+
+#define AP3223_REG_ALS_DATA_LOW    0x0C
+#define AP3223_REG_ALS_DATA_HIGH   0x0D
+
+#define AP3223_REG_PS_DATA_LOW		0x0E
+#define AP3223_REG_PS_DATA_LOW_SHIFT	(0)
+#define	AL3223_REG_PS_DATA_LOW_MASK	0xFF
+#define AP3223_REG_PS_DATA_HIGH		0x0F
+#define AP3223_REG_PS_DATA_HIGH_SHIFT	(0)
+#define	AL3223_REG_PS_DATA_HIGH_MASK	0x03
+
+#define AP3223_REG_ALS_CONF		   0x10	/*ALS GAIN */
+
+#define AP3223_REG_ALS_PERSIS		0x14
+#define AP3223_REG_ALS_PERSIS_SHIFT	(0)
+#define AP3223_REG_ALS_PERSIS_MASK	0x3F
+/* #define AP3223_REG_ALS_CAL		  0x19 */
+
+#define AP3223_REG_ALS_THDL_L		0x1A
+#define AP3223_REG_ALS_THDL_L_SHIFT	(0)
+#define AP3223_REG_ALS_THDL_L_MASK	0xFF
+
+#define AP3223_REG_ALS_THDL_H		0x1B
+#define AP3223_REG_ALS_THDL_H_SHIFT	(0)
+#define AP3223_REG_ALS_THDL_H_MASK	0xFF
+
+#define AP3223_REG_ALS_THDH_L		0x1C
+#define AP3223_REG_ALS_THDH_L_SHIFT	(0)
+#define AP3223_REG_ALS_THDH_L_MASK	0xFF
+
+#define AP3223_REG_ALS_THDH_H		0x1D
+#define AP3223_REG_ALS_THDH_H_SHIFT	(0)
+#define AP3223_REG_ALS_THDH_H_MASK	0xFF
+
+
+/* ap3223 PS CONFIG registers */
+#define AP3223_REG_PS_CONF		0x20	/*PS GAIN */
+#define AP3223_REG_PS_CONF_SHIFT	(2)
+#define AP3223_REG_PS_CONF_MASK		0x0C
+
+#define AP3223_REG_PS_LEDD		0x21	/*PS LED DRIVER */
+#define AP3223_REG_PS_LEDD_SHIFT	(0)
+#define AP3223_REG_PS_LEDD_MASK		0x03
+
+#define AP3223_REG_PS_IFORM		0x22	/* PS INT Mode */
+
+#define AP3223_REG_PS_MEAN		0x23
+#define AP3223_REG_PS_MEAN_SHIFT	(0)
+#define AP3223_REG_PS_MEAN_MASK		0x03
+
+#define AP3223_REG_PS_SMARTINT	   0x24	/* PS Smart INT for low power */
+#define AP3223_REG_PS_INTEGR	   0x25
+#define AP3223_REG_PS_PERSIS	   0x26
+#define AP3223_REG_PS_PERSIS_SHIFT	(0)
+#define AP3223_REG_PS_PERSIS_MASK	0x3F
+#define AP3223_REG_PS_CAL_L		0x28
+#define AP3223_REG_PS_CAL_L_SHIFT	(0)
+#define AP3223_REG_PS_CAL_L_MASK	0xFF
+#define AP3223_REG_PS_CAL_H		0x29
+#define AP3223_REG_PS_CAL_H_SHIFT	(0)
+#define AP3223_REG_PS_CAL_H_MASK	0x01
+
+#define AP3223_REG_PS_THDL_L		0x2A
+#define AP3223_REG_PS_THDL_L_SHIFT	(0)
+#define AP3223_REG_PS_THDL_L_MASK	0xFF
+
+#define AP3223_REG_PS_THDL_H		0x2B
+#define AP3223_REG_PS_THDL_H_SHIFT	(0)
+#define AP3223_REG_PS_THDL_H_MASK	0x03
+
+#define AP3223_REG_PS_THDH_L		0x2C
+#define AP3223_REG_PS_THDH_L_SHIFT	(0)
+#define AP3223_REG_PS_THDH_L_MASK	0xFF
+
+#define AP3223_REG_PS_THDH_H		0x2D
+#define AP3223_REG_PS_THDH_H_SHIFT	(0)
+#define AP3223_REG_PS_THDH_H_MASK	0x03
+
+
+/* SYSTEM MODE (AP3223_REG_SYS_CONF) */
+#define	AP3223_SYS_DEV_DOWN		0x00
+#define	AP3223_SYS_ALS_ENABLE		0x01
+#define	AP3223_SYS_PS_ENABLE		0x02
+#define	AP3223_SYS_ALS_PS_ENABLE	0x03
+#define	AP3223_SYS_DEV_RESET		0x04
+
+/* INT FLAG BIT MASK */
+#define	AP3223_SYS_ALS_INT_TRI	   0x01
+#define	AP3223_SYS_PS_INT_TRI	   0x02
+#define	AP3223_SYS_PS_INT_OBJ	   0x10
+#define	AP3223_SYS_PS_INT_IROV	   0x20
+
+/* INT CLEAN Mode */
+#define	AP3223_SYS_ICLEAN_AUTO	   0x00
+#define	AP3223_SYS_ICLEAN_MANUAL   0x01
+
+/* ALS CONFIG */
+#define AP3223_ALS_RANGE_0	0x00	/* Full range 32768 lux(0.5lux/count) */
+#define AP3223_ALS_RANGE_1	0x01	/* Full range 8192 lux */
+#define AP3223_ALS_RANGE_2	0x02	/* Full range 2048 lux */
+#define AP3223_ALS_RANGE_3	0x03	/* Full range 512 lux */
+#define AP3223_ALS_RANGE_MASK	0x30
+#define AP3223_ALS_RANGE_SHIFT	(4)
+#define AP3223_ALS_PERSIST_MASK	0x0F
+
+/* PS CONFIG */
+#define AP3223_PS_GAIN_1		0x00	/* PS resulation * 1 */
+#define AP3223_PS_GAIN_2		0x01	/* PS resulation * 2 */
+#define AP3223_PS_GAIN_4		0x02	/* PS resulation * 4 */
+#define AP3223_PS_GAIN_8		0x03	/* PS resulation * 8 */
+#define AP3223_PS_PERSIST_1		0x00
+#define AP3223_PS_PERSIST_2		0x01
+#define AP3223_PS_PERSIST_4		0x02
+#define AP3223_PS_PERSIST_8		0x03
+
+/* PS LED Control */
+#define AP3223_PS_LED_P0		0x00	/* 0 puls */
+#define AP3223_PS_LED_P1		0x01	/* 1 puls (default) */
+#define AP3223_PS_LED_P2		0x02	/* 2 puls  */
+#define AP3223_PS_LED_P3		0x03	/* 3 puls  */
+#define AP3223_PS_DEIVER_167		0x00	/* 16.7% */
+#define AP3223_PS_DEIVER_333		0x01	/* 33.3% */
+#define AP3223_PS_DEIVER_667		0x02	/* 66.7% */
+#define AP3223_PS_DEIVER_1000		0x03	/* 100% (default) */
+
+/* PS MEAN */
+#define AP3223_PS_MEAN_0		0x00	/* 5ms @2T */
+#define AP3223_PS_MEAN_1		0x01	/* 9.6ms @2T */
+#define AP3223_PS_MEAN_2		0x02	/* 14.1ms @2T */
+#define AP3223_PS_MEAN_3		0x03	/* 18.7ms @2T */
+
+#define DISABLE				0x00
+#define ENABLE				0x01
+
+/* PS Engineering Registers */
+#define AP3223_REG_PS_DC_1		0x30	/* Only in Engineering chip,
+						couldn't find in datasheet */
+#define AP3223_REG_PS_DC_1_SHIFT	(0)
+#define AP3223_REG_PS_DC_1_MASK		0xFF
+#define AP3223_REG_PS_DC_2		0x32	/* Only in Engineering chip,
+						couldn't find in datasheet */
+#define AP3223_REG_PS_DC_2_SHIFT	(0)
+#define AP3223_REG_PS_DC_2_MASK		0xFF
+
+#endif /* __AP3223_H__ */
-- 
2.6.0.rc2.230.g3dd15c0

