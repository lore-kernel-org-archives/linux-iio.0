Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43197 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753788Ab3EFRVO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 6 May 2013 13:21:14 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 4/4] iio:triggers:interrupt trigger - move out of staging.
Date: Mon,  6 May 2013 18:21:03 +0100
Message-Id: <1367860863-6863-5-git-send-email-jic23@kernel.org>
In-Reply-To: <1367860863-6863-1-git-send-email-jic23@kernel.org>
References: <1367860863-6863-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is now a very simple trigger indeed but useful in many common cases.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/trigger/Kconfig                      |   9 ++
 drivers/iio/trigger/Makefile                     |   1 +
 drivers/iio/trigger/iio-trig-interrupt.c         | 123 +++++++++++++++++++++++
 drivers/staging/iio/trigger/Kconfig              |   6 --
 drivers/staging/iio/trigger/Makefile             |   1 -
 drivers/staging/iio/trigger/iio-trig-interrupt.c | 123 -----------------------
 6 files changed, 133 insertions(+), 130 deletions(-)

diff --git a/drivers/iio/trigger/Kconfig b/drivers/iio/trigger/Kconfig
index a4e68db..360fd50 100644
--- a/drivers/iio/trigger/Kconfig
+++ b/drivers/iio/trigger/Kconfig
@@ -3,6 +3,15 @@
 #
 menu "Triggers - standalone"
 
+config IIO_INTERRUPT_TRIGGER
+	tristate "Generic interrupt trigger"
+	help
+	  Provides support for using an interrupt of any type as an IIO
+	  trigger.  This may be provided by a gpio driver for example.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called iio-trig-interrupt.
+
 config IIO_SYSFS_TRIGGER
 	tristate "SYSFS trigger"
 	depends on SYSFS
diff --git a/drivers/iio/trigger/Makefile b/drivers/iio/trigger/Makefile
index e0b2183..ce319a5 100644
--- a/drivers/iio/trigger/Makefile
+++ b/drivers/iio/trigger/Makefile
@@ -2,4 +2,5 @@
 # Makefile for triggers not associated with iio-devices
 #
 
+obj-$(CONFIG_IIO_INTERRUPT_TRIGGER) += iio-trig-interrupt.o
 obj-$(CONFIG_IIO_SYSFS_TRIGGER) += iio-trig-sysfs.o
diff --git a/drivers/iio/trigger/iio-trig-interrupt.c b/drivers/iio/trigger/iio-trig-interrupt.c
new file mode 100644
index 0000000..e015de2
--- /dev/null
+++ b/drivers/iio/trigger/iio-trig-interrupt.c
@@ -0,0 +1,123 @@
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
+
+struct iio_interrupt_trigger_info {
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
+	struct iio_trigger *trig;
+	unsigned long irqflags;
+	struct resource *irq_res;
+	int irq, ret = 0, irq_res_cnt = 0;
+
+	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, irq_res_cnt);
+
+	if (irq_res == NULL) {
+		if (irq_res_cnt == 0)
+			dev_err(&pdev->dev, "No IRQs specified");
+		return -ENODEV;
+	}
+	irqflags = (irq_res->flags & IRQF_TRIGGER_MASK) | IRQF_SHARED;
+
+	irq = irq_res->start;
+
+	trig = iio_trigger_alloc("irqtrig%d", irq_res->start);
+	if (!trig) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	trig_info = kzalloc(sizeof(*trig_info), GFP_KERNEL);
+	if (!trig_info) {
+		ret = -ENOMEM;
+		goto error_put_trigger;
+	}
+	iio_trigger_set_drvdata(trig, trig_info);
+	trig_info->irq = irq;
+	trig->ops = &iio_interrupt_trigger_ops;
+	ret = request_irq(irq, iio_interrupt_trigger_poll,
+			  irqflags, trig->name, trig);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"request IRQ-%d failed", irq);
+		goto error_free_trig_info;
+	}
+
+	ret = iio_trigger_register(trig);
+	if (ret)
+		goto error_release_irq;
+	platform_set_drvdata(pdev, trig);
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
+error_ret:
+	return ret;
+}
+
+static int iio_interrupt_trigger_remove(struct platform_device *pdev)
+{
+	struct iio_trigger *trig;
+	struct iio_interrupt_trigger_info *trig_info;
+
+	trig = platform_get_drvdata(pdev);
+	trig_info = iio_trigger_get_drvdata(trig);
+	iio_trigger_unregister(trig);
+	free_irq(trig_info->irq, trig);
+	kfree(trig_info);
+	iio_trigger_put(trig);
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
diff --git a/drivers/staging/iio/trigger/Kconfig b/drivers/staging/iio/trigger/Kconfig
index 4ecb213..2fd18c6 100644
--- a/drivers/staging/iio/trigger/Kconfig
+++ b/drivers/staging/iio/trigger/Kconfig
@@ -12,12 +12,6 @@ config IIO_PERIODIC_RTC_TRIGGER
 	  Provides support for using periodic capable real time
 	  clocks as IIO triggers.
 
-config IIO_INTERRUPT_TRIGGER
-	tristate "Generic interrupt trigger"
-	help
-	  Provides support for using interrupts of various types as IIO
-	  triggers.  These may be provided by a gpio driver for example.
-
 config IIO_BFIN_TMR_TRIGGER
 	tristate "Blackfin TIMER trigger"
 	depends on BLACKFIN
diff --git a/drivers/staging/iio/trigger/Makefile b/drivers/staging/iio/trigger/Makefile
index 48f2236..238481b 100644
--- a/drivers/staging/iio/trigger/Makefile
+++ b/drivers/staging/iio/trigger/Makefile
@@ -3,5 +3,4 @@
 #
 
 obj-$(CONFIG_IIO_PERIODIC_RTC_TRIGGER) += iio-trig-periodic-rtc.o
-obj-$(CONFIG_IIO_INTERRUPT_TRIGGER) += iio-trig-interrupt.o
 obj-$(CONFIG_IIO_BFIN_TMR_TRIGGER) += iio-trig-bfin-timer.o
diff --git a/drivers/staging/iio/trigger/iio-trig-interrupt.c b/drivers/staging/iio/trigger/iio-trig-interrupt.c
deleted file mode 100644
index e015de2..0000000
--- a/drivers/staging/iio/trigger/iio-trig-interrupt.c
+++ /dev/null
@@ -1,123 +0,0 @@
-/*
- * Industrial I/O - generic interrupt based trigger support
- *
- * Copyright (c) 2008-2013 Jonathan Cameron
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
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
-
-struct iio_interrupt_trigger_info {
-	unsigned int irq;
-};
-
-static irqreturn_t iio_interrupt_trigger_poll(int irq, void *private)
-{
-	/* Timestamp not currently provided */
-	iio_trigger_poll(private, 0);
-	return IRQ_HANDLED;
-}
-
-static const struct iio_trigger_ops iio_interrupt_trigger_ops = {
-	.owner = THIS_MODULE,
-};
-
-static int iio_interrupt_trigger_probe(struct platform_device *pdev)
-{
-	struct iio_interrupt_trigger_info *trig_info;
-	struct iio_trigger *trig;
-	unsigned long irqflags;
-	struct resource *irq_res;
-	int irq, ret = 0, irq_res_cnt = 0;
-
-	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, irq_res_cnt);
-
-	if (irq_res == NULL) {
-		if (irq_res_cnt == 0)
-			dev_err(&pdev->dev, "No IRQs specified");
-		return -ENODEV;
-	}
-	irqflags = (irq_res->flags & IRQF_TRIGGER_MASK) | IRQF_SHARED;
-
-	irq = irq_res->start;
-
-	trig = iio_trigger_alloc("irqtrig%d", irq_res->start);
-	if (!trig) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-
-	trig_info = kzalloc(sizeof(*trig_info), GFP_KERNEL);
-	if (!trig_info) {
-		ret = -ENOMEM;
-		goto error_put_trigger;
-	}
-	iio_trigger_set_drvdata(trig, trig_info);
-	trig_info->irq = irq;
-	trig->ops = &iio_interrupt_trigger_ops;
-	ret = request_irq(irq, iio_interrupt_trigger_poll,
-			  irqflags, trig->name, trig);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"request IRQ-%d failed", irq);
-		goto error_free_trig_info;
-	}
-
-	ret = iio_trigger_register(trig);
-	if (ret)
-		goto error_release_irq;
-	platform_set_drvdata(pdev, trig);
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
-error_ret:
-	return ret;
-}
-
-static int iio_interrupt_trigger_remove(struct platform_device *pdev)
-{
-	struct iio_trigger *trig;
-	struct iio_interrupt_trigger_info *trig_info;
-
-	trig = platform_get_drvdata(pdev);
-	trig_info = iio_trigger_get_drvdata(trig);
-	iio_trigger_unregister(trig);
-	free_irq(trig_info->irq, trig);
-	kfree(trig_info);
-	iio_trigger_put(trig);
-
-	return 0;
-}
-
-static struct platform_driver iio_interrupt_trigger_driver = {
-	.probe = iio_interrupt_trigger_probe,
-	.remove = iio_interrupt_trigger_remove,
-	.driver = {
-		.name = "iio_interrupt_trigger",
-		.owner = THIS_MODULE,
-	},
-};
-
-module_platform_driver(iio_interrupt_trigger_driver);
-
-MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
-MODULE_DESCRIPTION("Interrupt trigger for the iio subsystem");
-MODULE_LICENSE("GPL v2");
-- 
1.8.2.1

