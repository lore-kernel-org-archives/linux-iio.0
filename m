Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.lysator.liu.se ([130.236.254.3]:49857 "EHLO
        mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759082AbdENT5q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 May 2017 15:57:46 -0400
From: Peter Rosin <peda@lysator.liu.se>
To: linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@the-dreams.de>,
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
        kernel@pengutronix.de
Subject: [PATCH v15 13/13] mux: mmio-based syscon mux controller
Date: Sun, 14 May 2017 21:51:16 +0200
Message-Id: <1494791476-14599-14-git-send-email-peda@lysator.liu.se>
In-Reply-To: <1494791476-14599-1-git-send-email-peda@lysator.liu.se>
References: <1494791476-14599-1-git-send-email-peda@lysator.liu.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Philipp Zabel <p.zabel@pengutronix.de>

This adds a driver for mmio-based syscon multiplexers controlled by
bitfields in a syscon register range.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/mux/Kconfig    |  13 +++++
 drivers/mux/Makefile   |   1 +
 drivers/mux/mux-mmio.c | 141 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 155 insertions(+)
 create mode 100644 drivers/mux/mux-mmio.c

diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
index c4d050645605..e8f1df74644c 100644
--- a/drivers/mux/Kconfig
+++ b/drivers/mux/Kconfig
@@ -43,4 +43,17 @@ config MUX_GPIO
 	  To compile the driver as a module, choose M here: the module will
 	  be called mux-gpio.
 
+config MUX_MMIO
+	tristate "MMIO register bitfield-controlled Multiplexer"
+	depends on (OF && MFD_SYSCON) || COMPILE_TEST
+	help
+	  MMIO register bitfield-controlled Multiplexer controller.
+
+	  The driver builds multiplexer controllers for bitfields in a syscon
+	  register. For N bit wide bitfields, there will be 2^N possible
+	  multiplexer states.
+
+	  To compile the driver as a module, choose M here: the module will
+	  be called mux-mmio.
+
 endif
diff --git a/drivers/mux/Makefile b/drivers/mux/Makefile
index b00a7d37d2fb..6bac5b0fea13 100644
--- a/drivers/mux/Makefile
+++ b/drivers/mux/Makefile
@@ -5,3 +5,4 @@
 obj-$(CONFIG_MULTIPLEXER)	+= mux-core.o
 obj-$(CONFIG_MUX_ADG792A)	+= mux-adg792a.o
 obj-$(CONFIG_MUX_GPIO)		+= mux-gpio.o
+obj-$(CONFIG_MUX_MMIO)		+= mux-mmio.o
diff --git a/drivers/mux/mux-mmio.c b/drivers/mux/mux-mmio.c
new file mode 100644
index 000000000000..37c1de359a70
--- /dev/null
+++ b/drivers/mux/mux-mmio.c
@@ -0,0 +1,141 @@
+/*
+ * MMIO register bitfield-controlled multiplexer driver
+ *
+ * Copyright (C) 2017 Pengutronix, Philipp Zabel <kernel@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/mux/driver.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+
+static int mux_mmio_set(struct mux_control *mux, int state)
+{
+	struct regmap_field **fields = mux_chip_priv(mux->chip);
+
+	return regmap_field_write(fields[mux_control_get_index(mux)], state);
+}
+
+static const struct mux_control_ops mux_mmio_ops = {
+	.set = mux_mmio_set,
+};
+
+static const struct of_device_id mux_mmio_dt_ids[] = {
+	{ .compatible = "mmio-mux", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mux_mmio_dt_ids);
+
+static int mux_mmio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct regmap_field **fields;
+	struct mux_chip *mux_chip;
+	struct regmap *regmap;
+	int num_fields;
+	int ret;
+	int i;
+
+	regmap = syscon_node_to_regmap(np->parent);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(dev, "failed to get regmap: %d\n", ret);
+		return ret;
+	}
+
+	ret = of_property_count_u32_elems(np, "mux-reg-masks");
+	if (ret == 0 || ret % 2)
+		ret = -EINVAL;
+	if (ret < 0) {
+		dev_err(dev, "mux-reg-masks property missing or invalid: %d\n",
+			ret);
+		return ret;
+	}
+	num_fields = ret / 2;
+
+	mux_chip = devm_mux_chip_alloc(dev, num_fields, num_fields *
+				       sizeof(*fields));
+	if (IS_ERR(mux_chip))
+		return PTR_ERR(mux_chip);
+
+	fields = mux_chip_priv(mux_chip);
+
+	for (i = 0; i < num_fields; i++) {
+		struct mux_control *mux = &mux_chip->mux[i];
+		struct reg_field field;
+		s32 idle_state = MUX_IDLE_AS_IS;
+		u32 reg, mask;
+		int bits;
+
+		ret = of_property_read_u32_index(np, "mux-reg-masks",
+						 2 * i, &reg);
+		if (!ret)
+			ret = of_property_read_u32_index(np, "mux-reg-masks",
+							 2 * i + 1, &mask);
+		if (ret < 0) {
+			dev_err(dev, "bitfield %d: failed to read mux-reg-masks property: %d\n",
+				i, ret);
+			return ret;
+		}
+
+		field.reg = reg;
+		field.msb = fls(mask) - 1;
+		field.lsb = ffs(mask) - 1;
+
+		if (mask != GENMASK(field.msb, field.lsb)) {
+			dev_err(dev, "bitfield %d: invalid mask 0x%x\n",
+				i, mask);
+			return -EINVAL;
+		}
+
+		fields[i] = devm_regmap_field_alloc(dev, regmap, field);
+		if (IS_ERR(fields[i])) {
+			ret = PTR_ERR(fields[i]);
+			dev_err(dev, "bitfield %d: failed allocate: %d\n",
+				i, ret);
+			return ret;
+		}
+
+		bits = 1 + field.msb - field.lsb;
+		mux->states = 1 << bits;
+
+		of_property_read_u32_index(np, "idle-states", i,
+					   (u32 *)&idle_state);
+		if (idle_state != MUX_IDLE_AS_IS) {
+			if (idle_state < 0 || idle_state >= mux->states) {
+				dev_err(dev, "bitfield: %d: out of range idle state %d\n",
+					i, idle_state);
+				return -EINVAL;
+			}
+
+			mux->idle_state = idle_state;
+		}
+	}
+
+	mux_chip->ops = &mux_mmio_ops;
+
+	return devm_mux_chip_register(dev, mux_chip);
+}
+
+static struct platform_driver mux_mmio_driver = {
+	.driver = {
+		.name = "mmio-mux",
+		.of_match_table	= of_match_ptr(mux_mmio_dt_ids),
+	},
+	.probe = mux_mmio_probe,
+};
+module_platform_driver(mux_mmio_driver);
+
+MODULE_DESCRIPTION("MMIO register bitfield-controlled multiplexer driver");
+MODULE_AUTHOR("Philipp Zabel <p.zabel@pengutronix.de>");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4

