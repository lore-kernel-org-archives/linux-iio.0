Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35482 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936856AbeF3Kc5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jun 2018 06:32:57 -0400
From: Vignesh R <vigneshr@ti.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
CC: Vignesh R <vigneshr@ti.com>, <linux-iio@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-input@vger.kernel.org>
Subject: [PATCH 5/5] Input: ti_am335x_tsc: Mark IRQ as wakeup capable
Date: Sat, 30 Jun 2018 16:03:18 +0530
Message-ID: <20180630103318.25355-6-vigneshr@ti.com>
In-Reply-To: <20180630103318.25355-1-vigneshr@ti.com>
References: <20180630103318.25355-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On AM335x, ti_am335x_tsc can wake up the system from suspend, mark the
IRQ as wakeup capable, so that device irq is not disabled during system
suspend.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/input/touchscreen/ti_am335x_tsc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index a4f25a915ffc..9e8684ab48f4 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -27,6 +27,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/sort.h>
+#include <linux/pm_wakeirq.h>
 
 #include <linux/mfd/ti_am335x_tscadc.h>
 
@@ -439,6 +440,9 @@ static int titsc_probe(struct platform_device *pdev)
 	}
 
 	device_init_wakeup(&pdev->dev, true);
+	err = dev_pm_set_wake_irq(&pdev->dev, ts_dev->irq);
+	if (err)
+		dev_err(&pdev->dev, "irq wake enable failed.\n");
 
 	titsc_writel(ts_dev, REG_IRQSTATUS, TSC_IRQENB_MASK);
 	titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_FIFO0THRES);
@@ -471,6 +475,7 @@ static int titsc_probe(struct platform_device *pdev)
 	return 0;
 
 err_free_irq:
+	dev_pm_clear_wake_irq(&pdev->dev);
 	device_init_wakeup(&pdev->dev, false);
 	free_irq(ts_dev->irq, ts_dev);
 err_free_mem:
@@ -484,6 +489,7 @@ static int titsc_remove(struct platform_device *pdev)
 	struct titsc *ts_dev = platform_get_drvdata(pdev);
 	u32 steps;
 
+	dev_pm_clear_wake_irq(&pdev->dev);
 	device_init_wakeup(&pdev->dev, false);
 	free_irq(ts_dev->irq, ts_dev);
 
-- 
2.18.0

