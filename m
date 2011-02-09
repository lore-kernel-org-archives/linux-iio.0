Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: greg@kroah.com, jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] IIO: DDS: AD9832 / AD9835 driver
Date: Wed, 9 Feb 2011 11:03:29 +0100
Message-ID: <1297245809-23437-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

This is a complete rewrite of the AD9832/35 driver.
Purpose was to move this driver to the recently
created API for such devices.

Changes since V1:
IIO: DDS: AD9832 / AD9835 driver: Apply review feedback

Save a few bytes, use union for data allocated for spi buffers.
Remove use of device IDs.
Fix comments.
Make master clock mclk always type unsigned long.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/dds/Kconfig  |    5 +-
 drivers/staging/iio/dds/ad9832.c |  488 ++++++++++++++++++++++++--------------
 drivers/staging/iio/dds/ad9832.h |  128 ++++++++++
 3 files changed, 436 insertions(+), 185 deletions(-)
 create mode 100644 drivers/staging/iio/dds/ad9832.h

diff --git a/drivers/staging/iio/dds/Kconfig b/drivers/staging/iio/dds/Kconfig
index a047da6..06b6f3a 100644
--- a/drivers/staging/iio/dds/Kconfig
+++ b/drivers/staging/iio/dds/Kconfig
@@ -15,7 +15,10 @@ config AD9832
 	depends on SPI
 	help
 	  Say yes here to build support for Analog Devices DDS chip
-	  ad9832 and ad9835, provides direct access via sysfs.
+	  AD9832 and AD9835, provides direct access via sysfs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad9832.

 config AD9834
 	tristate "Analog Devices ad9833/4/ driver"
diff --git a/drivers/staging/iio/dds/ad9832.c b/drivers/staging/iio/dds/ad9832.c
index e911893..3e8491f 100644
--- a/drivers/staging/iio/dds/ad9832.c
+++ b/drivers/staging/iio/dds/ad9832.c
@@ -1,228 +1,336 @@
 /*
- * Driver for ADI Direct Digital Synthesis ad9832
+ * AD9832 SPI DDS driver
  *
- * Copyright (c) 2010 Analog Devices Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ * Copyright 2011 Analog Devices Inc.
  *
+ * Licensed under the GPL-2.
  */
-#include <linux/types.h>
-#include <linux/mutex.h>
+
 #include <linux/device.h>
-#include <linux/spi/spi.h>
+#include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
+#include <linux/spi/spi.h>
+#include <linux/regulator/consumer.h>
+#include <linux/err.h>
+#include <asm/div64.h>

 #include "../iio.h"
 #include "../sysfs.h"
+#include "dds.h"

-#define DRV_NAME "ad9832"
-
-#define value_mask (u16)0xf000
-#define cmd_shift 12
-#define add_shift 8
-#define AD9832_SYNC (1 << 13)
-#define AD9832_SELSRC (1 << 12)
-#define AD9832_SLEEP (1 << 13)
-#define AD9832_RESET (1 << 12)
-#define AD9832_CLR (1 << 11)
-
-#define ADD_FREQ0LL 0x0
-#define ADD_FREQ0HL 0x1
-#define ADD_FREQ0LM 0x2
-#define ADD_FREQ0HM 0x3
-#define ADD_FREQ1LL 0x4
-#define ADD_FREQ1HL 0x5
-#define ADD_FREQ1LM 0x6
-#define ADD_FREQ1HM 0x7
-#define ADD_PHASE0L 0x8
-#define ADD_PHASE0H 0x9
-#define ADD_PHASE1L 0xa
-#define ADD_PHASE1H 0xb
-#define ADD_PHASE2L 0xc
-#define ADD_PHASE2H 0xd
-#define ADD_PHASE3L 0xe
-#define ADD_PHASE3H 0xf
-
-#define CMD_PHA8BITSW 0x1
-#define CMD_PHA16BITSW 0x0
-#define CMD_FRE8BITSW 0x3
-#define CMD_FRE16BITSW 0x2
-#define CMD_SELBITSCTL 0x6
-
-struct ad9832_setting {
-	u16 freq0[4];
-	u16 freq1[4];
-	u16 phase0[2];
-	u16 phase1[2];
-	u16 phase2[2];
-	u16 phase3[2];
-};
+#include "ad9832.h"

-struct ad9832_state {
-	struct mutex lock;
-	struct iio_dev *idev;
-	struct spi_device *sdev;
-};
-
-static ssize_t ad9832_set_parameter(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf,
-					size_t len)
+static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
-	struct spi_message msg;
-	struct spi_transfer xfer;
-	int ret;
-	struct ad9832_setting config;
-	struct iio_dev *idev = dev_get_drvdata(dev);
-	struct ad9832_state *st = idev->dev_data;
-
-	config.freq0[0] = (CMD_FRE8BITSW << add_shift | ADD_FREQ0LL << add_shift | buf[0]);
-	config.freq0[1] = (CMD_FRE16BITSW << add_shift | ADD_FREQ0HL << add_shift | buf[1]);
-	config.freq0[2] = (CMD_FRE8BITSW << add_shift | ADD_FREQ0LM << add_shift | buf[2]);
-	config.freq0[3] = (CMD_FRE16BITSW << add_shift | ADD_FREQ0HM << add_shift | buf[3]);
-	config.freq1[0] = (CMD_FRE8BITSW << add_shift | ADD_FREQ1LL << add_shift | buf[4]);
-	config.freq1[1] = (CMD_FRE16BITSW << add_shift | ADD_FREQ1HL << add_shift | buf[5]);
-	config.freq1[2] = (CMD_FRE8BITSW << add_shift | ADD_FREQ1LM << add_shift | buf[6]);
-	config.freq1[3] = (CMD_FRE16BITSW << add_shift | ADD_FREQ1HM << add_shift | buf[7]);
-
-	config.phase0[0] = (CMD_PHA8BITSW << add_shift | ADD_PHASE0L << add_shift | buf[9]);
-	config.phase0[1] = (CMD_PHA16BITSW << add_shift | ADD_PHASE0H << add_shift | buf[10]);
-	config.phase1[0] = (CMD_PHA8BITSW << add_shift | ADD_PHASE1L << add_shift | buf[11]);
-	config.phase1[1] = (CMD_PHA16BITSW << add_shift | ADD_PHASE1H << add_shift | buf[12]);
-	config.phase2[0] = (CMD_PHA8BITSW << add_shift | ADD_PHASE2L << add_shift | buf[13]);
-	config.phase2[1] = (CMD_PHA16BITSW << add_shift | ADD_PHASE2H << add_shift | buf[14]);
-	config.phase3[0] = (CMD_PHA8BITSW << add_shift | ADD_PHASE3L << add_shift | buf[15]);
-	config.phase3[1] = (CMD_PHA16BITSW << add_shift | ADD_PHASE3H << add_shift | buf[16]);
-
-	xfer.len = 2 * len;
-	xfer.tx_buf = &config;
-	mutex_lock(&st->lock);
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->sdev, &msg);
-	if (ret)
-		goto error_ret;
-error_ret:
-	mutex_unlock(&st->lock);
+	unsigned long long freqreg = (u64) fout *
+				     (u64) ((u64) 1L << AD9832_FREQ_BITS);
+	do_div(freqreg, mclk);
+	return freqreg;
+}

-	return ret ? ret : len;
+static int ad9832_write_frequency(struct ad9832_state *st,
+				  unsigned addr, unsigned long fout)
+{
+	unsigned long regval;
+
+	if (fout > (st->mclk / 2))
+		return -EINVAL;
+
+	regval = ad9832_calc_freqreg(st->mclk, fout);
+
+	st->freq_data[0] = cpu_to_be16((AD9832_CMD_FRE8BITSW << CMD_SHIFT) |
+					(addr << ADD_SHIFT) |
+					((regval >> 24) & 0xFF));
+	st->freq_data[1] = cpu_to_be16((AD9832_CMD_FRE16BITSW << CMD_SHIFT) |
+					((addr - 1) << ADD_SHIFT) |
+					((regval >> 16) & 0xFF));
+	st->freq_data[2] = cpu_to_be16((AD9832_CMD_FRE8BITSW << CMD_SHIFT) |
+					((addr - 2) << ADD_SHIFT) |
+					((regval >> 8) & 0xFF));
+	st->freq_data[3] = cpu_to_be16((AD9832_CMD_FRE16BITSW << CMD_SHIFT) |
+					((addr - 3) << ADD_SHIFT) |
+					((regval >> 0) & 0xFF));
+
+	return spi_sync(st->spi, &st->freq_msg);;
 }

-static IIO_DEVICE_ATTR(dds, S_IWUSR, NULL, ad9832_set_parameter, 0);
+static int ad9832_write_phase(struct ad9832_state *st,
+				  unsigned long addr, unsigned long phase)
+{
+	if (phase > (1 << AD9832_PHASE_BITS))
+		return -EINVAL;

-static struct attribute *ad9832_attributes[] = {
-	&iio_dev_attr_dds.dev_attr.attr,
-	NULL,
-};
+	st->phase_data[0] = cpu_to_be16((AD9832_CMD_PHA8BITSW << CMD_SHIFT) |
+					(addr << ADD_SHIFT) |
+					((phase >> 8) & 0xFF));
+	st->phase_data[1] = cpu_to_be16((AD9832_CMD_PHA16BITSW << CMD_SHIFT) |
+					((addr - 1) << ADD_SHIFT) |
+					(phase & 0xFF));

-static const struct attribute_group ad9832_attribute_group = {
-	.name = DRV_NAME,
-	.attrs = ad9832_attributes,
-};
+	return spi_sync(st->spi, &st->phase_msg);
+}

-static void ad9832_init(struct ad9832_state *st)
+static ssize_t ad9832_write(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t len)
 {
-	struct spi_message msg;
-	struct spi_transfer xfer;
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct ad9832_state *st = dev_info->dev_data;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret;
-	u16 config = 0;
-
-	config = 0x3 << 14 | AD9832_SLEEP | AD9832_RESET | AD9832_CLR;
+	long val;

-	mutex_lock(&st->lock);
-
-	xfer.len = 2;
-	xfer.tx_buf = &config;
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->sdev, &msg);
+	ret = strict_strtoul(buf, 10, &val);
 	if (ret)
 		goto error_ret;

-	config = 0x2 << 14 | AD9832_SYNC | AD9832_SELSRC;
-	xfer.len = 2;
-	xfer.tx_buf = &config;
+	mutex_lock(&dev_info->mlock);
+	switch (this_attr->address) {
+	case AD9832_FREQ0HM:
+	case AD9832_FREQ1HM:
+		ret = ad9832_write_frequency(st, this_attr->address, val);
+		break;
+	case AD9832_PHASE0H:
+	case AD9832_PHASE1H:
+	case AD9832_PHASE2H:
+	case AD9832_PHASE3H:
+		ret = ad9832_write_phase(st, this_attr->address, val);
+		break;
+	case AD9832_PINCTRL_EN:
+		if (val)
+			st->ctrl_ss &= ~AD9832_SELSRC;
+		else
+			st->ctrl_ss |= AD9832_SELSRC;
+		st->data = cpu_to_be16((AD9832_CMD_SYNCSELSRC << CMD_SHIFT) |
+					st->ctrl_ss);
+		ret = spi_sync(st->spi, &st->msg);
+		break;
+	case AD9832_FREQ_SYM:
+		if (val == 1)
+			st->ctrl_fp |= AD9832_FREQ;
+		else if (val == 0)
+			st->ctrl_fp &= ~AD9832_FREQ;
+		else {
+			ret = -EINVAL;
+			break;
+		}
+		st->data = cpu_to_be16((AD9832_CMD_FPSELECT << CMD_SHIFT) |
+					st->ctrl_fp);
+		ret = spi_sync(st->spi, &st->msg);
+		break;
+	case AD9832_PHASE_SYM:
+		if (val < 0 || val > 3) {
+			ret = -EINVAL;
+			break;
+		}
+
+		st->ctrl_fp &= ~AD9832_PHASE(3);
+		st->ctrl_fp |= AD9832_PHASE(val);
+
+		st->data = cpu_to_be16((AD9832_CMD_FPSELECT << CMD_SHIFT) |
+					st->ctrl_fp);
+		ret = spi_sync(st->spi, &st->msg);
+		break;
+	case AD9832_OUTPUT_EN:
+		if (val)
+			st->ctrl_src &= ~(AD9832_RESET | AD9832_SLEEP |
+					AD9832_CLR);
+		else
+			st->ctrl_src |= AD9832_RESET;
+
+		st->data = cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
+					st->ctrl_src);
+		ret = spi_sync(st->spi, &st->msg);
+		break;
+	default:
+		ret = -ENODEV;
+	}
+	mutex_unlock(&dev_info->mlock);

-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->sdev, &msg);
-	if (ret)
-		goto error_ret;
+error_ret:
+	return ret ? ret : len;
+}

-	config = CMD_SELBITSCTL << cmd_shift;
-	xfer.len = 2;
-	xfer.tx_buf = &config;
+static ssize_t ad9832_show_name(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct ad9832_state *st = iio_dev_get_devdata(dev_info);

-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->sdev, &msg);
-	if (ret)
-		goto error_ret;
+	return sprintf(buf, "%s\n", spi_get_device_id(st->spi)->name);
+}
+static IIO_DEVICE_ATTR(name, S_IRUGO, ad9832_show_name, NULL, 0);

-	config = 0x3 << 14;
+/**
+ * see dds.h for further information
+ */

-	xfer.len = 2;
-	xfer.tx_buf = &config;
+static IIO_DEV_ATTR_FREQ(0, 0, S_IWUSR, NULL, ad9832_write, AD9832_FREQ0HM);
+static IIO_DEV_ATTR_FREQ(0, 1, S_IWUSR, NULL, ad9832_write, AD9832_FREQ1HM);
+static IIO_DEV_ATTR_FREQSYMBOL(0, S_IWUSR, NULL, ad9832_write, AD9832_FREQ_SYM);
+static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */

-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->sdev, &msg);
-	if (ret)
-		goto error_ret;
-error_ret:
-	mutex_unlock(&st->lock);
+static IIO_DEV_ATTR_PHASE(0, 0, S_IWUSR, NULL, ad9832_write, AD9832_PHASE0H);
+static IIO_DEV_ATTR_PHASE(0, 1, S_IWUSR, NULL, ad9832_write, AD9832_PHASE1H);
+static IIO_DEV_ATTR_PHASE(0, 2, S_IWUSR, NULL, ad9832_write, AD9832_PHASE2H);
+static IIO_DEV_ATTR_PHASE(0, 3, S_IWUSR, NULL, ad9832_write, AD9832_PHASE3H);
+static IIO_DEV_ATTR_PHASESYMBOL(0, S_IWUSR, NULL,
+				ad9832_write, AD9832_PHASE_SYM);
+static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12 rad*/

+static IIO_DEV_ATTR_PINCONTROL_EN(0, S_IWUSR, NULL,
+				ad9832_write, AD9832_PINCTRL_EN);
+static IIO_DEV_ATTR_OUT_ENABLE(0, S_IWUSR, NULL,
+				ad9832_write, AD9832_OUTPUT_EN);

+static struct attribute *ad9832_attributes[] = {
+	&iio_dev_attr_dds0_freq0.dev_attr.attr,
+	&iio_dev_attr_dds0_freq1.dev_attr.attr,
+	&iio_const_attr_dds0_freq_scale.dev_attr.attr,
+	&iio_dev_attr_dds0_phase0.dev_attr.attr,
+	&iio_dev_attr_dds0_phase1.dev_attr.attr,
+	&iio_dev_attr_dds0_phase2.dev_attr.attr,
+	&iio_dev_attr_dds0_phase3.dev_attr.attr,
+	&iio_const_attr_dds0_phase_scale.dev_attr.attr,
+	&iio_dev_attr_dds0_pincontrol_en.dev_attr.attr,
+	&iio_dev_attr_dds0_freqsymbol.dev_attr.attr,
+	&iio_dev_attr_dds0_phasesymbol.dev_attr.attr,
+	&iio_dev_attr_dds0_out_enable.dev_attr.attr,
+	&iio_dev_attr_name.dev_attr.attr,
+	NULL,
+};

-}
+static const struct attribute_group ad9832_attribute_group = {
+	.attrs = ad9832_attributes,
+};

 static int __devinit ad9832_probe(struct spi_device *spi)
 {
+	struct ad9832_platform_data *pdata = spi->dev.platform_data;
 	struct ad9832_state *st;
-	int ret = 0;
+	int ret;
+
+	if (!pdata) {
+		dev_dbg(&spi->dev, "no platform data?\n");
+		return -ENODEV;
+	}

 	st = kzalloc(sizeof(*st), GFP_KERNEL);
 	if (st == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-	spi_set_drvdata(spi, st);

-	mutex_init(&st->lock);
-	st->sdev = spi;
+	st->reg = regulator_get(&spi->dev, "vcc");
+	if (!IS_ERR(st->reg)) {
+		ret = regulator_enable(st->reg);
+		if (ret)
+			goto error_put_reg;
+	}
+
+	st->mclk = pdata->mclk;
+
+	spi_set_drvdata(spi, st);
+	st->spi = spi;

-	st->idev = iio_allocate_device();
-	if (st->idev == NULL) {
+	st->indio_dev = iio_allocate_device();
+	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
-		goto error_free_st;
+		goto error_disable_reg;
 	}
-	st->idev->dev.parent = &spi->dev;
-	st->idev->num_interrupt_lines = 0;
-	st->idev->event_attrs = NULL;

-	st->idev->attrs = &ad9832_attribute_group;
-	st->idev->dev_data = (void *)(st);
-	st->idev->driver_module = THIS_MODULE;
-	st->idev->modes = INDIO_DIRECT_MODE;
+	st->indio_dev->dev.parent = &spi->dev;
+	st->indio_dev->attrs = &ad9832_attribute_group;
+	st->indio_dev->dev_data = (void *) st;
+	st->indio_dev->driver_module = THIS_MODULE;
+	st->indio_dev->modes = INDIO_DIRECT_MODE;
+
+	/* Setup default messages */
+
+	st->xfer.tx_buf = &st->data;
+	st->xfer.len = 2;
+
+	spi_message_init(&st->msg);
+	spi_message_add_tail(&st->xfer, &st->msg);
+
+	st->freq_xfer[0].tx_buf = &st->freq_data[0];
+	st->freq_xfer[0].len = 2;
+	st->freq_xfer[0].cs_change = 1;
+	st->freq_xfer[1].tx_buf = &st->freq_data[1];
+	st->freq_xfer[1].len = 2;
+	st->freq_xfer[1].cs_change = 1;
+	st->freq_xfer[2].tx_buf = &st->freq_data[2];
+	st->freq_xfer[2].len = 2;
+	st->freq_xfer[2].cs_change = 1;
+	st->freq_xfer[3].tx_buf = &st->freq_data[3];
+	st->freq_xfer[3].len = 2;
+
+	spi_message_init(&st->freq_msg);
+	spi_message_add_tail(&st->freq_xfer[0], &st->freq_msg);
+	spi_message_add_tail(&st->freq_xfer[1], &st->freq_msg);
+	spi_message_add_tail(&st->freq_xfer[2], &st->freq_msg);
+	spi_message_add_tail(&st->freq_xfer[3], &st->freq_msg);
+
+	st->phase_xfer[0].tx_buf = &st->phase_data[0];
+	st->phase_xfer[0].len = 2;
+	st->phase_xfer[0].cs_change = 1;
+	st->phase_xfer[1].tx_buf = &st->phase_data[1];
+	st->phase_xfer[1].len = 2;
+
+	spi_message_init(&st->phase_msg);
+	spi_message_add_tail(&st->phase_xfer[0], &st->phase_msg);
+	spi_message_add_tail(&st->phase_xfer[1], &st->phase_msg);
+
+	st->ctrl_src = AD9832_SLEEP | AD9832_RESET | AD9832_CLR;
+	st->data = cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
+					st->ctrl_src);
+	ret = spi_sync(st->spi, &st->msg);
+	if (ret) {
+		dev_err(&spi->dev, "device init failed\n");
+		goto error_free_device;
+	}
+
+	ret = ad9832_write_frequency(st, AD9832_FREQ0HM, pdata->freq0);
+	if (ret)
+		goto error_free_device;
+
+	ret = ad9832_write_frequency(st, AD9832_FREQ1HM, pdata->freq1);
+	if (ret)
+		goto error_free_device;
+
+	ret = ad9832_write_phase(st, AD9832_PHASE0H, pdata->phase0);
+	if (ret)
+		goto error_free_device;
+
+	ret = ad9832_write_phase(st, AD9832_PHASE1H, pdata->phase1);
+	if (ret)
+		goto error_free_device;

-	ret = iio_device_register(st->idev);
+	ret = ad9832_write_phase(st, AD9832_PHASE2H, pdata->phase2);
 	if (ret)
-		goto error_free_dev;
-	spi->max_speed_hz = 2000000;
-	spi->mode = SPI_MODE_3;
-	spi->bits_per_word = 16;
-	spi_setup(spi);
-	ad9832_init(st);
+		goto error_free_device;
+
+	ret = ad9832_write_phase(st, AD9832_PHASE3H, pdata->phase3);
+	if (ret)
+		goto error_free_device;
+
+	ret = iio_device_register(st->indio_dev);
+	if (ret)
+		goto error_free_device;
+
 	return 0;

-error_free_dev:
-	iio_free_device(st->idev);
-error_free_st:
+error_free_device:
+	iio_free_device(st->indio_dev);
+error_disable_reg:
+	if (!IS_ERR(st->reg))
+		regulator_disable(st->reg);
+error_put_reg:
+	if (!IS_ERR(st->reg))
+		regulator_put(st->reg);
 	kfree(st);
 error_ret:
 	return ret;
@@ -232,33 +340,45 @@ static int __devexit ad9832_remove(struct spi_device *spi)
 {
 	struct ad9832_state *st = spi_get_drvdata(spi);

-	iio_device_unregister(st->idev);
+	iio_device_unregister(st->indio_dev);
+	if (!IS_ERR(st->reg)) {
+		regulator_disable(st->reg);
+		regulator_put(st->reg);
+	}
 	kfree(st);
-
 	return 0;
 }

+static const struct spi_device_id ad9832_id[] = {
+	{"ad9832", 0},
+	{"ad9835", 0},
+	{}
+};
+
 static struct spi_driver ad9832_driver = {
 	.driver = {
-		.name = DRV_NAME,
-		.owner = THIS_MODULE,
+		.name	= "ad9832",
+		.bus	= &spi_bus_type,
+		.owner	= THIS_MODULE,
 	},
-	.probe = ad9832_probe,
-	.remove = __devexit_p(ad9832_remove),
+	.probe		= ad9832_probe,
+	.remove		= __devexit_p(ad9832_remove),
+	.id_table	= ad9832_id,
 };

-static __init int ad9832_spi_init(void)
+static int __init ad9832_init(void)
 {
 	return spi_register_driver(&ad9832_driver);
 }
-module_init(ad9832_spi_init);
+module_init(ad9832_init);

-static __exit void ad9832_spi_exit(void)
+static void __exit ad9832_exit(void)
 {
 	spi_unregister_driver(&ad9832_driver);
 }
-module_exit(ad9832_spi_exit);
+module_exit(ad9832_exit);

-MODULE_AUTHOR("Cliff Cai");
-MODULE_DESCRIPTION("Analog Devices ad9832 driver");
+MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_DESCRIPTION("Analog Devices AD9832/AD9835 DDS");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:ad9832");
diff --git a/drivers/staging/iio/dds/ad9832.h b/drivers/staging/iio/dds/ad9832.h
new file mode 100644
index 0000000..5d47454
--- /dev/null
+++ b/drivers/staging/iio/dds/ad9832.h
@@ -0,0 +1,128 @@
+/*
+ * AD9832 SPI DDS driver
+ *
+ * Copyright 2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+#ifndef IIO_DDS_AD9832_H_
+#define IIO_DDS_AD9832_H_
+
+/* Registers */
+
+#define AD9832_FREQ0LL		0x0
+#define AD9832_FREQ0HL		0x1
+#define AD9832_FREQ0LM		0x2
+#define AD9832_FREQ0HM		0x3
+#define AD9832_FREQ1LL		0x4
+#define AD9832_FREQ1HL		0x5
+#define AD9832_FREQ1LM		0x6
+#define AD9832_FREQ1HM		0x7
+#define AD9832_PHASE0L		0x8
+#define AD9832_PHASE0H		0x9
+#define AD9832_PHASE1L		0xA
+#define AD9832_PHASE1H		0xB
+#define AD9832_PHASE2L		0xC
+#define AD9832_PHASE2H		0xD
+#define AD9832_PHASE3L		0xE
+#define AD9832_PHASE3H		0xF
+
+#define AD9832_PHASE_SYM	0x10
+#define AD9832_FREQ_SYM		0x11
+#define AD9832_PINCTRL_EN	0x12
+#define AD9832_OUTPUT_EN	0x13
+
+/* Command Control Bits */
+
+#define AD9832_CMD_PHA8BITSW	0x1
+#define AD9832_CMD_PHA16BITSW	0x0
+#define AD9832_CMD_FRE8BITSW	0x3
+#define AD9832_CMD_FRE16BITSW	0x2
+#define AD9832_CMD_FPSELECT	0x6
+#define AD9832_CMD_SYNCSELSRC	0x8
+#define AD9832_CMD_SLEEPRESCLR	0xC
+
+#define AD9832_FREQ		(1 << 11)
+#define AD9832_PHASE(x)		(((x) & 3) << 9)
+#define AD9832_SYNC		(1 << 13)
+#define AD9832_SELSRC		(1 << 12)
+#define AD9832_SLEEP		(1 << 13)
+#define AD9832_RESET		(1 << 12)
+#define AD9832_CLR		(1 << 11)
+#define CMD_SHIFT		12
+#define ADD_SHIFT		8
+#define AD9832_FREQ_BITS	32
+#define AD9832_PHASE_BITS	12
+#define RES_MASK(bits)		((1 << (bits)) - 1)
+
+/**
+ * struct ad9832_state - driver instance specific data
+ * @indio_dev:		the industrial I/O device
+ * @spi:		spi_device
+ * @reg:		supply regulator
+ * @mclk:		external master clock
+ * @ctrl_fp:		cached frequency/phase control word
+ * @ctrl_ss:		cached sync/selsrc control word
+ * @ctrl_src:		cached sleep/reset/clr word
+ * @xfer:		default spi transfer
+ * @msg:		default spi message
+ * @freq_xfer:		tuning word spi transfer
+ * @freq_msg:		tuning word spi message
+ * @phase_xfer:		tuning word spi transfer
+ * @phase_msg:		tuning word spi message
+ * @data:		spi transmit buffer
+ * @phase_data:		tuning word spi transmit buffer
+ * @freq_data:		tuning word spi transmit buffer
+ */
+
+struct ad9832_state {
+	struct iio_dev			*indio_dev;
+	struct spi_device		*spi;
+	struct regulator		*reg;
+	unsigned long			mclk;
+	unsigned short			ctrl_fp;
+	unsigned short			ctrl_ss;
+	unsigned short			ctrl_src;
+	struct spi_transfer		xfer;
+	struct spi_message		msg;
+	struct spi_transfer		freq_xfer[4];
+	struct spi_message		freq_msg;
+	struct spi_transfer		phase_xfer[2];
+	struct spi_message		phase_msg;
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	union {
+		unsigned short		freq_data[4]____cacheline_aligned;
+		unsigned short		phase_data[2];
+		unsigned short		data;
+	};
+};
+
+/*
+ * TODO: struct ad9832_platform_data needs to go into include/linux/iio
+ */
+
+/**
+ * struct ad9832_platform_data - platform specific information
+ * @mclk:		master clock in Hz
+ * @freq0:		power up freq0 tuning word in Hz
+ * @freq1:		power up freq1 tuning word in Hz
+ * @phase0:		power up phase0 value [0..4095] correlates with 0..2PI
+ * @phase1:		power up phase1 value [0..4095] correlates with 0..2PI
+ * @phase2:		power up phase2 value [0..4095] correlates with 0..2PI
+ * @phase3:		power up phase3 value [0..4095] correlates with 0..2PI
+ */
+
+struct ad9832_platform_data {
+	unsigned long		mclk;
+	unsigned long		freq0;
+	unsigned long		freq1;
+	unsigned short		phase0;
+	unsigned short		phase1;
+	unsigned short		phase2;
+	unsigned short		phase3;
+};
+
+#endif /* IIO_DDS_AD9832_H_ */
--
1.6.0.2
