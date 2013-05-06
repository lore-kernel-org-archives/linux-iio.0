Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43191 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754280Ab3EFRVN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 6 May 2013 13:21:13 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/4] staging:iio:triggers: rename iio-trig-gpio to iio-trig-interrupt
Date: Mon,  6 May 2013 18:21:01 +0100
Message-Id: <1367860863-6863-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1367860863-6863-1-git-send-email-jic23@kernel.org>
References: <1367860863-6863-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Also change all internal naming appropriately.
This trigger is no longer just for gpio provided interrupts so
change the naming to reflect this.  Also drop some now missleading
left over comments.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/trigger/Kconfig              |   8 +-
 drivers/staging/iio/trigger/Makefile             |   2 +-
 drivers/staging/iio/trigger/iio-trig-gpio.c      | 166 -----------------------
 drivers/staging/iio/trigger/iio-trig-interrupt.c | 152 +++++++++++++++++++++
 4 files changed, 157 insertions(+), 171 deletions(-)

diff --git a/drivers/staging/iio/trigger/Kconfig b/drivers/staging/iio/trigger/Kconfig
index d0ae99c..4ecb213 100644
--- a/drivers/staging/iio/trigger/Kconfig
+++ b/drivers/staging/iio/trigger/Kconfig
@@ -12,11 +12,11 @@ config IIO_PERIODIC_RTC_TRIGGER
 	  Provides support for using periodic capable real time
 	  clocks as IIO triggers.
 
-config IIO_GPIO_TRIGGER
-	tristate "GPIO trigger"
-	depends on GENERIC_GPIO
+config IIO_INTERRUPT_TRIGGER
+	tristate "Generic interrupt trigger"
 	help
-	  Provides support for using GPIO pins as IIO triggers.
+	  Provides support for using interrupts of various types as IIO
+	  triggers.  These may be provided by a gpio driver for example.
 
 config IIO_BFIN_TMR_TRIGGER
 	tristate "Blackfin TIMER trigger"
diff --git a/drivers/staging/iio/trigger/Makefile b/drivers/staging/iio/trigger/Makefile
index 8a53041..48f2236 100644
--- a/drivers/staging/iio/trigger/Makefile
+++ b/drivers/staging/iio/trigger/Makefile
@@ -3,5 +3,5 @@
 #
 
 obj-$(CONFIG_IIO_PERIODIC_RTC_TRIGGER) += iio-trig-periodic-rtc.o
-obj-$(CONFIG_IIO_GPIO_TRIGGER) += iio-trig-gpio.o
+obj-$(CONFIG_IIO_INTERRUPT_TRIGGER) += iio-trig-interrupt.o
 obj-$(CONFIG_IIO_BFIN_TMR_TRIGGER) += iio-trig-bfin-timer.o
diff --git a/drivers/staging/iio/trigger/iio-trig-gpio.c b/drivers/staging/iio/trigger/iio-trig-gpio.c
deleted file mode 100644
index 69dabca..0000000
--- a/drivers/staging/iio/trigger/iio-trig-gpio.c
+++ /dev/null
@@ -1,166 +0,0 @@
-/*
- * Industrial I/O - gpio based trigger support
- *
- * Copyright (c) 2008 Jonathan Cameron
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * Currently this is more of a functioning proof of concept than a full
- * fledged trigger driver.
- *
- * TODO:
- *
- * Add board config elements to allow specification of startup settings.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/slab.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/trigger.h>
-
-static LIST_HEAD(iio_gpio_trigger_list);
-static DEFINE_MUTEX(iio_gpio_trigger_list_lock);
-
-struct iio_gpio_trigger_info {
-	struct mutex in_use;
-	unsigned int irq;
-};
-/*
- * Need to reference count these triggers and only enable gpio interrupts
- * as appropriate.
- */
-
-/* So what functionality do we want in here?... */
-/* set high / low as interrupt type? */
-
-static irqreturn_t iio_gpio_trigger_poll(int irq, void *private)
-{
-	/* Timestamp not currently provided */
-	iio_trigger_poll(private, 0);
-	return IRQ_HANDLED;
-}
-
-static const struct iio_trigger_ops iio_gpio_trigger_ops = {
-	.owner = THIS_MODULE,
-};
-
-static int iio_gpio_trigger_probe(struct platform_device *pdev)
-{
-	struct iio_gpio_trigger_info *trig_info;
-	struct iio_trigger *trig, *trig2;
-	unsigned long irqflags;
-	struct resource *irq_res;
-	int irq, ret = 0, irq_res_cnt = 0;
-
-	do {
-		irq_res = platform_get_resource(pdev,
-				IORESOURCE_IRQ, irq_res_cnt);
-
-		if (irq_res == NULL) {
-			if (irq_res_cnt == 0)
-				dev_err(&pdev->dev, "No GPIO IRQs specified");
-			break;
-		}
-		irqflags = (irq_res->flags & IRQF_TRIGGER_MASK) | IRQF_SHARED;
-
-		for (irq = irq_res->start; irq <= irq_res->end; irq++) {
-
-			trig = iio_trigger_alloc("irqtrig%d", irq);
-			if (!trig) {
-				ret = -ENOMEM;
-				goto error_free_completed_registrations;
-			}
-
-			trig_info = kzalloc(sizeof(*trig_info), GFP_KERNEL);
-			if (!trig_info) {
-				ret = -ENOMEM;
-				goto error_put_trigger;
-			}
-			iio_trigger_set_drvdata(trig, trig_info);
-			trig_info->irq = irq;
-			trig->ops = &iio_gpio_trigger_ops;
-			ret = request_irq(irq, iio_gpio_trigger_poll,
-					  irqflags, trig->name, trig);
-			if (ret) {
-				dev_err(&pdev->dev,
-					"request IRQ-%d failed", irq);
-				goto error_free_trig_info;
-			}
-
-			ret = iio_trigger_register(trig);
-			if (ret)
-				goto error_release_irq;
-
-			list_add_tail(&trig->alloc_list,
-					&iio_gpio_trigger_list);
-		}
-
-		irq_res_cnt++;
-	} while (irq_res != NULL);
-
-
-	return 0;
-
-/* First clean up the partly allocated trigger */
-error_release_irq:
-	free_irq(irq, trig);
-error_free_trig_info:
-	kfree(trig_info);
-error_put_trigger:
-	iio_trigger_put(trig);
-error_free_completed_registrations:
-	/* The rest should have been added to the iio_gpio_trigger_list */
-	list_for_each_entry_safe(trig,
-				 trig2,
-				 &iio_gpio_trigger_list,
-				 alloc_list) {
-		trig_info = iio_trigger_get_drvdata(trig);
-		free_irq(trig_info->irq, trig);
-		kfree(trig_info);
-		iio_trigger_unregister(trig);
-	}
-
-	return ret;
-}
-
-static int iio_gpio_trigger_remove(struct platform_device *pdev)
-{
-	struct iio_trigger *trig, *trig2;
-	struct iio_gpio_trigger_info *trig_info;
-
-	mutex_lock(&iio_gpio_trigger_list_lock);
-	list_for_each_entry_safe(trig,
-				 trig2,
-				 &iio_gpio_trigger_list,
-				 alloc_list) {
-		trig_info = iio_trigger_get_drvdata(trig);
-		iio_trigger_unregister(trig);
-		free_irq(trig_info->irq, trig);
-		kfree(trig_info);
-		iio_trigger_put(trig);
-	}
-	mutex_unlock(&iio_gpio_trigger_list_lock);
-
-	return 0;
-}
-
-static struct platform_driver iio_gpio_trigger_driver = {
-	.probe = iio_gpio_trigger_probe,
-	.remove = iio_gpio_trigger_remove,
-	.driver = {
-		.name = "iio_gpio_trigger",
-		.owner = THIS_MODULE,
-	},
-};
-
-module_platform_driver(iio_gpio_trigger_driver);
-
-MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
-MODULE_DESCRIPTION("Example gpio trigger for the iio subsystem");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/trigger/iio-trig-interrupt.c b/drivers/staging/iio/trigger/iio-trig-interrupt.c
new file mode 100644
index 0000000..9afba96
--- /dev/null
+++ b/drivers/staging/iio/trigger/iio-trig-interrupt.c
@@ -0,0 +1,152 @@
+/*
+ * Industrial I/O - generic interrupt based trigger support
+ *
+ * Copyright (c) 2008-2013 Jonathan Cameron
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+
+static LIST_HEAD(iio_interrupt_trigger_list);
+static DEFINE_MUTEX(iio_interrupt_trigger_list_lock);
+
+struct iio_interrupt_trigger_info {
+	struct mutex in_use;
+	unsigned int irq;
+};
+
+static irqreturn_t iio_interrupt_trigger_poll(int irq, void *private)
+{
+	/* Timestamp not currently provided */
+	iio_trigger_poll(private, 0);
+	return IRQ_HANDLED;
+}
+
+static const struct iio_trigger_ops iio_interrupt_trigger_ops = {
+	.owner = THIS_MODULE,
+};
+
+static int iio_interrupt_trigger_probe(struct platform_device *pdev)
+{
+	struct iio_interrupt_trigger_info *trig_info;
+	struct iio_trigger *trig, *trig2;
+	unsigned long irqflags;
+	struct resource *irq_res;
+	int irq, ret = 0, irq_res_cnt = 0;
+
+	do {
+		irq_res = platform_get_resource(pdev,
+				IORESOURCE_IRQ, irq_res_cnt);
+
+		if (irq_res == NULL) {
+			if (irq_res_cnt == 0)
+				dev_err(&pdev->dev, "No IRQs specified");
+			break;
+		}
+		irqflags = (irq_res->flags & IRQF_TRIGGER_MASK) | IRQF_SHARED;
+
+		for (irq = irq_res->start; irq <= irq_res->end; irq++) {
+
+			trig = iio_trigger_alloc("irqtrig%d", irq);
+			if (!trig) {
+				ret = -ENOMEM;
+				goto error_free_completed_registrations;
+			}
+
+			trig_info = kzalloc(sizeof(*trig_info), GFP_KERNEL);
+			if (!trig_info) {
+				ret = -ENOMEM;
+				goto error_put_trigger;
+			}
+			iio_trigger_set_drvdata(trig, trig_info);
+			trig_info->irq = irq;
+			trig->ops = &iio_interrupt_trigger_ops;
+			ret = request_irq(irq, iio_interrupt_trigger_poll,
+					  irqflags, trig->name, trig);
+			if (ret) {
+				dev_err(&pdev->dev,
+					"request IRQ-%d failed", irq);
+				goto error_free_trig_info;
+			}
+
+			ret = iio_trigger_register(trig);
+			if (ret)
+				goto error_release_irq;
+
+			list_add_tail(&trig->alloc_list,
+					&iio_interrupt_trigger_list);
+		}
+
+		irq_res_cnt++;
+	} while (irq_res != NULL);
+
+
+	return 0;
+
+/* First clean up the partly allocated trigger */
+error_release_irq:
+	free_irq(irq, trig);
+error_free_trig_info:
+	kfree(trig_info);
+error_put_trigger:
+	iio_trigger_put(trig);
+error_free_completed_registrations:
+	/* The rest should have been added to the iio_interrupt_trigger_list */
+	list_for_each_entry_safe(trig,
+				 trig2,
+				 &iio_interrupt_trigger_list,
+				 alloc_list) {
+		trig_info = iio_trigger_get_drvdata(trig);
+		free_irq(trig_info->irq, trig);
+		kfree(trig_info);
+		iio_trigger_unregister(trig);
+	}
+
+	return ret;
+}
+
+static int iio_interrupt_trigger_remove(struct platform_device *pdev)
+{
+	struct iio_trigger *trig, *trig2;
+	struct iio_interrupt_trigger_info *trig_info;
+
+	mutex_lock(&iio_interrupt_trigger_list_lock);
+	list_for_each_entry_safe(trig,
+				 trig2,
+				 &iio_interrupt_trigger_list,
+				 alloc_list) {
+		trig_info = iio_trigger_get_drvdata(trig);
+		iio_trigger_unregister(trig);
+		free_irq(trig_info->irq, trig);
+		kfree(trig_info);
+		iio_trigger_put(trig);
+	}
+	mutex_unlock(&iio_interrupt_trigger_list_lock);
+
+	return 0;
+}
+
+static struct platform_driver iio_interrupt_trigger_driver = {
+	.probe = iio_interrupt_trigger_probe,
+	.remove = iio_interrupt_trigger_remove,
+	.driver = {
+		.name = "iio_interrupt_trigger",
+		.owner = THIS_MODULE,
+	},
+};
+
+module_platform_driver(iio_interrupt_trigger_driver);
+
+MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
+MODULE_DESCRIPTION("Interrupt trigger for the iio subsystem");
+MODULE_LICENSE("GPL v2");
-- 
1.8.2.1

