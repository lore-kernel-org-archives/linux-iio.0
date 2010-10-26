Return-Path: <vapier@gentoo.org>
From: Mike Frysinger <vapier@gentoo.org>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Cc: device-drivers-devel@blackfin.uclinux.org,
	Barry Song <barry.song@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 22/36] staging: iio: dac: new driver for AD5624R devices
Date: Tue, 26 Oct 2010 14:17:32 -0400
Message-Id: <1288117066-18055-23-git-send-email-vapier@gentoo.org>
In-Reply-To: <1288117066-18055-1-git-send-email-vapier@gentoo.org>
References: <1288117066-18055-1-git-send-email-vapier@gentoo.org>
List-ID: <linux-iio@vger.kernel.org>

From: Barry Song <barry.song@analog.com>

This is used to convert digital streams into voltages.

Signed-off-by: Barry Song <barry.song@analog.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/staging/iio/Kconfig           |    1 +
 drivers/staging/iio/Makefile          |    1 +
 drivers/staging/iio/dac/Kconfig       |   11 ++
 drivers/staging/iio/dac/Makefile      |    5 +
 drivers/staging/iio/dac/ad5624r.h     |   21 +++
 drivers/staging/iio/dac/ad5624r_spi.c |  313 +++++++++++++++++++++++++++++++++
 drivers/staging/iio/dac/dac.h         |    6 +
 7 files changed, 358 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/dac/Kconfig
 create mode 100644 drivers/staging/iio/dac/Makefile
 create mode 100644 drivers/staging/iio/dac/ad5624r.h
 create mode 100644 drivers/staging/iio/dac/ad5624r_spi.c
 create mode 100644 drivers/staging/iio/dac/dac.h

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index b8bb5f1..773c301 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -43,6 +43,7 @@ config IIO_TRIGGER
 source "drivers/staging/iio/accel/Kconfig"
 source "drivers/staging/iio/adc/Kconfig"
 source "drivers/staging/iio/addac/Kconfig"
+source "drivers/staging/iio/dac/Kconfig"
 source "drivers/staging/iio/gyro/Kconfig"
 source "drivers/staging/iio/imu/Kconfig"
 source "drivers/staging/iio/light/Kconfig"
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 0111647..15eba01 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_IIO_SW_RING) += ring_sw.o
 obj-y += accel/
 obj-y += adc/
 obj-y += addac/
+obj-y += dac/
 obj-y += gyro/
 obj-y += imu/
 obj-y += light/
diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kconfig
new file mode 100644
index 0000000..583df78
--- /dev/null
+++ b/drivers/staging/iio/dac/Kconfig
@@ -0,0 +1,11 @@
+#
+# DAC drivers
+#
+comment "Digital to analog convertors"
+
+config AD5624R_SPI
+	tristate "Analog Devices AD5624/44/64R DAC spi driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Analog Devices AD5624R, AD5644R and
+	  AD5664R convertors (DAC). This driver uses the common SPI interface.
diff --git a/drivers/staging/iio/dac/Makefile b/drivers/staging/iio/dac/Makefile
new file mode 100644
index 0000000..7ddf05d
--- /dev/null
+++ b/drivers/staging/iio/dac/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for industrial I/O DAC drivers
+#
+
+obj-$(CONFIG_AD5624R_SPI) += ad5624r_spi.o
diff --git a/drivers/staging/iio/dac/ad5624r.h b/drivers/staging/iio/dac/ad5624r.h
new file mode 100644
index 0000000..ce518be
--- /dev/null
+++ b/drivers/staging/iio/dac/ad5624r.h
@@ -0,0 +1,21 @@
+#ifndef SPI_AD5624R_H_
+#define SPI_AD5624R_H_
+
+#define AD5624R_DAC_CHANNELS	4
+
+#define AD5624R_ADDR_DAC0	0x0
+#define AD5624R_ADDR_DAC1	0x1
+#define AD5624R_ADDR_DAC2	0x2
+#define AD5624R_ADDR_DAC3	0x3
+#define AD5624R_ADDR_ALL_DAC	0x7
+
+#define AD5624R_CMD_WRITE_INPUT_N             0x0
+#define AD5624R_CMD_UPDATE_DAC_N              0x1
+#define AD5624R_CMD_WRITE_INPUT_N_UPDATE_ALL  0x2
+#define AD5624R_CMD_WRITE_INPUT_N_UPDATE_N    0x3
+#define AD5624R_CMD_POWERDOWN_DAC             0x4
+#define AD5624R_CMD_RESET                     0x5
+#define AD5624R_CMD_LDAC_SETUP                0x6
+#define AD5624R_CMD_INTERNAL_REFER_SETUP      0x7
+
+#endif
diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
new file mode 100644
index 0000000..705ff50
--- /dev/null
+++ b/drivers/staging/iio/dac/ad5624r_spi.c
@@ -0,0 +1,313 @@
+/*
+ * AD5624R, AD5644R, AD5664R Digital to analog convertors spi driver
+ *
+ * Copyright 2010 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/gpio.h>
+#include <linux/fs.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/spi/spi.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/delay.h>
+
+#include "../iio.h"
+#include "../sysfs.h"
+#include "dac.h"
+#include "ad5624r.h"
+
+/**
+ * struct ad5624r_state - device related storage
+ * @indio_dev:	associated industrial IO device
+ * @us:		spi device
+ **/
+struct ad5624r_state {
+	struct iio_dev *indio_dev;
+	struct spi_device *us;
+	int data_len;
+	int ldac_mode;
+	int dac_power_mode[AD5624R_DAC_CHANNELS];
+	int internal_ref;
+};
+
+static int ad5624r_spi_write(struct spi_device *spi, u8 cmd, u8 addr, u16 val, u8 len)
+{
+	struct spi_transfer t;
+	struct spi_message m;
+	u32 data;
+	u8 msg[3];
+
+	/*
+	 * The input shift register is 24 bits wide. The first two bits are don't care bits.
+	 * The next three are the command bits, C2 to C0, followed by the 3-bit DAC address,
+	 * A2 to A0, and then the 16-, 14-, 12-bit data-word. The data-word comprises the 16-,
+	 * 14-, 12-bit input code followed by 0, 2, or 4 don't care bits, for the AD5664R,
+	 * AD5644R, and AD5624R, respectively.
+	 */
+	data = (0 << 22) | (cmd << 19) | (addr << 16) | (val << (16 - len));
+	msg[0] = data >> 16;
+	msg[1] = data >> 8;
+	msg[2] = data;
+
+	spi_message_init(&m);
+	memset(&t, 0, (sizeof t));
+	t.tx_buf = &msg[0];
+	t.len = 3;
+
+	spi_message_add_tail(&t, &m);
+	spi_sync(spi, &m);
+
+	return len;
+}
+
+static ssize_t ad5624r_write_dac(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t len)
+{
+	long readin;
+	int ret;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad5624r_state *st = indio_dev->dev_data;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	ret = strict_strtol(buf, 10, &readin);
+	if (ret)
+		return ret;
+
+	ad5624r_spi_write(st->us, AD5624R_CMD_WRITE_INPUT_N_UPDATE_N,
+			this_attr->address, readin, st->data_len);
+	return ret ? ret : len;
+}
+
+static ssize_t ad5624r_read_ldac_mode(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad5624r_state *st = indio_dev->dev_data;
+
+	return sprintf(buf, "%x\n", st->ldac_mode);
+}
+
+static ssize_t ad5624r_write_ldac_mode(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t len)
+{
+	long readin;
+	int ret;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad5624r_state *st = indio_dev->dev_data;
+
+	ret = strict_strtol(buf, 16, &readin);
+	if (ret)
+		return ret;
+
+	ad5624r_spi_write(st->us, AD5624R_CMD_LDAC_SETUP, 0, readin & 0xF, 16);
+	st->ldac_mode = readin & 0xF;
+
+	return ret ? ret : len;
+}
+
+static ssize_t ad5624r_read_dac_power_mode(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad5624r_state *st = indio_dev->dev_data;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	return sprintf(buf, "%d\n", st->dac_power_mode[this_attr->address]);
+}
+
+static ssize_t ad5624r_write_dac_power_mode(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t len)
+{
+	long readin;
+	int ret;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad5624r_state *st = indio_dev->dev_data;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	ret = strict_strtol(buf, 10, &readin);
+	if (ret)
+		return ret;
+
+	ad5624r_spi_write(st->us, AD5624R_CMD_POWERDOWN_DAC, 0,
+			((readin & 0x3) << 4) | (1 << this_attr->address), 16);
+
+	st->dac_power_mode[this_attr->address] = readin & 0x3;
+
+	return ret ? ret : len;
+}
+
+static ssize_t ad5624r_read_internal_ref_mode(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad5624r_state *st = indio_dev->dev_data;
+
+	return sprintf(buf, "%d\n", st->internal_ref);
+}
+
+static ssize_t ad5624r_write_internal_ref_mode(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t len)
+{
+	long readin;
+	int ret;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad5624r_state *st = indio_dev->dev_data;
+
+	ret = strict_strtol(buf, 10, &readin);
+	if (ret)
+		return ret;
+
+	ad5624r_spi_write(st->us, AD5624R_CMD_INTERNAL_REFER_SETUP, 0, !!readin, 16);
+
+	st->internal_ref = !!readin;
+
+	return ret ? ret : len;
+}
+
+static IIO_DEV_ATTR_DAC(0, ad5624r_write_dac, AD5624R_ADDR_DAC0);
+static IIO_DEV_ATTR_DAC(1, ad5624r_write_dac, AD5624R_ADDR_DAC1);
+static IIO_DEV_ATTR_DAC(2, ad5624r_write_dac, AD5624R_ADDR_DAC2);
+static IIO_DEV_ATTR_DAC(3, ad5624r_write_dac, AD5624R_ADDR_DAC3);
+
+static IIO_DEVICE_ATTR(ldac_mode, S_IRUGO | S_IWUSR, ad5624r_read_ldac_mode,
+		ad5624r_write_ldac_mode, 0);
+static IIO_DEVICE_ATTR(internal_ref, S_IRUGO | S_IWUSR, ad5624r_read_internal_ref_mode,
+		ad5624r_write_internal_ref_mode, 0);
+
+#define IIO_DEV_ATTR_DAC_POWER_MODE(_num, _show, _store, _addr)			\
+	IIO_DEVICE_ATTR(dac_power_mode_##_num, S_IRUGO | S_IWUSR, _show, _store, _addr)
+
+static IIO_DEV_ATTR_DAC_POWER_MODE(0, ad5624r_read_dac_power_mode, ad5624r_write_dac_power_mode, 0);
+static IIO_DEV_ATTR_DAC_POWER_MODE(1, ad5624r_read_dac_power_mode, ad5624r_write_dac_power_mode, 1);
+static IIO_DEV_ATTR_DAC_POWER_MODE(2, ad5624r_read_dac_power_mode, ad5624r_write_dac_power_mode, 2);
+static IIO_DEV_ATTR_DAC_POWER_MODE(3, ad5624r_read_dac_power_mode, ad5624r_write_dac_power_mode, 3);
+
+static struct attribute *ad5624r_attributes[] = {
+	&iio_dev_attr_dac_0.dev_attr.attr,
+	&iio_dev_attr_dac_1.dev_attr.attr,
+	&iio_dev_attr_dac_2.dev_attr.attr,
+	&iio_dev_attr_dac_3.dev_attr.attr,
+	&iio_dev_attr_dac_power_mode_0.dev_attr.attr,
+	&iio_dev_attr_dac_power_mode_1.dev_attr.attr,
+	&iio_dev_attr_dac_power_mode_2.dev_attr.attr,
+	&iio_dev_attr_dac_power_mode_3.dev_attr.attr,
+	&iio_dev_attr_ldac_mode.dev_attr.attr,
+	&iio_dev_attr_internal_ref.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ad5624r_attribute_group = {
+	.attrs = ad5624r_attributes,
+};
+
+static int __devinit ad5624r_probe(struct spi_device *spi)
+{
+
+	struct ad5624r_state *st;
+	int ret = 0;
+	char *chip_name = spi->dev.platform_data;
+
+	if (!chip_name)
+		return -ENODEV;
+
+	st = kzalloc(sizeof(*st), GFP_KERNEL);
+	if (st == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+	spi_set_drvdata(spi, st);
+
+	if (strcmp(chip_name, "ad5624r") == 0)
+		st->data_len = 12;
+	else if (strcmp(chip_name, "ad5644r") == 0)
+		st->data_len = 14;
+	else if (strcmp(chip_name, "ad5664r") == 0)
+		st->data_len = 16;
+	else {
+		dev_err(&spi->dev, "not supported chip type\n");
+		ret = -EINVAL;
+		goto error_ret;
+	}
+
+	st->us = spi;
+	st->indio_dev = iio_allocate_device();
+	if (st->indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_free_st;
+	}
+	st->indio_dev->dev.parent = &spi->dev;
+	st->indio_dev->num_interrupt_lines = 0;
+	st->indio_dev->event_attrs = NULL;
+
+	st->indio_dev->attrs = &ad5624r_attribute_group;
+	st->indio_dev->dev_data = (void *)(st);
+	st->indio_dev->driver_module = THIS_MODULE;
+	st->indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = iio_device_register(st->indio_dev);
+	if (ret)
+		goto error_free_dev;
+
+	spi->mode = SPI_MODE_0;
+	spi_setup(spi);
+
+	return 0;
+
+error_free_dev:
+	iio_free_device(st->indio_dev);
+error_free_st:
+	kfree(st);
+error_ret:
+	return ret;
+}
+
+static int __devexit ad5624r_remove(struct spi_device *spi)
+{
+	struct ad5624r_state *st = spi_get_drvdata(spi);
+
+	iio_device_unregister(st->indio_dev);
+	kfree(st);
+
+	return 0;
+}
+
+static struct spi_driver ad5624r_driver = {
+	.driver = {
+		.name = "ad5624r",
+		.owner = THIS_MODULE,
+	},
+	.probe = ad5624r_probe,
+	.remove = __devexit_p(ad5624r_remove),
+};
+
+static __init int ad5624r_spi_init(void)
+{
+	return spi_register_driver(&ad5624r_driver);
+}
+module_init(ad5624r_spi_init);
+
+static __exit void ad5624r_spi_exit(void)
+{
+	spi_unregister_driver(&ad5624r_driver);
+}
+module_exit(ad5624r_spi_exit);
+
+MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
+MODULE_DESCRIPTION("Analog Devices AD5624/44/64R DAC spi driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/dac/dac.h b/drivers/staging/iio/dac/dac.h
new file mode 100644
index 0000000..55005ee
--- /dev/null
+++ b/drivers/staging/iio/dac/dac.h
@@ -0,0 +1,6 @@
+/*
+ * dac.h - sysfs attributes associated with DACs
+ */
+
+#define IIO_DEV_ATTR_DAC(_num, _store, _addr)			\
+	IIO_DEVICE_ATTR(dac_##_num, S_IWUSR, NULL, _store, _addr)
-- 
1.7.3.2
