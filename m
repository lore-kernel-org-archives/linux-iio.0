Return-Path: <SRS0=Dxs2=DK=gmail.com=vilhelm.gray@kernel.org>
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: benjamin.gaignard@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 04/11] counter: Introduce the Simple Counter interface
Date: Thu, 14 Dec 2017 15:51:30 -0500
Message-Id: <25bd5a9aa7c49cde0f56380bba830b73726be650.1513266127.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1513266127.git.vilhelm.gray@gmail.com>
References: <cover.1513266127.git.vilhelm.gray@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch introduces the Simple Counter interface. The Simple Counter
interface serves as an API to provide support for simple hardware
counter devices. The Simple Counter interface is built on top of the
Generic Counter interface.

A simple hardware counter device is a counter device that has a single
signal associated with each count value; Signals may have a value of
"low" or "high," and edge trigger the count function which either
increases or decreases the respective count value.

The Simple Counter interface provides two count function modes:

        SIMPLE_COUNTER_FUNCTION_INCREASE: "increase"
        SIMPLE_COUNTER_FUNCTION_DECREASE: "decrease"

The Simple Counter interface provides four action modes:

        SIMPLE_COUNTER_ACTION_NONE: "none"
        SIMPLE_COUNTER_ACTION_RISING_EDGE: "rising edge"
        SIMPLE_COUNTER_ACTION_FALLING_EDGE: "falling edge"
        SIMPLE_COUNTER_ACTION_BOTH_EDGES: "both edges"

Signals may be represented by two possible states:

        SIMPLE_COUNTER_SIGNAL_LOW: "low"
        SIMPLE_COUNTER_SIGNAL_HIGH: "high"

Since the Simple Counter interface utilizes the Generic Counter
interface underneath, all the expected functionality of the Generic
Counter interface such as sysfs attributes is exposed to userspace for
end user consumption. The Simple Counter interface serves as a
convenience API for supporting a common class of counter devices without
the need to manually configure the more cumbersome Generic Counter
interface for use.

To use the Simple Counter interface, create an array of
simple_counter_count structures to represent the desired counts and
signals of the counter device, allocate a simple_counter_device
structure and populate it with respective driver callbacks and the
simple_counter_count array created earlier, then register the counter by
calling the simple_counter_register function. The
simple_counter_unregister function may be used to unregistered a
previously registered counter.

Memory-managed versions of simple_counter_register and
simple_counter_unregister functions are provided by the
devm_simple_counter_register and devm_simple_counter_unregister
functions respectively.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/iio/counter/Kconfig          |   4 +-
 drivers/iio/counter/Makefile         |   1 +
 drivers/iio/counter/simple-counter.c | 734 +++++++++++++++++++++++++++++++++++
 include/linux/iio/counter.h          | 199 ++++++++++
 4 files changed, 937 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/counter/simple-counter.c

diff --git a/drivers/iio/counter/Kconfig b/drivers/iio/counter/Kconfig
index 4eaf4e53c5aa..6b9a43180d2c 100644
--- a/drivers/iio/counter/Kconfig
+++ b/drivers/iio/counter/Kconfig
@@ -8,7 +8,9 @@ menuconfig COUNTER
 	help
 	  Provides support for Counter devices. The Generic Counter API provides
 	  rudimentary support for counters and serves as building blocks to
-	  create more complex counter interfaces.
+	  create more complex counter interfaces. The Simple Counter API
+	  provides support for simple hardware counter devices that have a
+	  one-to-one mapping between their Signals and Counts.
 
 if COUNTER
 
diff --git a/drivers/iio/counter/Makefile b/drivers/iio/counter/Makefile
index 513c49d832d4..7450dee97446 100644
--- a/drivers/iio/counter/Makefile
+++ b/drivers/iio/counter/Makefile
@@ -6,6 +6,7 @@
 
 obj-$(CONFIG_COUNTER) += counter.o
 counter-$(CONFIG_COUNTER) += generic-counter.o
+counter-$(CONFIG_COUNTER) += simple-counter.o
 
 obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
 obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
diff --git a/drivers/iio/counter/simple-counter.c b/drivers/iio/counter/simple-counter.c
new file mode 100644
index 000000000000..e061db0860fd
--- /dev/null
+++ b/drivers/iio/counter/simple-counter.c
@@ -0,0 +1,734 @@
+/*
+ * Simple Counter interface
+ * Copyright (C) 2017 William Breathitt Gray
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
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/gfp.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include <linux/iio/counter.h>
+
+static const char *const simple_counter_signal_level_names[] = {
+	[SIMPLE_COUNTER_SIGNAL_LOW] = "low",
+	[SIMPLE_COUNTER_SIGNAL_HIGH] = "high"
+};
+
+static ssize_t simple_counter_signal_read(struct counter_device *counter_dev,
+	struct counter_signal *counter_sig, char *buf)
+{
+	struct simple_counter_device *const counter = counter_dev->priv;
+	struct simple_counter_signal *const signal = counter_sig->priv;
+	int err;
+	enum simple_counter_signal_level level;
+
+	err = counter->signal_read(counter, signal, &level);
+	if (err)
+		return err;
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n",
+		simple_counter_signal_level_names[level]);
+}
+
+static ssize_t simple_counter_signal_write(struct counter_device *counter_dev,
+	struct counter_signal *counter_sig, const char *buf, size_t len)
+{
+	struct simple_counter_device *const counter = counter_dev->priv;
+	struct simple_counter_signal *const signal = counter_sig->priv;
+	int level;
+	int err;
+
+	level = sysfs_match_string(simple_counter_signal_level_names, buf);
+	if (level < 0)
+		return level;
+
+	err = counter->signal_write(counter, signal, level);
+	if (err)
+		return err;
+
+	return len;
+}
+
+static ssize_t simple_counter_count_read(struct counter_device *counter_dev,
+	struct counter_count *counter_cnt, char *buf)
+{
+	struct simple_counter_device *const counter = counter_dev->priv;
+	struct simple_counter_count *const count = counter_cnt->priv;
+	int err;
+	long val;
+
+	err = counter->count_read(counter, count, &val);
+	if (err)
+		return err;
+
+	return scnprintf(buf, PAGE_SIZE, "%ld\n", val);
+}
+
+static ssize_t simple_counter_count_write(struct counter_device *counter_dev,
+	struct counter_count *counter_cnt, const char *buf, size_t len)
+{
+	struct simple_counter_device *const counter = counter_dev->priv;
+	struct simple_counter_count *const count = counter_cnt->priv;
+	int err;
+	long val;
+
+	err = kstrtol(buf, 0, &val);
+	if (err)
+		return err;
+
+	err = counter->count_write(counter, count, val);
+	if (err)
+		return err;
+
+	return len;
+}
+
+static int simple_counter_function_get(struct counter_device *counter_dev,
+	struct counter_count *counter_cnt, size_t *counter_func)
+{
+	int err;
+	struct simple_counter_device *const counter = counter_dev->priv;
+	struct simple_counter_count *const count = counter_cnt->priv;
+	enum simple_counter_function function;
+
+	err = counter->function_get(counter, count, &function);
+	if (err)
+		return err;
+
+	count->function = function;
+
+	*counter_func = function;
+
+	return 0;
+}
+
+static int simple_counter_function_set(struct counter_device *counter_dev,
+	struct counter_count *counter_cnt, size_t function)
+{
+	struct simple_counter_device *const counter = counter_dev->priv;
+	struct simple_counter_count *const count = counter_cnt->priv;
+	int err;
+
+	err = counter->function_set(counter, count, function);
+	if (err)
+		return err;
+
+	count->function = function;
+
+	return 0;
+}
+
+static int simple_counter_action_get(struct counter_device *counter_dev,
+	struct counter_count *counter_cnt, struct counter_synapse *counter_syn,
+	size_t *counter_act)
+{
+	int err;
+	struct simple_counter_device *const counter = counter_dev->priv;
+	struct simple_counter_count *const count = counter_cnt->priv;
+	enum simple_counter_action action;
+
+	err = counter->action_get(counter, count, &action);
+	if (err)
+		return err;
+
+	count->action = action;
+
+	*counter_act = action;
+
+	return 0;
+}
+
+static int simple_counter_action_set(struct counter_device *counter_dev,
+	struct counter_count *counter_cnt, struct counter_synapse *counter_syn,
+	size_t action)
+{
+	struct simple_counter_device *const counter = counter_dev->priv;
+	struct simple_counter_count *const count = counter_cnt->priv;
+	int err;
+
+	err = counter->action_set(counter, count, action);
+	if (err)
+		return err;
+
+	count->action = action;
+
+	return 0;
+}
+
+static ssize_t simple_counter_signal_ext_read(struct counter_device *dev,
+	struct counter_signal *signal, void *priv, char *buf)
+{
+	const struct simple_counter_signal_ext *const ext = priv;
+	struct simple_counter_device *const counter = dev->priv;
+	struct simple_counter_signal *const simple_signal = signal->priv;
+
+	return ext->read(counter, simple_signal, ext->priv, buf);
+}
+
+static ssize_t simple_counter_signal_ext_write(struct counter_device *dev,
+	struct counter_signal *signal, void *priv, const char *buf, size_t len)
+{
+	const struct simple_counter_signal_ext *const ext = priv;
+	struct simple_counter_device *const counter = dev->priv;
+	struct simple_counter_signal *const simple_signal = signal->priv;
+
+	return ext->write(counter, simple_signal, ext->priv, buf, len);
+}
+
+static int simple_counter_counter_signal_ext_register(
+	const struct simple_counter_signal *const simple_signal,
+	struct counter_signal *const signal)
+{
+	const struct simple_counter_signal_ext *const simple_ext =
+		simple_signal->ext;
+	const size_t num_ext = simple_signal->num_ext;
+	struct counter_signal_ext *ext;
+	size_t i;
+
+	/* Return early if no extensions */
+	if (!simple_ext || !num_ext)
+		return 0;
+
+	/* Allocate space for counter_signal_ext array */
+	ext = kmalloc_array(num_ext, sizeof(*ext), GFP_KERNEL);
+	if (!ext)
+		return -ENOMEM;
+
+	/* Register simple_counter_signal_ext via counter_signal_ext */
+	for (i = 0; i < num_ext; i++) {
+		ext[i].name = simple_ext[i].name;
+		ext[i].read = (simple_ext[i].read) ?
+			simple_counter_signal_ext_read : NULL;
+		ext[i].write = (simple_ext[i].write) ?
+			simple_counter_signal_ext_write : NULL;
+		ext[i].priv = simple_ext + i;
+	}
+
+	/* Register Counter Signal extensions */
+	signal->ext = ext;
+	signal->num_ext = num_ext;
+
+	return 0;
+}
+
+static int simple_counter_counter_signals_register(
+	const struct simple_counter_device *const counter)
+{
+	const size_t num_counts = counter->num_counts;
+	struct counter_signal *signals;
+	const size_t num_signals = num_counts;
+	struct simple_counter_count *const simple_counts = counter->counts;
+	size_t i;
+	struct counter_signal *signal;
+	struct simple_counter_signal *simple_signal;
+	int err;
+	struct counter_device *const counter_dev = counter->counter_dev;
+
+	/* Allocate space for signals array */
+	signals = kcalloc(num_signals, sizeof(*signals), GFP_KERNEL);
+	if (!signals)
+		return -ENOMEM;
+
+	/* Configure Signals */
+	for (i = 0; i < num_signals; i++) {
+		signal = signals + i;
+		simple_signal = &simple_counts[i].signal;
+
+		signal->id = simple_signal->id;
+		signal->name = simple_signal->name;
+		signal->priv = simple_signal;
+
+		/* Register Counter Signal extensions */
+		err = simple_counter_counter_signal_ext_register(simple_signal,
+			signal);
+		if (err)
+			goto err_free_signals;
+	}
+
+	/* Register Signals to Counter device container */
+	counter_dev->signals = signals;
+	counter_dev->num_signals = num_signals;
+
+	return 0;
+
+err_free_signals:
+	while (i--)
+		kfree(signals[i].ext);
+	kfree(signals);
+	return err;
+}
+
+static const char *const simple_counter_function_names[] = {
+	[SIMPLE_COUNTER_FUNCTION_INCREASE] = "increase",
+	[SIMPLE_COUNTER_FUNCTION_DECREASE] = "decrease"
+};
+
+static const char *const simple_counter_action_names[] = {
+	[SIMPLE_COUNTER_ACTION_NONE] = "none",
+	[SIMPLE_COUNTER_ACTION_RISING_EDGE] = "rising edge",
+	[SIMPLE_COUNTER_ACTION_FALLING_EDGE] = "falling edge",
+	[SIMPLE_COUNTER_ACTION_BOTH_EDGES] = "both edges"
+};
+
+static int simple_counter_counter_synapse_register(
+	struct counter_signal *const signal, struct counter_count *const count)
+{
+	struct counter_synapse *synapse;
+
+	/* Allocate space for Counter Synapse */
+	synapse = kzalloc(sizeof(*synapse), GFP_KERNEL);
+	if (!synapse)
+		return -ENOMEM;
+
+	/* Configure Synapse */
+	synapse->signal = signal;
+	synapse->actions = simple_counter_action_names;
+	synapse->num_actions = ARRAY_SIZE(simple_counter_action_names);
+
+	/* Register Counter Synapse */
+	count->synapses = synapse;
+	count->num_synapses = 1;
+
+	return 0;
+}
+
+static ssize_t simple_counter_count_ext_read(struct counter_device *dev,
+	struct counter_count *count, void *priv, char *buf)
+{
+	const struct simple_counter_count_ext *const ext = priv;
+	struct simple_counter_device *const counter = dev->priv;
+	struct simple_counter_count *const simple_count = count->priv;
+
+	return ext->read(counter, simple_count, ext->priv, buf);
+}
+
+static ssize_t simple_counter_count_ext_write(struct counter_device *dev,
+	struct counter_count *count, void *priv, const char *buf, size_t len)
+{
+	const struct simple_counter_count_ext *const ext = priv;
+	struct simple_counter_device *const counter = dev->priv;
+	struct simple_counter_count *const simple_count = count->priv;
+
+	return ext->write(counter, simple_count, ext->priv, buf, len);
+}
+
+static int simple_counter_counter_count_ext_register(
+	const struct simple_counter_count *const simple_count,
+	struct counter_count *const count)
+{
+	const struct simple_counter_count_ext *const simple_ext =
+		simple_count->ext;
+	const size_t num_ext = simple_count->num_ext;
+	struct counter_count_ext *ext;
+	size_t i;
+
+	/* Return early if no extensions */
+	if (!simple_ext || !num_ext)
+		return 0;
+
+	/* Allocate space for Counter Count extensions array */
+	ext = kmalloc_array(num_ext, sizeof(*ext), GFP_KERNEL);
+	if (!ext)
+		return -ENOMEM;
+
+	/* Register simple_counter_count_ext via counter_count_ext */
+	for (i = 0; i < num_ext; i++) {
+		ext[i].name = simple_ext[i].name;
+		ext[i].read = (simple_ext[i].read) ?
+			simple_counter_count_ext_read : NULL;
+		ext[i].write = (simple_ext[i].write) ?
+			simple_counter_count_ext_write : NULL;
+		ext[i].priv = simple_ext + i;
+	}
+
+	/* Register Counter Count extensions */
+	count->ext = ext;
+	count->num_ext = num_ext;
+
+	return 0;
+}
+
+static void simple_counter_counter_synapse_unregister(
+	const struct counter_count *const count)
+{
+	kfree(count->synapses);
+}
+
+static int simple_counter_counter_count_init(
+	struct counter_count *const count,
+	struct simple_counter_count *const simple_count,
+	struct counter_signal *const signal)
+{
+	int err;
+
+	count->id = simple_count->id;
+	count->name = simple_count->name;
+	count->functions = simple_counter_function_names;
+	count->num_functions = ARRAY_SIZE(simple_counter_function_names);
+	count->priv = simple_count;
+
+	/* Register Counter Synapse */
+	err = simple_counter_counter_synapse_register(signal, count);
+	if (err)
+		return err;
+
+	/* Register Counter Count extensions */
+	err = simple_counter_counter_count_ext_register(simple_count, count);
+	if (err)
+		goto err_unregister_synapse;
+
+	return 0;
+
+err_unregister_synapse:
+	simple_counter_counter_synapse_unregister(count);
+	return err;
+}
+
+static void simple_counter_counter_count_ext_unregister(
+	const struct counter_count *const count)
+{
+	kfree(count->ext);
+}
+
+static void simple_counter_counter_count_free(
+	const struct counter_count *const count)
+{
+	simple_counter_counter_count_ext_unregister(count);
+	simple_counter_counter_synapse_unregister(count);
+}
+
+static int simple_counter_counter_counts_register(
+	const struct simple_counter_device *const counter)
+{
+	struct counter_device *const counter_dev = counter->counter_dev;
+	struct counter_count *counts;
+	const size_t num_counts = counter->num_counts;
+	size_t i;
+	struct simple_counter_count *const simple_counts = counter->counts;
+	struct counter_signal *const signals = counter_dev->signals;
+	int err;
+
+	/* Allocate space for counts array */
+	counts = kcalloc(num_counts, sizeof(*counts), GFP_KERNEL);
+	if (!counts)
+		return -ENOMEM;
+
+	/* Initialize Counts */
+	for (i = 0; i < num_counts; i++) {
+		err = simple_counter_counter_count_init(counts + i,
+			simple_counts + i, signals + i);
+		if (err)
+			goto err_free_counts;
+	}
+
+	/* Register Counts to Counter device container */
+	counter_dev->counts = counts;
+	counter_dev->num_counts = num_counts;
+
+	return 0;
+
+err_free_counts:
+	while (i--)
+		simple_counter_counter_count_free(counts + i);
+	kfree(counts);
+	return err;
+}
+
+static void simple_counter_counter_signals_unregister(
+	const struct counter_device *const counter_dev)
+{
+	const struct counter_signal *const signals = counter_dev->signals;
+	size_t num_signals = counter_dev->num_signals;
+
+	while (num_signals--)
+		kfree(signals[num_signals].ext);
+	kfree(signals);
+}
+
+static int simple_counter_counts_register(
+	struct simple_counter_device *const counter)
+{
+	const struct simple_counter_count *const simple_counts =
+		counter->counts;
+	const size_t num_counts = counter->num_counts;
+	int err;
+
+	/* At least one Count must be defined */
+	if (!simple_counts || !num_counts) {
+		pr_err("simple-counter: Simple Counter Counts undefined\n");
+		return -EINVAL;
+	}
+
+	/* Register Counter Signals */
+	err = simple_counter_counter_signals_register(counter);
+	if (err)
+		return err;
+
+	/* Register Counter Counts */
+	err = simple_counter_counter_counts_register(counter);
+	if (err)
+		goto err_unregister_signals;
+
+	return 0;
+
+err_unregister_signals:
+	simple_counter_counter_signals_unregister(counter->counter_dev);
+	return err;
+}
+
+static ssize_t simple_counter_device_ext_read(struct counter_device *dev,
+	void *priv, char *buf)
+{
+	const struct simple_counter_device_ext *const ext = priv;
+	struct simple_counter_device *const counter = dev->priv;
+
+	return ext->read(counter, ext->priv, buf);
+}
+
+static ssize_t simple_counter_device_ext_write(struct counter_device *dev,
+	void *priv, const char *buf, size_t len)
+{
+	const struct simple_counter_device_ext *const ext = priv;
+	struct simple_counter_device *const counter = dev->priv;
+
+	return ext->write(counter, ext->priv, buf, len);
+}
+
+static int simple_counter_device_ext_register(
+	struct simple_counter_device *const counter)
+{
+	const struct simple_counter_device_ext *const simple_ext = counter->ext;
+	const size_t num_ext = counter->num_ext;
+	struct counter_device_ext *ext;
+	size_t i;
+	struct counter_device *const counter_dev = counter->counter_dev;
+
+	/* Return early if no extensions */
+	if (!simple_ext || !num_ext)
+		return 0;
+
+	/* Allocate space for Counter device extensions array */
+	ext = kmalloc_array(num_ext, sizeof(*ext), GFP_KERNEL);
+	if (!ext)
+		return -ENOMEM;
+
+	/* Register simple_counter_device_ext via counter_device_ext */
+	for (i = 0; i < num_ext; i++) {
+		ext[i].name = simple_ext[i].name;
+		ext[i].read = (simple_ext[i].read) ?
+			simple_counter_device_ext_read : NULL;
+		ext[i].write = (simple_ext[i].write) ?
+			simple_counter_device_ext_write : NULL;
+		ext[i].priv = simple_ext + i;
+	}
+
+	/* Register Counter device extensions */
+	counter_dev->ext = ext;
+	counter_dev->num_ext = num_ext;
+
+	return 0;
+}
+
+static void simple_counter_counter_counts_unregister(
+	const struct counter_device *const counter)
+{
+	const struct counter_count *const counts = counter->counts;
+	size_t num_counts = counter->num_counts;
+
+	while (num_counts--)
+		simple_counter_counter_count_free(counts + num_counts);
+	kfree(counts);
+}
+
+static void simple_counter_counts_unregister(
+	const struct simple_counter_device *const counter)
+{
+	const struct counter_device *const counter_dev = counter->counter_dev;
+
+	simple_counter_counter_counts_unregister(counter_dev);
+	simple_counter_counter_signals_unregister(counter_dev);
+}
+
+/**
+ * simple_counter_register - register Simple Counter to the system
+ * @counter: pointer to Simple Counter to register
+ *
+ * This function registers a Simple Counter to the system. A sysfs "counter"
+ * directory will be created and populated with sysfs attributes correlating
+ * with the Simple Counter Signals, Synapses, and Counts respectively.
+ */
+int simple_counter_register(struct simple_counter_device *const counter)
+{
+	struct counter_device *counter_dev;
+	int err;
+
+	if (!counter)
+		return -EINVAL;
+
+	/* Allocate internal Counter container */
+	counter_dev = kzalloc(sizeof(*counter_dev), GFP_KERNEL);
+	if (!counter)
+		return -ENOMEM;
+	counter->counter_dev = counter_dev;
+
+	/* Configure internal Counter */
+	counter_dev->name = counter->name;
+	counter_dev->parent = counter->parent;
+	counter_dev->signal_read = (counter->signal_read) ?
+		simple_counter_signal_read : NULL;
+	counter_dev->signal_write = (counter->signal_write) ?
+		simple_counter_signal_write : NULL;
+	counter_dev->count_read = (counter->count_read) ?
+		simple_counter_count_read : NULL;
+	counter_dev->count_write = (counter->count_write) ?
+		simple_counter_count_write : NULL;
+	counter_dev->function_get = (counter->function_get) ?
+		simple_counter_function_get : NULL;
+	counter_dev->function_set = (counter->function_set) ?
+		simple_counter_function_set : NULL;
+	counter_dev->action_get = (counter->action_get) ?
+		simple_counter_action_get : NULL;
+	counter_dev->action_set = (counter->action_set) ?
+		simple_counter_action_set : NULL;
+	counter_dev->priv = counter;
+
+	/* Register Simple Counter Counts */
+	err = simple_counter_counts_register(counter);
+	if (err)
+		goto err_free_counter_dev;
+
+	/* Register Simple Counter device extension attributes */
+	err = simple_counter_device_ext_register(counter);
+	if (err)
+		goto err_unregister_counts;
+
+	/* Register internal Counter to the system */
+	err = counter_register(counter_dev);
+	if (err)
+		goto err_free_ext;
+
+	return 0;
+
+err_free_ext:
+	kfree(counter_dev->ext);
+err_unregister_counts:
+	simple_counter_counts_unregister(counter);
+err_free_counter_dev:
+	kfree(counter_dev);
+	return err;
+}
+EXPORT_SYMBOL(simple_counter_register);
+
+/**
+ * simple_counter_unregister - unregister Simple Counter from the system
+ * @counter: pointer to Simple Counter to unregister
+ *
+ * The Simple Counter is unregistered from the system; all allocated memory is
+ * freed.
+ */
+void simple_counter_unregister(struct simple_counter_device *const counter)
+{
+	struct counter_device *counter_dev;
+
+	if (!counter)
+		return;
+
+	counter_dev = counter->counter_dev;
+
+	counter_unregister(counter_dev);
+
+	kfree(counter_dev->ext);
+	simple_counter_counts_unregister(counter);
+	kfree(counter_dev);
+}
+EXPORT_SYMBOL(simple_counter_unregister);
+
+static void devm_simple_counter_unreg(struct device *dev, void *res)
+{
+	simple_counter_unregister(*(struct simple_counter_device **)res);
+}
+
+/**
+ * devm_simple_counter_register - Resource-managed simple_counter_register
+ * @dev: device to allocate simple_counter_device for
+ * @counter: pointer to Simple Counter to register
+ *
+ * Managed simple_counter_register. The Simple Counter registered with this
+ * function is automatically unregistered on driver detach. This function calls
+ * simple_counter_register internally. Refer to that function for more
+ * information.
+ *
+ * If an Simple Counter registered with this function needs to be unregistered
+ * separately, devm_simple_counter_unregister must be used.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int devm_simple_counter_register(struct device *dev,
+	struct simple_counter_device *const counter)
+{
+	struct simple_counter_device **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_simple_counter_unreg, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = simple_counter_register(counter);
+	if (!ret) {
+		*ptr = counter;
+		devres_add(dev, ptr);
+	} else
+		devres_free(ptr);
+
+	return ret;
+}
+EXPORT_SYMBOL(devm_simple_counter_register);
+
+static int devm_simple_counter_match(struct device *dev, void *res, void *data)
+{
+	struct simple_counter_device **r = res;
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
+ * devm_simple_counter_unregister - Resource-managed simple_counter_unregister
+ * @dev: device this simple_counter_device belongs to
+ * @counter: the Simple Counter associated with the device
+ *
+ * Unregister Simple Counter registered with devm_simple_counter_register.
+ */
+void devm_simple_counter_unregister(struct device *dev,
+	struct simple_counter_device *const counter)
+{
+	int rc;
+
+	rc = devres_release(dev, devm_simple_counter_unreg,
+		devm_simple_counter_match, counter);
+	WARN_ON(rc);
+}
+EXPORT_SYMBOL(devm_simple_counter_unregister);
+
+MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
+MODULE_DESCRIPTION("Simple Counter interface");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/iio/counter.h b/include/linux/iio/counter.h
index 070ed8fd53fb..0967ea2a9bef 100644
--- a/include/linux/iio/counter.h
+++ b/include/linux/iio/counter.h
@@ -236,4 +236,203 @@ extern int devm_counter_register(struct device *dev,
 extern void devm_counter_unregister(struct device *dev,
 	struct counter_device *const counter);
 
+struct simple_counter_device;
+struct simple_counter_signal;
+
+/**
+ * struct simple_counter_signal_ext - Simple Counter Signal extension
+ * @name:	[DRIVER] attribute name
+ * @read:	[DRIVER] read callback for this attribute; may be NULL
+ * @write:	[DRIVER] write callback for this attribute; may be NULL
+ * @priv:	[DRIVER] data private to the driver
+ */
+struct simple_counter_signal_ext {
+	const char	*name;
+	ssize_t		(*read)(struct simple_counter_device *counter,
+				struct simple_counter_signal *signal,
+				void *priv, char *buf);
+	ssize_t		(*write)(struct simple_counter_device *counter,
+				struct simple_counter_signal *signal,
+				void *priv, const char *buf, size_t len);
+	void		*priv;
+};
+
+/**
+ * struct simple_counter_signal - Simple Counter Signal node
+ * @id:		[DRIVER] unique ID used to identify signal
+ * @name:	[DRIVER] device-specific signal name
+ * @ext:	[DRIVER] optional array of Simple Counter Signal extensions
+ * @num_ext:	[DRIVER] number of Simple Counter Signal extensions specified in
+ *		@ext
+ * @priv:	[DRIVER] optional private data supplied by driver
+ */
+struct simple_counter_signal {
+	int		id;
+	const char	*name;
+
+	const struct simple_counter_signal_ext	*ext;
+	size_t					num_ext;
+
+	void	*priv;
+};
+
+enum simple_counter_signal_level {
+	SIMPLE_COUNTER_SIGNAL_LOW = 0,
+	SIMPLE_COUNTER_SIGNAL_HIGH
+};
+
+struct simple_counter_count;
+
+enum simple_counter_function {
+	SIMPLE_COUNTER_FUNCTION_INCREASE = 0,
+	SIMPLE_COUNTER_FUNCTION_DECREASE
+};
+
+enum simple_counter_action {
+	SIMPLE_COUNTER_ACTION_NONE = 0,
+	SIMPLE_COUNTER_ACTION_RISING_EDGE,
+	SIMPLE_COUNTER_ACTION_FALLING_EDGE,
+	SIMPLE_COUNTER_ACTION_BOTH_EDGES
+};
+
+/**
+ * struct simple_counter_count_ext - Simple Counter Count extension
+ * @name:	[DRIVER] attribute name
+ * @read:	[DRIVER] read callback for this attribute; may be NULL
+ * @write:	[DRIVER] write callback for this attribute; may be NULL
+ * @priv:	[DRIVER] data private to the driver
+ */
+struct simple_counter_count_ext {
+	const char	*name;
+	ssize_t		(*read)(struct simple_counter_device *counter,
+				struct simple_counter_count *count, void *priv,
+				char *buf);
+	ssize_t		(*write)(struct simple_counter_device *counter,
+				struct simple_counter_count *count, void *priv,
+				const char *buf, size_t len);
+	void		*priv;
+};
+
+/**
+ * struct simple_counter_count - Simple Counter Count node
+ * @id:		[DRIVER] unique ID used to identify Count
+ * @name:	[DRIVER] device-specific Count name
+ * @function:	[DRIVER] current function mode
+ * @action:	[DRIVER] current action mode
+ * @signal:	[DRIVER] associated signal
+ * @ext:	[DRIVER] optional array of Simple Counter Count extensions
+ * @num_ext:	[DRIVER] number of Simple Counter Count extensions specified in
+ *		@ext
+ * @priv:	[DRIVER] optional private data supplied by driver
+ */
+struct simple_counter_count {
+	int				id;
+	const char			*name;
+	enum simple_counter_function	function;
+	enum simple_counter_action	action;
+
+	struct simple_counter_signal	signal;
+
+	const struct simple_counter_count_ext	*ext;
+	size_t					num_ext;
+
+	void	*priv;
+};
+
+/**
+ * struct simple_counter_device_ext - Simple Counter device extension
+ * @name:	[DRIVER] attribute name
+ * @read:	[DRIVER] read callback for this attribute; may be NULL
+ * @write:	[DRIVER] write callback for this attribute; may be NULL
+ * @priv:	[DRIVER] data private to the driver
+ */
+struct simple_counter_device_ext {
+	const char	*name;
+	ssize_t		(*read)(struct simple_counter_device *counter,
+				void *priv, char *buf);
+	ssize_t		(*write)(struct simple_counter_device *counter,
+				void *priv, const char *buf, size_t len);
+	void		*priv;
+};
+
+/**
+ * struct simple_counter_device - Simple Counter data structure
+ * @name:		[DRIVER] name of the device
+ * @parent:		[DRIVER] optional parent device providing the counters
+ * @counter_dev:	[INTERN] internal Counter container
+ * @signal_read:	[DRIVER] read callback for Signal attribute; may be
+ *			NULL. Returns 0 on success and negative error code on
+ *			error. The respective Signal's returned	level should be
+ *			passed back via the level parameter.
+ * @signal_write:	[DRIVER] write callback for Signal attribute; may be
+ *			NULL
+ * @count_read:		[DRIVER] read callback for Count attribute; may be NULL.
+ *			Returns 0 on success and negative error code on error.
+ *			The respective Count's returned value should be passed
+ *			back via the val parameter.
+ * @count_write:	[DRIVER] write callback for Count attribute; may be NULL
+ * @function_get:	[DRIVER] function to get the current count function
+ *			mode. Returns 0 on success and negative error code on
+ *			error. The respective Count's returned function mode
+ *			should be passed back via the function parameter.
+ * @function_set:	[DRIVER] function to set the count function mode
+ * @action_get:		[DRIVER] function to get the current action mode.
+ *			Returns 0 on success and negative error code on error.
+ *			The respective Signal's returned action mode should be
+ *			passed back via the action parameter.
+ * @action_set:		[DRIVER] function to set the action mode
+ * @counts:		[DRIVER] array of Simple Counter Counts
+ * @num_counts:		[DRIVER] number of Simple Counter Counts specified in
+ *			@counts
+ * @ext:		[DRIVER] optional array of Simple Counter device
+ *			extensions
+ * @num_ext:		[DRIVER] number of Simple Counter device extensions
+ *			specified in @ext
+ * @priv:		[DRIVER] optional private data supplied by driver
+ */
+struct simple_counter_device {
+	const char		*name;
+	struct device		*parent;
+	struct counter_device	*counter_dev;
+
+	int	(*signal_read)(struct simple_counter_device *counter,
+			struct simple_counter_signal *signal,
+			enum simple_counter_signal_level *level);
+	int	(*signal_write)(struct simple_counter_device *counter,
+			struct simple_counter_signal *signal,
+			enum simple_counter_signal_level level);
+	int	(*count_read)(struct simple_counter_device *counter,
+			struct simple_counter_count *count, long *val);
+	int	(*count_write)(struct simple_counter_device *counter,
+			struct simple_counter_count *count, long val);
+	int	(*function_get)(struct simple_counter_device *counter,
+			struct simple_counter_count *count,
+			enum simple_counter_function *function);
+	int	(*function_set)(struct simple_counter_device *counter,
+			struct simple_counter_count *count,
+			enum simple_counter_function function);
+	int	(*action_get)(struct simple_counter_device *counter,
+			struct simple_counter_count *count,
+			enum simple_counter_action *action);
+	int	(*action_set)(struct simple_counter_device *counter,
+			struct simple_counter_count *count,
+			enum simple_counter_action action);
+
+	struct simple_counter_count	*counts;
+	size_t				num_counts;
+
+	const struct simple_counter_device_ext	*ext;
+	size_t					num_ext;
+
+	void	*priv;
+};
+
+extern int simple_counter_register(struct simple_counter_device *const counter);
+extern void simple_counter_unregister(
+	struct simple_counter_device *const counter);
+extern int devm_simple_counter_register(struct device *dev,
+	struct simple_counter_device *const counter);
+extern void devm_simple_counter_unregister(struct device *dev,
+	struct simple_counter_device *const counter);
+
 #endif /* _COUNTER_H_ */
-- 
2.15.1
