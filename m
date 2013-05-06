Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43193 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754324Ab3EFRVN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 6 May 2013 13:21:13 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 3/4] staging:iio:triggers:interrupt trigger - one per platform device.
Date: Mon,  6 May 2013 18:21:02 +0100
Message-Id: <1367860863-6863-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1367860863-6863-1-git-send-email-jic23@kernel.org>
References: <1367860863-6863-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Switching from one platform device registering a lot of triggers
to one for each trigger simplifies the code somewhat. It would be
relatively unusual to have more than a couple of such devices
registered so this change will not result in much additional overhead.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/trigger/iio-trig-interrupt.c | 119 +++++++++--------------
 1 file changed, 45 insertions(+), 74 deletions(-)

diff --git a/drivers/staging/iio/trigger/iio-trig-interrupt.c b/drivers/staging/iio/trigger/iio-trig-interrupt.c
index 9afba96..e015de2 100644
--- a/drivers/staging/iio/trigger/iio-trig-interrupt.c
+++ b/drivers/staging/iio/trigger/iio-trig-interrupt.c
@@ -17,11 +17,8 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
 
-static LIST_HEAD(iio_interrupt_trigger_list);
-static DEFINE_MUTEX(iio_interrupt_trigger_list_lock);
 
 struct iio_interrupt_trigger_info {
-	struct mutex in_use;
 	unsigned int irq;
 };
 
@@ -39,57 +36,48 @@ static const struct iio_trigger_ops iio_interrupt_trigger_ops = {
 static int iio_interrupt_trigger_probe(struct platform_device *pdev)
 {
 	struct iio_interrupt_trigger_info *trig_info;
-	struct iio_trigger *trig, *trig2;
+	struct iio_trigger *trig;
 	unsigned long irqflags;
 	struct resource *irq_res;
 	int irq, ret = 0, irq_res_cnt = 0;
 
-	do {
-		irq_res = platform_get_resource(pdev,
-				IORESOURCE_IRQ, irq_res_cnt);
-
-		if (irq_res == NULL) {
-			if (irq_res_cnt == 0)
-				dev_err(&pdev->dev, "No IRQs specified");
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
-			trig->ops = &iio_interrupt_trigger_ops;
-			ret = request_irq(irq, iio_interrupt_trigger_poll,
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
-					&iio_interrupt_trigger_list);
-		}
-
-		irq_res_cnt++;
-	} while (irq_res != NULL);
+	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, irq_res_cnt);
 
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
 
 	return 0;
 
@@ -100,38 +88,21 @@ error_free_trig_info:
 	kfree(trig_info);
 error_put_trigger:
 	iio_trigger_put(trig);
-error_free_completed_registrations:
-	/* The rest should have been added to the iio_interrupt_trigger_list */
-	list_for_each_entry_safe(trig,
-				 trig2,
-				 &iio_interrupt_trigger_list,
-				 alloc_list) {
-		trig_info = iio_trigger_get_drvdata(trig);
-		free_irq(trig_info->irq, trig);
-		kfree(trig_info);
-		iio_trigger_unregister(trig);
-	}
-
+error_ret:
 	return ret;
 }
 
 static int iio_interrupt_trigger_remove(struct platform_device *pdev)
 {
-	struct iio_trigger *trig, *trig2;
+	struct iio_trigger *trig;
 	struct iio_interrupt_trigger_info *trig_info;
 
-	mutex_lock(&iio_interrupt_trigger_list_lock);
-	list_for_each_entry_safe(trig,
-				 trig2,
-				 &iio_interrupt_trigger_list,
-				 alloc_list) {
-		trig_info = iio_trigger_get_drvdata(trig);
-		iio_trigger_unregister(trig);
-		free_irq(trig_info->irq, trig);
-		kfree(trig_info);
-		iio_trigger_put(trig);
-	}
-	mutex_unlock(&iio_interrupt_trigger_list_lock);
+	trig = platform_get_drvdata(pdev);
+	trig_info = iio_trigger_get_drvdata(trig);
+	iio_trigger_unregister(trig);
+	free_irq(trig_info->irq, trig);
+	kfree(trig_info);
+	iio_trigger_put(trig);
 
 	return 0;
 }
-- 
1.8.2.1

