Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Marten Svanfeldt <marten@intuitiveaerial.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] IIO: trigger: Add hrtimer trigger
Date: Tue, 13 Mar 2012 14:18:57 +0100
Message-ID: <1331644737-27822-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Marten Svanfeldt <marten@intuitiveaerial.com>

This patch adds a IIO trigger driver which uses a highres timer to provide a
frequency based trigger.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
This patch is based on the version send by Marten Svanfeldt about a year ago.

Changes since the pervious version:
	* Set new timeout in the trigger handler
	* Register one trigger device per platform device
	* Codestyle cleanups

Marten can I get your Signed-off-by for this new version?
---
 drivers/staging/iio/trigger/Kconfig            |    8 +
 drivers/staging/iio/trigger/Makefile           |    1 +
 drivers/staging/iio/trigger/iio-trig-hrtimer.c |  177 ++++++++++++++++++++++++
 3 files changed, 186 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/trigger/iio-trig-hrtimer.c

diff --git a/drivers/staging/iio/trigger/Kconfig b/drivers/staging/iio/trigger/Kconfig
index b8abf54..7393584 100644
--- a/drivers/staging/iio/trigger/Kconfig
+++ b/drivers/staging/iio/trigger/Kconfig
@@ -39,4 +39,12 @@ config IIO_BFIN_TMR_TRIGGER
 	  To compile this driver as a module, choose M here: the
 	  module will be called iio-trig-bfin-timer.
 
+config IIO_TRIGGER_HRTIMER
+	tristate "Highres timer trigger"
+	help
+	  Provides a frequency based IIO trigger using hrtimers.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called iio-trig-hrtimer.
+
 endif # IIO_TRIGGER
diff --git a/drivers/staging/iio/trigger/Makefile b/drivers/staging/iio/trigger/Makefile
index b088b57..f6f99c2 100644
--- a/drivers/staging/iio/trigger/Makefile
+++ b/drivers/staging/iio/trigger/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_IIO_PERIODIC_RTC_TRIGGER) += iio-trig-periodic-rtc.o
 obj-$(CONFIG_IIO_GPIO_TRIGGER) += iio-trig-gpio.o
 obj-$(CONFIG_IIO_SYSFS_TRIGGER) += iio-trig-sysfs.o
 obj-$(CONFIG_IIO_BFIN_TMR_TRIGGER) += iio-trig-bfin-timer.o
+obj-$(CONFIG_IIO_TRIGGER_HRTIMER) += iio-trig-hrtimer.o
diff --git a/drivers/staging/iio/trigger/iio-trig-hrtimer.c b/drivers/staging/iio/trigger/iio-trig-hrtimer.c
new file mode 100644
index 0000000..d01853e
--- /dev/null
+++ b/drivers/staging/iio/trigger/iio-trig-hrtimer.c
@@ -0,0 +1,177 @@
+/**
+ * The industrial I/O periodic hrtimer trigger driver
+ *
+ * Copyright (C) Intuitive Aerial AB
+ * Written by Marten Svanfeldt, marten@intuitiveaerial.com
+ * Copyright (C) 2012, Analog Device Inc.
+ *	Author: Lars-Peter Clausen <lars@metafoo.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/hrtimer.h>
+#include "../iio.h"
+#include "../trigger.h"
+
+struct iio_hrtimer_trig_info {
+	struct iio_trigger *trigger;
+	unsigned int frequency;
+	struct hrtimer timer;
+	ktime_t period;
+};
+
+static enum hrtimer_restart iio_trig_hrtimer_trig(struct hrtimer *timer)
+{
+	struct iio_hrtimer_trig_info *trig_info;
+	trig_info = container_of(timer, struct iio_hrtimer_trig_info, timer);
+
+	hrtimer_forward_now(timer, trig_info->period);
+	iio_trigger_poll(trig_info->trigger, 0);
+
+	return HRTIMER_RESTART;
+}
+
+static int iio_trig_hrtimer_set_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_hrtimer_trig_info *trig_info = trig->private_data;
+
+	if (trig_info->frequency == 0)
+		return -EINVAL;
+
+	if (state) {
+		hrtimer_start(&trig_info->timer, trig_info->period,
+			HRTIMER_MODE_REL);
+	} else {
+		hrtimer_cancel(&trig_info->timer);
+	}
+
+	return 0;
+}
+
+static ssize_t iio_trig_hrtimer_read_freq(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct iio_trigger *trig = dev_get_drvdata(dev);
+	struct iio_hrtimer_trig_info *trig_info = trig->private_data;
+
+	return sprintf(buf, "%u\n", trig_info->frequency);
+}
+
+static ssize_t iio_trig_hrtimer_write_freq(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t len)
+{
+	struct iio_trigger *trig = dev_get_drvdata(dev);
+	struct iio_hrtimer_trig_info *trig_info = trig->private_data;
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val > NSEC_PER_SEC)
+		return -EINVAL;
+
+	trig_info->frequency = val;
+	if (trig_info->frequency != 0)
+		trig_info->period = ktime_set(0, NSEC_PER_SEC / trig_info->frequency);
+
+	return len;
+}
+
+static DEVICE_ATTR(frequency, S_IRUGO | S_IWUSR,
+		iio_trig_hrtimer_read_freq,
+		iio_trig_hrtimer_write_freq);
+
+static struct attribute *iio_trig_hrtimer_attrs[] = {
+	&dev_attr_frequency.attr,
+	NULL,
+};
+
+static const struct attribute_group iio_trig_hrtimer_attr_group = {
+	.attrs = iio_trig_hrtimer_attrs,
+};
+
+static const struct attribute_group *iio_trig_hrtimer_attr_groups[] = {
+	&iio_trig_hrtimer_attr_group,
+	NULL
+};
+
+static const struct iio_trigger_ops iio_hrtimer_trigger_ops = {
+	.owner = THIS_MODULE,
+	.set_trigger_state = iio_trig_hrtimer_set_state,
+};
+
+static int __devinit iio_trig_hrtimer_probe(struct platform_device *pdev)
+{
+	struct iio_hrtimer_trig_info *trig_info;
+	struct iio_trigger *trig;
+	char *name;
+	int ret;
+
+	trig_info = devm_kzalloc(&pdev->dev, sizeof(*trig_info), GFP_KERNEL);
+	if (!trig_info)
+		return -ENOMEM;
+
+	name = pdev->dev.platform_data;
+
+	if (name != NULL)
+		trig = iio_allocate_trigger("hrtimer%s", name);
+	else
+		trig = iio_allocate_trigger("hrtimer%d", pdev->id);
+
+	if (!trig)
+		return -ENOMEM;
+
+	trig_info->trigger = trig;
+	trig->private_data = trig_info;
+	trig->ops = &iio_hrtimer_trigger_ops;
+	trig->dev.groups = iio_trig_hrtimer_attr_groups;
+	trig->dev.parent = &pdev->dev;
+
+	hrtimer_init(&trig_info->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	trig_info->timer.function = iio_trig_hrtimer_trig;
+
+	ret = iio_trigger_register(trig);
+	if (ret)
+		goto err_put_trigger;
+
+	return 0;
+
+err_put_trigger:
+	iio_put_trigger(trig);
+
+	return ret;
+}
+
+static int __devexit iio_trig_hrtimer_remove(struct platform_device *pdev)
+{
+	struct iio_hrtimer_trig_info *trig_info = platform_get_drvdata(pdev);
+	struct iio_trigger *trig = trig_info->trigger;
+
+	hrtimer_cancel(&trig_info->timer);
+	iio_trigger_unregister(trig);
+
+	return 0;
+}
+
+static struct platform_driver iio_trig_hrtimer_driver = {
+	.driver = {
+		.name = "iio-trigger-hrtimer",
+		.owner = THIS_MODULE
+	},
+	.probe = iio_trig_hrtimer_probe,
+	.remove = __devexit_p(iio_trig_hrtimer_remove),
+};
+module_platform_driver(iio_trig_hrtimer_driver);
+
+MODULE_AUTHOR("Marten Svanfeldt <marten@intuitiveaerial.com>");
+MODULE_DESCRIPTION("Periodic hrtimer trigger for the IIO subsystem");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:iio-trigger-hrtimer");
-- 
1.7.9.1
