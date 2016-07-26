Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36443 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161145AbcGZVYB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jul 2016 17:24:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id x83so3595831wma.3
        for <linux-iio@vger.kernel.org>; Tue, 26 Jul 2016 14:24:00 -0700 (PDT)
From: Jelle van der Waa <jelle@vdwaa.nl>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Jelle van der Waa <jelle@vdwaa.nl>
Subject: [PATCH v3] iio: accel: add support for the Domintech DMARD09 3-axis accelerometer
Date: Tue, 26 Jul 2016 23:23:48 +0200
Message-Id: <20160726212348.21784-2-jelle@vdwaa.nl>
In-Reply-To: <20160726212348.21784-1-jelle@vdwaa.nl>
References: <20160726212348.21784-1-jelle@vdwaa.nl>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Minimal implementation of an IIO driver for the Domintech DMARD09 3-axis
accelerometer. Only supports reading the x,y,z axes at the moment.

Implementation based on the Android driver from the Acer Liquid E2
kernel sources.

Signed-off-by: Jelle van der Waa <jelle@vdwaa.nl>

---
Changes in v2:
  - Use ARRAY_SIZE instead of the #define DMARD09_AXES_NUM
  - Use a function-like macro to generate the channel structs
  - Remove duplicate 3-axis in driver description
  - Don't initialize the u8 buf
  - Use devm_iio_device_register and remove the now unrequired
    dmard09_remove.
  - Remove device from dmard09_data struct and use the client member to retrieve
    the device.
  - Describe the read strategy of the read_raw function
  - Simplify reading the X, Y, Z axis, by introducing DMARD09_AXIS_N_OFFSET,
    which removes the required if statements.
  - Log the _STAT address in the dev_error in the dmard09_read_raw function.
---
 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/accel/Kconfig                          |  10 ++
 drivers/iio/accel/Makefile                         |   1 +
 drivers/iio/accel/dmard09.c                        | 157 +++++++++++++++++++++
 5 files changed, 170 insertions(+)
 create mode 100644 drivers/iio/accel/dmard09.c

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index 53987449..e259b19 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -38,6 +38,7 @@ dallas,ds4510		CPU Supervisor with Nonvolatile Memory and Programmable I/O
 dallas,ds75		Digital Thermometer and Thermostat
 dlg,da9053		DA9053: flexible system level PMIC with multicore support
 dlg,da9063		DA9063: system PMIC for quad-core application processors
+domintech,dmard09	DMARD09: 3-axis Accelerometer
 epson,rx8010		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
 epson,rx8025		High-Stability. I2C-Bus INTERFACE REAL TIME CLOCK MODULE
 epson,rx8581		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 2c2500d..d670d32 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -75,6 +75,7 @@ digilent	Diglent, Inc.
 dlg	Dialog Semiconductor
 dlink	D-Link Corporation
 dmo	Data Modul AG
+domintech Domintech Technology Co. Ltd
 dptechnics	DPTechnics
 dragino	Dragino Technology Co., Limited
 ea	Embedded Artists AB
diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index e4a758c..4b886fb 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -40,6 +40,16 @@ config BMC150_ACCEL_SPI
 	tristate
 	select REGMAP_SPI
 
+config DMARD09
+	tristate "Domintech DMARD09 3-axis Accelerometer Driver"
+	depends on I2C
+	help
+	  Say yes here to get support for the Domintech DMARD09 3-axis
+	  accelerometer.
+
+	  Choosing M will build the driver as a module. If so, the module
+	  will be called dmard09.
+
 config HID_SENSOR_ACCEL_3D
 	depends on HID_SENSOR_HUB
 	select IIO_BUFFER
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 71b6794..b1022a0 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_BMA180) += bma180.o
 obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
 obj-$(CONFIG_BMC150_ACCEL_I2C) += bmc150-accel-i2c.o
 obj-$(CONFIG_BMC150_ACCEL_SPI) += bmc150-accel-spi.o
+obj-$(CONFIG_DMARD09) += dmard09.o
 obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
 obj-$(CONFIG_KXCJK1013) += kxcjk-1013.o
 obj-$(CONFIG_KXSD9)	+= kxsd9.o
diff --git a/drivers/iio/accel/dmard09.c b/drivers/iio/accel/dmard09.c
new file mode 100644
index 0000000..d3a28f9
--- /dev/null
+++ b/drivers/iio/accel/dmard09.c
@@ -0,0 +1,157 @@
+/*
+ * IIO driver for the 3-axis accelerometer Domintech DMARD09.
+ *
+ * Copyright (c) 2016, Jelle van der Waa <jelle@vdwaa.nl>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <asm/unaligned.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+
+#define DMARD09_DRV_NAME	"dmard09"
+
+#define DMARD09_REG_CHIPID      0x18
+#define DMARD09_REG_STAT	0x0A
+#define DMARD09_REG_X		0x0C
+#define DMARD09_REG_Y		0x0E
+#define DMARD09_REG_Z		0x10
+#define DMARD09_CHIPID		0x95
+
+#define DMARD09_BUF_LEN 8
+#define DMARD09_AXIS_X 0
+#define DMARD09_AXIS_Y 1
+#define DMARD09_AXIS_Z 2
+#define DMARD09_AXIS_X_OFFSET ((DMARD09_AXIS_X + 1) * 2)
+#define DMARD09_AXIS_Y_OFFSET ((DMARD09_AXIS_Y + 1 )* 2)
+#define DMARD09_AXIS_Z_OFFSET ((DMARD09_AXIS_Z + 1) * 2)
+
+struct dmard09_data {
+	struct i2c_client *client;
+};
+
+#define DMARD09_CHANNEL(_axis, offset) {			\
+	.type = IIO_ACCEL,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.modified = 1,						\
+	.address = offset,					\
+	.channel2 = IIO_MOD_##_axis,				\
+}
+
+static const struct iio_chan_spec dmard09_channels[] = {
+	DMARD09_CHANNEL(X, DMARD09_AXIS_X_OFFSET),
+	DMARD09_CHANNEL(Y, DMARD09_AXIS_Y_OFFSET),
+	DMARD09_CHANNEL(Z, DMARD09_AXIS_Z_OFFSET),
+};
+
+static int dmard09_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct dmard09_data *data = iio_priv(indio_dev);
+	u8 buf[DMARD09_BUF_LEN];
+	int ret;
+	s16 accel;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		/*
+		 * Read from the DMAR09_REG_STAT register, since the chip
+		 * caches reads from the individual X, Y, Z registers.
+		 */
+		ret = i2c_smbus_read_i2c_block_data(data->client,
+						    DMARD09_REG_STAT,
+						    DMARD09_BUF_LEN, buf);
+		if (ret < 0) {
+			dev_err(&data->client->dev, "Error reading reg %d\n",
+				DMARD09_REG_STAT);
+			return ret;
+		}
+
+		accel = get_unaligned_le16(&buf[chan->address]);
+
+		/* Remove lower 3 bits and sign extend */
+		accel <<= 4;
+		accel >>= 7;
+
+		*val = accel;
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info dmard09_info = {
+	.driver_module	= THIS_MODULE,
+	.read_raw	= dmard09_read_raw,
+};
+
+static int dmard09_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	int ret;
+	struct iio_dev *indio_dev;
+	struct dmard09_data *data;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev) {
+		dev_err(&client->dev, "iio allocation failed\n");
+		return -ENOMEM;
+	}
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+
+	ret = i2c_smbus_read_byte_data(data->client, DMARD09_REG_CHIPID);
+	if (ret < 0) {
+		dev_err(&client->dev, "Error reading chip id %d\n", ret);
+		return ret;
+	}
+
+	if (ret != DMARD09_CHIPID) {
+		dev_err(&client->dev, "Invalid chip id %d\n", ret);
+		return -ENODEV;
+	}
+
+	i2c_set_clientdata(client, indio_dev);
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->name = DMARD09_DRV_NAME;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = dmard09_channels;
+	indio_dev->num_channels = ARRAY_SIZE(dmard09_channels);
+	indio_dev->info = &dmard09_info;
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id dmard09_id[] = {
+	{ "dmard09", 0},
+	{ },
+};
+
+MODULE_DEVICE_TABLE(i2c, dmard09_id);
+
+static struct i2c_driver dmard09_driver = {
+	.driver = {
+		.name = DMARD09_DRV_NAME
+	},
+	.probe = dmard09_probe,
+	.id_table = dmard09_id,
+};
+
+module_i2c_driver(dmard09_driver);
+
+MODULE_AUTHOR("Jelle van der Waa <jelle@vdwaa.nl>");
+MODULE_DESCRIPTION("DMARD09 3-axis accelerometer driver");
+MODULE_LICENSE("GPL");
-- 
2.9.0

