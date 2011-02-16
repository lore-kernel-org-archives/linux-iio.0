Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] IIO: trigger: New Blackfin specific trigger driver iio-trig-bfin-timer
Date: Wed, 16 Feb 2011 14:42:49 +0100
Message-ID: <1297863769-24022-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

This driver allows any Blackfin system timer to be used as IIO trigger.
It supports trigger rates from 0 to 100kHz in Hz resolution.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/trigger/Kconfig               |   10 +
 drivers/staging/iio/trigger/Makefile              |    1 +
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c |  244 +++++++++++++++++++++
 3 files changed, 255 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/trigger/iio-trig-bfin-timer.c

diff --git a/drivers/staging/iio/trigger/Kconfig b/drivers/staging/iio/trigger/Kconfig
index 3a82013..c33777e 100644
--- a/drivers/staging/iio/trigger/Kconfig
+++ b/drivers/staging/iio/trigger/Kconfig
@@ -28,4 +28,14 @@ config IIO_SYSFS_TRIGGER
 	  To compile this driver as a module, choose M here: the
 	  module will be called iio-trig-sysfs.
 
+config IIO_BFIN_TMR_TRIGGER
+	tristate "Blackfin TIMER trigger"
+	depends on BLACKFIN
+	help
+	  Provides support for using a Blackfin timer as IIO triggers.
+	  If unsure, say N (but it's safe to say "Y").
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called iio-trig-bfin-timer.
+
 endif # IIO_TRIGGER
diff --git a/drivers/staging/iio/trigger/Makefile b/drivers/staging/iio/trigger/Makefile
index 504b9c0..b088b57 100644
--- a/drivers/staging/iio/trigger/Makefile
+++ b/drivers/staging/iio/trigger/Makefile
@@ -5,3 +5,4 @@
 obj-$(CONFIG_IIO_PERIODIC_RTC_TRIGGER) += iio-trig-periodic-rtc.o
 obj-$(CONFIG_IIO_GPIO_TRIGGER) += iio-trig-gpio.o
 obj-$(CONFIG_IIO_SYSFS_TRIGGER) += iio-trig-sysfs.o
+obj-$(CONFIG_IIO_BFIN_TMR_TRIGGER) += iio-trig-bfin-timer.o
diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
new file mode 100644
index 0000000..afcfc7a
--- /dev/null
+++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
@@ -0,0 +1,244 @@
+/*
+ * Copyright 2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/delay.h>
+
+#include <asm/gptimers.h>
+
+#include "../iio.h"
+#include "../trigger.h"
+
+struct bfin_timer {
+	unsigned short id, bit;
+	unsigned long irqbit;
+	int irq;
+};
+
+static struct bfin_timer iio_bfin_timer_code[MAX_BLACKFIN_GPTIMERS] = {
+	{TIMER0_id,  TIMER0bit,  TIMER_STATUS_TIMIL0,  IRQ_TIMER0},
+	{TIMER1_id,  TIMER1bit,  TIMER_STATUS_TIMIL1,  IRQ_TIMER1},
+	{TIMER2_id,  TIMER2bit,  TIMER_STATUS_TIMIL2,  IRQ_TIMER2},
+#if (MAX_BLACKFIN_GPTIMERS > 3)
+	{TIMER3_id,  TIMER3bit,  TIMER_STATUS_TIMIL3,  IRQ_TIMER3},
+	{TIMER4_id,  TIMER4bit,  TIMER_STATUS_TIMIL4,  IRQ_TIMER4},
+	{TIMER5_id,  TIMER5bit,  TIMER_STATUS_TIMIL5,  IRQ_TIMER5},
+	{TIMER6_id,  TIMER6bit,  TIMER_STATUS_TIMIL6,  IRQ_TIMER6},
+	{TIMER7_id,  TIMER7bit,  TIMER_STATUS_TIMIL7,  IRQ_TIMER7},
+#endif
+#if (MAX_BLACKFIN_GPTIMERS > 8)
+	{TIMER8_id,  TIMER8bit,  TIMER_STATUS_TIMIL8,  IRQ_TIMER8},
+	{TIMER9_id,  TIMER9bit,  TIMER_STATUS_TIMIL9,  IRQ_TIMER9},
+	{TIMER10_id, TIMER10bit, TIMER_STATUS_TIMIL10, IRQ_TIMER10},
+#if (MAX_BLACKFIN_GPTIMERS > 11)
+	{TIMER11_id, TIMER11bit, TIMER_STATUS_TIMIL11, IRQ_TIMER11},
+#endif
+#endif
+};
+
+struct bfin_tmr_state {
+	struct iio_trigger *trig;
+	struct bfin_timer *t;
+	unsigned timer_num;
+	int irq;
+};
+
+static ssize_t iio_bfin_tmr_frequency_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct iio_trigger *trig = dev_get_drvdata(dev);
+	struct bfin_tmr_state *st = trig->private_data;
+	long val;
+	int ret;
+
+	ret = strict_strtoul(buf, 10, &val);
+	if (ret)
+		goto error_ret;
+
+	disable_gptimers(st->t->bit);
+
+	if (val <= 0 || val > 100000) {
+		ret = -EINVAL;
+		goto error_ret;
+	}
+
+	val = get_sclk() / val;
+	if (val <= 4) {
+		ret = -EINVAL;
+		goto error_ret;
+	}
+
+	set_gptimer_period(st->t->id, val);
+	set_gptimer_pwidth(st->t->id, 1);
+	enable_gptimers(st->t->bit);
+
+error_ret:
+	return ret ? ret : count;
+}
+
+static ssize_t iio_bfin_tmr_frequency_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct iio_trigger *trig = dev_get_drvdata(dev);
+	struct bfin_tmr_state *st = trig->private_data;
+
+	return sprintf(buf, "%lu\n",
+			get_sclk() / get_gptimer_period(st->t->id));
+}
+
+static DEVICE_ATTR(frequency, S_IRUGO | S_IWUSR, iio_bfin_tmr_frequency_show,
+		   iio_bfin_tmr_frequency_store);
+static IIO_TRIGGER_NAME_ATTR;
+
+static struct attribute *iio_bfin_tmr_trigger_attrs[] = {
+	&dev_attr_frequency.attr,
+	&dev_attr_name.attr,
+	NULL,
+};
+
+static const struct attribute_group iio_bfin_tmr_trigger_attr_group = {
+	.attrs = iio_bfin_tmr_trigger_attrs,
+};
+
+
+static irqreturn_t iio_bfin_tmr_trigger_isr(int irq, void *devid)
+{
+	struct bfin_tmr_state *st = devid;
+
+	clear_gptimer_intr(st->t->id);
+	iio_trigger_poll(st->trig, 0);
+
+	return IRQ_HANDLED;
+}
+
+static int iio_bfin_tmr_get_number(int irq)
+{
+	int i;
+
+	for (i = 0; i < MAX_BLACKFIN_GPTIMERS; i++)
+		if (iio_bfin_timer_code[i].irq == irq)
+			return i;
+
+	return -ENODEV;
+}
+
+static int __devinit iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
+{
+	struct bfin_tmr_state *st;
+	int ret;
+
+	st = kzalloc(sizeof(*st), GFP_KERNEL);
+	if (st == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	st->irq = platform_get_irq(pdev, 0);
+	if (!st->irq) {
+		dev_err(&pdev->dev, "No IRQs specified");
+		ret = -ENODEV;
+		goto out1;
+	}
+
+	ret = iio_bfin_tmr_get_number(st->irq);
+	if (ret < 0)
+		goto out1;
+
+	st->timer_num = ret;
+	st->t = &iio_bfin_timer_code[st->timer_num];
+
+	st->trig = iio_allocate_trigger();
+	if (!st->trig) {
+		ret = -ENOMEM;
+		goto out1;
+	}
+
+	st->trig->private_data = st;
+	st->trig->control_attrs = &iio_bfin_tmr_trigger_attr_group;
+	st->trig->owner = THIS_MODULE;
+	st->trig->name = kasprintf(GFP_KERNEL, "bfintmr%d", st->timer_num);
+	if (st->trig->name == NULL) {
+		ret = -ENOMEM;
+		goto out2;
+	}
+
+	ret = iio_trigger_register(st->trig);
+	if (ret)
+		goto out3;
+
+	ret = request_irq(st->irq, iio_bfin_tmr_trigger_isr,
+			  0, st->trig->name, st);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"request IRQ-%d failed", st->irq);
+		goto out4;
+	}
+
+	set_gptimer_config(st->t->id, OUT_DIS | PWM_OUT | PERIOD_CNT | IRQ_ENA);
+
+	dev_info(&pdev->dev, "iio trigger Blackfin TMR%d, IRQ-%d",
+		 st->timer_num, st->irq);
+	platform_set_drvdata(pdev, st);
+
+	return 0;
+out4:
+	iio_trigger_unregister(st->trig);
+out3:
+	kfree(st->trig->name);
+out2:
+	iio_put_trigger(st->trig);
+out1:
+	kfree(st);
+out:
+	return ret;
+}
+
+static int __devexit iio_bfin_tmr_trigger_remove(struct platform_device *pdev)
+{
+	struct bfin_tmr_state *st = platform_get_drvdata(pdev);
+
+	disable_gptimers(st->t->bit);
+	free_irq(st->irq, st);
+	iio_trigger_unregister(st->trig);
+	kfree(st->trig->name);
+	iio_put_trigger(st->trig);
+	kfree(st);
+
+	return 0;
+}
+
+static struct platform_driver iio_bfin_tmr_trigger_driver = {
+	.driver = {
+		.name = "iio_bfin_tmr_trigger",
+		.owner = THIS_MODULE,
+	},
+	.probe = iio_bfin_tmr_trigger_probe,
+	.remove = __devexit_p(iio_bfin_tmr_trigger_remove),
+};
+
+static int __init iio_bfin_tmr_trig_init(void)
+{
+	return platform_driver_register(&iio_bfin_tmr_trigger_driver);
+}
+module_init(iio_bfin_tmr_trig_init);
+
+static void __exit iio_bfin_tmr_trig_exit(void)
+{
+	platform_driver_unregister(&iio_bfin_tmr_trigger_driver);
+}
+module_exit(iio_bfin_tmr_trig_exit);
+
+MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_DESCRIPTION("Blackfin system timer based trigger for the iio subsystem");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:iio-trig-bfin-timer");
-- 
1.6.0.2
