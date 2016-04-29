Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42661 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753374AbcD2NGB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 29 Apr 2016 09:06:01 -0400
From: Tiberiu Breana <tiberiu.a.breana@intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v2 1/2] iio: accel: Add support for Bosch BMA220
Date: Fri, 29 Apr 2016 16:05:16 +0300
Message-Id: <1461935117-16124-2-git-send-email-tiberiu.a.breana@intel.com>
In-Reply-To: <1461935117-16124-1-git-send-email-tiberiu.a.breana@intel.com>
References: <1461935117-16124-1-git-send-email-tiberiu.a.breana@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This commit adds basic support for the Bosch Sensortec BMA220
digital triaxial acceleration sensor.

Includes:
- raw readings
- ACPI detection
- power management

Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
---
 drivers/iio/accel/Kconfig      |  10 ++
 drivers/iio/accel/Makefile     |   1 +
 drivers/iio/accel/bma220_spi.c | 257 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 268 insertions(+)
 create mode 100644 drivers/iio/accel/bma220_spi.c

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index e4a758c..98740c7 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -17,6 +17,16 @@ config BMA180
 	  To compile this driver as a module, choose M here: the
 	  module will be called bma180.
 
+config BMA220
+    tristate "Bosch BMA220 3-Axis Accelerometer Driver"
+	depends on SPI
+    help
+      Say yes here to add support for the Bosch BMA220 triaxial
+      acceleration sensor.
+
+      To compile this driver as a module, choose M here: the
+      module will be called bma220_spi.
+
 config BMC150_ACCEL
 	tristate "Bosch BMC150 Accelerometer Driver"
 	select IIO_BUFFER
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 71b6794..9ae7820e 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -4,6 +4,7 @@
 
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_BMA180) += bma180.o
+obj-$(CONFIG_BMA220) += bma220_spi.o
 obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
 obj-$(CONFIG_BMC150_ACCEL_I2C) += bmc150-accel-i2c.o
 obj-$(CONFIG_BMC150_ACCEL_SPI) += bmc150-accel-spi.o
diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
new file mode 100644
index 0000000..5df5594
--- /dev/null
+++ b/drivers/iio/accel/bma220_spi.c
@@ -0,0 +1,257 @@
+/**
+ * BMA220 Digital triaxial acceleration sensor driver
+ *
+ * Copyright (c) 2016, Intel Corporation.
+ *
+ * This file is subject to the terms and conditions of version 2 of
+ * the GNU General Public License. See the file COPYING in the main
+ * directory of this archive for more details.
+ */
+
+#include <linux/acpi.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/spi/spi.h>
+
+#define BMA220_REG_ID				0x00
+#define BMA220_REG_ACCEL_X			0x02
+#define BMA220_REG_ACCEL_Y			0x03
+#define BMA220_REG_ACCEL_Z			0x04
+#define BMA220_REG_RANGE			0x11
+#define BMA220_REG_SUSPEND			0x18
+
+#define BMA220_CHIP_ID				0xDD
+#define BMA220_READ_MASK			0x80
+#define BMA220_RANGE_MASK			0x03
+#define BMA220_DATA_SHIFT			2
+#define BMA220_SUSPEND_SLEEP			0xFF
+#define BMA220_SUSPEND_WAKE			0x00
+
+#define BMA220_DEVICE_NAME			"bma220"
+#define BMA220_SCALE_AVAILABLE			"0.623 1.248 2.491 4.983"
+
+#define BMA220_ACCEL_CHANNEL(index, reg, axis) {			\
+	.type = IIO_ACCEL,						\
+	.address = reg,							\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+}
+
+static IIO_CONST_ATTR(in_accel_scale_available, BMA220_SCALE_AVAILABLE);
+
+static struct attribute *bma220_attributes[] = {
+	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group bma220_attribute_group = {
+	.attrs = bma220_attributes,
+};
+
+static const int bma220_scale_table[][4] = {
+	{0, 623000}, {1, 248000}, {2, 491000}, {4, 983000}
+};
+
+struct bma220_data {
+	struct spi_device *spi_device;
+};
+
+static const struct iio_chan_spec bma220_channels[] = {
+	BMA220_ACCEL_CHANNEL(0, BMA220_REG_ACCEL_X, X),
+	BMA220_ACCEL_CHANNEL(1, BMA220_REG_ACCEL_Y, Y),
+	BMA220_ACCEL_CHANNEL(2, BMA220_REG_ACCEL_Z, Z),
+};
+
+static inline int bma220_read_reg(struct spi_device *spi, u8 reg)
+{
+	return spi_w8r8(spi, reg | BMA220_READ_MASK);
+}
+
+static int bma220_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	int ret;
+	u8 range_idx;
+	struct bma220_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = bma220_read_reg(data->spi_device, chan->address);
+		if (ret < 0)
+			return -EINVAL;
+		*val = sign_extend32(ret >> BMA220_DATA_SHIFT, 5);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		ret = bma220_read_reg(data->spi_device, BMA220_REG_RANGE);
+		if (ret < 0)
+			return ret;
+		range_idx = ret & BMA220_RANGE_MASK;
+		*val = bma220_scale_table[range_idx][0];
+		*val2 = bma220_scale_table[range_idx][1];
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+
+	return -EINVAL;
+}
+
+static int bma220_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	int i;
+	int ret;
+	u8 buf[2];
+	int index = -1;
+	struct bma220_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		for (i = 0; i < ARRAY_SIZE(bma220_scale_table); i++)
+			if (val == bma220_scale_table[i][0] &&
+			    val2 == bma220_scale_table[i][1]) {
+				index = i;
+				break;
+			}
+		if (index < 0)
+			return -EINVAL;
+
+		buf[0] = BMA220_REG_RANGE;
+		buf[1] = index;
+		ret = spi_write(data->spi_device, &buf, sizeof(buf));
+		if (ret < 0)
+			dev_err(&data->spi_device->dev,
+				"failed to set measurement range\n");
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_info bma220_info = {
+	.driver_module		= THIS_MODULE,
+	.read_raw		= bma220_read_raw,
+	.write_raw		= bma220_write_raw,
+	.attrs			= &bma220_attribute_group,
+};
+
+static int bma220_init(struct spi_device *spi)
+{
+	int ret;
+
+	ret = bma220_read_reg(spi, BMA220_REG_ID);
+	if (ret != BMA220_CHIP_ID)
+		return -ENODEV;
+
+	/* Make sure the chip is powered on */
+	ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
+	if (ret < 0)
+		return ret;
+	else if (ret == BMA220_SUSPEND_WAKE)
+		return bma220_read_reg(spi, BMA220_REG_SUSPEND);
+
+	return 0;
+}
+
+static int bma220_probe(struct spi_device *spi)
+{
+	int ret;
+	struct iio_dev *indio_dev;
+	struct bma220_data *data;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
+	if (!indio_dev) {
+		dev_err(&spi->dev, "iio allocation failed!\n");
+		return -ENOMEM;
+	}
+
+	data = iio_priv(indio_dev);
+	data->spi_device = spi;
+	spi_set_drvdata(spi, indio_dev);
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->info = &bma220_info;
+	indio_dev->name = BMA220_DEVICE_NAME;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = bma220_channels;
+	indio_dev->num_channels = ARRAY_SIZE(bma220_channels);
+
+	ret = bma220_init(data->spi_device);
+	if (ret < 0)
+		return ret;
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0)
+		dev_err(&spi->dev, "iio_device_register failed\n");
+
+	return ret;
+}
+
+static int bma220_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct bma220_data *data = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+
+	return bma220_read_reg(data->spi_device, BMA220_REG_SUSPEND);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int bma220_suspend(struct device *dev)
+{
+	struct bma220_data *data =
+			iio_priv(spi_get_drvdata(to_spi_device(dev)));
+
+	/* The chip can be suspended/woken up by a simple register read. */
+	return bma220_read_reg(data->spi_device, BMA220_REG_SUSPEND);
+}
+
+static int bma220_resume(struct device *dev)
+{
+	struct bma220_data *data =
+			iio_priv(spi_get_drvdata(to_spi_device(dev)));
+
+	return bma220_read_reg(data->spi_device, BMA220_REG_SUSPEND);
+}
+
+static SIMPLE_DEV_PM_OPS(bma220_pm_ops, bma220_suspend, bma220_resume);
+
+#define BMA220_PM_OPS (&bma220_pm_ops)
+#else
+#define BMA220_PM_OPS NULL
+#endif
+
+static const struct spi_device_id bma220_spi_id[] = {
+	{"bma220", 0},
+	{}
+};
+
+static const struct acpi_device_id bma220_acpi_id[] = {
+	{"BMA0220", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(spi, bma220_spi_id);
+
+static struct spi_driver bma220_driver = {
+	.driver = {
+		.name = "bma220_spi",
+		.pm = BMA220_PM_OPS,
+		.acpi_match_table = ACPI_PTR(bma220_acpi_id),
+	},
+	.probe =            bma220_probe,
+	.remove =           bma220_remove,
+	.id_table =         bma220_spi_id,
+};
+
+module_spi_driver(bma220_driver);
+
+MODULE_AUTHOR("Tiberiu Breana <tiberiu.a.breana@intel.com>");
+MODULE_DESCRIPTION("BMA220 acceleration sensor driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

