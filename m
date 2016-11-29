Return-Path: <peda@axentia.se>
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, "Rob
 Herring" <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Jonathan
 Cameron" <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, <linux-i2c@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
Subject: [PATCH v5 2/9] misc: minimal mux subsystem and gpio-based mux controller
Date: Tue, 29 Nov 2016 11:10:38 +0100
Message-ID: <1480414245-14034-3-git-send-email-peda@axentia.se>
In-Reply-To: <1480414245-14034-1-git-send-email-peda@axentia.se>
References: <1480414245-14034-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add a new minimalistic subsystem that handles multiplexer controllers.
When multiplexers are used in various places in the kernel, and the
same multiplexer controller can be used for several independent things,
there should be one place to implement support for said multiplexer
controller.

A single multiplexer controller can also be used to control several
parallel multiplexers, that are in turn used by different subsystems
in the kernel, leading to a need to coordinate multiplexer accesses.
The multiplexer subsystem handles this coordination.

This new mux controller subsystem initially comes with a single backend
driver that controls gpio based multiplexers. Even though not needed by
this initial driver, the mux controller subsystem is prepared to handle
chips with multiple (independent) mux controllers.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/driver-model/devres.txt |   6 +-
 MAINTAINERS                           |   2 +
 drivers/misc/Kconfig                  |  30 ++++
 drivers/misc/Makefile                 |   2 +
 drivers/misc/mux-core.c               | 311 ++++++++++++++++++++++++++++++++++
 drivers/misc/mux-gpio.c               | 138 +++++++++++++++
 include/linux/mux.h                   | 197 +++++++++++++++++++++
 7 files changed, 685 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/mux-core.c
 create mode 100644 drivers/misc/mux-gpio.c
 create mode 100644 include/linux/mux.h

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index ca9d1eb46bc0..d64ede85b61b 100644
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
 
 PER-CPU MEM
   devm_alloc_percpu()
diff --git a/MAINTAINERS b/MAINTAINERS
index 3d4d0efc2b64..dc7498682752 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8407,6 +8407,8 @@ MULTIPLEXER SUBSYSTEM
 M:	Peter Rosin <peda@axentia.se>
 S:	Maintained
 F:	Documentation/devicetree/bindings/misc/mux-*
+F:	include/linux/mux.h
+F:	drivers/misc/mux-*
 
 MULTISOUND SOUND DRIVER
 M:	Andrew Veliath <andrewtv@usa.net>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 64971baf11fa..2ce675e410c5 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -766,6 +766,36 @@ config PANEL_BOOT_MESSAGE
 	  An empty message will only clear the display at driver init time. Any other
 	  printf()-formatted message is valid with newline and escape codes.
 
+menuconfig MULTIPLEXER
+	bool "Multiplexer subsystem"
+	help
+	  Multiplexer controller subsystem. Multiplexers are used in a
+	  variety of settings, and this subsystem abstracts their use
+	  so that the rest of the kernel sees a common interface. When
+	  multiple parallel multiplexers are controlled by one single
+	  multiplexer controller, this subsystem also coordinates the
+	  multiplexer accesses.
+
+	  If unsure, say no.
+
+if MULTIPLEXER
+
+config MUX_GPIO
+	tristate "GPIO-controlled Multiplexer"
+	depends on OF && GPIOLIB
+	help
+	  GPIO-controlled Multiplexer controller.
+
+	  The driver builds a single multiplexer controller using a number
+	  of gpio pins. For N pins, there will be 2^N possible multiplexer
+	  states. The GPIO pins can be connected (by the hardware) to several
+	  multiplexers, which in that case will be operated in parallel.
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
index 000000000000..cccaa7261a6e
--- /dev/null
+++ b/drivers/misc/mux-core.c
@@ -0,0 +1,311 @@
+/*
+ * Multiplexer subsystem
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
+static struct class mux_class = {
+	.name = "mux",
+	.owner = THIS_MODULE,
+};
+
+static int __init mux_init(void)
+{
+	return class_register(&mux_class);
+}
+
+static DEFINE_IDA(mux_ida);
+
+static void mux_chip_release(struct device *dev)
+{
+	struct mux_chip *mux_chip = to_mux_chip(dev);
+
+	ida_simple_remove(&mux_ida, mux_chip->id);
+	kfree(mux_chip);
+}
+
+static struct device_type mux_type = {
+	.name = "mux-chip",
+	.release = mux_chip_release,
+};
+
+struct mux_chip *mux_chip_alloc(struct device *dev,
+				unsigned int controllers, size_t sizeof_priv)
+{
+	struct mux_chip *mux_chip;
+	int i;
+
+	if (!dev || !controllers)
+		return NULL;
+
+	mux_chip = kzalloc(sizeof(*mux_chip) +
+			   controllers * sizeof(*mux_chip->mux) +
+			   sizeof_priv, GFP_KERNEL);
+	if (!mux_chip)
+		return NULL;
+
+	mux_chip->mux = (struct mux_control *)(mux_chip + 1);
+	mux_chip->dev.class = &mux_class;
+	mux_chip->dev.type = &mux_type;
+	mux_chip->dev.parent = dev;
+	mux_chip->dev.of_node = dev->of_node;
+	dev_set_drvdata(&mux_chip->dev, mux_chip);
+
+	mux_chip->id = ida_simple_get(&mux_ida, 0, 0, GFP_KERNEL);
+	if (mux_chip->id < 0) {
+		pr_err("muxchipX failed to get a device id\n");
+		kfree(mux_chip);
+		return NULL;
+	}
+	dev_set_name(&mux_chip->dev, "muxchip%d", mux_chip->id);
+
+	mux_chip->controllers = controllers;
+	for (i = 0; i < controllers; ++i) {
+		struct mux_control *mux = &mux_chip->mux[i];
+
+		mux->chip = mux_chip;
+		init_rwsem(&mux->lock);
+		mux->cached_state = -1;
+		mux->idle_state = -1;
+	}
+
+	device_initialize(&mux_chip->dev);
+
+	return mux_chip;
+}
+EXPORT_SYMBOL_GPL(mux_chip_alloc);
+
+static int mux_control_set(struct mux_control *mux, int state)
+{
+	int ret = mux->chip->ops->set(mux, state);
+
+	mux->cached_state = ret < 0 ? -1 : state;
+
+	return ret;
+}
+
+int mux_chip_register(struct mux_chip *mux_chip)
+{
+	int i;
+	int ret;
+
+	for (i = 0; i < mux_chip->controllers; ++i) {
+		struct mux_control *mux = &mux_chip->mux[i];
+
+		if (mux->idle_state == mux->cached_state)
+			continue;
+
+		ret = mux_control_set(mux, mux->idle_state);
+		if (ret < 0)
+			return ret;
+	}
+
+	return device_add(&mux_chip->dev);
+}
+EXPORT_SYMBOL_GPL(mux_chip_register);
+
+void mux_chip_unregister(struct mux_chip *mux_chip)
+{
+	device_del(&mux_chip->dev);
+}
+EXPORT_SYMBOL_GPL(mux_chip_unregister);
+
+void mux_chip_free(struct mux_chip *mux_chip)
+{
+	if (!mux_chip)
+		return;
+	put_device(&mux_chip->dev);
+}
+EXPORT_SYMBOL_GPL(mux_chip_free);
+
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
+static int of_dev_node_match(struct device *dev, const void *data)
+{
+	return dev->of_node == data;
+}
+
+static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
+{
+	struct device *dev;
+
+	dev = class_find_device(&mux_class, NULL, np, of_dev_node_match);
+
+	return dev ? to_mux_chip(dev) : NULL;
+}
+
+struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
+{
+	struct device_node *np = dev->of_node;
+	struct of_phandle_args args;
+	struct mux_chip *mux_chip;
+	unsigned int controller;
+	int index = 0;
+	int ret;
+
+	if (mux_name) {
+		index = of_property_match_string(np, "mux-control-names",
+						 mux_name);
+		if (index < 0)
+			return ERR_PTR(index);
+	}
+
+	ret = of_parse_phandle_with_args(np,
+					 "mux-controls", "#mux-control-cells",
+					 index, &args);
+	if (ret) {
+		dev_err(dev, "%s: failed to get mux-control %s(%i)\n",
+			np->full_name, mux_name ?: "", index);
+		return ERR_PTR(ret);
+	}
+
+	mux_chip = of_find_mux_chip_by_node(args.np);
+	of_node_put(args.np);
+	if (!mux_chip)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	if (args.args_count > 1 ||
+	    (!args.args_count && (mux_chip->controllers > 1))) {
+		dev_err(dev, "%s: wrong #mux-control-cells for %s\n",
+			np->full_name, args.np->full_name);
+		return ERR_PTR(-EINVAL);
+	}
+
+	controller = 0;
+	if (args.args_count)
+		controller = args.args[0];
+
+	if (controller >= mux_chip->controllers)
+		return ERR_PTR(-EINVAL);
+
+	get_device(&mux_chip->dev);
+	return &mux_chip->mux[controller];
+}
+EXPORT_SYMBOL_GPL(mux_control_get);
+
+void mux_control_put(struct mux_control *mux)
+{
+	put_device(&mux->chip->dev);
+}
+EXPORT_SYMBOL_GPL(mux_control_put);
+
+static void devm_mux_control_release(struct device *dev, void *res)
+{
+	struct mux_control *mux = *(struct mux_control **)res;
+
+	mux_control_put(mux);
+}
+
+struct mux_control *devm_mux_control_get(struct device *dev,
+					 const char *mux_name)
+{
+	struct mux_control **ptr, *mux;
+
+	ptr = devres_alloc(devm_mux_control_release, sizeof(*ptr), GFP_KERNEL);
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
+void devm_mux_control_put(struct device *dev, struct mux_control *mux)
+{
+	WARN_ON(devres_release(dev, devm_mux_control_release,
+			       devm_mux_control_match, mux));
+}
+EXPORT_SYMBOL_GPL(devm_mux_control_put);
+
+subsys_initcall(mux_init);
+
+MODULE_DESCRIPTION("Multiplexer subsystem");
+MODULE_AUTHOR("Peter Rosin <peda@axentia.se");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/misc/mux-gpio.c b/drivers/misc/mux-gpio.c
new file mode 100644
index 000000000000..b50d6b871895
--- /dev/null
+++ b/drivers/misc/mux-gpio.c
@@ -0,0 +1,138 @@
+/*
+ * GPIO-controlled multiplexer driver
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
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/mux.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
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
+	{ .compatible = "mux-gpio", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mux_gpio_dt_ids);
+
+static int mux_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = pdev->dev.of_node;
+	struct mux_chip *mux_chip;
+	struct mux_gpio *mux_gpio;
+	int pins;
+	u32 idle_state;
+	int ret;
+
+	if (!np)
+		return -ENODEV;
+
+	pins = gpiod_count(dev, "mux");
+	if (pins < 0)
+		return pins;
+
+	mux_chip = mux_chip_alloc(dev, 1, sizeof(*mux_gpio) +
+				  pins * sizeof(*mux_gpio->val));
+	if (!mux_chip)
+		return -ENOMEM;
+
+	mux_gpio = mux_chip_priv(mux_chip);
+	mux_gpio->val = (int *)(mux_gpio + 1);
+	mux_chip->ops = &mux_gpio_ops;
+
+	platform_set_drvdata(pdev, mux_chip);
+
+	mux_gpio->gpios = devm_gpiod_get_array(dev, "mux", GPIOD_OUT_LOW);
+	if (IS_ERR(mux_gpio->gpios)) {
+		ret = PTR_ERR(mux_gpio->gpios);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get gpios\n");
+		goto free_mux_chip;
+	}
+	WARN_ON(pins != mux_gpio->gpios->ndescs);
+	mux_chip->mux->states = 1 << pins;
+
+	ret = of_property_read_u32(np, "idle-state", &idle_state);
+	if (ret >= 0) {
+		if (idle_state >= mux_chip->mux->states) {
+			dev_err(dev, "invalid idle-state %u\n", idle_state);
+			ret = -EINVAL;
+			goto free_mux_chip;
+		}
+
+		mux_chip->mux->idle_state = idle_state;
+	}
+
+	ret = mux_chip_register(mux_chip);
+	if (ret < 0) {
+		dev_err(dev, "failed to register mux-chip\n");
+		goto free_mux_chip;
+	}
+
+	dev_info(dev, "%u-way mux-controller registered\n",
+		 mux_chip->mux->states);
+
+	return 0;
+
+free_mux_chip:
+	mux_chip_free(mux_chip);
+	return ret;
+}
+
+static int mux_gpio_remove(struct platform_device *pdev)
+{
+	struct mux_chip *mux_chip = to_mux_chip(&pdev->dev);
+
+	mux_chip_unregister(mux_chip);
+	mux_chip_free(mux_chip);
+
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
+MODULE_DESCRIPTION("GPIO-controlled multiplexer driver");
+MODULE_AUTHOR("Peter Rosin <peda@axentia.se");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mux.h b/include/linux/mux.h
new file mode 100644
index 000000000000..d52a651660ff
--- /dev/null
+++ b/include/linux/mux.h
@@ -0,0 +1,197 @@
+/*
+ * mux.h - definitions for the multiplexer interface
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
+#ifndef _LINUX_MUX_H
+#define _LINUX_MUX_H
+
+#include <linux/device.h>
+#include <linux/rwsem.h>
+
+struct mux_chip;
+struct mux_control;
+struct platform_device;
+
+struct mux_control_ops {
+	int (*set)(struct mux_control *mux, int state);
+};
+
+/**
+ * struct mux_control - Represents a mux controller.
+ * @lock:		Protects the mux controller state.
+ * @chip:		The mux chip that is handling this mux controller.
+ * @states:		The number of mux controller states.
+ * @cached_state:	The current mux controller state, or -1 if none.
+ * @idle_state:		The mux controller state to use when inactive, or -1
+ *			for none.
+ */
+struct mux_control {
+	struct rw_semaphore lock; /* protects the state of the mux */
+
+	struct mux_chip *chip;
+
+	unsigned int states;
+	int cached_state;
+	int idle_state;
+};
+
+/**
+ * struct mux_chip -	Represents a chip holding mux controllers.
+ * @controllers:	Number of mux controllers handled by the chip.
+ * @mux:		Array of mux controllers that is handled.
+ * @dev:		Device structure.
+ * @id:			Used to identify the device internally.
+ * @ops:		Mux controller operations.
+ */
+struct mux_chip {
+	unsigned int controllers;
+	struct mux_control *mux;
+	struct device dev;
+	int id;
+
+	const struct mux_control_ops *ops;
+};
+
+#define to_mux_chip(x) container_of((x), struct mux_chip, dev)
+
+/**
+ * mux_chip_priv() - Get the extra memory reserved by mux_chip_alloc().
+ * @mux_chip: The mux-chip to get the private memory from.
+ *
+ * Return: Pointer to the private memory reserved by the allocator.
+ */
+static inline void *mux_chip_priv(struct mux_chip *mux_chip)
+{
+	return mux_chip + 1;
+}
+
+/**
+ * mux_chip_alloc() - Allocate a mux-chip.
+ * @dev: The parent device implementing the mux interface.
+ * @controllers: The number of mux controllers to allocate for this chip.
+ * @sizeof_priv: Size of extra memory area for private use by the caller.
+ *
+ * Return: A pointer to the new mux-chip, NULL on failure.
+ */
+struct mux_chip *mux_chip_alloc(struct device *dev,
+				unsigned int controllers, size_t sizeof_priv);
+
+/**
+ * mux_chip_register() - Register a mux-chip, thus readying the controllers
+ *			 for use.
+ * @mux_chip: The mux-chip to register.
+ *
+ * Do not retry registration of the same mux-chip on failure. You should
+ * instead put it away with mux_chip_free() and allocate a new one, if you
+ * for some reason would like to retry registration.
+ *
+ * Return: Zero on success or a negative errno on error.
+ */
+int mux_chip_register(struct mux_chip *mux_chip);
+
+/**
+ * mux_chip_unregister() - Take the mux-chip off-line.
+ * @mux_chip: The mux-chip to unregister.
+ *
+ * mux_chip_unregister() reverses the effects of mux_chip_register().
+ * But not completely, you should not try to call mux_chip_register()
+ * on a mux-chip that has been registered before.
+ */
+void mux_chip_unregister(struct mux_chip *mux_chip);
+
+/**
+ * mux_chip_free() - Free the mux-chip for good.
+ * @mux_chip: The mux-chip to free.
+ *
+ * mux_chip_free() reverses the effects of mux_chip_alloc().
+ */
+void mux_chip_free(struct mux_chip *mux_chip);
+
+/**
+ * mux_control_select() - Select the given multiplexer state.
+ * @mux: The mux-control to request a change of state from.
+ * @state: The new requested state.
+ *
+ * Make sure to call mux_control_deselect() when the operation is complete and
+ * the mux-control is free for others to use, but do not call
+ * mux_control_deselect() if mux_control_select() fails.
+ *
+ * Return: 0 if the requested state was already active, or 1 it the
+ * mux-control state was changed to the requested state. Or a negavive
+ * errno on error.
+ *
+ * Note that the difference in return value of zero or one is of
+ * questionable value; especially if the mux-control has several independent
+ * consumers, which is something the consumers should perhaps not be making
+ * assumptions about.
+ */
+int mux_control_select(struct mux_control *mux, int state);
+
+/**
+ * mux_control_deselect() - Deselect the previously selected multiplexer state.
+ * @mux: The mux-control to deselect.
+ *
+ * Return: 0 on success and a negative errno on error. An error can only
+ * occur if the mux has an idle state. Note that even if an error occurs, the
+ * mux-control is unlocked for others to access.
+ */
+int mux_control_deselect(struct mux_control *mux);
+
+/**
+ * mux_control_get_index() - Get the index of the given mux controller
+ * @mux: The mux-control to the the index for.
+ *
+ * Return: The index of the mux controller within the mux chip the mux
+ * controller is a part of.
+ */
+static inline unsigned int mux_control_get_index(struct mux_control *mux)
+{
+	return mux - mux->chip->mux;
+}
+
+/**
+ * mux_control_get() - Get the mux-control for a device.
+ * @dev: The device that needs a mux-control.
+ * @mux_name: The name identifying the mux-control.
+ *
+ * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
+ */
+struct mux_control *mux_control_get(struct device *dev, const char *mux_name);
+
+/**
+ * mux_control_put() - Put away the mux-control for good.
+ * @mux: The mux-control to put away.
+ *
+ * mux_control_put() reverses the effects of mux_control_get().
+ */
+void mux_control_put(struct mux_control *mux);
+
+/**
+ * devm_mux_control_get() - Get the mux-control for a device, with resource
+ *			    management.
+ * @dev: The device that needs a mux-control.
+ * @mux_name: The name identifying the mux-control.
+ *
+ * Return: Pointer to the mux-control, or an ERR_PTR with a negative errno.
+ */
+struct mux_control *devm_mux_control_get(struct device *dev,
+					 const char *mux_name);
+
+/**
+ * devm_mux_control_put() - Resource-managed version mux_control_put().
+ * @dev: The device that originally got the mux-control.
+ * @mux: The mux-control to put away.
+ *
+ * Note that you do not normally need to call this function.
+ */
+void devm_mux_control_put(struct device *dev, struct mux_control *mux);
+
+#endif /* _LINUX_MUX_H */
-- 
2.1.4
