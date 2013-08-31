Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:48270 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286Ab3HaRNN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 31 Aug 2013 13:13:13 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf1so3539691pab.24
        for <linux-iio@vger.kernel.org>; Sat, 31 Aug 2013 10:13:13 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 9/9] staging: iio: adt7316: Use devm_* APIs
Date: Sat, 31 Aug 2013 22:42:39 +0530
Message-Id: <1377969159-2491-9-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1377969159-2491-1-git-send-email-sachin.kamat@linaro.org>
References: <1377969159-2491-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_* APIs are device managed and make code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/addac/adt7316.c |   48 +++++++++++-----------------------
 1 files changed, 16 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 1e13568..514ddcc 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2106,11 +2106,9 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	unsigned short *adt7316_platform_data = dev->platform_data;
 	int ret = 0;
 
-	indio_dev = iio_device_alloc(sizeof(*chip));
-	if (indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
+	if (!indio_dev)
+		return -ENOMEM;
 	chip = iio_priv(indio_dev);
 	/* this is only used for device removal purposes */
 	dev_set_drvdata(dev, indio_dev);
@@ -2146,58 +2144,44 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 		if (adt7316_platform_data[0])
 			chip->bus.irq_flags = adt7316_platform_data[0];
 
-		ret = request_threaded_irq(chip->bus.irq,
-					   NULL,
-					   &adt7316_event_handler,
-					   chip->bus.irq_flags | IRQF_ONESHOT,
-					   indio_dev->name,
-					   indio_dev);
+		ret = devm_request_threaded_irq(dev, chip->bus.irq,
+						NULL,
+						&adt7316_event_handler,
+						chip->bus.irq_flags |
+						IRQF_ONESHOT,
+						indio_dev->name,
+						indio_dev);
 		if (ret)
-			goto error_free_dev;
+			return ret;
 
 		if (chip->bus.irq_flags & IRQF_TRIGGER_HIGH)
 			chip->config1 |= ADT7316_INT_POLARITY;
 	}
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, chip->config1);
-	if (ret) {
-		ret = -EIO;
-		goto error_unreg_irq;
-	}
+	if (ret)
+		return -EIO;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, chip->config3);
-	if (ret) {
-		ret = -EIO;
-		goto error_unreg_irq;
-	}
+	if (ret)
+		return -EIO;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_unreg_irq;
+		return ret;
 
 	dev_info(dev, "%s temperature sensor, ADC and DAC registered.\n",
 			indio_dev->name);
 
 	return 0;
-
-error_unreg_irq:
-	free_irq(chip->bus.irq, indio_dev);
-error_free_dev:
-	iio_device_free(indio_dev);
-error_ret:
-	return ret;
 }
 EXPORT_SYMBOL(adt7316_probe);
 
 int adt7316_remove(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	if (chip->bus.irq)
-		free_irq(chip->bus.irq, indio_dev);
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.4.1

