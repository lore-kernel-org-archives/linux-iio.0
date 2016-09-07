Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34186 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932255AbcIGRzt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Sep 2016 13:55:49 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 2/2] iio: 104-quad-8: Add IIO support for the ACCES 104-QUAD-8
Date: Wed,  7 Sep 2016 13:55:41 -0400
Message-Id: <529813321ba41afddb9fe1dcc97b3e04759007ad.1473265537.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1473265537.git.vilhelm.gray@gmail.com>
References: <cover.1473265537.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ACCES 104-QUAD-8 is a general purpose quadrature encoder
counter/interface board. The 104-QUAD-8 is capable of monitoring the
outputs of eight encoders via four on-board LSI/CSI LS7266R1 24-bit
dual-axis quadrature counter chips. Core functions handled by the
LS7266R1, such as direction and total count, are available.

Index interrupts (FLG1) are not supported by this driver. Furthermore,
the index function is disabled; non-synchorous mode is enabled for
non-quadrature and quadrature count modes. Performing a write of 0 to
a counter's IIO_CHAN_INFO_FLAGS clears the respective clearable flags.

This driver adds IIO support for the ACCES 104-QUAD-8 and ACCES
104-QUAD-4. The base port addresses for the devices may be configured
via the base array module parameter.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 MAINTAINERS                      |   6 +
 drivers/iio/Kconfig              |   1 +
 drivers/iio/Makefile             |   1 +
 drivers/iio/counter/104-quad-8.c | 265 +++++++++++++++++++++++++++++++++++++++
 drivers/iio/counter/Kconfig      |  23 ++++
 drivers/iio/counter/Makefile     |   7 ++
 6 files changed, 303 insertions(+)
 create mode 100644 drivers/iio/counter/104-quad-8.c
 create mode 100644 drivers/iio/counter/Kconfig
 create mode 100644 drivers/iio/counter/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index 6f0ff72..759a2ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -255,6 +255,12 @@ L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-104-idio-16.c
 
+ACCES 104-QUAD-8 IIO DRIVER
+M:	William Breathitt Gray <vilhelm.gray@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/counter/104-quad-8.c
+
 ACENIC DRIVER
 M:	Jes Sorensen <jes@trained-monkey.org>
 L:	linux-acenic@sunsite.dk
diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 6743b18..574d1fb 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -73,6 +73,7 @@ source "drivers/iio/adc/Kconfig"
 source "drivers/iio/amplifiers/Kconfig"
 source "drivers/iio/chemical/Kconfig"
 source "drivers/iio/common/Kconfig"
+source "drivers/iio/counter/Kconfig"
 source "drivers/iio/dac/Kconfig"
 source "drivers/iio/dummy/Kconfig"
 source "drivers/iio/frequency/Kconfig"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 87e4c43..77b2000 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -18,6 +18,7 @@ obj-y += amplifiers/
 obj-y += buffer/
 obj-y += chemical/
 obj-y += common/
+obj-y += counter/
 obj-y += dac/
 obj-y += dummy/
 obj-y += gyro/
diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/iio/counter/104-quad-8.c
new file mode 100644
index 0000000..37ad382
--- /dev/null
+++ b/drivers/iio/counter/104-quad-8.c
@@ -0,0 +1,265 @@
+/*
+ * IIO driver for the ACCES 104-QUAD-8
+ * Copyright (C) 2016 William Breathitt Gray
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * This driver supports the ACCES 104-QUAD-8 and ACCES 104-QUAD-4.
+ */
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/isa.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+
+#define QUAD8_CHAN(chan) {						\
+	.type = IIO_COUNT,						\
+	.channel = chan,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
+		BIT(IIO_CHAN_INFO_FLAGS) |				\
+		BIT(IIO_CHAN_INFO_DIRECTION) |				\
+		BIT(IIO_CHAN_INFO_INDEX) | BIT(IIO_CHAN_INFO_MODE) |	\
+		BIT(IIO_CHAN_INFO_PRESET) |				\
+		BIT(IIO_CHAN_INFO_PRESET_EN),				\
+	.indexed = 1							\
+}
+
+#define QUAD8_NUM_CHAN 8
+
+#define QUAD8_EXTENT 32
+
+static unsigned int base[max_num_isa_dev(QUAD8_EXTENT)];
+static unsigned int num_quad8;
+module_param_array(base, uint, &num_quad8, 0);
+MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
+
+/**
+ * struct quad8_iio - IIO device private data structure
+ * @mode:	array of counter mode configurations
+ * @preset:	array of preset values
+ * @preset_en:	array of preset enable configurations
+ * @base:	base port address of the IIO device
+ */
+struct quad8_iio {
+	unsigned int mode[QUAD8_NUM_CHAN];
+	unsigned int preset[QUAD8_NUM_CHAN];
+	unsigned int preset_en[QUAD8_NUM_CHAN];
+	unsigned int base;
+};
+
+static int quad8_read_raw(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
+{
+	struct quad8_iio *const priv = iio_priv(indio_dev);
+	const int base_offset = priv->base + 2 * chan->channel;
+	int i;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		/* Reset Byte Pointer; transfer Counter to Output Latch */
+		outb(0x11, base_offset + 1);
+
+		*val = 0;
+		for (i = 0; i < 3; i++)
+			*val |= (unsigned int)inb(base_offset) << (8 * i);
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_FLAGS:
+		*val = inb(base_offset + 1);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_DIRECTION:
+		*val = !!(inb(base_offset + 1) & BIT(5));
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_INDEX:
+		*val = !!(inb(base_offset + 1) & BIT(6));
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_MODE:
+		*val = priv->mode[chan->channel];
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_PRESET:
+		*val = priv->preset[chan->channel];
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_PRESET_EN:
+		*val = priv->preset_en[chan->channel];
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static int quad8_write_raw(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *chan, int val, int val2, long mask)
+{
+	struct quad8_iio *const priv = iio_priv(indio_dev);
+	const int base_offset = priv->base + 2 * chan->channel;
+	int i;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		/* Only 24-bit values are supported */
+		if ((unsigned int)val > 0xFFFFFF)
+			return -EINVAL;
+
+		/* Reset Byte Pointer */
+		outb(0x01, base_offset + 1);
+
+		/* Set Preset Register */
+		for (i = 0; i < 3; i++)
+			outb(val >> (8 * i), base_offset);
+
+		/* Transfer Preset Register to Counter */
+		outb(0x08, base_offset + 1);
+
+		/* Reset Byte Pointer */
+		outb(0x01, base_offset + 1);
+
+		/* Set Preset Register back to original value */
+		val = priv->preset[chan->channel];
+		for (i = 0; i < 3; i++)
+			outb(val >> (8 * i), base_offset);
+
+		return 0;
+	case IIO_CHAN_INFO_FLAGS:
+		/* Only clear operation is supported */
+		if (val)
+			return -EINVAL;
+
+		/* Reset Borrow, Carry, Compare, and Sign flags */
+		outb(0x02, base_offset + 1);
+		/* Reset Error flag */
+		outb(0x06, base_offset + 1);
+
+		return 0;
+	case IIO_CHAN_INFO_MODE:
+		/* Counter Mode Register exposes 5 configuration bits */
+		if ((unsigned int)val > 0x1F)
+			return -EINVAL;
+
+		priv->mode[chan->channel] = val;
+
+		/* Load mode configuration to Counter Mode Register */
+		outb(0x20 | val, base_offset + 1);
+
+		return 0;
+	case IIO_CHAN_INFO_PRESET:
+		/* Only 24-bit values are supported */
+		if ((unsigned int)val > 0xFFFFFF)
+			return -EINVAL;
+
+		priv->preset[chan->channel] = val;
+
+		/* Reset Byte Pointer */
+		outb(0x01, base_offset + 1);
+
+		/* Set Preset Register */
+		for (i = 0; i < 3; i++)
+			outb(val >> (8 * i), base_offset);
+
+		return 0;
+	case IIO_CHAN_INFO_PRESET_EN:
+		if (val && val != 1)
+			return -EINVAL;
+
+		priv->preset_en[chan->channel] = val;
+
+		/* Enable/disable preset counter function */
+		if (val)
+			outb(0x41, base_offset + 1);
+		else
+			outb(0x43, base_offset + 1);
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_info quad8_info = {
+	.driver_module = THIS_MODULE,
+	.read_raw = quad8_read_raw,
+	.write_raw = quad8_write_raw
+};
+
+static const struct iio_chan_spec quad8_channels[QUAD8_NUM_CHAN] = {
+	QUAD8_CHAN(0), QUAD8_CHAN(1), QUAD8_CHAN(2), QUAD8_CHAN(3),
+	QUAD8_CHAN(4), QUAD8_CHAN(5), QUAD8_CHAN(6), QUAD8_CHAN(7)
+};
+
+static int quad8_probe(struct device *dev, unsigned int id)
+{
+	struct iio_dev *indio_dev;
+	struct quad8_iio *priv;
+	int i, j;
+	unsigned int base_offset;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	if (!devm_request_region(dev, base[id], QUAD8_EXTENT,
+		dev_name(dev))) {
+		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
+			base[id], base[id] + QUAD8_EXTENT);
+		return -EBUSY;
+	}
+
+	indio_dev->info = &quad8_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->num_channels = QUAD8_NUM_CHAN;
+	indio_dev->channels = quad8_channels;
+	indio_dev->name = dev_name(dev);
+
+	priv = iio_priv(indio_dev);
+	priv->base = base[id];
+
+	/* Reset all counters and disable interrupt function */
+	outb(0x01, base[id] + 0x11);
+	/* Set initial configuration for all channels */
+	for (i = 0; i < QUAD8_NUM_CHAN; i++) {
+		base_offset = base[id] + 2 * i;
+		/* Reset Byte Pointer */
+		outb(0x01, base_offset + 1);
+		/* Reset Preset Register */
+		for (j = 0; j < 3; j++)
+			outb(0x00, base_offset);
+		/* Reset Borrow, Carry, Compare, and Sign flags */
+		outb(0x04, base_offset + 1);
+		/* Reset Error flag */
+		outb(0x06, base_offset + 1);
+		/* Binary encoding; Normal count; non-quadrature mode */
+		outb(0x20, base_offset + 1);
+		/* Enable A and B inputs; continuously count; FLG1 as Carry */
+		outb(0x43, base_offset + 1);
+		/* Disable index function */
+		outb(0x60, base_offset + 1);
+	}
+	/* Enable all counters */
+	outb(0x00, base[id] + 0x11);
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static struct isa_driver quad8_driver = {
+	.probe = quad8_probe,
+	.driver = {
+		.name = "104-quad-8"
+	}
+};
+
+module_isa_driver(quad8_driver, num_quad8);
+
+MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
+MODULE_DESCRIPTION("ACCES 104-QUAD-8 IIO driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/counter/Kconfig b/drivers/iio/counter/Kconfig
new file mode 100644
index 0000000..71402b5
--- /dev/null
+++ b/drivers/iio/counter/Kconfig
@@ -0,0 +1,23 @@
+#
+# Counter devices
+#
+# When adding new entries keep the list in alphabetical order
+
+menu "Counters"
+
+config 104_QUAD_8
+	tristate "ACCES 104-QUAD-8 driver"
+	depends on X86 && ISA_BUS_API
+	help
+	  Say yes here to build support for the ACCES 104-QUAD-8 quadrature
+	  encoder counter/interface device family (104-QUAD-8, 104-QUAD-4).
+
+	  Index interrupts (FLG1) are not supported by this driver. Furthermore,
+	  the index function is disabled; non-synchorous mode is enabled for
+	  non-quadrature and quadrature count modes. Performing a write of 0 to
+	  a counter's flags interface clears the respective clearable flags.
+
+	  The base port addresses for the devices may be configured via the base
+	  array module parameter.
+
+endmenu
diff --git a/drivers/iio/counter/Makefile b/drivers/iio/counter/Makefile
new file mode 100644
index 0000000..007e884
--- /dev/null
+++ b/drivers/iio/counter/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for IIO counter devices
+#
+
+# When adding new entries keep the list in alphabetical order
+
+obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
-- 
2.7.3

