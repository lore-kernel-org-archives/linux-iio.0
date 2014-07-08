Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:54269 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753645AbaGHLHF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 8 Jul 2014 07:07:05 -0400
Message-ID: <53BBD0D3.7060006@gmx.de>
Date: Tue, 08 Jul 2014 13:06:59 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
CC: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/6] staging:iio:ad7291 define alert register bits
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Define some names for alert register bits and apply them to
ad7291_event_handler().

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 06eb0c0..a257f78 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -68,6 +68,17 @@
  */
 #define AD7291_VALUE_MASK		GENMASK(11, 0)
 
+/*
+ * AD7291 alert register bits
+ */
+#define AD7291_T_LOW			BIT(0)
+#define AD7291_T_HIGH			BIT(1)
+#define AD7291_T_AVG_LOW		BIT(2)
+#define AD7291_T_AVG_HIGH		BIT(3)
+#define AD7291_V_LOW(x)			BIT((x) * 2)
+#define AD7291_V_HIGH(x)		BIT((x) * 2 + 1)
+
+
 struct ad7291_chip_info {
 	struct i2c_client	*client;
 	struct regulator	*reg;
@@ -122,14 +133,14 @@ static irqreturn_t ad7291_event_handler(int irq, void *private)
 	ad7291_i2c_write(chip, AD7291_COMMAND, command);
 
 	/* For now treat t_sense and t_sense_average the same */
-	if ((t_status & (1 << 0)) || (t_status & (1 << 2)))
+	if ((t_status & AD7291_T_LOW) || (t_status & AD7291_T_AVG_LOW))
 		iio_push_event(indio_dev,
 			       IIO_UNMOD_EVENT_CODE(IIO_TEMP,
 						    0,
 						    IIO_EV_TYPE_THRESH,
 						    IIO_EV_DIR_FALLING),
 			       timestamp);
-	if ((t_status & (1 << 1)) || (t_status & (1 << 3)))
+	if ((t_status & AD7291_T_HIGH) || (t_status & AD7291_T_AVG_HIGH))
 		iio_push_event(indio_dev,
 			       IIO_UNMOD_EVENT_CODE(IIO_TEMP,
 						    0,
@@ -137,18 +148,18 @@ static irqreturn_t ad7291_event_handler(int irq, void *private)
 						    IIO_EV_DIR_RISING),
 			       timestamp);
 
-	for (i = 0; i < AD7291_VOLTAGE_LIMIT_COUNT*2; i += 2) {
-		if (v_status & (1 << i))
+	for (i = 0; i < AD7291_VOLTAGE_LIMIT_COUNT; i++) {
+		if (v_status & AD7291_V_LOW(i))
 			iio_push_event(indio_dev,
 				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
-							    i/2,
+							    i,
 							    IIO_EV_TYPE_THRESH,
 							    IIO_EV_DIR_FALLING),
 				       timestamp);
-		if (v_status & (1 << (i + 1)))
+		if (v_status & AD7291_V_HIGH(i))
 			iio_push_event(indio_dev,
 				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
-							    i/2,
+							    i,
 							    IIO_EV_TYPE_THRESH,
 							    IIO_EV_DIR_RISING),
 				       timestamp);
