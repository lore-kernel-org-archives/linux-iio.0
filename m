Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0092.outbound.protection.outlook.com ([104.47.2.92]:55803
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1166825AbdDXIfF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 24 Apr 2017 04:35:05 -0400
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>, <linux-i2c@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, <kernel@pengutronix.de>
Subject: [PATCH v14 03/11] mux: minimal mux subsystem
Date: Mon, 24 Apr 2017 10:36:27 +0200
Message-ID: <1493022995-16917-4-git-send-email-peda@axentia.se>
In-Reply-To: <1493022995-16917-1-git-send-email-peda@axentia.se>
References: <1493022995-16917-1-git-send-email-peda@axentia.se>
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

Thanks go out to Lars-Peter Clausen, Jonathan Cameron, Rob Herring,
Wolfram Sang, Paul Gortmaker, Dan Carpenter, Colin Ian King, Greg
Kroah-Hartman and last but certainly not least to Philipp Zabel for
helpful comments, reviews, patches and general encouragement!

Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/ABI/testing/sysfs-class-mux |  16 +
 Documentation/driver-model/devres.txt     |   8 +
 MAINTAINERS                               |   3 +
 drivers/Kconfig                           |   2 +
 drivers/Makefile                          |   1 +
 drivers/mux/Kconfig                       |  16 +
 drivers/mux/Makefile                      |   5 +
 drivers/mux/mux-core.c                    | 593 ++++++++++++++++++++++++++++++
 include/linux/mux/consumer.h              |  33 ++
 include/linux/mux/driver.h                | 111 ++++++
 10 files changed, 788 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-mux
 create mode 100644 drivers/mux/Kconfig
 create mode 100644 drivers/mux/Makefile
 create mode 100644 drivers/mux/mux-core.c
 create mode 100644 include/linux/mux/consumer.h
 create mode 100644 include/linux/mux/driver.h

diff --git a/Documentation/ABI/testing/sysfs-class-mux b/Documentation/ABI/testing/sysfs-class-mux
new file mode 100644
index 000000000000..8715f9c7bd4f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-mux
@@ -0,0 +1,16 @@
+What:		/sys/class/mux/
+Date:		April 2017
+KernelVersion:	4.13
+Contact:	Peter Rosin <peda@axentia.se>
+Description:
+		The mux/ class sub-directory belongs to the Generic MUX
+		Framework and provides a sysfs interface for using MUX
+		controllers.
+
+What:		/sys/class/mux/muxchipN/
+Date:		April 2017
+KernelVersion:	4.13
+Contact:	Peter Rosin <peda@axentia.se>
+Description:
+		A /sys/class/mux/muxchipN directory is created for each
+		probed MUX chip where N is a simple enumeration.
diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index efb8200819d6..e2343d9cbec7 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -337,6 +337,14 @@ MEM
 MFD
   devm_mfd_add_devices()
 
+MUX
+  devm_mux_chip_alloc()
+  devm_mux_chip_free()
+  devm_mux_chip_register()
+  devm_mux_chip_unregister()
+  devm_mux_control_get()
+  devm_mux_control_put()
+
 PER-CPU MEM
   devm_alloc_percpu()
   devm_free_percpu()
diff --git a/MAINTAINERS b/MAINTAINERS
index 7fc06739c8ad..4cfa080878e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8561,8 +8561,11 @@ F:	include/linux/spi/mmc_spi.h
 MULTIPLEXER SUBSYSTEM
 M:	Peter Rosin <peda@axentia.se>
 S:	Maintained
+F:	Documentation/ABI/testing/mux/sysfs-class-mux*
 F:	Documentation/devicetree/bindings/mux/
 F:	include/linux/dt-bindings/mux/
+F:	include/linux/mux/
+F:	drivers/mux/
 
 MULTISOUND SOUND DRIVER
 M:	Andrew Veliath <andrewtv@usa.net>
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 117ca14ccf85..a7ea13e1b869 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -204,4 +204,6 @@ source "drivers/fpga/Kconfig"
 
 source "drivers/fsi/Kconfig"
 
+source "drivers/mux/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 2eced9afba53..c0436f6dd5a9 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -177,3 +177,4 @@ obj-$(CONFIG_ANDROID)		+= android/
 obj-$(CONFIG_NVMEM)		+= nvmem/
 obj-$(CONFIG_FPGA)		+= fpga/
 obj-$(CONFIG_FSI)		+= fsi/
+obj-$(CONFIG_MULTIPLEXER)	+= mux/
diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
new file mode 100644
index 000000000000..23ab2cde83b1
--- /dev/null
+++ b/drivers/mux/Kconfig
@@ -0,0 +1,16 @@
+#
+# Multiplexer devices
+#
+
+menuconfig MULTIPLEXER
+	tristate "Multiplexer subsystem"
+	help
+	  Multiplexer controller subsystem. Multiplexers are used in a
+	  variety of settings, and this subsystem abstracts their use
+	  so that the rest of the kernel sees a common interface. When
+	  multiple parallel multiplexers are controlled by one single
+	  multiplexer controller, this subsystem also coordinates the
+	  multiplexer accesses.
+
+	  To compile the subsystem as a module, choose M here: the module will
+	  be called mux-core.
diff --git a/drivers/mux/Makefile b/drivers/mux/Makefile
new file mode 100644
index 000000000000..09f0299e109d
--- /dev/null
+++ b/drivers/mux/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for multiplexer devices.
+#
+
+obj-$(CONFIG_MULTIPLEXER)	+= mux-core.o
diff --git a/drivers/mux/mux-core.c b/drivers/mux/mux-core.c
new file mode 100644
index 000000000000..c02fa4dd2d09
--- /dev/null
+++ b/drivers/mux/mux-core.c
@@ -0,0 +1,593 @@
+/*
+ * Multiplexer subsystem
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
+#define pr_fmt(fmt) "mux-core: " fmt
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/idr.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mux/consumer.h>
+#include <linux/mux/driver.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+
+/*
+ * The idle-as-is "state" is not an actual state that may be selected, it
+ * only implies that the state should not be changed. So, use that state
+ * as indication that the cached state of the multiplexer is unknown.
+ */
+#define MUX_CACHE_UNKNOWN MUX_IDLE_AS_IS
+
+static struct class mux_class = {
+	.name = "mux",
+	.owner = THIS_MODULE,
+};
+
+static DEFINE_IDA(mux_ida);
+
+static int __init mux_init(void)
+{
+	ida_init(&mux_ida);
+	return class_register(&mux_class);
+}
+
+static void __exit mux_exit(void)
+{
+	class_register(&mux_class);
+	ida_destroy(&mux_ida);
+}
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
+/**
+ * mux_chip_alloc() - Allocate a mux-chip.
+ * @dev: The parent device implementing the mux interface.
+ * @controllers: The number of mux controllers to allocate for this chip.
+ * @sizeof_priv: Size of extra memory area for private use by the caller.
+ *
+ * After allocating the mux-chip with the desired number of mux controllers
+ * but before registering the chip, the mux driver is required to configure
+ * the number of valid mux states in the mux_chip->mux[N].states members and
+ * the desired idle state in the returned mux_chip->mux[N].idle_state members.
+ * The default idle state is MUX_IDLE_AS_IS. The mux driver also needs to
+ * provide a pointer to the operations struct in the mux_chip->ops member
+ * before registering the mux-chip with mux_chip_register.
+ *
+ * Return: A pointer to the new mux-chip, or an ERR_PTR with a negative errno.
+ */
+struct mux_chip *mux_chip_alloc(struct device *dev,
+				unsigned int controllers, size_t sizeof_priv)
+{
+	struct mux_chip *mux_chip;
+	int i;
+
+	if (WARN_ON(!dev || !controllers))
+		return ERR_PTR(-EINVAL);
+
+	mux_chip = kzalloc(sizeof(*mux_chip) +
+			   controllers * sizeof(*mux_chip->mux) +
+			   sizeof_priv, GFP_KERNEL);
+	if (!mux_chip)
+		return ERR_PTR(-ENOMEM);
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
+		int err = mux_chip->id;
+
+		pr_err("muxchipX failed to get a device id\n");
+		kfree(mux_chip);
+		return ERR_PTR(err);
+	}
+	dev_set_name(&mux_chip->dev, "muxchip%d", mux_chip->id);
+
+	mux_chip->controllers = controllers;
+	for (i = 0; i < controllers; ++i) {
+		struct mux_control *mux = &mux_chip->mux[i];
+
+		mux->chip = mux_chip;
+		mutex_init(&mux->lock);
+		mux->cached_state = MUX_CACHE_UNKNOWN;
+		mux->idle_state = MUX_IDLE_AS_IS;
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
+	mux->cached_state = ret < 0 ? MUX_CACHE_UNKNOWN : state;
+
+	return ret;
+}
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
+		if (ret < 0) {
+			dev_err(&mux_chip->dev, "unable to set idle state\n");
+			return ret;
+		}
+	}
+
+	ret = device_add(&mux_chip->dev);
+	if (ret < 0)
+		dev_err(&mux_chip->dev,
+			"device_add failed in %s: %d\n", __func__, ret);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mux_chip_register);
+
+/**
+ * mux_chip_unregister() - Take the mux-chip off-line.
+ * @mux_chip: The mux-chip to unregister.
+ *
+ * mux_chip_unregister() reverses the effects of mux_chip_register().
+ * But not completely, you should not try to call mux_chip_register()
+ * on a mux-chip that has been registered before.
+ */
+void mux_chip_unregister(struct mux_chip *mux_chip)
+{
+	device_del(&mux_chip->dev);
+}
+EXPORT_SYMBOL_GPL(mux_chip_unregister);
+
+/**
+ * mux_chip_free() - Free the mux-chip for good.
+ * @mux_chip: The mux-chip to free.
+ *
+ * mux_chip_free() reverses the effects of mux_chip_alloc().
+ */
+void mux_chip_free(struct mux_chip *mux_chip)
+{
+	if (!mux_chip)
+		return;
+
+	put_device(&mux_chip->dev);
+}
+EXPORT_SYMBOL_GPL(mux_chip_free);
+
+static void devm_mux_chip_release(struct device *dev, void *res)
+{
+	struct mux_chip *mux_chip = *(struct mux_chip **)res;
+
+	mux_chip_free(mux_chip);
+}
+
+/**
+ * devm_mux_chip_alloc() - Resource-managed version of mux_chip_alloc().
+ * @dev: The parent device implementing the mux interface.
+ * @controllers: The number of mux controllers to allocate for this chip.
+ * @sizeof_priv: Size of extra memory area for private use by the caller.
+ *
+ * See mux_chip_alloc() for more details.
+ *
+ * Return: A pointer to the new mux-chip, or an ERR_PTR with a negative errno.
+ */
+struct mux_chip *devm_mux_chip_alloc(struct device *dev,
+				     unsigned int controllers,
+				     size_t sizeof_priv)
+{
+	struct mux_chip **ptr, *mux_chip;
+
+	ptr = devres_alloc(devm_mux_chip_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	mux_chip = mux_chip_alloc(dev, controllers, sizeof_priv);
+	if (IS_ERR(mux_chip)) {
+		devres_free(ptr);
+		return mux_chip;
+	}
+
+	*ptr = mux_chip;
+	devres_add(dev, ptr);
+
+	return mux_chip;
+}
+EXPORT_SYMBOL_GPL(devm_mux_chip_alloc);
+
+static int devm_mux_chip_match(struct device *dev, void *res, void *data)
+{
+	struct mux_chip **r = res;
+
+	return *r == data;
+}
+
+/**
+ * devm_mux_chip_free() - Resource-managed version mux_chip_free().
+ * @dev: The device that originally got the mux-chip.
+ * @mux_chip: The mux-chip to free.
+ *
+ * See mux_chip_free() for more details.
+ *
+ * Note that you do not normally need to call this function.
+ */
+void devm_mux_chip_free(struct device *dev, struct mux_chip *mux_chip)
+{
+	devres_release(dev, devm_mux_chip_release,
+		       devm_mux_chip_match, mux_chip);
+}
+EXPORT_SYMBOL_GPL(devm_mux_chip_free);
+
+static void devm_mux_chip_reg_release(struct device *dev, void *res)
+{
+	struct mux_chip *mux_chip = *(struct mux_chip **)res;
+
+	mux_chip_unregister(mux_chip);
+}
+
+/**
+ * devm_mux_chip_register() - Resource-managed version mux_chip_register().
+ * @dev: The parent device implementing the mux interface.
+ * @mux_chip: The mux-chip to register.
+ *
+ * See mux_chip_register() for more details.
+ *
+ * Return: Zero on success or a negative errno on error.
+ */
+int devm_mux_chip_register(struct device *dev,
+			   struct mux_chip *mux_chip)
+{
+	struct mux_chip **ptr;
+	int res;
+
+	ptr = devres_alloc(devm_mux_chip_reg_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	res = mux_chip_register(mux_chip);
+	if (res) {
+		devres_free(ptr);
+		return res;
+	}
+
+	*ptr = mux_chip;
+	devres_add(dev, ptr);
+
+	return res;
+}
+EXPORT_SYMBOL_GPL(devm_mux_chip_register);
+
+/**
+ * devm_mux_chip_unregister() - Resource-managed version mux_chip_unregister().
+ * @dev: The device that originally registered the mux-chip.
+ * @mux_chip: The mux-chip to unregister.
+ *
+ * See mux_chip_unregister() for more details.
+ *
+ * Note that you do not normally need to call this function.
+ */
+void devm_mux_chip_unregister(struct device *dev, struct mux_chip *mux_chip)
+{
+	devres_release(dev, devm_mux_chip_reg_release,
+		       devm_mux_chip_match, mux_chip);
+}
+EXPORT_SYMBOL_GPL(devm_mux_chip_unregister);
+
+/**
+ * mux_control_states() - Query the number of multiplexer states.
+ * @mux: The mux-control to query.
+ *
+ * Return: The number of multiplexer states.
+ */
+unsigned int mux_control_states(struct mux_control *mux)
+{
+	return mux->states;
+}
+EXPORT_SYMBOL_GPL(mux_control_states);
+
+/*
+ * The mux->lock must be held when calling this function.
+ */
+static int __mux_control_select(struct mux_control *mux, int state)
+{
+	int ret;
+
+	if (WARN_ON(state < 0 || state >= mux->states))
+		return -EINVAL;
+
+	if (mux->cached_state == state)
+		return 0;
+
+	ret = mux_control_set(mux, state);
+	if (ret >= 0)
+		return 0;
+
+	/* The mux update failed, try to revert if appropriate... */
+	if (mux->idle_state != MUX_IDLE_AS_IS)
+		mux_control_set(mux, mux->idle_state);
+
+	return ret;
+}
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
+ * Return: 0 when the mux-control state has the requested state or a negative
+ * errno on error.
+ */
+int mux_control_select(struct mux_control *mux, unsigned int state)
+{
+	int ret;
+
+	mutex_lock(&mux->lock);
+
+	ret = __mux_control_select(mux, state);
+
+	if (ret < 0)
+		mutex_unlock(&mux->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mux_control_select);
+
+/**
+ * mux_control_try_select() - Try to select the given multiplexer state.
+ * @mux: The mux-control to request a change of state from.
+ * @state: The new requested state.
+ *
+ * Make sure to call mux_control_deselect() when the operation is complete and
+ * the mux-control is free for others to use, but do not call
+ * mux_control_deselect() if mux_control_try_select() fails.
+ *
+ * Return: 0 when the mux-control state has the requested state or a negative
+ * errno on error. Specifically -EBUSY if the mux-control is contended.
+ */
+int mux_control_try_select(struct mux_control *mux, unsigned int state)
+{
+	int ret;
+
+	if (!mutex_trylock(&mux->lock))
+		return -EBUSY;
+
+	ret = __mux_control_select(mux, state);
+
+	if (ret < 0)
+		mutex_unlock(&mux->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mux_control_try_select);
+
+/**
+ * mux_control_deselect() - Deselect the previously selected multiplexer state.
+ * @mux: The mux-control to deselect.
+ *
+ * Return: 0 on success and a negative errno on error. An error can only
+ * occur if the mux has an idle state. Note that even if an error occurs, the
+ * mux-control is unlocked and is thus free for the next access.
+ */
+int mux_control_deselect(struct mux_control *mux)
+{
+	int ret = 0;
+
+	if (mux->idle_state != MUX_IDLE_AS_IS &&
+	    mux->idle_state != mux->cached_state)
+		ret = mux_control_set(mux, mux->idle_state);
+
+	mutex_unlock(&mux->lock);
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
+/**
+ * mux_control_get() - Get the mux-control for a device.
+ * @dev: The device that needs a mux-control.
+ * @mux_name: The name identifying the mux-control.
+ *
+ * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
+ */
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
+		if (index < 0) {
+			dev_err(dev, "mux controller '%s' not found\n",
+				mux_name);
+			return ERR_PTR(index);
+		}
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
+	if (controller >= mux_chip->controllers) {
+		dev_err(dev, "%s: bad mux controller %u specified in %s\n",
+			np->full_name, controller, args.np->full_name);
+		return ERR_PTR(-EINVAL);
+	}
+
+	get_device(&mux_chip->dev);
+	return &mux_chip->mux[controller];
+}
+EXPORT_SYMBOL_GPL(mux_control_get);
+
+/**
+ * mux_control_put() - Put away the mux-control for good.
+ * @mux: The mux-control to put away.
+ *
+ * mux_control_put() reverses the effects of mux_control_get().
+ */
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
+/**
+ * devm_mux_control_get() - Get the mux-control for a device, with resource
+ *			    management.
+ * @dev: The device that needs a mux-control.
+ * @mux_name: The name identifying the mux-control.
+ *
+ * Return: Pointer to the mux-control, or an ERR_PTR with a negative errno.
+ */
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
+	return *r == data;
+}
+
+/**
+ * devm_mux_control_put() - Resource-managed version mux_control_put().
+ * @dev: The device that originally got the mux-control.
+ * @mux: The mux-control to put away.
+ *
+ * Note that you do not normally need to call this function.
+ */
+void devm_mux_control_put(struct device *dev, struct mux_control *mux)
+{
+	devres_release(dev, devm_mux_control_release,
+		       devm_mux_control_match, mux);
+}
+EXPORT_SYMBOL_GPL(devm_mux_control_put);
+
+/*
+ * Using subsys_initcall instead of module_init here to try to ensure - for
+ * the non-modular case - that the subsystem is initialized when mux consumers
+ * and mux controllers start to use it.
+ * For the modular case, the ordering is ensured with module dependencies.
+ */
+subsys_initcall(mux_init);
+module_exit(mux_exit);
+
+MODULE_DESCRIPTION("Multiplexer subsystem");
+MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
new file mode 100644
index 000000000000..a2a61834bd3a
--- /dev/null
+++ b/include/linux/mux/consumer.h
@@ -0,0 +1,33 @@
+/*
+ * mux/consumer.h - definitions for the multiplexer consumer interface
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
+#ifndef _LINUX_MUX_CONSUMER_H
+#define _LINUX_MUX_CONSUMER_H
+
+struct device;
+struct mux_control;
+
+unsigned int mux_control_states(struct mux_control *mux);
+int __must_check mux_control_select(struct mux_control *mux,
+				    unsigned int state);
+int __must_check mux_control_try_select(struct mux_control *mux,
+					unsigned int state);
+int mux_control_deselect(struct mux_control *mux);
+
+struct mux_control *mux_control_get(struct device *dev, const char *mux_name);
+void mux_control_put(struct mux_control *mux);
+
+struct mux_control *devm_mux_control_get(struct device *dev,
+					 const char *mux_name);
+void devm_mux_control_put(struct device *dev, struct mux_control *mux);
+
+#endif /* _LINUX_MUX_CONSUMER_H */
diff --git a/include/linux/mux/driver.h b/include/linux/mux/driver.h
new file mode 100644
index 000000000000..95269f40670a
--- /dev/null
+++ b/include/linux/mux/driver.h
@@ -0,0 +1,111 @@
+/*
+ * mux/driver.h - definitions for the multiplexer driver interface
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
+#ifndef _LINUX_MUX_DRIVER_H
+#define _LINUX_MUX_DRIVER_H
+
+#include <dt-bindings/mux/mux.h>
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/semaphore.h>
+
+struct mux_chip;
+struct mux_control;
+
+/**
+ * struct mux_control_ops -	Mux controller operations for a mux chip.
+ * @set:			Set the state of the given mux controller.
+ */
+struct mux_control_ops {
+	int (*set)(struct mux_control *mux, int state);
+};
+
+/**
+ * struct mux_control -	Represents a mux controller.
+ * @lock:		Protects the mux controller state.
+ * @chip:		The mux chip that is handling this mux controller.
+ * @cached_state:	The current mux controller state, or -1 if none.
+ * @states:		The number of mux controller states.
+ * @idle_state:		The mux controller state to use when inactive, or one
+ *			of MUX_IDLE_AS_IS and MUX_IDLE_DISCONNECT.
+ *
+ * Mux drivers may only change @states and @idle_state, and may only do so
+ * between allocation and registration of the mux controller. Specifically,
+ * @cached_state is internal to the mux core and should never be written by
+ * mux drivers.
+ */
+struct mux_control {
+	struct mutex lock; /* protects the state of the mux */
+
+	struct mux_chip *chip;
+	int cached_state;
+
+	unsigned int states;
+	int idle_state;
+};
+
+/**
+ * struct mux_chip -	Represents a chip holding mux controllers.
+ * @controllers:	Number of mux controllers handled by the chip.
+ * @mux:		Array of mux controllers that are handled.
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
+	return &mux_chip->mux[mux_chip->controllers];
+}
+
+struct mux_chip *mux_chip_alloc(struct device *dev,
+				unsigned int controllers, size_t sizeof_priv);
+int mux_chip_register(struct mux_chip *mux_chip);
+void mux_chip_unregister(struct mux_chip *mux_chip);
+void mux_chip_free(struct mux_chip *mux_chip);
+
+struct mux_chip *devm_mux_chip_alloc(struct device *dev,
+				     unsigned int controllers,
+				     size_t sizeof_priv);
+int devm_mux_chip_register(struct device *dev, struct mux_chip *mux_chip);
+void devm_mux_chip_unregister(struct device *dev, struct mux_chip *mux_chip);
+void devm_mux_chip_free(struct device *dev, struct mux_chip *mux_chip);
+
+/**
+ * mux_control_get_index() - Get the index of the given mux controller
+ * @mux: The mux-control to get the index for.
+ *
+ * Return: The index of the mux controller within the mux chip the mux
+ * controller is a part of.
+ */
+static inline unsigned int mux_control_get_index(struct mux_control *mux)
+{
+	return mux - mux->chip->mux;
+}
+
+#endif /* _LINUX_MUX_DRIVER_H */
-- 
2.1.4

