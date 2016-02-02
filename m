Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33322 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099AbcBBXsV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Feb 2016 18:48:21 -0500
Date: Tue, 2 Feb 2016 18:30:26 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: Add IIO support for the DAC on the Apex Embedded
 Systems STX104
Message-ID: <20160202233026.GA25092@sophia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Apex Embedded Systems STX104 is a 16-channel 16-bit analog input and
2-channel 16-bit analog output PC/104 card. The STX104 incorporates a
large one mega-sample FIFO.

This driver provides IIO support for the 2-channel DAC on the STX104.
The base port address for the device may be configured via the
stx104_base module parameter.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 MAINTAINERS              |   6 ++
 drivers/iio/dac/Kconfig  |   8 +++
 drivers/iio/dac/Makefile |   1 +
 drivers/iio/dac/stx104.c | 178 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 193 insertions(+)
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
index 5dc7150..85295b1 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -206,4 +206,12 @@ config MCP4922
 	  To compile this driver as a module, choose M here: the module
 	  will be called mcp4922.
 
+config STX104
+	tristate "Apex Embedded Systems STX104 DAC driver"
+	depends on X86
+	help
+	  Say yes here to build support for the 2-channel DAC on the Apex Embedded
+	  Systems STX104 integrated analog PC/104 card. The base port address for
+	  the device may be configured via the stx104_base module parameter.
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
index 0000000..3a887ae
--- /dev/null
+++ b/drivers/iio/dac/stx104.c
@@ -0,0 +1,178 @@
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
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/platform_device.h>
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
+static unsigned stx104_base;
+module_param(stx104_base, uint, 0);
+MODULE_PARM_DESC(stx104_base, "Apex Embedded Systems STX104 base address");
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
+static int __init stx104_probe(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev;
+	struct device *const dev = &pdev->dev;
+	struct stx104_iio *priv;
+	const unsigned extent = 16;
+	const char *const name = dev_name(dev);
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	if (!devm_request_region(dev, stx104_base, extent, name)) {
+		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
+			stx104_base, stx104_base + extent);
+		return -EBUSY;
+	}
+
+	indio_dev->info = &stx104_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = stx104_channels;
+	indio_dev->num_channels = STX104_NUM_CHAN;
+	indio_dev->name = name;
+
+	priv = iio_priv(indio_dev);
+	priv->base = stx104_base;
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	/* initialize DAC output to 0V */
+	outw(0, stx104_base + 4);
+	outw(0, stx104_base + 6);
+
+	return iio_device_register(indio_dev);
+}
+
+static int stx104_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+
+	iio_device_unregister(indio_dev);
+
+	return 0;
+}
+
+static struct platform_device *stx104_device;
+
+static struct platform_driver stx104_driver = {
+	.driver = {
+		.name = "stx104"
+	},
+	.remove = stx104_remove
+};
+
+static void __exit stx104_exit(void)
+{
+	platform_device_unregister(stx104_device);
+	platform_driver_unregister(&stx104_driver);
+}
+
+static int __init stx104_init(void)
+{
+	int err;
+
+	stx104_device = platform_device_alloc(stx104_driver.driver.name, -1);
+	if (!stx104_device)
+		return -ENOMEM;
+
+	err = platform_device_add(stx104_device);
+	if (err)
+		goto err_platform_device;
+
+	err = platform_driver_probe(&stx104_driver, stx104_probe);
+	if (err)
+		goto err_platform_driver;
+
+	return 0;
+
+err_platform_driver:
+	platform_device_del(stx104_device);
+err_platform_device:
+	platform_device_put(stx104_device);
+	return err;
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

