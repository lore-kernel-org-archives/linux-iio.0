Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-01.vtx.ch ([194.38.175.90]:60320 "EHLO smtp-01.vtx.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752237Ab1LULRc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 21 Dec 2011 06:17:32 -0500
From: Pirmin Duss <pirmin.duss@flytec.ch>
To: linux-iio@vger.kernel.org
Cc: Pirmin Duss <pirmin.duss@flytec.ch>
Subject: [PATCH v2] Adds support for the Texas Instruments ADS1110 adc.
Date: Wed, 21 Dec 2011 12:17:46 +0100
Message-Id: <1324466266-30926-1-git-send-email-pirmin.duss@flytec.ch>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is the second iteration of the patch to add the Texas Instruments
ADS1110 adc driver.

Signed-off-by: Pirmin Duss (Flytec) <pirmin.duss@flytec.ch>
---
 drivers/staging/iio/adc/Kconfig   |   10 +
 drivers/staging/iio/adc/Makefile  |    1 +
 drivers/staging/iio/adc/ads1110.c |  397 +++++++++++++++++++++++++++++++++++++
 3 files changed, 408 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/adc/ads1110.c

diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index d9decea..ab516dd 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -145,6 +145,16 @@ config AD7192
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7192.
 
+config ADS1110
+	tristate "Texas Instruments ADS1110 Analog Digital Converter driver"
+	depends on I2C
+	help
+		Say yes here to build support for Texas Instruments ads1110 ADC.
+		Provides direct access via sysfs.
+
+		To compile this driver as a module, choose M here: the
+		module will be called ads1110.
+
 config ADT7310
 	tristate "Analog Devices ADT7310 temperature sensor driver"
 	depends on SPI
diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index ceee7f3..5551e03 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_AD7780) += ad7780.o
 obj-$(CONFIG_AD7793) += ad7793.o
 obj-$(CONFIG_AD7816) += ad7816.o
 obj-$(CONFIG_AD7192) += ad7192.o
+obj-$(CONFIG_ADS1110) += ads1110.o
 obj-$(CONFIG_ADT7310) += adt7310.o
 obj-$(CONFIG_ADT7410) += adt7410.o
 obj-$(CONFIG_AD7280) += ad7280a.o
diff --git a/drivers/staging/iio/adc/ads1110.c b/drivers/staging/iio/adc/ads1110.c
new file mode 100644
index 0000000..ad0d386
--- /dev/null
+++ b/drivers/staging/iio/adc/ads1110.c
@@ -0,0 +1,397 @@
+/*
+ * Driver for Texas Instruments ads1110 ADC.
+ *
+ * Datashhet con be found on: http://www.ti.com/lit/ds/symlink/ads1110.pdf
+ *
+ * Copyright 2011 Flytec AG.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/err.h>
+
+#include "../iio.h"
+#include "../sysfs.h"
+
+/*
+ * ADS1110 definitions
+ */
+
+#define ADS1110_CYC_MASK		0x0C
+#define ADS1110_CYC_SHIFT		2
+#define ADS1110_CYC_TCONF_15		3
+#define ADS1110_CYC_TCONF_30		2
+#define ADS1110_CYC_TCONF_60		1
+#define ADS1110_CYC_TCONF_240		0
+
+#define ADS1110_PGA_MASK		0x03
+#define ADS1110_PGA_CLEAR   		0x9C
+#define ADS1110_PGA_1			0
+#define ADS1110_PGA_2			1
+#define ADS1110_PGA_4			2
+#define ADS1110_PGA_8			3
+
+#define ADS1110_MAX_CONV_MODE		2
+#define ADS1110_MAX_DATA_RATE		4
+#define ADS1110_MAX_PGA		4
+
+/*
+ * struct ads1110_chip_info  - chip specifig information
+ */
+
+struct ads1110_chip_info {
+	struct i2c_client	*client;
+};
+
+static const unsigned int ads1110_frequencies[] = {
+	[ADS1110_CYC_TCONF_240] = 240,
+	[ADS1110_CYC_TCONF_60] = 60,
+	[ADS1110_CYC_TCONF_30] = 30,
+	[ADS1110_CYC_TCONF_15] = 15,
+};
+
+struct ads1110_pga {
+	char *name;
+	u8 reg_cfg;
+};
+
+static struct ads1110_pga
+ads1110_pga_table[ADS1110_MAX_PGA] = {
+	{ "gain-1",  ADS1110_PGA_1 },
+	{ "gain-2",  ADS1110_PGA_2 },
+	{ "gain-4",  ADS1110_PGA_4 },
+	{ "gain-8",  ADS1110_PGA_8 },
+};
+
+/*
+ * channel specifications
+ */
+
+static const struct iio_chan_spec ads1110_channels[] = {
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0, 0, 0, 0, 
+		IIO_ST('s', 16, 16, 0), 0),
+};
+
+/*
+ * cummunication functions for i2c
+ */
+
+static int ads1110_i2c_read_config(struct ads1110_chip_info *chip, u8 *data)
+{
+	struct i2c_client *client = chip->client;
+	int ret = 0;
+	u8 tmp[3];		/* read three bytes ; first two are data third is the config */
+
+	ret = i2c_master_recv(client, tmp, 3);
+	if (ret < 3) {
+		dev_err(&client->dev, "I2C read error\n");
+		return ret;
+	}
+
+	*data = tmp[2];
+
+	return ret;
+}
+
+static int ads1110_i2c_read_data(struct ads1110_chip_info *chip, int *data)
+{
+	struct i2c_client *client = chip->client;
+	int ret = 0;
+	u8 tmp[3];		/* read three bytes ; first two are data third is the config */
+
+	ret = i2c_master_recv(client, tmp, 3);
+	if (ret < 3) {
+		dev_err(&client->dev, "I2C read error\n");
+		return ret;
+	}
+
+	*data = (int)(tmp[0] << 8) + tmp[1];
+
+	return ret;
+}
+
+
+static int ads1110_i2c_write_config(struct ads1110_chip_info *chip, u8 data)
+{
+	struct i2c_client *client = chip->client;
+	int ret = 0;
+
+	ret = i2c_master_send(client, &data, 1);        /* there is only one register to write to. */
+	if (ret < 0)
+		dev_err(&client->dev, "I2C write error\n");
+
+	return ret;
+}
+
+/*
+ * setter- / getter functions for the sysfs nodes.
+ */
+
+static ssize_t ads1110_read_frequency(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ads1110_chip_info *st = iio_priv(indio_dev);
+	u8 cfg;
+
+	ads1110_i2c_read_config(st, &cfg);
+	cfg = ((cfg & ADS1110_CYC_MASK) >> ADS1110_CYC_SHIFT);
+
+	return sprintf(buf, "%d\n", ads1110_frequencies[cfg]);
+}
+
+static ssize_t ads1110_write_frequency(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ads1110_chip_info *st = iio_priv(indio_dev);
+	unsigned long lval;
+	int ret, i;
+	u8 cfg;
+
+	ads1110_i2c_read_config(st, &cfg);
+
+	ret = kstrtoul(buf, 10, &lval);
+	if (ret)
+		return ret;
+
+	if (lval < 15 || lval > 240) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ads1110_frequencies); i++)
+		if (lval == ads1110_frequencies[i])
+			break;
+
+	if (i == ARRAY_SIZE(ads1110_frequencies)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	cfg &= ~ADS1110_CYC_MASK;               /* erase old datarate */
+	cfg |= (i << ADS1110_CYC_SHIFT);
+
+	ads1110_i2c_write_config(st, cfg);
+
+out:
+	return ret ? ret : len;
+}
+
+static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
+		ads1110_read_frequency,
+		ads1110_write_frequency);
+
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("240 60 30 15");
+
+static ssize_t ads1110_show_gains(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int i;
+	int len = 0;
+
+	for (i = 0; i < ADS1110_MAX_PGA; i++)
+		len += sprintf(buf + len, "%s\n", ads1110_pga_table[i].name);
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(gains_available,
+		S_IRUGO,
+		ads1110_show_gains, NULL, 0);
+
+static ssize_t ads1110_show_gain(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ads1110_chip_info *st = iio_priv(indio_dev);
+	u8 cfg;
+
+	ads1110_i2c_read_config(st, &cfg);
+	cfg = (cfg & ADS1110_PGA_MASK);
+
+	return sprintf(buf, "%s\n", ads1110_pga_table[cfg].name);
+}
+
+static ssize_t ads1110_store_gain(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ads1110_chip_info *st = iio_priv(indio_dev);
+	u8 cfg;
+	int i;
+
+	for (i = 0; i < ADS1110_MAX_PGA; i++) {
+		if (strncmp(buf, ads1110_pga_table[i].name,
+			strlen(ads1110_pga_table[i].name)) == 0) {
+			ads1110_i2c_read_config(st, &cfg);
+			cfg &= ADS1110_PGA_CLEAR;		/* clear old value */
+			cfg |= ads1110_pga_table[i].reg_cfg;
+			ads1110_i2c_write_config(st, cfg);
+			return len;
+		}
+	}
+
+	dev_err(dev, "not supported gain\n");
+
+	return -EINVAL;
+}
+
+static IIO_DEVICE_ATTR(gain,
+		S_IRUGO | S_IWUSR,
+		ads1110_show_gain, ads1110_store_gain, 0);
+
+static int ads1110_read_raw(struct iio_dev *indio_dev,
+		struct iio_chan_spec const *chan,
+		int *val,
+		int *val2,
+		long mask)
+{
+	struct ads1110_chip_info *st = iio_priv(indio_dev);
+	int ret, data;
+
+	ret = ads1110_i2c_read_data(st, &data);
+	if (ret!=3)
+		return -EIO;
+
+	*val = data;
+	*val2 = 0;
+
+	return IIO_VAL_INT;
+}
+
+/*
+ * attributes for sysfs
+ */
+
+static struct attribute *ads1110_attributes[] = {
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_dev_attr_gains_available.dev_attr.attr,
+	&iio_dev_attr_gain.dev_attr.attr,
+	NULL,
+};
+ 
+static const struct attribute_group ads1110_attribute_group = {
+	.attrs = ads1110_attributes,
+};
+
+static const struct iio_info ads1110_info = {
+	.attrs = &ads1110_attribute_group,
+	.event_attrs = NULL,
+	.read_raw = &ads1110_read_raw,
+	.driver_module = THIS_MODULE,
+};
+
+/*
+ * device probe and remove
+ */
+
+static int __devinit ads1110_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	int ret = 0, regdone = 0;
+	struct ads1110_chip_info *chip;
+	struct iio_dev *indio_dev;
+
+	indio_dev= iio_allocate_device(sizeof(*chip));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+	chip = iio_priv(indio_dev);
+
+	/* this is only used for device removal purposes  */
+	i2c_set_clientdata(client, indio_dev);
+
+	chip->client = client;
+
+	/* Establish that the iio_dev is a child of the i2c device */
+	indio_dev->name = id->name;
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->info = &ads1110_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ads1110_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ads1110_channels);
+
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_free_dev;
+	regdone = 1;
+
+	dev_err(&client->dev, "%s ADC registered.\n", id->name);
+
+	return 0;
+
+error_free_dev:
+	if (regdone)
+		iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
+	kfree(chip);
+error_ret:
+	return ret;
+}
+
+static int __devexit ads1110_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
+
+	return 0;
+}
+
+static const struct i2c_device_id ads1110_id[] = {
+	{ "ads1110-ed0", 0x48 },
+	{ "ads1110-ed1", 0x49 },
+	{ "ads1110-ed2", 0x50 },
+	{ "ads1110-ed3", 0x51 },
+	{ "ads1110-ed4", 0x52 },
+	{ "ads1110-ed5", 0x53 },
+	{ "ads1110-ed6", 0x54 },
+	{ "ads1110-ed7", 0x55 },
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, ads1110_id);
+
+static struct i2c_driver ads1110_driver = {
+	.driver = {
+		.name = "ads1110",
+	},
+	.probe = ads1110_probe,
+	.remove = __devexit_p(ads1110_remove),
+	.id_table = ads1110_id,
+};
+
+static __init int ads1110_init(void)
+{
+	return i2c_add_driver(&ads1110_driver);
+}
+
+static __exit void ads1110_exit(void)
+{
+	i2c_del_driver(&ads1110_driver);
+}
+
+MODULE_AUTHOR("Duss Pirmin <pirmin.duss@flytec.ch>");
+MODULE_DESCRIPTION("Texas Instruments ads1110 adc driver");
+MODULE_LICENSE("GPL v2");
+
+module_init(ads1110_init);
+module_exit(ads1110_exit);
-- 
1.7.2.5

