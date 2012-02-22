Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:34853
	"EHLO VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751871Ab2BVMjW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Feb 2012 07:39:22 -0500
From: <michael.hennerich@analog.com>
To: <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [RFC] iio: amplifiers: New driver for AD8366 Dual-Digital Variable Gain Amplifier
Date: Wed, 22 Feb 2012 13:36:22 +0100
Message-ID: <1329914182-5428-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/Kconfig             |    1 +
 drivers/staging/iio/Makefile            |    1 +
 drivers/staging/iio/amplifiers/Kconfig  |   17 +++
 drivers/staging/iio/amplifiers/Makefile |    5 +
 drivers/staging/iio/amplifiers/ad8366.c |  228 +++++++++++++++++++++++++++++++
 5 files changed, 252 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/amplifiers/Kconfig
 create mode 100644 drivers/staging/iio/amplifiers/Makefile
 create mode 100644 drivers/staging/iio/amplifiers/ad8366.c

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index 2b56823..fd7a164 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -59,6 +59,7 @@ config IIO_CONSUMERS_PER_TRIGGER
 source "drivers/staging/iio/accel/Kconfig"
 source "drivers/staging/iio/adc/Kconfig"
 source "drivers/staging/iio/addac/Kconfig"
+source "drivers/staging/iio/amplifiers/Kconfig"
 source "drivers/staging/iio/cdc/Kconfig"
 source "drivers/staging/iio/dac/Kconfig"
 source "drivers/staging/iio/frequency/Kconfig"
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 0161095..c52cde3 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_IIO_DUMMY_EVGEN) += iio_dummy_evgen.o
 obj-y += accel/
 obj-y += adc/
 obj-y += addac/
+obj-y += amplifiers/
 obj-y += cdc/
 obj-y += dac/
 obj-y += frequency/
diff --git a/drivers/staging/iio/amplifiers/Kconfig b/drivers/staging/iio/amplifiers/Kconfig
new file mode 100644
index 0000000..05d707e
--- /dev/null
+++ b/drivers/staging/iio/amplifiers/Kconfig
@@ -0,0 +1,17 @@
+#
+# Gain Amplifiers, etc.
+#
+menu "Amplifiers"
+
+config AD8366
+	tristate "Analog Devices AD8366 VGA"
+	depends on SPI
+	select BITREVERSE
+	help
+	  Say yes here to build support for Analog Devices AD8366
+	  SPI Dual-Digital Variable Gain Amplifier (VGA).
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad8366.
+
+endmenu
diff --git a/drivers/staging/iio/amplifiers/Makefile b/drivers/staging/iio/amplifiers/Makefile
new file mode 100644
index 0000000..a6ca366
--- /dev/null
+++ b/drivers/staging/iio/amplifiers/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile iio/amplifiers
+#
+
+obj-$(CONFIG_AD8366) += ad8366.o
diff --git a/drivers/staging/iio/amplifiers/ad8366.c b/drivers/staging/iio/amplifiers/ad8366.c
new file mode 100644
index 0000000..187606f
--- /dev/null
+++ b/drivers/staging/iio/amplifiers/ad8366.c
@@ -0,0 +1,228 @@
+/*
+ * AD8366 SPI Dual-Digital Variable Gain Amplifier (VGA)
+ *
+ * Copyright 2012 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/spi/spi.h>
+#include <linux/regulator/consumer.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/bitrev.h>
+
+#include "../iio.h"
+#include "../sysfs.h"
+
+struct ad8366_state {
+	struct spi_device	*spi;
+	struct regulator	*reg;
+	unsigned char		ch_a;
+	unsigned char		ch_b;
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	unsigned char		data[2] ____cacheline_aligned;
+};
+
+static int ad8366_write(struct iio_dev *indio_dev,
+			unsigned char ch_a, char unsigned ch_b)
+{
+	struct ad8366_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ch_a = bitrev8(ch_a & 0x3F);
+	ch_b = bitrev8(ch_b & 0x3F);
+
+	st->data[0] = ch_b >> 4;
+	st->data[1] = (ch_b << 4) | (ch_a >> 2);
+
+	ret = spi_write(st->spi, st->data, ARRAY_SIZE(st->data));
+	if (ret < 0)
+		dev_err(&indio_dev->dev, "write failed (%d)", ret);
+
+	return ret;
+}
+
+static int ad8366_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long m)
+{
+	struct ad8366_state *st = iio_priv(indio_dev);
+	int ret;
+	unsigned code;
+
+	mutex_lock(&indio_dev->mlock);
+	switch (m) {
+	case 0:
+		if (chan->channel == 0)
+			code = st->ch_a;
+		else
+			code = st->ch_b;
+
+		/* Values in dB */
+		code = code * 253 + 4500;
+		*val = code / 1000;
+		*val2 = (code % 1000) * 1000;
+
+		ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret;
+};
+
+static int ad8366_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val,
+			    int val2,
+			    long mask)
+{
+	struct ad8366_state *st = iio_priv(indio_dev);
+	unsigned code;
+	int ret;
+
+	/* Values in dB */
+	code = (((u8)val * 1000) + ((u32)val2 / 1000));
+
+	if (code > 20500 || code < 4500)
+		return -EINVAL;
+
+	code = (code - 4500) / 253;
+
+	mutex_lock(&indio_dev->mlock);
+	switch (mask) {
+	case 0:
+		if (chan->channel == 0)
+			st->ch_a = code;
+		else
+			st->ch_b = code;
+
+		ret = ad8366_write(indio_dev, st->ch_a, st->ch_b);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret;
+}
+
+static const struct iio_info ad8366_info = {
+	.read_raw = &ad8366_read_raw,
+	.write_raw = &ad8366_write_raw,
+	.driver_module = THIS_MODULE,
+};
+
+#define AD8366_CHAN(_channel, _name) {			\
+	.type = IIO_ALTVOLTAGE,				\
+	.output = 1,					\
+	.indexed = 1,					\
+	.processed_val = 1,				\
+	.channel = _channel,				\
+	.extend_name = _name,				\
+}
+
+static const struct iio_chan_spec ad8366_channels[] = {
+	AD8366_CHAN(0, "gain"),
+	AD8366_CHAN(1, "gain"),
+};
+
+static int __devinit ad8366_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct ad8366_state *st;
+	int ret;
+
+	indio_dev = iio_allocate_device(sizeof(*st));
+	if (indio_dev == NULL)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	st->reg = regulator_get(&spi->dev, "vcc");
+	if (!IS_ERR(st->reg)) {
+		ret = regulator_enable(st->reg);
+		if (ret)
+			goto error_put_reg;
+	}
+
+	spi_set_drvdata(spi, indio_dev);
+	st->spi = spi;
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->info = &ad8366_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ad8366_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad8366_channels);
+
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_disable_reg;
+
+	ad8366_write(indio_dev, 0 , 0);
+
+	return 0;
+
+error_disable_reg:
+	if (!IS_ERR(st->reg))
+		regulator_disable(st->reg);
+error_put_reg:
+	if (!IS_ERR(st->reg))
+		regulator_put(st->reg);
+
+	iio_free_device(indio_dev);
+
+	return ret;
+}
+
+static int __devexit ad8366_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct ad8366_state *st = iio_priv(indio_dev);
+	struct regulator *reg = st->reg;
+
+	iio_device_unregister(indio_dev);
+
+	if (!IS_ERR(reg)) {
+		regulator_disable(reg);
+		regulator_put(reg);
+	}
+
+	iio_free_device(indio_dev);
+
+	return 0;
+}
+
+static const struct spi_device_id ad8366_id[] = {
+	{"ad8366", 0},
+	{}
+};
+
+static struct spi_driver ad8366_driver = {
+	.driver = {
+		.name	= KBUILD_MODNAME,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= ad8366_probe,
+	.remove		= __devexit_p(ad8366_remove),
+	.id_table	= ad8366_id,
+};
+
+module_spi_driver(ad8366_driver);
+
+MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_DESCRIPTION("Analog Devices AD8366 VGA");
+MODULE_LICENSE("GPL v2");
--
1.7.0.4


