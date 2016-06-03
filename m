Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35611 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759AbcFCKEX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2016 06:04:23 -0400
Received: by mail-pf0-f173.google.com with SMTP id g64so42374922pfb.2
        for <linux-iio@vger.kernel.org>; Fri, 03 Jun 2016 03:04:23 -0700 (PDT)
From: Rocky Hsiao <rocky.hsiao@dyna-image.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Adriana Reus <adriana.reus@intel.com>,
	Guenter Roeck <groeck@chromium.org>,
	Matt Ranostay <mranostay@gmail.com>,
	Rocky Hsiao <rocky.hsiao@dyna-image.com>,
	Andreas Dannenberg <dannenberg@ti.com>,
	Puthikorn Voravootivat <puthik@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	linux-kernel@vger.kernel.org,
	John Huang <john.huang@dyna-image.com>,
	Thomas Lin <thomas.lin@dyna-image.com>
Subject: [PATCH 2/2] iio: light: new driver for Dyna-Image AL3010
Date: Fri,  3 Jun 2016 18:03:18 +0800
Message-Id: <1464948198-49123-1-git-send-email-rocky.hsiao@dyna-image.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This driver is based on drivers/iio/light/al3320a.c

Differences form the original file:
- Difference REG map
- Difference scale

Signed-off-by: Rocky Hsiao <rocky.hsiao@dyna-image.com>
---
 drivers/iio/light/Kconfig  |  10 ++
 drivers/iio/light/Makefile |   1 +
 drivers/iio/light/al3010.c | 292 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 303 insertions(+)
 create mode 100644 drivers/iio/light/al3010.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index ca89b26..57a2a7e 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -40,6 +40,16 @@ config AL3320A
 	 To compile this driver as a module, choose M here: the
 	 module will be called al3320a.
 
+config AL3010
+	tristate "AL3010 ambient light sensor"
+	depends on I2C
+	help
+	 Say Y here if you want to build a driver for the Dyna Image AL3010
+	 ambient light sensor.
+
+	 To compile this driver as a module, choose M here: the
+	 module will be called al3010.
+
 config APDS9300
 	tristate "APDS9300 ambient light sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index 5df1118..3f615d7 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -5,6 +5,7 @@
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ACPI_ALS)		+= acpi-als.o
 obj-$(CONFIG_ADJD_S311)		+= adjd_s311.o
+obj-$(CONFIG_AL3010)		+= al3010.o
 obj-$(CONFIG_AL3320A)		+= al3320a.o
 obj-$(CONFIG_APDS9300)		+= apds9300.o
 obj-$(CONFIG_APDS9960)		+= apds9960.o
diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
new file mode 100644
index 0000000..84da37c
--- /dev/null
+++ b/drivers/iio/light/al3010.c
@@ -0,0 +1,292 @@
+/*
+ * AL3010A - Dyna Image Ambient Light Sensor
+ *
+ * Copyright (c) 2014, Intel Corporation.
+ *
+ * This file is subject to the terms and conditions of version 2 of
+ * the GNU General Public License.  See the file COPYING in the main
+ * directory of this archive for more details.
+ *
+ * IIO driver for AL3010 (7-bit I2C slave address 0x1C).
+ *
+ * TODO: interrupt support, thresholds
+ *
+ * This driver is base on the original driver for AL3320A that was distributed
+ * by Intel Corporation.
+ *
+ * last change: 2016/06/03
+ * editor: Rocky Hsiao <rocky.hsiao@dyan-image.com>
+ *
+ * Datasheet:
+ * http://www.dyna-image.com/english/product/optical-sensor-detail.php?cpid=1&dpid=10#doc
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define AL3010_DRV_NAME "al3010"
+
+#define AL3010_REG_SYSTEM	0x00
+#define	AL3010_REG_CONFIG	0x10
+#define	AL3010_REG_DATA_LOW	0x0c
+
+#define	AL3010_GAIN_MASK	(BIT(6) | BIT(5) | BIT(4))
+#define	AL3010_GAIN_SHIFT	4
+
+#define AL3010_CONFIG_DISABLE	0x00
+#define AL3010_CONFIG_ENABLE	0x01
+
+#define AL3010_SCALE_AVAILABLE "1.1872 0.2968 0.0742 0.0186"
+
+enum al3010_range {
+	AL3010_RANGE_1, /* 77806 lx */
+	AL3010_RANGE_2, /* 19452 lx  */
+	AL3010_RANGE_3, /* 4863  lx  */
+	AL3010_RANGE_4  /* 1216  lx  */
+};
+
+static const int al3010_scales[][2] = {
+	{0, 1187200}, {0, 296800}, {0, 74200}, {0, 18600}
+};
+
+struct al3010_data {
+	struct i2c_client *client;
+};
+
+static const struct iio_chan_spec al3010_channels[] = {
+	{
+		.type	= IIO_LIGHT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+	}
+};
+
+static int al3010_set_gain(struct al3010_data *data, int gain)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(data->client, AL3010_REG_CONFIG,
+		(gain<<AL3010_GAIN_SHIFT)&AL3010_GAIN_MASK);
+
+	return ret;
+}
+
+static int al3010_set_mode(struct al3010_data *data, int mode)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(data->client, AL3010_REG_SYSTEM, mode);
+
+	return ret;
+}
+
+static int al3010_get_mode(struct al3010_data *data)
+{
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, AL3010_REG_SYSTEM);
+
+	return ret;
+}
+
+static int al3010_get_adc_value(struct al3010_data *data)
+{
+	int ret;
+
+	ret = i2c_smbus_read_word_data(data->client, AL3010_REG_DATA_LOW);
+
+	return ret;
+}
+
+static int al3010_get_lux(struct al3010_data *data)
+{
+	int ret;
+	long int ret64;
+
+	ret = al3010_get_adc_value(data);
+	ret64 = ret;
+	ret64 = (ret64 * 74200) / 1000000;
+	ret = ret64;
+
+	return ret;
+}
+
+/* lux */
+static ssize_t al3010_show_lux(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct al3010_data *data = iio_priv(dev_to_iio_dev(dev));
+	int ret;
+
+	/* No LUX data if not operational */
+	if (al3010_get_mode(data) != AL3010_CONFIG_ENABLE)
+		return -EBUSY;
+
+	ret = al3010_get_lux(data);
+
+	return sprintf(buf, "%d\n", ret);
+}
+
+static IIO_CONST_ATTR(in_illuminance_scale_available, AL3010_SCALE_AVAILABLE);
+
+static DEVICE_ATTR(illuminance0_input, S_IRUGO, al3010_show_lux, NULL);
+
+static struct attribute *al3010_attributes[] = {
+	&dev_attr_illuminance0_input.attr,
+	&iio_const_attr_in_illuminance_scale_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group al3010_attribute_group = {
+	.attrs = al3010_attributes,
+};
+
+static int al3010_init(struct al3010_data *data)
+{
+	int err = 0;
+
+	err = al3010_set_mode(data, AL3010_CONFIG_ENABLE);
+	if (err) {
+		dev_err(&data->client->dev,
+			"%s: al3010_set_mode returned error %d\n",
+			__func__, err);
+		return err;
+	}
+
+	/*
+	 * set sensor range to 4863 lux.
+	 * (If panel luminousness is 10% , the range of pad is 0 ~ 48630 lux.)
+	*/
+	err = al3010_set_gain(data, AL3010_RANGE_3);
+	if (err) {
+		dev_err(&data->client->dev,
+			"%s: al3010_set_range returned error %d\n",
+			__func__, err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int al3010_read_raw(struct iio_dev *indio_dev,
+		struct iio_chan_spec const *chan, int *val,
+		int *val2, long mask)
+{
+	struct al3010_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		/*
+		 * ALS ADC value is stored in two adjacent registers:
+		 * - low byte of output is stored at AL3320A_REG_DATA_LOW
+		 * - high byte of output is stored at AL3320A_REG_DATA_LOW + 1
+		 */
+		ret = i2c_smbus_read_word_data(data->client,
+				AL3010_REG_DATA_LOW);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		ret = i2c_smbus_read_byte_data(data->client,
+				AL3010_REG_CONFIG);
+		if (ret < 0)
+			return ret;
+
+		ret = (ret & AL3010_GAIN_MASK) >> AL3010_GAIN_SHIFT;
+		*val = al3010_scales[ret][0];
+		*val2 = al3010_scales[ret][1];
+
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+	return -EINVAL;
+}
+
+static int al3010_write_raw(struct iio_dev *indio_dev,
+		struct iio_chan_spec const *chan, int val,
+		int val2, long mask)
+{
+	struct al3010_data *data = iio_priv(indio_dev);
+	int i;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		for (i = 0; i < ARRAY_SIZE(al3010_scales); i++) {
+			if (val == al3010_scales[i][0] &&
+			    val2 == al3010_scales[i][1])
+				return al3010_set_gain(data, i);
+		}
+		break;
+	}
+	return -EINVAL;
+}
+
+static const struct iio_info al3010_info = {
+	.driver_module	= THIS_MODULE,
+	.read_raw	= al3010_read_raw,
+	.write_raw	= al3010_write_raw,
+	.attrs		= &al3010_attribute_group,
+};
+
+static int al3010_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct al3010_data *data;
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
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->info = &al3010_info;
+	indio_dev->name = AL3010_DRV_NAME;
+	indio_dev->channels = al3010_channels;
+	indio_dev->num_channels = ARRAY_SIZE(al3010_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = al3010_init(data);
+	if (ret < 0) {
+		dev_err(&client->dev, "al3010 chip init failed\n");
+		return ret;
+	}
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static int al3010_remove(struct i2c_client *client)
+{
+	return i2c_smbus_write_byte_data(client, AL3010_REG_SYSTEM, 0x00);
+}
+
+static const struct i2c_device_id al3010_id[] = {
+	{"al3010", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, al3010_id);
+
+static struct i2c_driver al3010_driver = {
+	.driver = {
+		.name = AL3010_DRV_NAME,
+	},
+	.probe		= al3010_probe,
+	.remove		= al3010_remove,
+	.id_table	= al3010_id,
+};
+
+module_i2c_driver(al3010_driver);
+
+MODULE_AUTHOR("Rocky Hsiao <rocky.hsiao@dyna-image.com");
+MODULE_DESCRIPTION("AL3010 Ambient Light Sensor driver");
+MODULE_LICENSE("GPL v2");
+
-- 
2.1.2

