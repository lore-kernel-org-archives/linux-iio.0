Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53466 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505Ab3FBTAZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jun 2013 15:00:25 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: mirq-linux@rere.qmqm.pl, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/4] staging:iio:trigger:gpio bug in release of gpio in error path
Date: Sun,  2 Jun 2013 20:00:13 +0100
Message-Id: <1370199616-25500-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1370199616-25500-1-git-send-email-jic23@kernel.org>
References: <1370199616-25500-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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
1.8.2.3

