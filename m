Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/4] staging:iio:trigger:gpio bug in release of gpio in error path
Date: Mon,  6 May 2013 18:21:00 +0100
Message-Id: <1367860863-6863-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1367860863-6863-1-git-send-email-jic23@kernel.org>
References: <1367860863-6863-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Also dropped the unneeded gpio.h header.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/trigger/iio-trig-gpio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/iio/trigger/iio-trig-gpio.c b/drivers/staging/iio/trigger/iio-trig-gpio.c
index 7c593d1..69dabca 100644
--- a/drivers/staging/iio/trigger/iio-trig-gpio.c
+++ b/drivers/staging/iio/trigger/iio-trig-gpio.c
@@ -19,7 +19,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
 #include <linux/slab.h>
 
 #include <linux/iio/iio.h>
@@ -122,7 +121,7 @@ error_free_completed_registrations:
 				 &iio_gpio_trigger_list,
 				 alloc_list) {
 		trig_info = iio_trigger_get_drvdata(trig);
-		free_irq(gpio_to_irq(trig_info->irq), trig);
+		free_irq(trig_info->irq, trig);
 		kfree(trig_info);
 		iio_trigger_unregister(trig);
 	}
-- 
1.8.2.1
