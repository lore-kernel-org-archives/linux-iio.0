Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34289 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754889AbcBHRuo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2016 12:50:44 -0500
Date: Mon, 8 Feb 2016 12:50:34 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: Add IIO support for the DAC on the Apex Embedded
 Systems STX104
Message-ID: <20160208175034.GA14727@sophia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Apex Embedded Systems STX104 is a 16-channel 16-bit analog input and
2-channel 16-bit analog output PC/104 card. The STX104 incorporates a
large one mega-sample FIFO.

This driver provides IIO support for the 2-channel DAC on the STX104.
The base port addresses for the devices may be configured via the
stx104_base module parameter array.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
Changes in v2:
  - Inline use of dev_name macro
  - Use devm_iio_device_register to simplify cleanup code
  - Use ISA bus driver instead of platform driver
  - Provide stx104_base module parameter as an array in order to support
    multiple instances

 MAINTAINERS              |   6 ++
 drivers/iio/dac/Kconfig  |   9 +++
 drivers/iio/dac/Makefile |   1 +
 drivers/iio/dac/stx104.c | 152 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 168 insertions(+)
 create mode 100644 drivers/iio/dac/stx104.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ddb488..3905b31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -763,6 +763,12 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
 F:	sound/aoa/
 
+APEX EMBEDDED SYSTEMS STX104 DAC DRIVER
+M:	William Breathitt Gray <vilhelm.gray@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/dac/stx104.c
+
 APM DRIVER
 M:	Jiri Kosina <jikos@kernel.org>
 S:	Odd fixes
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 5dc7150..6cf1066 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -206,4 +206,13 @@ config MCP4922
 	  To compile this driver as a module, choose M here: the module
 	  will be called mcp4922.
 
+config STX104
+	tristate "Apex Embedded Systems STX104 DAC driver"
+	depends on ISA
+	help
+	  Say yes here to build support for the 2-channel DAC on the Apex
+	  Embedded Systems STX104 integrated analog PC/104 card. The base port
+	  addresses for the devices may be configured via the stx104_base module
+	  parameter array.
+
 endmenu
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index cb525b5..e2deda9 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -22,3 +22,4 @@ obj-$(CONFIG_MAX517) += max517.o
 obj-$(CONFIG_MAX5821) += max5821.o
 obj-$(CONFIG_MCP4725) += mcp4725.o
 obj-$(CONFIG_MCP4922) += mcp4922.o
+obj-$(CONFIG_STX104) += stx104.o
diff --git a/drivers/iio/dac/stx104.c b/drivers/iio/dac/stx104.c
new file mode 100644
index 0000000..f183e3f
--- /dev/null
+++ b/drivers/iio/dac/stx104.c
@@ -0,0 +1,152 @@
+/*
+ * DAC driver for the Apex Embedded Systems STX104
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
+#define STX104_NUM_CHAN 2
+
+#define STX104_CHAN(chan) {				\
+	.type = IIO_VOLTAGE,				\
+	.channel = chan,				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+	.indexed = 1,					\
+	.output = 1					\
+}
+
+#define STX104_EXTENT 16
+/**
+ * The highest base address possible for an ISA device is 0x3FF; this results in
+ * 1024 possible base addresses. Dividing the number of possible base addresses
+ * by the address extent taken by each device results in the maximum number of
+ * devices on a system.
+ */
+#define MAX_NUM_STX104 (1024 / STX104_EXTENT)
+
+static unsigned stx104_base[MAX_NUM_STX104];
+static unsigned num_stx104;
+module_param_array(stx104_base, uint, &num_stx104, 0);
+MODULE_PARM_DESC(stx104_base, "Apex Embedded Systems STX104 base addresses");
+
+/**
+ * struct stx104_iio - IIO device private data structure
+ * @chan_out_states:	channels' output states
+ * @base:		base port address of the IIO device
+ */
+struct stx104_iio {
+	unsigned chan_out_states[STX104_NUM_CHAN];
+	unsigned base;
+};
+
+static int stx104_read_raw(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
+{
+	struct stx104_iio *const priv = iio_priv(indio_dev);
+
+	if (mask != IIO_CHAN_INFO_RAW)
+		return -EINVAL;
+
+	*val = priv->chan_out_states[chan->channel];
+
+	return IIO_VAL_INT;
+}
+
+static int stx104_write_raw(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *chan, int val, int val2, long mask)
+{
+	struct stx104_iio *const priv = iio_priv(indio_dev);
+	const unsigned chan_addr_offset = 2 * chan->channel;
+
+	if (mask != IIO_CHAN_INFO_RAW)
+		return -EINVAL;
+
+	priv->chan_out_states[chan->channel] = val;
+	outw(val, priv->base + 4 + chan_addr_offset);
+
+	return 0;
+}
+
+static const struct iio_info stx104_info = {
+	.driver_module = THIS_MODULE,
+	.read_raw = stx104_read_raw,
+	.write_raw = stx104_write_raw
+};
+
+static const struct iio_chan_spec stx104_channels[STX104_NUM_CHAN] = {
+	STX104_CHAN(0),
+	STX104_CHAN(1)
+};
+
+static int stx104_probe(struct device *dev, unsigned int id)
+{
+	struct iio_dev *indio_dev;
+	struct stx104_iio *priv;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	if (!devm_request_region(dev, stx104_base[id], STX104_EXTENT,
+		dev_name(dev))) {
+		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
+			stx104_base[id], stx104_base[id] + STX104_EXTENT);
+		return -EBUSY;
+	}
+
+	indio_dev->info = &stx104_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = stx104_channels;
+	indio_dev->num_channels = STX104_NUM_CHAN;
+	indio_dev->name = dev_name(dev);
+
+	priv = iio_priv(indio_dev);
+	priv->base = stx104_base[id];
+
+	/* initialize DAC output to 0V */
+	outw(0, stx104_base[id] + 4);
+	outw(0, stx104_base[id] + 6);
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static struct isa_driver stx104_driver = {
+	.probe = stx104_probe,
+	.driver = {
+		.name = "stx104"
+	}
+};
+
+static void __exit stx104_exit(void)
+{
+	isa_unregister_driver(&stx104_driver);
+}
+
+static int __init stx104_init(void)
+{
+	return isa_register_driver(&stx104_driver, num_stx104);
+}
+
+module_init(stx104_init);
+module_exit(stx104_exit);
+
+MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
+MODULE_DESCRIPTION("Apex Embedded Systems STX104 DAC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.4.10

