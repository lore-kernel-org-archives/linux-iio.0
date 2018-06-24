Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42339 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751792AbeFXPFq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jun 2018 11:05:46 -0400
Received: by mail-pf0-f195.google.com with SMTP id w7-v6so5292132pfn.9
        for <linux-iio@vger.kernel.org>; Sun, 24 Jun 2018 08:05:46 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
        =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio: adc: ina2xx: avoid kthread_stop() with stale task_struct
Date: Mon, 25 Jun 2018 00:05:21 +0900
Message-Id: <1529852721-17828-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When the buffer is enabled for ina2xx driver, a dedicated kthread is
invoked to capture mesurement data.  When the buffer is disabled, the
kthread is stopped.

However if the kthread gets register access errors, it immediately exits
and when the malfunctional buffer is disabled, the stale task_struct
pointer is accessed as there is no kthread to be stopped.

A similar issue in the usbip driver is prevented by kthread_get_run and
kthread_stop_put helpers by increasing usage count of the task_struct.
This change applies the same solution.

Cc: Stefan Brüns <stefan.bruens@rwth-aachen.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/iio/adc/ina2xx-adc.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 0635a79..d123962 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -30,6 +30,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/regmap.h>
+#include <linux/sched/task.h>
 #include <linux/util_macros.h>
 
 #include <linux/platform_data/ina2xx.h>
@@ -826,6 +827,7 @@ static int ina2xx_buffer_enable(struct iio_dev *indio_dev)
 {
 	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
 	unsigned int sampling_us = SAMPLING_PERIOD(chip);
+	struct task_struct *task;
 
 	dev_dbg(&indio_dev->dev, "Enabling buffer w/ scan_mask %02x, freq = %d, avg =%u\n",
 		(unsigned int)(*indio_dev->active_scan_mask),
@@ -835,11 +837,17 @@ static int ina2xx_buffer_enable(struct iio_dev *indio_dev)
 	dev_dbg(&indio_dev->dev, "Async readout mode: %d\n",
 		chip->allow_async_readout);
 
-	chip->task = kthread_run(ina2xx_capture_thread, (void *)indio_dev,
-				 "%s:%d-%uus", indio_dev->name, indio_dev->id,
-				 sampling_us);
+	task = kthread_create(ina2xx_capture_thread, (void *)indio_dev,
+			      "%s:%d-%uus", indio_dev->name, indio_dev->id,
+			      sampling_us);
+	if (IS_ERR(task))
+		return PTR_ERR(task);
+
+	get_task_struct(task);
+	wake_up_process(task);
+	chip->task = task;
 
-	return PTR_ERR_OR_ZERO(chip->task);
+	return 0;
 }
 
 static int ina2xx_buffer_disable(struct iio_dev *indio_dev)
@@ -848,6 +856,7 @@ static int ina2xx_buffer_disable(struct iio_dev *indio_dev)
 
 	if (chip->task) {
 		kthread_stop(chip->task);
+		put_task_struct(chip->task);
 		chip->task = NULL;
 	}
 
-- 
2.7.4

