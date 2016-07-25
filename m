Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35340 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878AbcGYPVa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jul 2016 11:21:30 -0400
From: Aleksei Mamlin <mamlinav@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Aleksei Mamlin <mamlinav@gmail.com>
Subject: [PATCH v2 2/2] iio: accel: Add support for Domintech DMARD06 accelerometer
Date: Mon, 25 Jul 2016 18:21:18 +0300
Message-Id: <1469460078-6460-3-git-send-email-mamlinav@gmail.com>
In-Reply-To: <1469460078-6460-1-git-send-email-mamlinav@gmail.com>
References: <1469460078-6460-1-git-send-email-mamlinav@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch add support for Domintech DMARD05, DMARD06 and DMARD07
accelerometers.

Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
---
 .../devicetree/bindings/iio/accel/dmard06.txt      |  19 ++
 drivers/iio/accel/Kconfig                          |  11 +
 drivers/iio/accel/Makefile                         |   1 +
 drivers/iio/accel/dmard06.c                        | 241 +++++++++++++++++++++
 4 files changed, 272 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/dmard06.txt
 create mode 100644 drivers/iio/accel/dmard06.c

diff --git a/Documentation/devicetree/bindings/iio/accel/dmard06.txt b/Documentation/devicetree/bindings/iio/accel/dmard06.txt
new file mode 100644
index 0000000..ce105a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/dmard06.txt
@@ -0,0 +1,19 @@
+Device tree bindings for Domintech DMARD05, DMARD06, DMARD07 accelerometers
+
+Required properties:
+ - compatible		: Should be "domintech,dmard05"
+				 or "domintech,dmard06"
+				 or "domintech,dmard07"
+ - reg			: I2C address of the chip. Should be 0x1c
+
+Example:
+	&i2c1 {
+		/* ... */
+
+		accelerometer@1c {
+			compatible = "domintech,dmard06";
+			reg = <0x1c>;
+		};
+
+		/* ... */
+	};
diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 89d7820..ee57eff 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -50,6 +50,17 @@ config BMC150_ACCEL_SPI
 	tristate
 	select REGMAP_SPI
 
+config DMARD06
+	tristate "Domintech DMARD06 Digital Accelerometer Driver"
+	depends on OF || COMPILE_TEST
+	depends on I2C
+	help
+	  Say yes here to build support for the Domintech low-g tri-axial
+	  digital accelerometers: DMARD05, DMARD06, DMARD07.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called dmard06.
+
 config HID_SENSOR_ACCEL_3D
 	depends on HID_SENSOR_HUB
 	select IIO_BUFFER
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 6cedbec..24eba65 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_BMA220) += bma220_spi.o
 obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
 obj-$(CONFIG_BMC150_ACCEL_I2C) += bmc150-accel-i2c.o
 obj-$(CONFIG_BMC150_ACCEL_SPI) += bmc150-accel-spi.o
+obj-$(CONFIG_DMARD06)	+= dmard06.o
 obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
 obj-$(CONFIG_KXCJK1013) += kxcjk-1013.o
 obj-$(CONFIG_KXSD9)	+= kxsd9.o
diff --git a/drivers/iio/accel/dmard06.c b/drivers/iio/accel/dmard06.c
new file mode 100644
index 0000000..656ca8e
--- /dev/null
+++ b/drivers/iio/accel/dmard06.c
@@ -0,0 +1,241 @@
+/*
+ * IIO driver for Domintech DMARD06 accelerometer
+ *
+ * Copyright (C) 2016 Aleksei Mamlin <mamlinav@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+
+#define DMARD06_DRV_NAME		"dmard06"
+
+/* Device data registers */
+#define DMARD06_CHIP_ID_REG		0x0f
+#define DMARD06_TOUT_REG		0x40
+#define DMARD06_XOUT_REG		0x41
+#define DMARD06_YOUT_REG		0x42
+#define DMARD06_ZOUT_REG		0x43
+#define DMARD06_CTRL1_REG		0x44
+
+/* Device ID value */
+#define DMARD05_CHIP_ID			0x05
+#define DMARD06_CHIP_ID			0x06
+#define DMARD07_CHIP_ID			0x07
+
+/* Device values */
+#define DMARD05_AXIS_SCALE_VAL		15625
+#define DMARD06_AXIS_SCALE_VAL		31250
+#define DMARD06_TEMP_CENTER_VAL		25
+#define DMARD06_SIGN_BIT		7
+
+/* Device power modes */
+#define DMARD06_MODE_NORMAL		0x27
+#define DMARD06_MODE_POWERDOWN		0x00
+
+/* Device channels */
+#define DMARD06_ACCEL_CHANNEL(_axis, _reg) {			\
+	.type = IIO_ACCEL,					\
+	.address = _reg,					\
+	.channel2 = IIO_MOD_##_axis,				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.modified = 1,						\
+}
+
+#define DMARD06_TEMP_CHANNEL(_reg) {				\
+	.type = IIO_TEMP,					\
+	.address = _reg,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_OFFSET),	\
+}
+
+struct dmard06_data {
+	struct i2c_client *client;
+	u8 chip_id;
+};
+
+static const struct iio_chan_spec dmard06_channels[] = {
+	DMARD06_ACCEL_CHANNEL(X, DMARD06_XOUT_REG),
+	DMARD06_ACCEL_CHANNEL(Y, DMARD06_YOUT_REG),
+	DMARD06_ACCEL_CHANNEL(Z, DMARD06_ZOUT_REG),
+	DMARD06_TEMP_CHANNEL(DMARD06_TOUT_REG),
+};
+
+static int dmard06_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct dmard06_data *dmard06 = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = i2c_smbus_read_byte_data(dmard06->client,
+					       chan->address);
+		if (ret < 0) {
+			dev_err(&dmard06->client->dev,
+				"Error reading data: %d\n", ret);
+			return ret;
+		}
+
+		*val = sign_extend32(ret, DMARD06_SIGN_BIT);
+
+		if (dmard06->chip_id == DMARD06_CHIP_ID)
+			*val = *val >> 1;
+
+		switch (chan->type) {
+		case IIO_ACCEL:
+			return IIO_VAL_INT;
+		case IIO_TEMP:
+			if (dmard06->chip_id != DMARD06_CHIP_ID)
+				*val = *val / 2;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_OFFSET:
+		switch (chan->type) {
+		case IIO_TEMP:
+			*val = DMARD06_TEMP_CENTER_VAL;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_ACCEL:
+			*val = 0;
+			if (dmard06->chip_id == DMARD06_CHIP_ID)
+				*val2 = DMARD06_AXIS_SCALE_VAL;
+			else
+				*val2 = DMARD05_AXIS_SCALE_VAL;
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info dmard06_info = {
+	.driver_module	= THIS_MODULE,
+	.read_raw	= dmard06_read_raw,
+};
+
+static int dmard06_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	int ret;
+	struct iio_dev *indio_dev;
+	struct dmard06_data *dmard06;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		dev_err(&client->dev, "I2C check functionality failed\n");
+		return -ENXIO;
+	}
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*dmard06));
+	if (!indio_dev) {
+		dev_err(&client->dev, "Failed to allocate iio device\n");
+		return -ENOMEM;
+	}
+
+	dmard06 = iio_priv(indio_dev);
+	dmard06->client = client;
+
+	ret = i2c_smbus_read_byte_data(dmard06->client, DMARD06_CHIP_ID_REG);
+	if (ret < 0) {
+		dev_err(&client->dev, "Error reading chip id: %d\n", ret);
+		return ret;
+	}
+
+	if (ret != DMARD05_CHIP_ID && ret != DMARD06_CHIP_ID &&
+	    ret != DMARD07_CHIP_ID) {
+		dev_err(&client->dev, "Invalid chip id: %02d\n", ret);
+		return -ENODEV;
+	}
+
+	dmard06->chip_id = ret;
+
+	i2c_set_clientdata(client, indio_dev);
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->name = DMARD06_DRV_NAME;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = dmard06_channels;
+	indio_dev->num_channels = ARRAY_SIZE(dmard06_channels);
+	indio_dev->info = &dmard06_info;
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int dmard06_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct dmard06_data *dmard06 = iio_priv(indio_dev);
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(dmard06->client, DMARD06_CTRL1_REG,
+					DMARD06_MODE_POWERDOWN);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int dmard06_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct dmard06_data *dmard06 = iio_priv(indio_dev);
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(dmard06->client, DMARD06_CTRL1_REG,
+					DMARD06_MODE_NORMAL);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(dmard06_pm_ops, dmard06_suspend, dmard06_resume);
+#define DMARD06_PM_OPS (&dmard06_pm_ops)
+#else
+#define DMARD06_PM_OPS NULL
+#endif
+
+static const struct i2c_device_id dmard06_id[] = {
+	{ "dmard05", 0 },
+	{ "dmard06", 0 },
+	{ "dmard07", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, dmard06_id);
+
+static const struct of_device_id dmard06_of_match[] = {
+	{ .compatible = "domintech,dmard05" },
+	{ .compatible = "domintech,dmard06" },
+	{ .compatible = "domintech,dmard07" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, dmard06_of_match);
+
+static struct i2c_driver dmard06_driver = {
+	.probe = dmard06_probe,
+	.id_table = dmard06_id,
+	.driver = {
+		.name = DMARD06_DRV_NAME,
+		.of_match_table = of_match_ptr(dmard06_of_match),
+		.pm = DMARD06_PM_OPS,
+	},
+};
+module_i2c_driver(dmard06_driver);
+
+MODULE_AUTHOR("Aleksei Mamlin <mamlinav@gmail.com>");
+MODULE_DESCRIPTION("Domintech DMARD06 accelerometer driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.3

