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
Subject: [PATCH v4 08/11] counter: Introduce the Quadrature Counter interface
Date: Thu, 14 Dec 2017 15:52:20 -0500
Message-Id: <1e181df0fa457813b2d5b97a63827c10da65eec3.1513266127.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1513266127.git.vilhelm.gray@gmail.com>
References: <cover.1513266127.git.vilhelm.gray@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch introduces the Quadrature Counter interface. The Quadrature
Counter interface serves as an API to provide support for quadrature
encoder counter devices. The Quadrature Counter interface is built on
top of the Generic Counter interface.

A quadrature encoder counter device is a counter device that has a
quadrature pair of signals associated with each count value. Signals may
have a value of "low" or "high."

Signals may be represented by two possible states:

        QUAD_COUNTER_SIGNAL_LOW: "low"
        QUAD_COUNTER_SIGNAL_HIGH: "high"

With quadrature encoders, there types of encoding are typically used:
X1, X2, and X4; some quadrature encoders also offer a non-quadrature
mode (typically pulse-direction encoding).

The Quadrature Counter interface provides four count function modes:

        QUAD_COUNTER_FUNCTION_PULSE_DIRECTION: "pulse-direction"
        QUAD_COUNTER_FUNCTION_QUADRATURE_X1: "quadrature x1"
        QUAD_COUNTER_FUNCTION_QUADRATURE_X2: "quadrature x2"
        QUAD_COUNTER_FUNCTION_QUADRATURE_X4: "quadrature x4"

Since the Quadrature Counter interface utilizes the Generic Counter
interface underneath, all the expected functionality of the Generic
Counter interface such as sysfs attributes is exposed to userspace for
end user consumption. The Quadrature Counter interface serves as a
convenience API for supporting a common class of counter devices without
the need to manually configure the more cumbersome Generic Counter
interface for use.

In addition to the typical sysfs attributes of the Generic Counter
interface, the Quadrature Counter interface provides "direction"
attributes for each count value. These read-only attributes provide the
current direction of their respective quadrature encoding stream.

To use the Quadrature Counter interface, first create an array of
quad_counter_count structures to represent the desired counts and
signals of the counter device; the signal_a member of a
quad_counter_count structure should define the Channel A signal of the
respective quadrature pair, and similarly the signal_b member should
define Channel B. Next, allocate a quad_counter_device structure and
populate it with the desired driver callbacks and the quad_counter_count
array created earlier. Finally, register the counter by calling the
quad_counter_register function. The quad_counter_unregister function may
be used to unregistered a previously registered counter.

Memory-managed versions of quad_counter_register and
quad_counter_unregister functions are provided by the
devm_quad_counter_register and devm_quad_counter_unregister functions
respectively.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/iio/counter/Kconfig        |   4 +-
 drivers/iio/counter/Makefile       |   1 +
 drivers/iio/counter/quad-counter.c | 774 +++++++++++++++++++++++++++++++++++++
 include/linux/iio/counter.h        | 191 +++++++++
 4 files changed, 969 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/counter/quad-counter.c

diff --git a/drivers/iio/counter/Kconfig b/drivers/iio/counter/Kconfig
index 9d7dae137f9c..33fde25e5018 100644
--- a/drivers/iio/counter/Kconfig
+++ b/drivers/iio/counter/Kconfig
@@ -10,7 +10,9 @@ menuconfig COUNTER
 	  rudimentary support for counters and serves as building blocks to
 	  create more complex counter interfaces. The Simple Counter API
 	  provides support for simple hardware counter devices that have a
-	  one-to-one mapping between their Signals and Counts.
+	  one-to-one mapping between their Signals and Counts. The Quadrature
+	  Counter API provides support for quadrature counter devices that have
+	  Signals arranged as quadrature pairs associated to Counts.
 
 if COUNTER
 
diff --git a/drivers/iio/counter/Makefile b/drivers/iio/counter/Makefile
index febd2884b474..55f59e566d72 100644
--- a/drivers/iio/counter/Makefile
+++ b/drivers/iio/counter/Makefile
@@ -6,6 +6,7 @@
 
 obj-$(CONFIG_COUNTER) += counter.o
 counter-$(CONFIG_COUNTER) += generic-counter.o
+counter-$(CONFIG_COUNTER) += quad-counter.o
 counter-$(CONFIG_COUNTER) += simple-counter.o
 
 obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
diff --git a/drivers/iio/counter/quad-counter.c b/drivers/iio/counter/quad-counter.c
new file mode 100644
index 000000000000..74a738e4b515
--- /dev/null
+++ b/drivers/iio/counter/quad-counter.c
@@ -0,0 +1,774 @@
+/*
+ * Quadrature Counter interface
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
+static const char *const quad_counter_signal_level_names[] = {
+	[QUAD_COUNTER_SIGNAL_LOW] = "low",
+	[QUAD_COUNTER_SIGNAL_HIGH] = "high"
+};
+
+static ssize_t quad_counter_signal_read(struct counter_device *counter_dev,
+	struct counter_signal *counter_sig, char *buf)
+{
+	struct quad_counter_device *const counter = counter_dev->priv;
+	struct quad_counter_signal *const signal = counter_sig->priv;
+	int err;
+	enum quad_counter_signal_level level;
+
+	err = counter->signal_read(counter, signal, &level);
+	if (err)
+		return err;
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n",
+		quad_counter_signal_level_names[level]);
+}
+
+static ssize_t quad_counter_count_read(struct counter_device *counter_dev,
+	struct counter_count *counter_cnt, char *buf)
+{
+	struct quad_counter_device *const counter = counter_dev->priv;
+	struct quad_counter_count *const count = counter_cnt->priv;
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
+static ssize_t quad_counter_count_write(struct counter_device *counter_dev,
+	struct counter_count *counter_cnt, const char *buf, size_t len)
+{
+	struct quad_counter_device *const counter = counter_dev->priv;
+	struct quad_counter_count *const count = counter_cnt->priv;
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
+static int quad_counter_function_get(struct counter_device *counter_dev,
+	struct counter_count *counter_cnt, size_t *counter_func)
+{
+	int err;
+	struct quad_counter_device *const counter = counter_dev->priv;
+	struct quad_counter_count *const count = counter_cnt->priv;
+	enum quad_counter_function function;
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
+static int quad_counter_function_set(struct counter_device *counter_dev,
+	struct counter_count *counter_cnt, size_t function)
+{
+	struct quad_counter_device *const counter = counter_dev->priv;
+	struct quad_counter_count *const count = counter_cnt->priv;
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
+enum quad_counter_action {
+	QUAD_COUNTER_ACTION_NONE = 0,
+	QUAD_COUNTER_ACTION_RISING_EDGE,
+	QUAD_COUNTER_ACTION_FALLING_EDGE,
+	QUAD_COUNTER_ACTION_BOTH_EDGES
+};
+
+static int quad_counter_action_get(struct counter_device *counter_dev,
+	struct counter_count *counter_cnt, struct counter_synapse *counter_syn,
+	size_t *counter_act)
+{
+	int err;
+	struct quad_counter_device *const counter = counter_dev->priv;
+	struct quad_counter_count *const count = counter_cnt->priv;
+	enum quad_counter_function function;
+	enum quad_counter_direction dir;
+
+	err = counter->function_get(counter, count, &function);
+	if (err)
+		return err;
+
+	/* Default action mode */
+	*counter_act = QUAD_COUNTER_ACTION_NONE;
+
+	/* Determine action mode based on current count function mode */
+	switch (function) {
+	case QUAD_COUNTER_FUNCTION_PULSE_DIRECTION:
+		if (count->signal_a.id == counter_syn->signal->id)
+			*counter_act = QUAD_COUNTER_ACTION_RISING_EDGE;
+		break;
+	case QUAD_COUNTER_FUNCTION_QUADRATURE_X1:
+		if (count->signal_a.id == counter_syn->signal->id) {
+			err = counter->direction_get(counter, count, &dir);
+			if (err)
+				return err;
+
+			if (dir == QUAD_COUNTER_DIRECTION_FORWARD)
+				*counter_act = QUAD_COUNTER_ACTION_RISING_EDGE;
+			else
+				*counter_act = QUAD_COUNTER_ACTION_FALLING_EDGE;
+		}
+		break;
+	case QUAD_COUNTER_FUNCTION_QUADRATURE_X2:
+		if (count->signal_a.id == counter_syn->signal->id)
+			*counter_act = QUAD_COUNTER_ACTION_BOTH_EDGES;
+		break;
+	case QUAD_COUNTER_FUNCTION_QUADRATURE_X4:
+		*counter_act = QUAD_COUNTER_ACTION_BOTH_EDGES;
+		break;
+	}
+
+	return 0;
+}
+
+static ssize_t quad_counter_signal_ext_read(struct counter_device *dev,
+	struct counter_signal *signal, void *priv, char *buf)
+{
+	const struct quad_counter_signal_ext *const ext = priv;
+	struct quad_counter_device *const counter = dev->priv;
+	struct quad_counter_signal *const quad_signal = signal->priv;
+
+	return ext->read(counter, quad_signal, ext->priv, buf);
+}
+
+static ssize_t quad_counter_signal_ext_write(struct counter_device *dev,
+	struct counter_signal *signal, void *priv, const char *buf, size_t len)
+{
+	const struct quad_counter_signal_ext *const ext = priv;
+	struct quad_counter_device *const counter = dev->priv;
+	struct quad_counter_signal *const quad_signal = signal->priv;
+
+	return ext->write(counter, quad_signal, ext->priv, buf, len);
+}
+
+static int quad_counter_counter_signal_ext_register(
+	const struct quad_counter_signal *const quad_signal,
+	struct counter_signal *const signal)
+{
+	const struct quad_counter_signal_ext *const quad_ext = quad_signal->ext;
+	const size_t num_ext = quad_signal->num_ext;
+	struct counter_signal_ext *ext;
+	size_t i;
+
+	/* Exit early if no extensions */
+	if (!quad_ext || !num_ext)
+		return 0;
+
+	/* Allocate space for counter_signal_ext array */
+	ext = kmalloc_array(num_ext, sizeof(*ext), GFP_KERNEL);
+	if (!ext)
+		return -ENOMEM;
+
+	/* Register quad_counter_signal_ext via counter_signal_ext */
+	for (i = 0; i < num_ext; i++) {
+		ext[i].name = quad_ext[i].name;
+		ext[i].read = (quad_ext[i].read) ?
+			quad_counter_signal_ext_read : NULL;
+		ext[i].write = (quad_ext[i].write) ?
+			quad_counter_signal_ext_write : NULL;
+		ext[i].priv = quad_ext + i;
+	}
+
+	/* Register Counter Signal extensions */
+	signal->ext = ext;
+	signal->num_ext = num_ext;
+
+	return 0;
+}
+
+static int quad_counter_counter_signals_register(
+	const struct quad_counter_device *const counter)
+{
+	struct counter_signal *signals;
+	const size_t num_counts = counter->num_counts;
+	const size_t num_signals = 2 * num_counts;
+	size_t i;
+	struct counter_signal *signal;
+	struct quad_counter_signal *quad_signal;
+	struct quad_counter_count *const counts = counter->counts;
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
+		if (i % 2)
+			quad_signal = &counts[i / 2].signal_b;
+		else
+			quad_signal = &counts[i / 2].signal_a;
+
+		signal->id = quad_signal->id;
+		signal->name = quad_signal->name;
+		signal->priv = quad_signal;
+
+		/* Register Counter Signal extensions */
+		err = quad_counter_counter_signal_ext_register(quad_signal,
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
+static const char *const quad_counter_function_names[] = {
+	[QUAD_COUNTER_FUNCTION_PULSE_DIRECTION] = "pulse-direction",
+	[QUAD_COUNTER_FUNCTION_QUADRATURE_X1] = "quadrature x1",
+	[QUAD_COUNTER_FUNCTION_QUADRATURE_X2] = "quadrature x2",
+	[QUAD_COUNTER_FUNCTION_QUADRATURE_X4] = "quadrature x4"
+};
+
+static const char *const quad_counter_action_names[] = {
+	[QUAD_COUNTER_ACTION_NONE] = "none",
+	[QUAD_COUNTER_ACTION_RISING_EDGE] = "rising edge",
+	[QUAD_COUNTER_ACTION_FALLING_EDGE] = "falling edge",
+	[QUAD_COUNTER_ACTION_BOTH_EDGES] = "both edges"
+};
+
+static int quad_counter_counter_synapses_register(
+	struct counter_signal *const signals, struct counter_count *const count)
+{
+	struct counter_synapse *synapses;
+	const size_t num_synapses = 2;
+	size_t i;
+
+	/* Allocate space for Counter Synapses */
+	synapses = kcalloc(num_synapses, sizeof(*synapses), GFP_KERNEL);
+	if (!synapses)
+		return -ENOMEM;
+
+	/* Configure Synapses */
+	for (i = 0; i < num_synapses; i++) {
+		synapses[i].signal = signals + i;
+		synapses[i].actions = quad_counter_action_names;
+		synapses[i].num_actions = ARRAY_SIZE(quad_counter_action_names);
+	}
+
+	/* Register Counter Synapses */
+	count->synapses = synapses;
+	count->num_synapses = num_synapses;
+
+	return 0;
+}
+
+static const char *const quad_counter_direction_names[] = {
+	[QUAD_COUNTER_DIRECTION_FORWARD] = "forward",
+	[QUAD_COUNTER_DIRECTION_BACKWARD] = "backward"
+};
+
+static ssize_t quad_counter_direction_read(struct counter_device *dev,
+	struct counter_count *count, void *priv, char *buf)
+{
+	struct quad_counter_device *const counter = dev->priv;
+	struct quad_counter_count *const quad_count = count->priv;
+	int err;
+	enum quad_counter_direction direction;
+
+	err = counter->direction_get(counter, quad_count, &direction);
+	if (err)
+		return err;
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n",
+		quad_counter_direction_names[direction]);
+}
+
+static ssize_t quad_counter_count_ext_read(struct counter_device *dev,
+	struct counter_count *count, void *priv, char *buf)
+{
+	const struct quad_counter_count_ext *const ext = priv;
+	struct quad_counter_device *const counter = dev->priv;
+	struct quad_counter_count *const quad_count = count->priv;
+
+	return ext->read(counter, quad_count, ext->priv, buf);
+}
+
+static ssize_t quad_counter_count_ext_write(struct counter_device *dev,
+	struct counter_count *count, void *priv, const char *buf, size_t len)
+{
+	const struct quad_counter_count_ext *const ext = priv;
+	struct quad_counter_device *const counter = dev->priv;
+	struct quad_counter_count *const quad_count = count->priv;
+
+	return ext->write(counter, quad_count, ext->priv, buf, len);
+}
+
+static int quad_counter_counter_count_ext_register(
+	const struct quad_counter_device *const counter,
+	const struct quad_counter_count *const quad_count,
+	struct counter_count *const count)
+{
+	size_t num_ext = 0;
+	const struct quad_counter_count_ext *const quad_ext = quad_count->ext;
+	const size_t quad_num_ext = quad_count->num_ext;
+	struct counter_count_ext *ext;
+	size_t ext_i = 0;
+	size_t i;
+
+	/* Count number of extensions */
+	if (counter->direction_get)
+		num_ext++;
+	if (quad_ext)
+		num_ext += quad_num_ext;
+
+	/* Return early if no extensions */
+	if (!num_ext)
+		return 0;
+
+	/* Allocate space for Counter Count extensions array */
+	ext = kcalloc(num_ext, sizeof(*ext), GFP_KERNEL);
+	if (!ext)
+		return -ENOMEM;
+
+	/* Register direction extension */
+	if (counter->direction_get) {
+		ext[ext_i].name = "direction";
+		ext[ext_i].read = quad_counter_direction_read;
+
+		ext_i++;
+	}
+
+	/* Register driver Quadrature Counter Count extensions */
+	for (i = 0; i < quad_num_ext; i++) {
+		ext[ext_i + i].name = quad_ext[i].name;
+		ext[ext_i + i].read = (quad_ext[i].read) ?
+			quad_counter_count_ext_read : NULL;
+		ext[ext_i + i].write = (quad_ext[i].write) ?
+			quad_counter_count_ext_write : NULL;
+		ext[ext_i + i].priv = quad_ext + i;
+	}
+	ext_i += quad_num_ext;
+
+	/* Register Counter Count extensions */
+	count->ext = ext;
+	count->num_ext = num_ext;
+
+	return 0;
+}
+
+static void quad_counter_counter_synapses_unregister(
+	const struct counter_count *const count)
+{
+	kfree(count->synapses);
+}
+
+static int quad_counter_counter_count_init(struct counter_count *const count,
+	struct quad_counter_count *const quad_count,
+	struct counter_signal *const signals,
+	const struct quad_counter_device *const counter)
+{
+	int err;
+
+	count->id = quad_count->id;
+	count->name = quad_count->name;
+	count->functions = quad_counter_function_names;
+	count->num_functions = ARRAY_SIZE(quad_counter_function_names);
+	count->priv = quad_count;
+
+	/* Register Counter Synapses */
+	err = quad_counter_counter_synapses_register(signals, count);
+	if (err)
+		return -ENOMEM;
+
+	/* Register Quadrature Counter Count extensions */
+	err = quad_counter_counter_count_ext_register(counter, quad_count,
+		count);
+	if (err)
+		goto err_unregister_synapses;
+
+	return 0;
+
+err_unregister_synapses:
+	quad_counter_counter_synapses_unregister(count);
+	return err;
+}
+
+static void quad_counter_counter_count_ext_unregister(
+	const struct counter_count *const count)
+{
+	kfree(count->ext);
+}
+
+static void quad_counter_counter_count_free(
+	const struct counter_count *const count)
+{
+	quad_counter_counter_count_ext_unregister(count);
+	quad_counter_counter_synapses_unregister(count);
+}
+
+static int quad_counter_counter_counts_register(
+	const struct quad_counter_device *const counter)
+{
+	struct counter_device *const counter_dev = counter->counter_dev;
+	struct counter_count *counts;
+	const size_t num_counts = counter->num_counts;
+	size_t i;
+	struct quad_counter_count *const quad_counts = counter->counts;
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
+		err = quad_counter_counter_count_init(counts + i,
+			quad_counts + i, signals + 2 * i, counter);
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
+		quad_counter_counter_count_free(counts + i);
+	kfree(counts);
+	return err;
+}
+
+static void quad_counter_counter_signals_unregister(
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
+static int quad_counter_counts_register(
+	struct quad_counter_device *const counter)
+{
+	const struct quad_counter_count *const quad_counts = counter->counts;
+	const size_t num_counts = counter->num_counts;
+	int err;
+
+	/* At least one Count must be defined */
+	if (!quad_counts || !num_counts) {
+		pr_err("quad-counter: Quadrature Counter Counts undefined\n");
+		return -EINVAL;
+	}
+
+	/* Allocate Counter Signals */
+	err = quad_counter_counter_signals_register(counter);
+	if (err)
+		return err;
+
+	/* Allocate Counter Counts */
+	err = quad_counter_counter_counts_register(counter);
+	if (err)
+		goto err_unregister_signals;
+
+	return 0;
+
+err_unregister_signals:
+	quad_counter_counter_signals_unregister(counter->counter_dev);
+	return err;
+}
+
+static ssize_t quad_counter_device_ext_read(struct counter_device *dev,
+	void *priv, char *buf)
+{
+	const struct quad_counter_device_ext *const ext = priv;
+	struct quad_counter_device *const counter = dev->priv;
+
+	return ext->read(counter, ext->priv, buf);
+}
+
+static ssize_t quad_counter_device_ext_write(struct counter_device *dev,
+	void *priv, const char *buf, size_t len)
+{
+	const struct quad_counter_device_ext *const ext = priv;
+	struct quad_counter_device *const counter = dev->priv;
+
+	return ext->write(counter, ext->priv, buf, len);
+}
+
+static int quad_counter_device_ext_register(
+	struct quad_counter_device *const counter)
+{
+	const struct quad_counter_device_ext *const quad_ext = counter->ext;
+	const size_t num_ext = counter->num_ext;
+	struct counter_device_ext *ext;
+	size_t i;
+	struct counter_device *const counter_dev = counter->counter_dev;
+
+	/* Return early if no extensions */
+	if (!quad_ext || !num_ext)
+		return 0;
+
+	/* Allocate space for counter_device_ext array */
+	ext = kmalloc_array(num_ext, sizeof(*ext), GFP_KERNEL);
+	if (!ext)
+		return -ENOMEM;
+
+	/* Register quad_counter_device_ext via counter_device_ext */
+	for (i = 0; i < num_ext; i++) {
+		ext[i].name = quad_ext[i].name;
+		ext[i].read = (quad_ext[i].read) ?
+			quad_counter_device_ext_read : NULL;
+		ext[i].write = (quad_ext[i].write) ?
+			quad_counter_device_ext_write : NULL;
+		ext[i].priv = quad_ext + i;
+	}
+
+	/* Register Counter device extensions */
+	counter_dev->ext = ext;
+	counter_dev->num_ext = num_ext;
+
+	return 0;
+}
+
+static void quad_counter_counter_counts_unregister(
+	const struct counter_device *const counter_dev)
+{
+	const struct counter_count *const counts = counter_dev->counts;
+	size_t num_counts = counter_dev->num_counts;
+
+	while (num_counts--)
+		quad_counter_counter_count_free(counts + num_counts);
+	kfree(counts);
+}
+
+static void quad_counter_counts_unregister(
+	const struct quad_counter_device *const counter)
+{
+	const struct counter_device *const counter_dev = counter->counter_dev;
+
+	quad_counter_counter_counts_unregister(counter_dev);
+	quad_counter_counter_signals_unregister(counter_dev);
+}
+
+/**
+ * quad_counter_register - register Quadrature Counter to the system
+ * @counter: pointer to Quadrature Counter to register
+ *
+ * This function registers a Quadrature Counter to the system. A sysfs "counter"
+ * directory will be created and populated with sysfs attributes correlating
+ * with the Quadrature Counter Signals, Synapses, and Counts respectively.
+ */
+int quad_counter_register(struct quad_counter_device *const counter)
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
+		quad_counter_signal_read : NULL;
+	counter_dev->count_read = (counter->count_read) ?
+		quad_counter_count_read : NULL;
+	counter_dev->count_write = (counter->count_write) ?
+		quad_counter_count_write : NULL;
+	counter_dev->function_get = (counter->function_get) ?
+		quad_counter_function_get : NULL;
+	counter_dev->function_set = (counter->function_set) ?
+		quad_counter_function_set : NULL;
+	counter_dev->action_get = (counter->function_get &&
+		counter->direction_get) ? quad_counter_action_get : NULL;
+	counter_dev->priv = counter;
+
+	/* Register Quadrature Counter Counts */
+	err = quad_counter_counts_register(counter);
+	if (err)
+		goto err_free_counter_dev;
+
+	/* Register Quadrature Counter device extension attributes */
+	err = quad_counter_device_ext_register(counter);
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
+	quad_counter_counts_unregister(counter);
+err_free_counter_dev:
+	kfree(counter_dev);
+	return err;
+}
+EXPORT_SYMBOL(quad_counter_register);
+
+/**
+ * quad_counter_unregister - unregister Quadrature Counter from the system
+ * @counter: pointer to Quadrature Counter to unregister
+ *
+ * The Quadrature Counter is unregistered from the system; all allocated memory
+ * is freed.
+ */
+void quad_counter_unregister(struct quad_counter_device *const counter)
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
+	quad_counter_counts_unregister(counter);
+	kfree(counter_dev);
+}
+EXPORT_SYMBOL(quad_counter_unregister);
+
+static void devm_quad_counter_unreg(struct device *dev, void *res)
+{
+	quad_counter_unregister(*(struct quad_counter_device **)res);
+}
+
+/**
+ * devm_quad_counter_register - Resource-managed quad_counter_register
+ * @dev: device to allocate quad_counter_device for
+ * @counter: pointer to Quadrature Counter to register
+ *
+ * Managed quad_counter_register. The Quadrature Counter registered with this
+ * function is automatically unregistered on driver detach. This function calls
+ * quad_counter_register internally. Refer to that function for more
+ * information.
+ *
+ * If an Quadrature Counter registered with this function needs to be
+ * unregistered separately, devm_quad_counter_unregister must be used.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int devm_quad_counter_register(struct device *dev,
+	struct quad_counter_device *const counter)
+{
+	struct quad_counter_device **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_quad_counter_unreg, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = quad_counter_register(counter);
+	if (!ret) {
+		*ptr = counter;
+		devres_add(dev, ptr);
+	} else
+		devres_free(ptr);
+
+	return ret;
+}
+EXPORT_SYMBOL(devm_quad_counter_register);
+
+static int devm_quad_counter_match(struct device *dev, void *res, void *data)
+{
+	struct quad_counter_device **r = res;
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
+ * devm_quad_counter_unregister - Resource-managed quad_counter_unregister
+ * @dev: device this quad_counter_device belongs to
+ * @counter: the Quadrature Counter associated with the device
+ *
+ * Unregister Quadrature Counter registered with devm_quad_counter_register.
+ */
+void devm_quad_counter_unregister(struct device *dev,
+	struct quad_counter_device *const counter)
+{
+	int rc;
+
+	rc = devres_release(dev, devm_quad_counter_unreg,
+		devm_quad_counter_match, counter);
+	WARN_ON(rc);
+}
+EXPORT_SYMBOL(devm_quad_counter_unregister);
+
+MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
+MODULE_DESCRIPTION("Quadrature Counter interface");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/iio/counter.h b/include/linux/iio/counter.h
index 0967ea2a9bef..a6f0f9130377 100644
--- a/include/linux/iio/counter.h
+++ b/include/linux/iio/counter.h
@@ -435,4 +435,195 @@ extern int devm_simple_counter_register(struct device *dev,
 extern void devm_simple_counter_unregister(struct device *dev,
 	struct simple_counter_device *const counter);
 
+struct quad_counter_device;
+struct quad_counter_signal;
+
+/**
+ * struct quad_counter_signal_ext - Quadrature Counter Signal extension
+ * @name:	[DRIVER] attribute name
+ * @read:	[DRIVER] read callback for this attribute; may be NULL
+ * @write:	[DRIVER] write callback for this attribute; may be NULL
+ * @priv:	[DRIVER] data private to the driver
+ */
+struct quad_counter_signal_ext {
+	const char	*name;
+	ssize_t		(*read)(struct quad_counter_device *counter,
+				struct quad_counter_signal *signal, void *priv,
+				char *buf);
+	ssize_t		(*write)(struct quad_counter_device *counter,
+				struct quad_counter_signal *signal, void *priv,
+				const char *buf, size_t len);
+	void		*priv;
+};
+
+/**
+ * struct quad_counter_signal - Quadrature Counter Signal node
+ * @id:		[DRIVER] unique ID used to identify signal
+ * @name:	[DRIVER] device-specific signal name
+ * @ext:	[DRIVER] optional array of Quadrature Counter Signal extensions
+ * @num_ext:	[DRIVER] number of Quadrature Counter Signal extensions
+ *		specified in @ext
+ * @priv:	[DRIVER] optional private data supplied by driver
+ */
+struct quad_counter_signal {
+	int		id;
+	const char	*name;
+
+	const struct quad_counter_signal_ext	*ext;
+	size_t					num_ext;
+
+	void	*priv;
+};
+
+enum quad_counter_signal_level {
+	QUAD_COUNTER_SIGNAL_LOW = 0,
+	QUAD_COUNTER_SIGNAL_HIGH
+};
+
+struct quad_counter_count;
+
+enum quad_counter_function {
+	QUAD_COUNTER_FUNCTION_PULSE_DIRECTION = 0,
+	QUAD_COUNTER_FUNCTION_QUADRATURE_X1,
+	QUAD_COUNTER_FUNCTION_QUADRATURE_X2,
+	QUAD_COUNTER_FUNCTION_QUADRATURE_X4
+};
+
+enum quad_counter_direction {
+	QUAD_COUNTER_DIRECTION_FORWARD = 0,
+	QUAD_COUNTER_DIRECTION_BACKWARD
+};
+
+/**
+ * struct quad_counter_count_ext - Quadrature Counter Count extension
+ * @name:	[DRIVER] attribute name
+ * @read:	[DRIVER] read callback for this attribute; may be NULL
+ * @write:	[DRIVER] write callback for this attribute; may be NULL
+ * @priv:	[DRIVER] data private to the driver
+ */
+struct quad_counter_count_ext {
+	const char	*name;
+	ssize_t		(*read)(struct quad_counter_device *counter,
+				struct quad_counter_count *count, void *priv,
+				char *buf);
+	ssize_t		(*write)(struct quad_counter_device *counter,
+				struct quad_counter_count *count, void *priv,
+				const char *buf, size_t len);
+	void		*priv;
+};
+
+/**
+ * struct quad_counter_count - Quadrature Counter Count node
+ * @id:		[DRIVER] unique ID used to identify Count
+ * @name:	[DRIVER] device-specific Count name
+ * @function:	[DRIVER] current function mode
+ * @direction:	[DRIVER] current direction state
+ * @signal_a:	[DRIVER] associated quadrature A signal
+ * @signal_b:	[DRIVER] associated quadrature B signal
+ * @ext:	[DRIVER] optional array of Quadrature Counter Count extensions
+ * @num_ext:	[DRIVER] number of Quadrature Counter Count extensions specified
+ *		in @ext
+ * @priv:	[DRIVER] optional private data supplied by driver
+ */
+struct quad_counter_count {
+	int				id;
+	const char			*name;
+	enum quad_counter_function	function;
+	enum quad_counter_direction	direction;
+
+	struct quad_counter_signal	signal_a;
+	struct quad_counter_signal	signal_b;
+
+	const struct quad_counter_count_ext	*ext;
+	size_t					num_ext;
+
+	void	*priv;
+};
+
+/**
+ * struct quad_counter_device_ext - Quadrature Counter device extension
+ * @name:	[DRIVER] attribute name
+ * @read:	[DRIVER] read callback for this attribute; may be NULL
+ * @write:	[DRIVER] write callback for this attribute; may be NULL
+ * @priv:	[DRIVER] data private to the driver
+ */
+struct quad_counter_device_ext {
+	const char	*name;
+	ssize_t		(*read)(struct quad_counter_device *counter, void *priv,
+				char *buf);
+	ssize_t		(*write)(struct quad_counter_device *counter,
+				void *priv, const char *buf, size_t len);
+	void		*priv;
+};
+
+/**
+ * struct quad_counter_device - Quadrature Counter data structure
+ * @name:		[DRIVER] name of the device
+ * @parent:		[DRIVER] optional parent device providing the counters
+ * @counter_dev:	[INTERN] internal Counter container
+ * @signal_read:	[DRIVER] read callback for Signal attribute; may be
+ *			NULL. Returns 0 on success and negative error code on
+ *			error. The respective Signal's returned	level should be
+ *			passed back via the level parameter.
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
+ * @direction_get:	[DRIVER] function to get the current direction. Returns
+ *			0 on success and negative error code on	error. The
+ *			respective Count's returned direction should be passed
+ *			back via the direction parameter.
+ * @counts:		[DRIVER] array of Quadrature Counter Counts
+ * @num_counts:		[DRIVER] number of Quadrature Counter Counts specified
+ *			in @counts
+ * @ext:		[DRIVER] optional array of Quadrature Counter device
+ *			extensions
+ * @num_ext:		[DRIVER] number of Quadrature Counter device extensions
+ *			specified in @ext
+ * @priv:		[DRIVER] optional private data supplied by driver
+ */
+struct quad_counter_device {
+	const char		*name;
+	struct device		*parent;
+	struct counter_device	*counter_dev;
+
+	int	(*signal_read)(struct quad_counter_device *counter,
+			struct quad_counter_signal *signal,
+			enum quad_counter_signal_level *level);
+	int	(*count_read)(struct quad_counter_device *counter,
+			struct quad_counter_count *count, long *val);
+	int	(*count_write)(struct quad_counter_device *counter,
+			struct quad_counter_count *count, long val);
+	int	(*function_get)(struct quad_counter_device *counter,
+			struct quad_counter_count *count,
+			enum quad_counter_function *function);
+	int	(*function_set)(struct quad_counter_device *counter,
+			struct quad_counter_count *count,
+			enum quad_counter_function function);
+	int	(*direction_get)(struct quad_counter_device *counter,
+			struct quad_counter_count *count,
+			enum quad_counter_direction *direction);
+
+	struct quad_counter_count	*counts;
+	size_t				num_counts;
+
+	const struct quad_counter_device_ext	*ext;
+	size_t					num_ext;
+
+	void	*priv;
+};
+
+extern int quad_counter_register(struct quad_counter_device *const counter);
+extern void quad_counter_unregister(struct quad_counter_device *const counter);
+extern int devm_quad_counter_register(struct device *dev,
+	struct quad_counter_device *const counter);
+extern void devm_quad_counter_unregister(struct device *dev,
+	struct quad_counter_device *const counter);
+
 #endif /* _COUNTER_H_ */
-- 
2.15.1
