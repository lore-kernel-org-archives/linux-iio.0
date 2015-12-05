Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34685 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbbLEXdH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Dec 2015 18:33:07 -0500
Received: by pacwq6 with SMTP id wq6so27729344pac.1
        for <linux-iio@vger.kernel.org>; Sat, 05 Dec 2015 15:33:06 -0800 (PST)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org
Cc: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v2 1/1] iio: chemical: add AMS iAQ-core support
Date: Sat,  5 Dec 2015 15:33:11 -0800
Message-Id: <1449358391-11851-2-git-send-email-mranostay@gmail.com>
In-Reply-To: <1449358391-11851-1-git-send-email-mranostay@gmail.com>
References: <1449358391-11851-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add support for AMS iAQ-core continuous and pulsed VOC sensors.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 drivers/iio/chemical/Kconfig                       |   8 +
 drivers/iio/chemical/Makefile                      |   1 +
 drivers/iio/chemical/ams-iaq-core.c                | 200 +++++++++++++++++++++
 4 files changed, 210 insertions(+)
 create mode 100644 drivers/iio/chemical/ams-iaq-core.c

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index c50cf13..f6fec95 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -20,6 +20,7 @@ adi,adt7476		+/-1C TDM Extended Temp Range I.C
 adi,adt7490		+/-1C TDM Extended Temp Range I.C
 adi,adxl345		Three-Axis Digital Accelerometer
 adi,adxl346		Three-Axis Digital Accelerometer (backward-compatibility value "adi,adxl345" must be listed too)
+ams,iaq-core		AMS iAQ-Core VOC Sensor
 at,24c08		i2c serial eeprom  (24cxx)
 atmel,24c00		i2c serial eeprom  (24cxx)
 atmel,24c01		i2c serial eeprom  (24cxx)
diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index 3061b72..f16de61 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -4,6 +4,14 @@
 
 menu "Chemical Sensors"
 
+config IAQCORE
+	tristate "AMS iAQ-Core VOC sensors"
+	depends on I2C
+	help
+	  Say Y here to build I2C interface support for the AMS
+	  iAQ-Core Continuous/Pulsed VOC (Volatile Organic Compounds)
+	  sensors
+
 config VZ89X
 	tristate "SGX Sensortech MiCS VZ89X VOC sensor"
 	depends on I2C
diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
index 7292f2d..167861f 100644
--- a/drivers/iio/chemical/Makefile
+++ b/drivers/iio/chemical/Makefile
@@ -3,4 +3,5 @@
 #
 
 # When adding new entries keep the list in alphabetical order
+obj-$(CONFIG_IAQCORE)		+= ams-iaq-core.o
 obj-$(CONFIG_VZ89X)		+= vz89x.o
diff --git a/drivers/iio/chemical/ams-iaq-core.c b/drivers/iio/chemical/ams-iaq-core.c
new file mode 100644
index 0000000..9fadcb7
--- /dev/null
+++ b/drivers/iio/chemical/ams-iaq-core.c
@@ -0,0 +1,200 @@
+/*
+ * ams-iaq-core.c - Support for AMS iAQ-Core VOC sensors
+ *
+ * Copyright (C) 2015 Matt Ranostay <mranostay@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+
+#define AMS_IAQCORE_DATA_SIZE		9
+
+#define AMS_IAQCORE_VOC_CO2_IDX		0
+#define AMS_IAQCORE_VOC_RESISTANCE_IDX	1
+#define AMS_IAQCORE_VOC_TVOC_IDX	2
+
+struct ams_iaqcore_reading {
+	__be16 co2_ppm;
+	u8 status;
+	__be32 resistance;
+	__be16 voc_ppb;
+} __attribute__((__packed__));
+
+struct ams_iaqcore_data {
+	struct i2c_client *client;
+	struct mutex lock;
+	unsigned long last_update;
+
+	struct ams_iaqcore_reading buffer;
+};
+
+static const struct iio_chan_spec ams_iaqcore_channels[] = {
+	{
+		.type = IIO_CONCENTRATION,
+		.channel2 = IIO_MOD_CO2,
+		.modified = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.address = AMS_IAQCORE_VOC_CO2_IDX,
+	},
+	{
+		.type = IIO_RESISTANCE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.address = AMS_IAQCORE_VOC_RESISTANCE_IDX,
+	},
+	{
+		.type = IIO_CONCENTRATION,
+		.channel2 = IIO_MOD_VOC,
+		.modified = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.address = AMS_IAQCORE_VOC_TVOC_IDX,
+	},
+};
+
+static int ams_iaqcore_read_measurement(struct ams_iaqcore_data *data)
+{
+	struct i2c_client *client = data->client;
+	int ret;
+
+	struct i2c_msg msg = {
+		.addr = client->addr,
+		.flags = client->flags | I2C_M_RD,
+		.len = AMS_IAQCORE_DATA_SIZE,
+		.buf = (char *) &data->buffer,
+	};
+
+	ret = i2c_transfer(client->adapter, &msg, 1);
+
+	return (ret == AMS_IAQCORE_DATA_SIZE) ? 0 : ret;
+}
+
+static int ams_iaqcore_get_measurement(struct ams_iaqcore_data *data)
+{
+	int ret;
+
+	/* sensor can only be polled once a second max per datasheet */
+	if (!time_after(jiffies, data->last_update + HZ))
+		return 0;
+
+	ret = ams_iaqcore_read_measurement(data);
+	if (ret < 0)
+		return ret;
+
+	data->last_update = jiffies;
+
+	return 0;
+}
+
+static int ams_iaqcore_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan, int *val,
+				int *val2, long mask)
+{
+	struct ams_iaqcore_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (mask != IIO_CHAN_INFO_RAW)
+		return -EINVAL;
+
+	mutex_lock(&data->lock);
+	ret = ams_iaqcore_get_measurement(data);
+
+	if (ret)
+		goto err_out;
+
+	switch (chan->address) {
+	case AMS_IAQCORE_VOC_CO2_IDX:
+		*val = 0;
+		*val2 = be16_to_cpu(data->buffer.co2_ppm);
+		ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
+	case AMS_IAQCORE_VOC_RESISTANCE_IDX:
+		*val = be32_to_cpu(data->buffer.resistance);
+		ret = IIO_VAL_INT;
+		break;
+	case AMS_IAQCORE_VOC_TVOC_IDX:
+		*val = 0;
+		*val2 = be16_to_cpu(data->buffer.voc_ppb);
+		ret = IIO_VAL_INT_PLUS_NANO;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+err_out:
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static const struct iio_info ams_iaqcore_info = {
+	.read_raw	= ams_iaqcore_read_raw,
+	.driver_module	= THIS_MODULE,
+};
+
+static int ams_iaqcore_probe(struct i2c_client *client,
+			     const struct i2c_device_id *id)
+{
+	struct iio_dev *indio_dev;
+	struct ams_iaqcore_data *data;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+
+	/* set timestamp so initial reading will complete */
+	data->last_update = jiffies - HZ;
+	mutex_init(&data->lock);
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->info = &ams_iaqcore_info,
+	indio_dev->name = dev_name(&client->dev);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	indio_dev->channels = ams_iaqcore_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ams_iaqcore_channels);
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id ams_iaqcore_id[] = {
+	{ "ams-iaq-core", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ams_iaqcore_id);
+
+static const struct of_device_id ams_iaqcore_dt_ids[] = {
+	{ .compatible = "ams,iaq-core" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ams_iaqcore_dt_ids);
+
+static struct i2c_driver ams_iaqcore_driver = {
+	.driver = {
+		.name	= "ams-iaq-core",
+		.of_match_table = of_match_ptr(ams_iaqcore_dt_ids),
+	},
+	.probe = ams_iaqcore_probe,
+	.id_table = ams_iaqcore_id,
+};
+module_i2c_driver(ams_iaqcore_driver);
+
+MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
+MODULE_DESCRIPTION("AMS iAQ-Core VOC sensors");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

