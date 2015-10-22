Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56788 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756802AbbJVMpo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 22 Oct 2015 08:45:44 -0400
From: Teodora Baluta <teodora.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	daniel.baluta@intel.com, teodora.baluta@intel.com,
	dan.carpenter@oracle.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: accel: add support for Memsic MXC6255XC sensor
Date: Thu, 22 Oct 2015 15:44:50 +0300
Message-Id: <1445517890-24938-1-git-send-email-teodora.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds a minimal implementation for the Memsic MXC6255XC
orientation sensing accelerometer. The supported operations are reading
raw acceleration values for X/Y axis that can be scaled using the
exposed scale.

Signed-off-by: Teodora Baluta <teodora.baluta@intel.com>
---
Changes since v1:

- remove scale_available attribute
- use chan->address instead
- drop _AXIS_TO_REG macro
- put register address in .address field of MXC6255_CHANNEL macro
- check chip id
- use "as follows" instead of "as following"

 drivers/iio/accel/Kconfig   |  11 +++
 drivers/iio/accel/Makefile  |   1 +
 drivers/iio/accel/mxc6255.c | 199 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 211 insertions(+)
 create mode 100644 drivers/iio/accel/mxc6255.c

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 969428d..75ac087 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -158,6 +158,17 @@ config MXC4005
 	  To compile this driver as a module, choose M. The module will be
 	  called mxc4005.
 
+config MXC6255
+	tristate "Memsic MXC6255 Orientation Sensing Accelerometer Driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say yes here to build support for the Memsic MXC6255 Orientation
+	  Sensing Accelerometer Driver.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called mxc6255.
+
 config STK8312
 	tristate "Sensortek STK8312 3-Axis Accelerometer Driver"
 	depends on I2C
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 7925f16..525ed52 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_MMA9551)		+= mma9551.o
 obj-$(CONFIG_MMA9553)		+= mma9553.o
 
 obj-$(CONFIG_MXC4005)		+= mxc4005.o
+obj-$(CONFIG_MXC6255)		+= mxc6255.o
 
 obj-$(CONFIG_STK8312)		+= stk8312.o
 obj-$(CONFIG_STK8BA50)		+= stk8ba50.o
diff --git a/drivers/iio/accel/mxc6255.c b/drivers/iio/accel/mxc6255.c
new file mode 100644
index 0000000..b853ff0
--- /dev/null
+++ b/drivers/iio/accel/mxc6255.c
@@ -0,0 +1,199 @@
+/*
+ * MXC6255 - MEMSIC orientation sensing accelerometer
+ *
+ * Copyright (c) 2015, Intel Corporation.
+ *
+ * This file is subject to the terms and conditions of version 2 of
+ * the GNU General Public License.  See the file COPYING in the main
+ * directory of this archive for more details.
+ *
+ * IIO driver for MXC6255 (7-bit I2C slave address 0x15).
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/iio/iio.h>
+#include <linux/delay.h>
+#include <linux/acpi.h>
+#include <linux/regmap.h>
+#include <linux/iio/sysfs.h>
+
+#define MXC6255_DRV_NAME		"mxc6255"
+#define MXC6255_REGMAP_NAME		"mxc6255_regmap"
+
+#define MXC6255_REG_XOUT		0x00
+#define MXC6255_REG_YOUT		0x01
+#define MXC6255_REG_CHIP_ID		0x08
+
+#define MXC6255_CHIP_ID			0x05
+
+/*
+ * MXC6255 has only one measurement range: +/- 2G.
+ * The acceleration output is an 8-bit value.
+ *
+ * Scale is calculated as follows:
+ * (2 + 2) * 9.80665 / (2^8 - 1) = 0.153829
+ *
+ * Scale value for +/- 2G measurement range
+ */
+#define MXC6255_SCALE			153829
+
+enum mxc6255_axis {
+	AXIS_X,
+	AXIS_Y,
+};
+
+struct mxc6255_data {
+	struct i2c_client *client;
+	struct regmap *regmap;
+};
+
+static int mxc6255_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct mxc6255_data *data = iio_priv(indio_dev);
+	unsigned int reg;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_read(data->regmap, chan->address, &reg);
+		if (ret < 0) {
+			dev_err(&data->client->dev,
+				"Error reading reg %lu\n", chan->address);
+			return ret;
+		}
+
+		*val = sign_extend32(reg, 7);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		*val2 = MXC6255_SCALE;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info mxc6255_info = {
+	.driver_module	= THIS_MODULE,
+	.read_raw	= mxc6255_read_raw,
+};
+
+#define MXC6255_CHANNEL(_axis, reg) {				\
+	.type = IIO_ACCEL,					\
+	.modified = 1,						\
+	.channel2 = IIO_MOD_##_axis,				\
+	.address = reg,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+}
+
+static const struct iio_chan_spec mxc6255_channels[] = {
+	MXC6255_CHANNEL(X, MXC6255_REG_XOUT),
+	MXC6255_CHANNEL(Y, MXC6255_REG_YOUT),
+};
+
+static bool mxc6255_is_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MXC6255_REG_XOUT:
+	case MXC6255_REG_YOUT:
+	case MXC6255_REG_CHIP_ID:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config mxc6255_regmap_config = {
+	.name = MXC6255_REGMAP_NAME,
+
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.readable_reg = mxc6255_is_readable_reg,
+};
+
+static int mxc6255_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct mxc6255_data *data;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	unsigned int chip_id;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_i2c(client, &mxc6255_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Error initializing regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	data->regmap = regmap;
+
+	indio_dev->name = MXC6255_DRV_NAME;
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->channels = mxc6255_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mxc6255_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &mxc6255_info;
+
+	ret = regmap_read(data->regmap, MXC6255_REG_CHIP_ID, &chip_id);
+	if (ret < 0) {
+		dev_err(&client->dev, "Error reading chip id %d\n", ret);
+		return ret;
+	}
+
+	if (chip_id != MXC6255_CHIP_ID) {
+		dev_err(&client->dev, "Invalid chip id %x\n", chip_id);
+		return -ENODEV;
+	}
+
+	dev_dbg(&client->dev, "Chip id %x\n", chip_id);
+
+	ret = devm_iio_device_register(&client->dev, indio_dev);
+	if (ret < 0) {
+		dev_err(&client->dev, "Could not register IIO device\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct acpi_device_id mxc6255_acpi_match[] = {
+	{"MXC6255",	0},
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, mxc6255_acpi_match);
+
+static const struct i2c_device_id mxc6255_id[] = {
+	{"mxc6255",	0},
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mxc6255_id);
+
+static struct i2c_driver mxc6255_driver = {
+	.driver = {
+		.name = MXC6255_DRV_NAME,
+		.acpi_match_table = ACPI_PTR(mxc6255_acpi_match),
+	},
+	.probe		= mxc6255_probe,
+	.id_table	= mxc6255_id,
+};
+
+module_i2c_driver(mxc6255_driver);
+
+MODULE_AUTHOR("Teodora Baluta <teodora.baluta@intel.com>");
+MODULE_DESCRIPTION("MEMSIC MXC6255 orientation sensing accelerometer driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

