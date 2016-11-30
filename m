Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0125.outbound.protection.outlook.com ([104.47.2.125]:34512
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932233AbcK3MyV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 30 Nov 2016 07:54:21 -0500
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v6 9/9] misc: mux-adg792a: add mux controller driver for ADG792A/G
Date: Wed, 30 Nov 2016 09:17:03 +0100
Message-ID: <1480493823-21462-10-git-send-email-peda@axentia.se>
In-Reply-To: <1480493823-21462-1-git-send-email-peda@axentia.se>
References: <1480493823-21462-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Analog Devices ADG792A/G is a triple 4:1 mux.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/misc/Kconfig       |  12 ++++
 drivers/misc/Makefile      |   1 +
 drivers/misc/mux-adg792a.c | 154 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+)
 create mode 100644 drivers/misc/mux-adg792a.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 2ce675e410c5..45567a444bbf 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -780,6 +780,18 @@ menuconfig MULTIPLEXER
 
 if MULTIPLEXER
 
+config MUX_ADG792A
+	tristate "Analog Devices ADG792A/ADG792G Multiplexers"
+	depends on I2C
+	help
+	  ADG792A and ADG792G Wide Bandwidth Triple 4:1 Multiplexers
+
+	  The driver supports both operating the three multiplexers in
+	  parellel and operating them independently.
+
+	  To compile the driver as a module, choose M here: the module will
+	  be called mux-adg792a.
+
 config MUX_GPIO
 	tristate "GPIO-controlled Multiplexer"
 	depends on OF && GPIOLIB
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 0befa2bba762..10ab8d34c9e5 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
 obj-$(CONFIG_CXL_BASE)		+= cxl/
 obj-$(CONFIG_PANEL)             += panel.o
 obj-$(CONFIG_MULTIPLEXER)      	+= mux-core.o
+obj-$(CONFIG_MUX_ADG792A)	+= mux-adg792a.o
 obj-$(CONFIG_MUX_GPIO)		+= mux-gpio.o
 
 lkdtm-$(CONFIG_LKDTM)		+= lkdtm_core.o
diff --git a/drivers/misc/mux-adg792a.c b/drivers/misc/mux-adg792a.c
new file mode 100644
index 000000000000..7d309a78af65
--- /dev/null
+++ b/drivers/misc/mux-adg792a.c
@@ -0,0 +1,154 @@
+/*
+ * Multiplexer driver for Analog Devices ADG792A/G Triple 4:1 mux
+ *
+ * Copyright (C) 2016 Axentia Technologies AB
+ *
+ * Author: Peter Rosin <peda@axentia.se>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mux.h>
+
+#define ADG792A_LDSW		BIT(0)
+#define ADG792A_RESET		BIT(1)
+#define ADG792A_DISABLE(mux)	(0x50 | (mux))
+#define ADG792A_DISABLE_ALL	(0x5f)
+#define ADG792A_MUX(mux, state)	(0xc0 | (((mux) + 1) << 2) | (state))
+#define ADG792A_MUX_ALL(state)	(0xc0 | (state))
+
+#define ADG792A_DISABLE_STATE	(4)
+#define ADG792A_KEEP_STATE	(5)
+
+static int adg792a_set(struct mux_control *mux, int state)
+{
+	struct i2c_client *i2c = to_i2c_client(mux->chip->dev.parent);
+	u8 cmd;
+
+	if (mux->chip->controllers == 1) {
+		/* parallel mux controller operation */
+		if (state == ADG792A_DISABLE_STATE)
+			cmd = ADG792A_DISABLE_ALL;
+		else
+			cmd = ADG792A_MUX_ALL(state);
+	} else {
+		unsigned int controller = mux_control_get_index(mux);
+
+		if (state == ADG792A_DISABLE_STATE)
+			cmd = ADG792A_DISABLE(controller);
+		else
+			cmd = ADG792A_MUX(controller, state);
+	}
+
+	return i2c_smbus_write_byte_data(i2c, cmd, ADG792A_LDSW);
+}
+
+static const struct mux_control_ops adg792a_ops = {
+	.set = adg792a_set,
+};
+
+static int adg792a_probe(struct i2c_client *i2c,
+			 const struct i2c_device_id *id)
+{
+	struct device *dev = &i2c->dev;
+	struct mux_chip *mux_chip;
+	bool parallel;
+	int ret;
+	int i;
+
+	parallel = of_property_read_bool(i2c->dev.of_node, "adi,parallel");
+
+	mux_chip = mux_chip_alloc(dev, parallel ? 1 : 3, 0);
+	if (!mux_chip)
+		return -ENOMEM;
+
+	mux_chip->ops = &adg792a_ops;
+	dev_set_drvdata(dev, mux_chip);
+
+	ret = i2c_smbus_write_byte_data(i2c, ADG792A_DISABLE_ALL,
+					ADG792A_RESET | ADG792A_LDSW);
+	if (ret < 0)
+		goto free_mux_chip;
+
+	for (i = 0; i < mux_chip->controllers; ++i) {
+		struct mux_control *mux = &mux_chip->mux[i];
+		u32 idle_state;
+
+		mux->states = 4;
+
+		ret = of_property_read_u32_index(i2c->dev.of_node,
+						 "adi,idle-state", i,
+						 &idle_state);
+		if (ret >= 0) {
+			if (idle_state > ADG792A_KEEP_STATE) {
+				dev_err(dev, "invalid idle-state %u\n",
+					idle_state);
+				ret = -EINVAL;
+				goto free_mux_chip;
+			}
+			if (idle_state != ADG792A_KEEP_STATE)
+				mux->idle_state = idle_state;
+		}
+	}
+
+	ret = mux_chip_register(mux_chip);
+	if (ret < 0) {
+		dev_err(dev, "failed to register mux-chip\n");
+		goto free_mux_chip;
+	}
+
+	if (parallel)
+		dev_info(dev, "1 triple 4-way mux-controller registered\n");
+	else
+		dev_info(dev, "3 4-way mux-controllers registered\n");
+
+	return 0;
+
+free_mux_chip:
+	mux_chip_free(mux_chip);
+	return ret;
+}
+
+static int adg792a_remove(struct i2c_client *i2c)
+{
+	struct mux_chip *mux_chip = dev_get_drvdata(&i2c->dev);
+
+	mux_chip_unregister(mux_chip);
+	mux_chip_free(mux_chip);
+
+	return 0;
+}
+
+static const struct i2c_device_id adg792a_id[] = {
+	{ .name = "adg792a", },
+	{ .name = "adg792g", },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, adg792a_id);
+
+static const struct of_device_id adg792a_of_match[] = {
+	{ .compatible = "adi,adg792a", },
+	{ .compatible = "adi,adg792g", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adg792a_of_match);
+
+static struct i2c_driver adg792a_driver = {
+	.driver		= {
+		.name		= "adg792a",
+		.of_match_table = of_match_ptr(adg792a_of_match),
+	},
+	.probe		= adg792a_probe,
+	.remove		= adg792a_remove,
+	.id_table	= adg792a_id,
+};
+module_i2c_driver(adg792a_driver);
+
+MODULE_DESCRIPTION("Analog Devices ADG792A/G Triple 4:1 mux driver");
+MODULE_AUTHOR("Peter Rosin <peda@axentia.se");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4

