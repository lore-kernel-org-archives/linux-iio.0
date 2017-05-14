Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.lysator.liu.se ([130.236.254.3]:59712 "EHLO
        mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759610AbdENT5t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 May 2017 15:57:49 -0400
From: Peter Rosin <peda@lysator.liu.se>
To: linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de
Subject: [PATCH v15 04/13] mux: gpio: add mux controller driver for gpio based multiplexers
Date: Sun, 14 May 2017 21:51:07 +0200
Message-Id: <1494791476-14599-5-git-send-email-peda@lysator.liu.se>
In-Reply-To: <1494791476-14599-1-git-send-email-peda@lysator.liu.se>
References: <1494791476-14599-1-git-send-email-peda@lysator.liu.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

The driver builds a single multiplexer controller using a number
of gpio pins. For N pins, there will be 2^N possible multiplexer
states. The GPIO pins can be connected (by the hardware) to several
multiplexers, which in that case will be operated in parallel.

Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/mux/Kconfig    |  18 ++++++++
 drivers/mux/Makefile   |   1 +
 drivers/mux/mux-gpio.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+)
 create mode 100644 drivers/mux/mux-gpio.c

diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
index 23ab2cde83b1..738670aaecb7 100644
--- a/drivers/mux/Kconfig
+++ b/drivers/mux/Kconfig
@@ -14,3 +14,21 @@ menuconfig MULTIPLEXER
 
 	  To compile the subsystem as a module, choose M here: the module will
 	  be called mux-core.
+
+if MULTIPLEXER
+
+config MUX_GPIO
+	tristate "GPIO-controlled Multiplexer"
+	depends on GPIOLIB || COMPILE_TEST
+	help
+	  GPIO-controlled Multiplexer controller.
+
+	  The driver builds a single multiplexer controller using a number
+	  of gpio pins. For N pins, there will be 2^N possible multiplexer
+	  states. The GPIO pins can be connected (by the hardware) to several
+	  multiplexers, which in that case will be operated in parallel.
+
+	  To compile the driver as a module, choose M here: the module will
+	  be called mux-gpio.
+
+endif
diff --git a/drivers/mux/Makefile b/drivers/mux/Makefile
index 09f0299e109d..bb16953f6290 100644
--- a/drivers/mux/Makefile
+++ b/drivers/mux/Makefile
@@ -3,3 +3,4 @@
 #
 
 obj-$(CONFIG_MULTIPLEXER)	+= mux-core.o
+obj-$(CONFIG_MUX_GPIO)		+= mux-gpio.o
diff --git a/drivers/mux/mux-gpio.c b/drivers/mux/mux-gpio.c
new file mode 100644
index 000000000000..468bf1709606
--- /dev/null
+++ b/drivers/mux/mux-gpio.c
@@ -0,0 +1,114 @@
+/*
+ * GPIO-controlled multiplexer driver
+ *
+ * Copyright (C) 2017 Axentia Technologies AB
+ *
+ * Author: Peter Rosin <peda@axentia.se>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/mux/driver.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+
+struct mux_gpio {
+	struct gpio_descs *gpios;
+	int *val;
+};
+
+static int mux_gpio_set(struct mux_control *mux, int state)
+{
+	struct mux_gpio *mux_gpio = mux_chip_priv(mux->chip);
+	int i;
+
+	for (i = 0; i < mux_gpio->gpios->ndescs; i++)
+		mux_gpio->val[i] = (state >> i) & 1;
+
+	gpiod_set_array_value_cansleep(mux_gpio->gpios->ndescs,
+				       mux_gpio->gpios->desc,
+				       mux_gpio->val);
+
+	return 0;
+}
+
+static const struct mux_control_ops mux_gpio_ops = {
+	.set = mux_gpio_set,
+};
+
+static const struct of_device_id mux_gpio_dt_ids[] = {
+	{ .compatible = "gpio-mux", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mux_gpio_dt_ids);
+
+static int mux_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mux_chip *mux_chip;
+	struct mux_gpio *mux_gpio;
+	int pins;
+	s32 idle_state;
+	int ret;
+
+	pins = gpiod_count(dev, "mux");
+	if (pins < 0)
+		return pins;
+
+	mux_chip = devm_mux_chip_alloc(dev, 1, sizeof(*mux_gpio) +
+				       pins * sizeof(*mux_gpio->val));
+	if (IS_ERR(mux_chip))
+		return PTR_ERR(mux_chip);
+
+	mux_gpio = mux_chip_priv(mux_chip);
+	mux_gpio->val = (int *)(mux_gpio + 1);
+	mux_chip->ops = &mux_gpio_ops;
+
+	mux_gpio->gpios = devm_gpiod_get_array(dev, "mux", GPIOD_OUT_LOW);
+	if (IS_ERR(mux_gpio->gpios)) {
+		ret = PTR_ERR(mux_gpio->gpios);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get gpios\n");
+		return ret;
+	}
+	WARN_ON(pins != mux_gpio->gpios->ndescs);
+	mux_chip->mux->states = 1 << pins;
+
+	ret = device_property_read_u32(dev, "idle-state", (u32 *)&idle_state);
+	if (ret >= 0 && idle_state != MUX_IDLE_AS_IS) {
+		if (idle_state < 0 || idle_state >= mux_chip->mux->states) {
+			dev_err(dev, "invalid idle-state %u\n", idle_state);
+			return -EINVAL;
+		}
+
+		mux_chip->mux->idle_state = idle_state;
+	}
+
+	ret = devm_mux_chip_register(dev, mux_chip);
+	if (ret < 0)
+		return ret;
+
+	dev_info(dev, "%u-way mux-controller registered\n",
+		 mux_chip->mux->states);
+
+	return 0;
+}
+
+static struct platform_driver mux_gpio_driver = {
+	.driver = {
+		.name = "gpio-mux",
+		.of_match_table	= of_match_ptr(mux_gpio_dt_ids),
+	},
+	.probe = mux_gpio_probe,
+};
+module_platform_driver(mux_gpio_driver);
+
+MODULE_DESCRIPTION("GPIO-controlled multiplexer driver");
+MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4

