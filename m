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
Subject: [PATCH v4 07/11] counter: Add dummy counter driver
Date: Thu, 14 Dec 2017 15:52:08 -0500
Message-Id: <efbcb4991cbde077f341c84ca8f892e526ef21e3.1513266127.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1513266127.git.vilhelm.gray@gmail.com>
References: <cover.1513266127.git.vilhelm.gray@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch introduces the dummy counter driver. The dummy counter driver
serves as a reference implementation of a driver that utilizes the
Simple Counter interface.

Writing "low" and "high" to the Signal attributes allows a user to
simulate a typical Simple Counter Signal input stream for evaluation;
the Counter will evaluate the Signal data based on the respective action
mode for the associated Signal, and trigger the associated count
function specified by the respective Count's function mode. The current
Count value may be read, and the Count value preset by a write.

The Count max and min attributes serve to configure respective value
ceiling and value floor for each desired Count.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/iio/counter/Kconfig         |  15 ++
 drivers/iio/counter/Makefile        |   1 +
 drivers/iio/counter/dummy-counter.c | 308 ++++++++++++++++++++++++++++++++++++
 3 files changed, 324 insertions(+)
 create mode 100644 drivers/iio/counter/dummy-counter.c

diff --git a/drivers/iio/counter/Kconfig b/drivers/iio/counter/Kconfig
index 6b9a43180d2c..9d7dae137f9c 100644
--- a/drivers/iio/counter/Kconfig
+++ b/drivers/iio/counter/Kconfig
@@ -30,6 +30,21 @@ config 104_QUAD_8
 	  The base port addresses for the devices may be configured via the base
 	  array module parameter.
 
+config DUMMY_COUNTER
+	tristate "Dummy counter driver"
+	help
+	  Select this option to enable the dummy counter driver. The dummy
+	  counter driver serves as a reference implementation of a driver that
+	  utilizes the Generic Counter interface.
+
+	  Writing "low" and "high" to the Signal attributes allows a user to
+	  simulate a typical Simple Counter Signal input stream for evaluation;
+	  the Counter will evaluate the Signal data based on the respective
+	  trigger mode for the associated Signal, and trigger the associated
+	  counter function specified by the respective function mode. The
+	  current Value value may be read, and the Value value preset by a
+	  write.
+
 config STM32_LPTIMER_CNT
 	tristate "STM32 LP Timer encoder counter driver"
 	depends on (MFD_STM32_LPTIMER || COMPILE_TEST) && IIO
diff --git a/drivers/iio/counter/Makefile b/drivers/iio/counter/Makefile
index 7450dee97446..febd2884b474 100644
--- a/drivers/iio/counter/Makefile
+++ b/drivers/iio/counter/Makefile
@@ -9,4 +9,5 @@ counter-$(CONFIG_COUNTER) += generic-counter.o
 counter-$(CONFIG_COUNTER) += simple-counter.o
 
 obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
+obj-$(CONFIG_DUMMY_COUNTER)	+= dummy-counter.o
 obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
diff --git a/drivers/iio/counter/dummy-counter.c b/drivers/iio/counter/dummy-counter.c
new file mode 100644
index 000000000000..31d7e3a7d8fa
--- /dev/null
+++ b/drivers/iio/counter/dummy-counter.c
@@ -0,0 +1,308 @@
+/*
+ * Dummy counter driver
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
+#include <linux/errno.h>
+#include <linux/iio/counter.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
+#define DUMCNT_NUM_COUNTERS 2
+/**
+ * struct dumcnt - private data structure
+ * @counter:	instance of the Simple Counter
+ * @counts:	array of accumulation counts
+ * @max:	array of value ceilings for each count
+ * @min:	array of value floors for each count
+ * @states:	array of input line states
+ */
+struct dumcnt {
+	struct simple_counter_device counter;
+	long counts[DUMCNT_NUM_COUNTERS];
+	long max[DUMCNT_NUM_COUNTERS];
+	long min[DUMCNT_NUM_COUNTERS];
+	enum simple_counter_signal_level states[DUMCNT_NUM_COUNTERS];
+};
+
+static int dumcnt_signal_read(struct simple_counter_device *counter,
+	struct simple_counter_signal *signal,
+	enum simple_counter_signal_level *level)
+{
+	struct dumcnt *const priv = counter->priv;
+
+	*level = priv->states[signal->id];
+
+	return 0;
+}
+
+static int dumcnt_signal_write(struct simple_counter_device *counter,
+	struct simple_counter_signal *signal,
+	enum simple_counter_signal_level level)
+{
+	struct dumcnt *const priv = counter->priv;
+	const int id = signal->id;
+	const enum simple_counter_signal_level prev_state = priv->states[id];
+	struct simple_counter_count *const count = counter->counts + id;
+	unsigned int triggered = 0;
+
+	/* If no state change then just exit */
+	if (prev_state == level)
+		return 0;
+
+	priv->states[id] = level;
+
+	/* Check if Count function was triggered */
+	switch (count->action) {
+	case SIMPLE_COUNTER_ACTION_NONE:
+		return 0;
+	case SIMPLE_COUNTER_ACTION_RISING_EDGE:
+		if (!prev_state)
+			triggered = 1;
+		break;
+	case SIMPLE_COUNTER_ACTION_FALLING_EDGE:
+		if (prev_state)
+			triggered = 1;
+		break;
+	case SIMPLE_COUNTER_ACTION_BOTH_EDGES:
+		triggered = 1;
+		break;
+	}
+
+	/* Exit early if Count function was not triggered */
+	if (!triggered)
+		return 0;
+
+	/* Execute Count function */
+	switch (count->function) {
+	case SIMPLE_COUNTER_FUNCTION_INCREASE:
+		if (priv->counts[id] < priv->max[id])
+			priv->counts[id]++;
+		break;
+	case SIMPLE_COUNTER_FUNCTION_DECREASE:
+		if (priv->counts[id] > priv->min[id])
+			priv->counts[id]--;
+		break;
+	}
+
+	return 0;
+}
+
+static int dumcnt_count_read(struct simple_counter_device *counter,
+	struct simple_counter_count *count, long *val)
+{
+	struct dumcnt *const priv = counter->priv;
+
+	*val = priv->counts[count->id];
+
+	return 0;
+}
+
+static int dumcnt_count_write(struct simple_counter_device *counter,
+	struct simple_counter_count *count, long val)
+{
+	struct dumcnt *const priv = counter->priv;
+	const int id = count->id;
+
+	/* Verify that value is within configured boundaries */
+	if (val > priv->max[id] || val < priv->min[id])
+		return -EINVAL;
+
+	priv->counts[id] = val;
+
+	return 0;
+}
+
+static int dumcnt_function_get(struct simple_counter_device *counter,
+	struct simple_counter_count *count,
+	enum simple_counter_function *function)
+{
+	*function = count->function;
+
+	return 0;
+}
+
+static int dumcnt_function_set(struct simple_counter_device *counter,
+	struct simple_counter_count *count,
+	enum simple_counter_function function)
+{
+	return 0;
+}
+
+static int dumcnt_action_get(struct simple_counter_device *counter,
+	struct simple_counter_count *count,
+	enum simple_counter_action *action)
+{
+	*action = count->action;
+
+	return 0;
+}
+
+static int dumcnt_action_set(struct simple_counter_device *counter,
+	struct simple_counter_count *count,
+	enum simple_counter_action action)
+{
+	return 0;
+}
+
+ssize_t dumcnt_count_max_read(struct simple_counter_device *counter,
+	struct simple_counter_count *count, void *priv,	char *buf)
+{
+	struct dumcnt *const drv_data = counter->priv;
+
+	return scnprintf(buf, PAGE_SIZE, "%ld\n", drv_data->max[count->id]);
+}
+
+ssize_t dumcnt_count_max_write(struct simple_counter_device *counter,
+	struct simple_counter_count *count, void *priv,	const char *buf,
+	size_t len)
+{
+	int err;
+	struct dumcnt *const drv_data = counter->priv;
+
+	err = kstrtol(buf, 0, drv_data->max + count->id);
+	if (err)
+		return err;
+
+	return len;
+}
+
+ssize_t dumcnt_count_min_read(struct simple_counter_device *counter,
+	struct simple_counter_count *count, void *priv,	char *buf)
+{
+	struct dumcnt *const drv_data = counter->priv;
+
+	return scnprintf(buf, PAGE_SIZE, "%ld\n", drv_data->min[count->id]);
+}
+
+ssize_t dumcnt_count_min_write(struct simple_counter_device *counter,
+	struct simple_counter_count *count, void *priv,	const char *buf,
+	size_t len)
+{
+	int err;
+	struct dumcnt *const drv_data = counter->priv;
+
+	err = kstrtol(buf, 0, drv_data->min + count->id);
+	if (err)
+		return err;
+
+	return len;
+}
+
+static const struct simple_counter_count_ext dumcnt_count_ext[] = {
+	{
+		.name = "max",
+		.read = dumcnt_count_max_read,
+		.write = dumcnt_count_max_write
+	},
+	{
+		.name = "min",
+		.read = dumcnt_count_min_read,
+		.write = dumcnt_count_min_write
+	}
+};
+
+#define DUMCNT_COUNT(_id, _cntname, _signame) {	\
+	.id = _id,				\
+	.name = _cntname,			\
+	.signal = {				\
+		.id = _id,			\
+		.name = _signame		\
+	},					\
+	.ext = dumcnt_count_ext,		\
+	.num_ext = ARRAY_SIZE(dumcnt_count_ext)	\
+}
+
+static const struct simple_counter_count dumcnt_counts[] = {
+	DUMCNT_COUNT(0, "Count A", "Signal A"),
+	DUMCNT_COUNT(1, "Count B", "Signal B")
+};
+
+static int dumcnt_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct simple_counter_count *counts;
+	struct dumcnt *dumcnt;
+
+	counts = devm_kmemdup(dev, dumcnt_counts, sizeof(dumcnt_counts),
+		GFP_KERNEL);
+	if (!counts)
+		return -ENOMEM;
+
+	dumcnt = devm_kzalloc(dev, sizeof(*dumcnt), GFP_KERNEL);
+	if (!dumcnt)
+		return -ENOMEM;
+
+	dumcnt->counter.name = dev_name(dev);
+	dumcnt->counter.parent = dev;
+	dumcnt->counter.signal_read = dumcnt_signal_read;
+	dumcnt->counter.signal_write = dumcnt_signal_write;
+	dumcnt->counter.count_read = dumcnt_count_read;
+	dumcnt->counter.count_write = dumcnt_count_write;
+	dumcnt->counter.function_get = dumcnt_function_get;
+	dumcnt->counter.function_set = dumcnt_function_set;
+	dumcnt->counter.action_get = dumcnt_action_get;
+	dumcnt->counter.action_set = dumcnt_action_set;
+	dumcnt->counter.counts = counts;
+	dumcnt->counter.num_counts = ARRAY_SIZE(dumcnt_counts);
+	dumcnt->counter.priv = dumcnt;
+
+	return devm_simple_counter_register(dev, &dumcnt->counter);
+}
+
+static struct platform_device *dumcnt_device;
+
+static struct platform_driver dumcnt_driver = {
+	.driver = {
+		.name = "dummy-counter"
+	}
+};
+
+static void __exit dumcnt_exit(void)
+{
+	platform_device_unregister(dumcnt_device);
+	platform_driver_unregister(&dumcnt_driver);
+}
+
+static int __init dumcnt_init(void)
+{
+	int err;
+
+	dumcnt_device = platform_device_alloc(dumcnt_driver.driver.name, -1);
+	if (!dumcnt_device)
+		return -ENOMEM;
+
+	err = platform_device_add(dumcnt_device);
+	if (err)
+		goto err_platform_device;
+
+	err = platform_driver_probe(&dumcnt_driver, dumcnt_probe);
+	if (err)
+		goto err_platform_driver;
+
+	return 0;
+
+err_platform_driver:
+	platform_device_del(dumcnt_device);
+err_platform_device:
+	platform_device_put(dumcnt_device);
+	return err;
+}
+
+module_init(dumcnt_init);
+module_exit(dumcnt_exit);
+
+MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
+MODULE_DESCRIPTION("Dummy counter driver");
+MODULE_LICENSE("GPL v2");
-- 
2.15.1
