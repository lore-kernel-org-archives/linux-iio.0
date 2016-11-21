Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0137.outbound.protection.outlook.com ([104.47.2.137]:58478
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753457AbcKUNdC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Nov 2016 08:33:02 -0500
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
Subject: [PATCH v3 2/7] misc: minimal mux subsystem and gpio-based mux controller
Date: Mon, 21 Nov 2016 14:17:10 +0100
Message-ID: <1479734235-18837-3-git-send-email-peda@axentia.se>
In-Reply-To: <1479734235-18837-1-git-send-email-peda@axentia.se>
References: <1479734235-18837-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add a new minimalistic subsystem that handles multiplexer controllers.
When multiplexers are used in various places in the kernel, and the
same multiplexer controller can be used for several independent things,
there should be one place to implement support for said multiplexer
controller.

A single multiplexer controller can also be used to control several
parallel multiplexers, that are in turn used by different subsystems
in the kernel, leading to a need to coordinate multiplexer accesses.
The multiplexer subsystem handles this coordination.

This new mux controller subsystem comes with a single backend driver
that controls gpio based multiplexers.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/driver-model/devres.txt |   6 +-
 MAINTAINERS                           |   2 +
 drivers/misc/Kconfig                  |  23 +++
 drivers/misc/Makefile                 |   2 +
 drivers/misc/mux-core.c               | 325 ++++++++++++++++++++++++++++++++++
 drivers/misc/mux-gpio.c               | 116 ++++++++++++
 include/linux/mux.h                   |  55 ++++++
 7 files changed, 528 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/mux-core.c
 create mode 100644 drivers/misc/mux-gpio.c
 create mode 100644 include/linux/mux.h

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index 167070895498..947bfcfac9ae 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -330,7 +330,11 @@ MEM
   devm_kzalloc()
 
 MFD
- devm_mfd_add_devices()
+  devm_mfd_add_devices()
+
+MUX
+  devm_mux_control_get()
+  devm_mux_control_put()
 
 PCI
   pcim_enable_device()	: after success, all PCI ops become managed
diff --git a/MAINTAINERS b/MAINTAINERS
index 7d797f087822..37974aeee750 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8248,6 +8248,8 @@ MULTIPLEXER SUBSYSTEM
 M:	Peter Rosin <peda@axentia.se>
 S:	Maintained
 F:	Documentation/devicetree/bindings/misc/mux-*
+F:	include/linux/mux.h
+F:	drivers/misc/mux-*
 
 MULTISOUND SOUND DRIVER
 M:	Andrew Veliath <andrewtv@usa.net>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 64971baf11fa..a3ca79e082c7 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -766,6 +766,29 @@ config PANEL_BOOT_MESSAGE
 	  An empty message will only clear the display at driver init time. Any other
 	  printf()-formatted message is valid with newline and escape codes.
 
+config MULTIPLEXER
+	tristate "Multiplexer subsystem"
+	help
+	  Multiplexer controller subsystem. Multiplexers are used in a
+	  variety of settings, and this subsystem abstracts their use
+	  so that the rest of the kernel sees a common interface. When
+	  multiple parallel multiplexers are controlled by one single
+	  multiplexer controller, this subsystem also coordinates the
+	  multiplexer accesses.
+
+if MULTIPLEXER
+
+config MUX_GPIO
+	tristate "GPIO-controlled MUX controller"
+	depends on OF && GPIOLIB
+	help
+	  GPIO-controlled MUX controller.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called mux-gpio.
+
+endif
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 31983366090a..0befa2bba762 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -53,6 +53,8 @@ obj-$(CONFIG_ECHO)		+= echo/
 obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
 obj-$(CONFIG_CXL_BASE)		+= cxl/
 obj-$(CONFIG_PANEL)             += panel.o
+obj-$(CONFIG_MULTIPLEXER)      	+= mux-core.o
+obj-$(CONFIG_MUX_GPIO)		+= mux-gpio.o
 
 lkdtm-$(CONFIG_LKDTM)		+= lkdtm_core.o
 lkdtm-$(CONFIG_LKDTM)		+= lkdtm_bugs.o
diff --git a/drivers/misc/mux-core.c b/drivers/misc/mux-core.c
new file mode 100644
index 000000000000..5142caa19236
--- /dev/null
+++ b/drivers/misc/mux-core.c
@@ -0,0 +1,325 @@
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
+#include <linux/of_platform.h>
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
+/**
+ * mux_control_alloc - allocate a mux-control
+ * @sizeof_priv: Size of extra memory area for private use by the caller.
+ *
+ * Returns the new mux-control.
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
+/**
+ * mux_control_register - register a mux-control, thus readying it for use
+ * @mux: The mux-control to register.
+ *
+ * Returns zero on success or a negative errno on error.
+ */
+int mux_control_register(struct mux_control *mux)
+{
+	int ret;
+
+	/* If the calling driver did not initialize of_node, do it here */
+	if (!mux->dev.of_node && mux->dev.parent)
+		mux->dev.of_node = mux->dev.parent->of_node;
+
+	ret = device_add(&mux->dev);
+	if (ret < 0)
+		return ret;
+
+	ret = of_platform_populate(mux->dev.of_node, NULL, NULL, &mux->dev);
+	if (ret < 0)
+		device_del(&mux->dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mux_control_register);
+
+/**
+ * mux_control_unregister - take the mux-control off-line, reversing the
+ *			    effexts of mux_control_register
+ * @mux: the mux-control to unregister.
+ */
+void mux_control_unregister(struct mux_control *mux)
+{
+	of_platform_depopulate(&mux->dev);
+	device_del(&mux->dev);
+}
+EXPORT_SYMBOL_GPL(mux_control_unregister);
+
+/**
+ * mux_control_put - put away the mux-control for good, reversing the
+ *		     effects of either mux_control_alloc or mux_control_get
+ * @mux: The mux-control to put away.
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
+/**
+ * mux_control_select - select the given multiplexer state
+ * @mux: The mux-control to request a change of state from.
+ * @state: The new requested state.
+ *
+ * Returns 0 if the requested state was already active, or 1 it the
+ * mux-control state was changed to the requested state. Or a negavive
+ * errno on error.
+ * Note that the difference in return value of zero or one is of
+ * questionable value; especially if the mux-control has several independent
+ * consumers, which is something the consumers should not be making
+ * assumptions about.
+ *
+ * Make sure to call mux_control_deselect when the operation is complete and
+ * the mux-control is free for others to use, but do not call
+ * mux_control_deselect if mux_control_select fails.
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
+		 * That makes me wonder how long I waited for nothing?
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
+/**
+ * mux_control_deselect - deselect the previously selected multiplexer state
+ * @mux: The mux-control to deselect.
+ *
+ * Returns 0 on success and a negative errno on error. An error can only
+ * occur if the mux has an idle state. Note that even if an error occurs, the
+ * mux-control is unlocked for others to access.
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
+/**
+ * mux_control_get - get the mux-control for a device
+ * @dev: The device that needs a mux-control.
+ *
+ * Returns the mux-control.
+ */
+struct mux_control *mux_control_get(struct device *dev)
+{
+	struct mux_control *mux;
+
+	if (!dev->of_node)
+		return ERR_PTR(-ENODEV);
+
+	mux = of_find_mux_by_node(dev->of_node->parent);
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
+/**
+ * devm_mux_control_get - get the mux-control for a device, with resource
+ *			  management
+ * @dev: The device that needs a mux-control.
+ *
+ * Returns the mux-control.
+ */
+struct mux_control *devm_mux_control_get(struct device *dev)
+{
+	struct mux_control **ptr, *mux;
+
+	ptr = devres_alloc(devm_mux_control_free, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	mux = mux_control_get(dev);
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
+/**
+ * devm_mux_control_put - resource-managed version mux_control_put
+ * @dev: The device that originally got the mux-control.
+ * @mux: The mux-control to put away.
+ *
+ * Note that you do not normally need to call this function.
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
index 000000000000..e9baca35f400
--- /dev/null
+++ b/drivers/misc/mux-gpio.c
@@ -0,0 +1,116 @@
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
+	struct mux_gpio *mux_gpio = mux_control_priv(mux);
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
+	mux_gpio = mux_control_priv(mux);
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
+	mux->states = 1 << mux_gpio->gpios->ndescs;
+
+	ret = of_property_read_u32(np, "idle-state", &idle_state);
+	if (ret >= 0) {
+		if (idle_state >= mux->states) {
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
index 000000000000..2f1472192d6d
--- /dev/null
+++ b/include/linux/mux.h
@@ -0,0 +1,55 @@
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
+	unsigned int states;
+	int cached_state;
+	int idle_state;
+
+	const struct mux_control_ops *ops;
+};
+
+#define to_mux_control(x) container_of((x), struct mux_control, dev)
+
+static inline void *mux_control_priv(struct mux_control *mux)
+{
+	return mux + 1;
+}
+
+struct mux_control *mux_control_alloc(size_t sizeof_priv);
+int mux_control_register(struct mux_control *mux);
+void mux_control_unregister(struct mux_control *mux);
+void mux_control_put(struct mux_control *mux);
+
+int mux_control_select(struct mux_control *mux, int state);
+int mux_control_deselect(struct mux_control *mux);
+
+struct mux_control *mux_control_get(struct device *dev);
+struct mux_control *devm_mux_control_get(struct device *dev);
+void devm_mux_control_put(struct device *dev, struct mux_control *mux);
+
+#endif /* _LINUX_MUX_H */
-- 
2.1.4

