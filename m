Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 04/16] staging:iio:adc:ad7150: Add support for the second interrupt strobe.
Date: Fri, 26 Aug 2011 11:19:21 +0100
Message-Id: <1314353973-7662-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353973-7662-1-git-send-email-jic23@cam.ac.uk>
References: <1314353973-7662-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

The AD7150 features two outputs that can be used as interrupt strobes
to the host processor. In order to receive all events independently,
both need to utilized.

Update copyright notice.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7150.c |   38 +++++++++++++++++++++++++-------------
 1 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7150.c b/drivers/staging/iio/adc/ad7150.c
index deb0339..25f354c 100644
--- a/drivers/staging/iio/adc/ad7150.c
+++ b/drivers/staging/iio/adc/ad7150.c
@@ -1,7 +1,7 @@
 /*
  * AD7150 capacitive sensor driver supporting AD7150/1/6
  *
- * Copyright 2010 Analog Devices Inc.
+ * Copyright 2010-2011 Analog Devices Inc.
  *
  * Licensed under the GPL-2 or later.
  */
@@ -45,14 +45,6 @@
 #define AD7150_SN0                 22
 #define AD7150_ID                  23
 
-#define AD7150_MAX_CONV_MODE       4
-
-/**
- * Todo list:
- * - Review whether old_state usage makes sense.
- * - get rid of explicit control of conversion mode
- */
-
 /**
  * struct ad7150_chip_info - instance specific chip data
  * @client: i2c client for this device
@@ -591,24 +583,40 @@ static int __devinit ad7150_probe(struct i2c_client *client,
 					   &ad7150_event_handler,
 					   IRQF_TRIGGER_RISING |
 					   IRQF_TRIGGER_FALLING,
-					   "ad7150",
+					   "ad7150_irq1",
 					   indio_dev);
 		if (ret)
 			goto error_free_dev;
 	}
 
+	if (client->dev.platform_data) {
+		ret = request_threaded_irq(*(unsigned int *)
+					   client->dev.platform_data,
+					   NULL,
+					   &ad7150_event_handler,
+					   IRQF_TRIGGER_RISING |
+					   IRQF_TRIGGER_FALLING,
+					   "ad7150_irq2",
+					   indio_dev);
+		if (ret)
+			goto error_free_irq;
+	}
+
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_free_irq;
+		goto error_free_irq2;
 
 	dev_info(&client->dev, "%s capacitive sensor registered,irq: %d\n",
 		 id->name, client->irq);
 
 	return 0;
+error_free_irq2:
+	if (client->dev.platform_data)
+		free_irq(*(unsigned int *)client->dev.platform_data,
+			 indio_dev);
 error_free_irq:
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
-
 error_free_dev:
 	iio_free_device(indio_dev);
 error_ret:
@@ -621,6 +629,10 @@ static int __devexit ad7150_remove(struct i2c_client *client)
 
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
+
+	if (client->dev.platform_data)
+		free_irq(*(unsigned int *)client->dev.platform_data, indio_dev);
+
 	iio_device_unregister(indio_dev);
 
 	return 0;
@@ -655,7 +667,7 @@ static __exit void ad7150_exit(void)
 }
 
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
-MODULE_DESCRIPTION("Analog Devices ad7150/1/6 capacitive sensor driver");
+MODULE_DESCRIPTION("Analog Devices AD7150/1/6 capacitive sensor driver");
 MODULE_LICENSE("GPL v2");
 
 module_init(ad7150_init);
-- 
1.7.3.4
