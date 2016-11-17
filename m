Return-Path: <peda@axentia.se>
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, "Rob
 Herring" <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Jonathan
 Cameron" <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, "Arnd
 Bergmann" <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: [RFC PATCH v2 2/7] misc: minimal mux subsystem and gpio-based mux controller
Date: Thu, 17 Nov 2016 22:48:04 +0100
Message-ID: <1479419289-17553-3-git-send-email-peda@axentia.se>
In-Reply-To: <1479419289-17553-1-git-send-email-peda@axentia.se>
References: <1479419289-17553-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

When both the iio subsystem and the i2c subsystem wants to update
the same mux, there needs to be some coordination. Invent a new
minimal "mux" subsystem that handles this.

Add a single backend driver for this new subsystem that can
control gpio based multiplexers.
---
 drivers/misc/Kconfig    |   6 +
 drivers/misc/Makefile   |   2 +
 drivers/misc/mux-core.c | 299 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/misc/mux-gpio.c | 115 +++++++++++++++++++
 include/linux/mux.h     |  53 +++++++++
 5 files changed, 475 insertions(+)
 create mode 100644 drivers/misc/mux-core.c
 create mode 100644 drivers/misc/mux-gpio.c
 create mode 100644 include/linux/mux.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 64971baf11fa..9e119bb78d82 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -766,6 +766,12 @@ config PANEL_BOOT_MESSAGE
 	  An empty message will only clear the display at driver init time. Any other
 	  printf()-formatted message is valid with newline and escape codes.
 
+config MUX_GPIO
+	tristate "GPIO-controlled MUX controller"
+	depends on OF
+	help
+	  GPIO-controlled MUX controller
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 31983366090a..92b547bcbac1 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -53,6 +53,8 @@ obj-$(CONFIG_ECHO)		+= echo/
 obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
 obj-$(CONFIG_CXL_BASE)		+= cxl/
 obj-$(CONFIG_PANEL)             += panel.o
+obj-$(CONFIG_MUX_GPIO)          += mux-core.o
+obj-$(CONFIG_MUX_GPIO)          += mux-gpio.o
 
 lkdtm-$(CONFIG_LKDTM)		+= lkdtm_core.o
 lkdtm-$(CONFIG_LKDTM)		+= lkdtm_bugs.o
diff --git a/drivers/misc/mux-core.c b/drivers/misc/mux-core.c
new file mode 100644
index 000000000000..7a8bf003a92c
--- /dev/null
+++ b/drivers/misc/mux-core.c
@@ -0,0 +1,299 @@
+/*
+ * Multiplexer subsystem
+ *
+ * Copyright (C) 2016 Axentia Technologies AB
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define pr_fmt(fmt) "mux-core: " fmt
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/idr.h>
+#include <linux/module.h>
+#include <linux/mux.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+
+static struct bus_type mux_bus_type = {
+	.name = "mux",
+};
+
+static int __init mux_init(void)
+{
+	return bus_register(&mux_bus_type);
+}
+
+static void __exit mux_exit(void)
+{
+	bus_unregister(&mux_bus_type);
+}
+
+static DEFINE_IDA(mux_ida);
+
+static void mux_control_release(struct device *dev)
+{
+	struct mux_control *mux = to_mux_control(dev);
+
+	ida_simple_remove(&mux_ida, mux->id);
+	kfree(mux);
+}
+
+static struct device_type mux_control_type = {
+	.name = "mux-control",
+	.release = mux_control_release,
+};
+
+/*
+ * Allocate a mux-control, plus an extra memory area for private use
+ * by the caller.
+ */
+struct mux_control *mux_control_alloc(size_t sizeof_priv)
+{
+	struct mux_control *mux;
+
+	mux = kzalloc(sizeof(*mux) + sizeof_priv, GFP_KERNEL);
+	if (!mux)
+		return NULL;
+
+	mux->dev.bus = &mux_bus_type;
+	mux->dev.type = &mux_control_type;
+	device_initialize(&mux->dev);
+	dev_set_drvdata(&mux->dev, mux);
+
+	init_rwsem(&mux->lock);
+	mux->priv = mux + 1;
+
+	mux->id = ida_simple_get(&mux_ida, 0, 0, GFP_KERNEL);
+	if (mux->id < 0) {
+		pr_err("mux-controlX failed to get device id\n");
+		kfree(mux);
+		return NULL;
+	}
+	dev_set_name(&mux->dev, "mux:control%d", mux->id);
+
+	mux->cached_state = -1;
+	mux->idle_state = -1;
+
+	return mux;
+}
+EXPORT_SYMBOL_GPL(mux_control_alloc);
+
+/*
+ * Register the mux-control, thus readying it for use.
+ */
+int mux_control_register(struct mux_control *mux)
+{
+	/* If the calling driver did not initialize of_node, do it here */
+	if (!mux->dev.of_node && mux->dev.parent)
+		mux->dev.of_node = mux->dev.parent->of_node;
+
+	return device_add(&mux->dev);
+}
+EXPORT_SYMBOL_GPL(mux_control_register);
+
+/*
+ * Take the mux-control off-line.
+ */
+void mux_control_unregister(struct mux_control *mux)
+{
+	device_del(&mux->dev);
+}
+EXPORT_SYMBOL_GPL(mux_control_unregister);
+
+/*
+ * Put away the mux-control for good.
+ */
+void mux_control_put(struct mux_control *mux)
+{
+	if (!mux)
+		return;
+	put_device(&mux->dev);
+}
+EXPORT_SYMBOL_GPL(mux_control_put);
+
+static int mux_control_set(struct mux_control *mux, int state)
+{
+	int ret = mux->ops->set(mux, state);
+
+	mux->cached_state = ret < 0 ? -1 : state;
+
+	return ret;
+}
+
+/*
+ * Select the given multiplexer channel. Call mux_control_deselect()
+ * when the operation is complete on the multiplexer channel, and the
+ * multiplexer is free for others to use.
+ */
+int mux_control_select(struct mux_control *mux, int state)
+{
+	int ret;
+
+	if (down_read_trylock(&mux->lock)) {
+		if (mux->cached_state == state)
+			return 0;
+
+		/* Sigh, the mux needs updating... */
+		up_read(&mux->lock);
+	}
+
+	/* ...or it's just contended. */
+	down_write(&mux->lock);
+
+	if (mux->cached_state == state) {
+		/*
+		 * Hmmm, someone else changed the mux to my liking.
+		 * That makes me wonder how long I waited for nothing...
+		 */
+		downgrade_write(&mux->lock);
+		return 0;
+	}
+
+	ret = mux_control_set(mux, state);
+	if (ret < 0) {
+		if (mux->idle_state != -1)
+			mux_control_set(mux, mux->idle_state);
+
+		up_write(&mux->lock);
+		return ret;
+	}
+
+	downgrade_write(&mux->lock);
+
+	return 1;
+}
+EXPORT_SYMBOL_GPL(mux_control_select);
+
+/*
+ * Deselect the previously selected multiplexer channel.
+ */
+int mux_control_deselect(struct mux_control *mux)
+{
+	int ret = 0;
+
+	if (mux->idle_state != -1 && mux->cached_state != mux->idle_state)
+		ret = mux_control_set(mux, mux->idle_state);
+
+	up_read(&mux->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mux_control_deselect);
+
+static int of_dev_node_match(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+static struct mux_control *of_find_mux_by_node(struct device_node *np)
+{
+	struct device *dev;
+
+	dev = bus_find_device(&mux_bus_type, NULL, np, of_dev_node_match);
+
+	return dev ? to_mux_control(dev) : NULL;
+}
+
+static struct mux_control *of_mux_control_get(struct device_node *np, int index)
+{
+	struct device_node *mux_np;
+	struct mux_control *mux;
+
+	mux_np = of_parse_phandle(np, "control-muxes", index);
+	if (!mux_np)
+		return NULL;
+
+	mux = of_find_mux_by_node(mux_np);
+	of_node_put(mux_np);
+
+	return mux;
+}
+
+/*
+ * Get a named mux.
+ */
+struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
+{
+	struct device_node *np = dev->of_node;
+	struct mux_control *mux;
+	int index;
+
+	index = of_property_match_string(np, "control-mux-names", mux_name);
+	if (index < 0) {
+		dev_err(dev, "failed to get control-mux %s:%s(%i)\n",
+			np->full_name, mux_name ?: "", index);
+		return ERR_PTR(index);
+	}
+
+	mux = of_mux_control_get(np, index);
+	if (!mux)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return mux;
+}
+EXPORT_SYMBOL_GPL(mux_control_get);
+
+static void devm_mux_control_free(struct device *dev, void *res)
+{
+	struct mux_control *mux = *(struct mux_control **)res;
+
+	mux_control_put(mux);
+}
+
+/*
+ * Get a named mux, with resource management.
+ */
+struct mux_control *devm_mux_control_get(struct device *dev,
+					 const char *mux_name)
+{
+	struct mux_control **ptr, *mux;
+
+	ptr = devres_alloc(devm_mux_control_free, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	mux = mux_control_get(dev, mux_name);
+	if (IS_ERR(mux)) {
+		devres_free(ptr);
+		return mux;
+	}
+
+	*ptr = mux;
+	devres_add(dev, ptr);
+
+	return mux;
+}
+EXPORT_SYMBOL_GPL(devm_mux_control_get);
+
+static int devm_mux_control_match(struct device *dev, void *res, void *data)
+{
+	struct mux_control **r = res;
+
+	if (!r || !*r) {
+		WARN_ON(!r || !*r);
+		return 0;
+	}
+
+	return *r == data;
+}
+
+/*
+ * Resource-managed version mux_control_put.
+ */
+void devm_mux_control_put(struct device *dev, struct mux_control *mux)
+{
+	WARN_ON(devres_release(dev, devm_mux_control_free,
+			       devm_mux_control_match, mux));
+}
+EXPORT_SYMBOL_GPL(devm_mux_control_put);
+
+subsys_initcall(mux_init);
+module_exit(mux_exit);
+
+MODULE_AUTHOR("Peter Rosin <peda@axentia.se");
+MODULE_DESCRIPTION("MUX subsystem");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/misc/mux-gpio.c b/drivers/misc/mux-gpio.c
new file mode 100644
index 000000000000..2ddd7fb24078
--- /dev/null
+++ b/drivers/misc/mux-gpio.c
@@ -0,0 +1,115 @@
+/*
+ * GPIO-controlled multiplexer driver
+ *
+ * Copyright (C) 2016 Axentia Technologies AB
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/mux.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+struct mux_gpio {
+	struct gpio_descs *gpios;
+};
+
+static int mux_gpio_set(struct mux_control *mux, int val)
+{
+	struct mux_gpio *mux_gpio = mux->priv;
+	int i;
+
+	for (i = 0; i < mux_gpio->gpios->ndescs; i++)
+		gpiod_set_value_cansleep(mux_gpio->gpios->desc[i],
+					 val & (1 << i));
+
+	return 0;
+}
+
+static const struct mux_control_ops mux_gpio_ops = {
+	.set = mux_gpio_set,
+};
+
+static const struct of_device_id mux_gpio_dt_ids[] = {
+	{ .compatible = "mux-gpio", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mux_gpio_dt_ids);
+
+static int mux_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = pdev->dev.of_node;
+	struct mux_control *mux;
+	struct mux_gpio *mux_gpio;
+	u32 idle_state;
+	int ret;
+
+	if (!np)
+		return -ENODEV;
+
+	mux = mux_control_alloc(sizeof(*mux_gpio));
+	if (!mux)
+		return -ENOMEM;
+	mux_gpio = mux->priv;
+	mux->dev.parent = dev;
+	mux->ops = &mux_gpio_ops;
+
+	platform_set_drvdata(pdev, mux);
+
+	mux_gpio->gpios = devm_gpiod_get_array(dev, "mux", GPIOD_OUT_LOW);
+	if (IS_ERR(mux_gpio->gpios)) {
+		if (PTR_ERR(mux_gpio->gpios) != -EPROBE_DEFER)
+			dev_err(dev, "failed to get gpios\n");
+		mux_control_put(mux);
+		return PTR_ERR(mux_gpio->gpios);
+	}
+
+	ret = of_property_read_u32(np, "idle-state", &idle_state);
+	if (ret >= 0) {
+		if (idle_state >= (1 << mux_gpio->gpios->ndescs)) {
+			dev_err(dev, "invalid idle-state %u\n", idle_state);
+			return -EINVAL;
+		}
+		mux->idle_state = idle_state;
+	}
+
+	ret = mux_control_register(mux);
+	if (ret < 0) {
+		dev_err(dev, "failed to register mux_control\n");
+		mux_control_put(mux);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int mux_gpio_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mux_control *mux = to_mux_control(dev);
+
+	mux_control_unregister(mux);
+	mux_control_put(mux);
+	return 0;
+}
+
+static struct platform_driver mux_gpio_driver = {
+	.driver = {
+		.name = "mux-gpio",
+		.of_match_table	= of_match_ptr(mux_gpio_dt_ids),
+	},
+	.probe = mux_gpio_probe,
+	.remove = mux_gpio_remove,
+};
+module_platform_driver(mux_gpio_driver);
+
+MODULE_AUTHOR("Peter Rosin <peda@axentia.se");
+MODULE_DESCRIPTION("GPIO-controlled multiplexer driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mux.h b/include/linux/mux.h
new file mode 100644
index 000000000000..5b21b8184056
--- /dev/null
+++ b/include/linux/mux.h
@@ -0,0 +1,53 @@
+/*
+ * mux.h - definitions for the multiplexer interface
+ *
+ * Copyright (C) 2016 Axentia Technologies AB
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _LINUX_MUX_H
+#define _LINUX_MUX_H
+
+#include <linux/device.h>
+#include <linux/rwsem.h>
+
+struct mux_control;
+
+struct mux_control_ops {
+	int (*set)(struct mux_control *mux, int reg);
+};
+
+struct mux_control {
+	struct rw_semaphore lock; /* protects the state of the mux */
+
+	struct device dev;
+	int id;
+
+	int cached_state;
+	int idle_state;
+
+	const struct mux_control_ops *ops;
+
+	void *priv;
+};
+
+#define to_mux_control(x) container_of((x), struct mux_control, dev)
+
+struct mux_control *mux_control_alloc(size_t sizeof_priv);
+int mux_control_register(struct mux_control *mux);
+void mux_control_unregister(struct mux_control *mux);
+void mux_control_put(struct mux_control *mux);
+
+int mux_control_select(struct mux_control *mux, int state);
+int mux_control_deselect(struct mux_control *mux);
+
+struct mux_control *mux_control_get(struct device *dev,
+				    const char *mux_name);
+struct mux_control *devm_mux_control_get(struct device *dev,
+					 const char *mux_name);
+void devm_mux_control_put(struct device *dev, struct mux_control *mux);
+
+#endif /* _LINUX_MUX_H */
-- 
2.1.4
