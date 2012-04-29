Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 2/2] iio: add mcp4725 I2C DAC driver
Date: Sun, 29 Apr 2012 19:13:38 +0200
Message-Id: <1335719618-28295-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1335719618-28295-1-git-send-email-pmeerw@pmeerw.net>
References: <1335719618-28295-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>

---
 drivers/staging/iio/dac/mcp4725.c |  210 +++++++++++++++++++++++++++++++++++++
 drivers/staging/iio/dac/mcp4725.h |   16 +++
 2 files changed, 226 insertions(+)
 create mode 100644 drivers/staging/iio/dac/mcp4725.c
 create mode 100644 drivers/staging/iio/dac/mcp4725.h

diff --git a/drivers/staging/iio/dac/mcp4725.c b/drivers/staging/iio/dac/mcp4725.c
new file mode 100644
index 0000000..8603c66
--- /dev/null
+++ b/drivers/staging/iio/dac/mcp4725.c
@@ -0,0 +1,210 @@
+/*
+ * mcp4725.c - Support for Microchip MCP4725
+ *
+ * Copyright (C) 2012 Peter Meerwald <pmeerw@pmeerw.net>
+ *
+ * Based on max517 by Roland Stigge <stigge@antcom.de>
+ *
+ * This file is subject to the terms and conditions of version 2 of
+ * the GNU General Public License.  See the file COPYING in the main
+ * directory of this archive for more details.
+ *
+ * driver for the Microchip I2C 12-bit digital-to-analog converter (DAC)
+ * (7-bit I2C slave address 0x60, the three LSBs can be configured in
+ * hardware)
+ *
+ * writing the DAC value to EEPROM is not supported
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+
+#include "../iio.h"
+#include "../sysfs.h"
+#include "dac.h"
+
+#include "mcp4725.h"
+
+#define MCP4725_DRV_NAME	"mcp4725"
+
+struct mcp4725_data {
+	struct iio_dev		*indio_dev;
+	struct i2c_client	*client;
+	unsigned short		vref_mv;
+	unsigned short		dac_value;
+};
+
+static ssize_t mcp4725_set_value(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct mcp4725_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+	u8 outbuf[2];
+	int res;
+	long val;
+
+	res = strict_strtol(buf, 10, &val);
+	if (res)
+		return res;
+
+	if (val < 0 || val > 0xfff)
+		return -EINVAL;
+
+	outbuf[0] = (val >> 8) & 0xf;
+	outbuf[1] = val & 0xff;
+
+	res = i2c_master_send(client, outbuf, 2);
+	if (res < 0)
+		return res;
+
+	data->dac_value = val;
+
+	return count;
+}
+
+static IIO_DEVICE_ATTR(out_voltage_raw, S_IWUSR,
+		       NULL, mcp4725_set_value, 0);
+
+static ssize_t mcp4725_show_scale(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct mcp4725_data *data = iio_priv(indio_dev);
+
+	unsigned int scale_uv = (data->vref_mv * 1000) >> 12;
+
+	return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv % 1000);
+}
+
+static IIO_DEVICE_ATTR(out_voltage_scale, S_IRUGO,
+		       mcp4725_show_scale, NULL, 0);
+
+static struct attribute *mcp4725_attributes[] = {
+	&iio_dev_attr_out_voltage_raw.dev_attr.attr,
+	&iio_dev_attr_out_voltage_scale.dev_attr.attr,
+	NULL
+};
+
+static struct attribute_group mcp4725_attribute_group = {
+	.attrs = mcp4725_attributes,
+};
+
+#ifdef CONFIG_PM_SLEEP
+static int mcp4725_suspend(struct device *dev)
+{
+	u8 outbuf[2];
+
+	outbuf[0] = 0x3 << 4; /* power-down bits, 500 kOhm resistor */
+	outbuf[1] = 0;
+
+	return i2c_master_send(to_i2c_client(dev), &outbuf, 2);
+}
+
+static int mcp4725_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct mcp4725_data *data = iio_priv(indio_dev);
+	u8 outbuf[2];
+
+	/* restore previous DAC value */
+	outbuf[0] = (data->dac_value >> 8) & 0xf;
+	outbuf[1] = data->dac_value & 0xff;
+
+	return i2c_master_send(to_i2c_client(dev), &outbuf, 2);
+}
+
+static SIMPLE_DEV_PM_OPS(mcp4725_pm_ops, mcp4725_suspend, mcp4725_resume);
+#define MCP4725_PM_OPS (&mcp4725_pm_ops)
+#else
+#define MCP4725_PM_OPS NULL
+#endif
+
+static const struct iio_info mcp4725_info = {
+	.attrs = &mcp4725_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
+static int mcp4725_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct mcp4725_data *data;
+	struct iio_dev *indio_dev;
+	struct mcp4725_platform_data *platform_data = client->dev.platform_data;
+	u8 inbuf[3];
+	int err;
+
+	if (!platform_data || !platform_data->vref_mv) {
+		dev_err(&client->dev, "invalid platform data");
+		err = -EINVAL;
+		goto exit;
+	}
+
+	indio_dev = iio_allocate_device(sizeof(*data));
+	if (indio_dev == NULL) {
+		err = -ENOMEM;
+		goto exit;
+	}
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->info = &mcp4725_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	data->vref_mv = platform_data->vref_mv;
+
+	/* read current DAC value */
+	err = i2c_master_recv(client, inbuf, 3);
+	if (err < 0) {
+		dev_err(&client->dev, "failed to read DAC value");
+		goto exit_free_device;
+	}
+	data->dac_value = (inbuf[1] << 4) | (inbuf[2] >> 4);
+
+	err = iio_device_register(indio_dev);
+	if (err)
+		goto exit_free_device;
+
+	dev_info(&client->dev, "MCP4725 DAC registered\n");
+
+	return 0;
+
+exit_free_device:
+	iio_free_device(indio_dev);
+exit:
+	return err;
+}
+
+static int mcp4725_remove(struct i2c_client *client)
+{
+	iio_free_device(i2c_get_clientdata(client));
+
+	return 0;
+}
+
+static const struct i2c_device_id mcp4725_id[] = {
+	{ "mcp4725", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mcp4725_id);
+
+static struct i2c_driver mcp4725_driver = {
+	.driver = {
+		.name	= MCP4725_DRV_NAME,
+		.pm	= MCP4725_PM_OPS,
+	},
+	.probe		= mcp4725_probe,
+	.remove		= mcp4725_remove,
+	.id_table	= mcp4725_id,
+};
+module_i2c_driver(mcp4725_driver);
+
+MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
+MODULE_DESCRIPTION("MCP4725 12-bit DAC");
+MODULE_LICENSE("GPL");
diff --git a/drivers/staging/iio/dac/mcp4725.h b/drivers/staging/iio/dac/mcp4725.h
new file mode 100644
index 0000000..91530e6
--- /dev/null
+++ b/drivers/staging/iio/dac/mcp4725.h
@@ -0,0 +1,16 @@
+/*
+ * MCP4725 DAC driver
+ *
+ * Copyright (C) 2012 Peter Meerwald <pmeerw@pmeerw.net>
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#ifndef IIO_DAC_MCP4725_H_
+#define IIO_DAC_MCP4725_H_
+
+struct mcp4725_platform_data {
+	u16 vref_mv;
+};
+
+#endif /* IIO_DAC_MCP4725_H_ */
-- 
1.7.9.5
