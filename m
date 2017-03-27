Return-Path: <SRS0=6mYY=3E=axentia.se=peda@kernel.org>
From: Peter Rosin <peda@axentia.se>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, "Rob
 Herring" <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Jonathan
 Cameron" <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jonathan Corbet <corbet@lwn.net>, <linux-i2c@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Colin Ian King <colin.king@canonical.com>, "Paul
 Gortmaker" <paul.gortmaker@windriver.com>
Subject: [PATCH v11 08/12] i2c: i2c-mux-gpmux: new driver
Date: Mon, 27 Mar 2017 14:17:45 +0200
Message-ID: <1490617069-13119-9-git-send-email-peda@axentia.se>
In-Reply-To: <1490617069-13119-1-git-send-email-peda@axentia.se>
References: <1490617069-13119-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This is a general purpose i2c mux that uses a multiplexer controlled by
the multiplexer subsystem to do the muxing.

The user can select if the mux is to be mux-locked and parent-locked
as described in Documentation/i2c/i2c-topology.

Acked-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/Kconfig         |  13 +++
 drivers/i2c/muxes/Makefile        |   1 +
 drivers/i2c/muxes/i2c-mux-gpmux.c | 173 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 187 insertions(+)
 create mode 100644 drivers/i2c/muxes/i2c-mux-gpmux.c

diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
index 10b3d17ae3ea..11115fb34f24 100644
--- a/drivers/i2c/muxes/Kconfig
+++ b/drivers/i2c/muxes/Kconfig
@@ -30,6 +30,19 @@ config I2C_MUX_GPIO
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-mux-gpio.
 
+config I2C_MUX_GPMUX
+	tristate "General Purpose I2C multiplexer"
+	select MULTIPLEXER
+	depends on OF
+	help
+	  If you say yes to this option, support will be included for a
+	  general purpose I2C multiplexer. This driver provides access to
+	  I2C busses connected through a MUX, which in turn is controlled
+	  by a MUX-controller from the MUX subsystem.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-mux-gpmux.
+
 config I2C_MUX_PCA9541
 	tristate "NXP PCA9541 I2C Master Selector"
 	help
diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
index 9948fa45037f..af43c6c3e861 100644
--- a/drivers/i2c/muxes/Makefile
+++ b/drivers/i2c/muxes/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_I2C_ARB_GPIO_CHALLENGE)	+= i2c-arb-gpio-challenge.o
 obj-$(CONFIG_I2C_DEMUX_PINCTRL)		+= i2c-demux-pinctrl.o
 
 obj-$(CONFIG_I2C_MUX_GPIO)	+= i2c-mux-gpio.o
+obj-$(CONFIG_I2C_MUX_GPMUX)	+= i2c-mux-gpmux.o
 obj-$(CONFIG_I2C_MUX_MLXCPLD)	+= i2c-mux-mlxcpld.o
 obj-$(CONFIG_I2C_MUX_PCA9541)	+= i2c-mux-pca9541.o
 obj-$(CONFIG_I2C_MUX_PCA954x)	+= i2c-mux-pca954x.o
diff --git a/drivers/i2c/muxes/i2c-mux-gpmux.c b/drivers/i2c/muxes/i2c-mux-gpmux.c
new file mode 100644
index 000000000000..fb23b2278462
--- /dev/null
+++ b/drivers/i2c/muxes/i2c-mux-gpmux.c
@@ -0,0 +1,173 @@
+/*
+ * General Purpose I2C multiplexer
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
+#include <linux/i2c.h>
+#include <linux/i2c-mux.h>
+#include <linux/module.h>
+#include <linux/mux.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+struct mux {
+	struct mux_control *control;
+
+	bool do_not_deselect;
+};
+
+static int i2c_mux_select(struct i2c_mux_core *muxc, u32 chan)
+{
+	struct mux *mux = i2c_mux_priv(muxc);
+	int ret;
+
+	ret = mux_control_select(mux->control, chan);
+	mux->do_not_deselect = ret < 0;
+
+	return ret;
+}
+
+static int i2c_mux_deselect(struct i2c_mux_core *muxc, u32 chan)
+{
+	struct mux *mux = i2c_mux_priv(muxc);
+
+	if (mux->do_not_deselect)
+		return 0;
+
+	return mux_control_deselect(mux->control);
+}
+
+static struct i2c_adapter *mux_parent_adapter(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct device_node *parent_np;
+	struct i2c_adapter *parent;
+
+	parent_np = of_parse_phandle(np, "i2c-parent", 0);
+	if (!parent_np) {
+		dev_err(dev, "Cannot parse i2c-parent\n");
+		return ERR_PTR(-ENODEV);
+	}
+	parent = of_find_i2c_adapter_by_node(parent_np);
+	of_node_put(parent_np);
+	if (!parent)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return parent;
+}
+
+static const struct of_device_id i2c_mux_of_match[] = {
+	{ .compatible = "i2c-mux", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, i2c_mux_of_match);
+
+static int i2c_mux_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct device_node *child;
+	struct i2c_mux_core *muxc;
+	struct mux *mux;
+	struct i2c_adapter *parent;
+	int children;
+	int ret;
+
+	if (!np)
+		return -ENODEV;
+
+	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return -ENOMEM;
+
+	mux->control = devm_mux_control_get(dev, NULL);
+	if (IS_ERR(mux->control)) {
+		if (PTR_ERR(mux->control) != -EPROBE_DEFER)
+			dev_err(dev, "failed to get control-mux\n");
+		return PTR_ERR(mux->control);
+	}
+
+	parent = mux_parent_adapter(dev);
+	if (IS_ERR(parent)) {
+		if (PTR_ERR(parent) != -EPROBE_DEFER)
+			dev_err(dev, "failed to get i2c-parent adapter\n");
+		return PTR_ERR(parent);
+	}
+
+	children = of_get_child_count(np);
+
+	muxc = i2c_mux_alloc(parent, dev, children, 0, 0,
+			     i2c_mux_select, i2c_mux_deselect);
+	if (!muxc) {
+		ret = -ENOMEM;
+		goto err_parent;
+	}
+	muxc->priv = mux;
+
+	platform_set_drvdata(pdev, muxc);
+
+	muxc->mux_locked = of_property_read_bool(np, "mux-locked");
+
+	for_each_child_of_node(np, child) {
+		u32 chan;
+
+		ret = of_property_read_u32(child, "reg", &chan);
+		if (ret < 0) {
+			dev_err(dev, "no reg property for node '%s'\n",
+				child->name);
+			goto err_children;
+		}
+
+		if (chan >= mux->control->states) {
+			dev_err(dev, "invalid reg %u\n", chan);
+			ret = -EINVAL;
+			goto err_children;
+		}
+
+		ret = i2c_mux_add_adapter(muxc, 0, chan, 0);
+		if (ret)
+			goto err_children;
+	}
+
+	dev_info(dev, "%d-port mux on %s adapter\n", children, parent->name);
+
+	return 0;
+
+err_children:
+	i2c_mux_del_adapters(muxc);
+err_parent:
+	i2c_put_adapter(parent);
+
+	return ret;
+}
+
+static int i2c_mux_remove(struct platform_device *pdev)
+{
+	struct i2c_mux_core *muxc = platform_get_drvdata(pdev);
+
+	i2c_mux_del_adapters(muxc);
+	i2c_put_adapter(muxc->parent);
+
+	return 0;
+}
+
+static struct platform_driver i2c_mux_driver = {
+	.probe	= i2c_mux_probe,
+	.remove	= i2c_mux_remove,
+	.driver	= {
+		.name	= "i2c-mux-gpmux",
+		.of_match_table = i2c_mux_of_match,
+	},
+};
+module_platform_driver(i2c_mux_driver);
+
+MODULE_DESCRIPTION("General Purpose I2C multiplexer driver");
+MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4
