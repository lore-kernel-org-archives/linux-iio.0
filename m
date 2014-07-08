Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:60940 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753413AbaGHLHB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 8 Jul 2014 07:07:01 -0400
Message-ID: <53BBD0CF.4050702@gmx.de>
Date: Tue, 08 Jul 2014 13:06:55 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
CC: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/6] staging:iio:ad7291 fix defines
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use BIT and GENMASK, remove unused defines, use AD7291_VOLTAGE_OFFSET
definition and move AD7291_BITS.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index b868c64..8ff3536 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -46,31 +46,27 @@
 #define AD7291_VOLTAGE_ALERT_STATUS	0x1F
 #define AD7291_T_ALERT_STATUS		0x20
 
+#define AD7291_BITS			12
 #define AD7291_VOLTAGE_LIMIT_COUNT	8
 
 
 /*
  * AD7291 command
  */
-#define AD7291_AUTOCYCLE		(1 << 0)
-#define AD7291_RESET			(1 << 1)
-#define AD7291_ALERT_CLEAR		(1 << 2)
-#define AD7291_ALERT_POLARITY		(1 << 3)
-#define AD7291_EXT_REF			(1 << 4)
-#define AD7291_NOISE_DELAY		(1 << 5)
-#define AD7291_T_SENSE_MASK		(1 << 7)
-#define AD7291_VOLTAGE_MASK		0xFF00
-#define AD7291_VOLTAGE_OFFSET		0x8
+#define AD7291_AUTOCYCLE		BIT(0)
+#define AD7291_RESET			BIT(1)
+#define AD7291_ALERT_CLEAR		BIT(2)
+#define AD7291_ALERT_POLARITY		BIT(3)
+#define AD7291_EXT_REF			BIT(4)
+#define AD7291_NOISE_DELAY		BIT(5)
+#define AD7291_T_SENSE_MASK		BIT(7)
+#define AD7291_VOLTAGE_MASK		GENMASK(15, 8)
+#define AD7291_VOLTAGE_OFFSET		8
 
 /*
  * AD7291 value masks
  */
-#define AD7291_CHANNEL_MASK		0xF000
-#define AD7291_BITS			12
-#define AD7291_VALUE_MASK		0xFFF
-#define AD7291_T_VALUE_SIGN		0x400
-#define AD7291_T_VALUE_FLOAT_OFFSET	2
-#define AD7291_T_VALUE_FLOAT_MASK	0x2
+#define AD7291_VALUE_MASK		GENMASK(11, 0)
 
 struct ad7291_chip_info {
 	struct i2c_client	*client;
@@ -172,7 +168,7 @@ static unsigned int ad7291_threshold_reg(const struct iio_chan_spec *chan,
 		offset = chan->channel;
 		break;
 	case IIO_TEMP:
-		offset = 8;
+		offset = AD7291_VOLTAGE_OFFSET;
 		break;
 	}
 
@@ -246,7 +242,7 @@ static int ad7291_read_event_config(struct iio_dev *indio_dev,
 
 	switch (chan->type) {
 	case IIO_VOLTAGE:
-		if (chip->c_mask & (1 << (15 - chan->channel)))
+		if (chip->c_mask & BIT(15 - chan->channel))
 			return 1;
 		else
 			return 0;
@@ -331,7 +327,7 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
 			}
 			/* Enable this channel alone */
 			regval = chip->command & (~AD7291_VOLTAGE_MASK);
-			regval |= 1 << (15 - chan->channel);
+			regval |= BIT(15 - chan->channel);
 			ret = ad7291_i2c_write(chip, AD7291_COMMAND, regval);
 			if (ret < 0) {
 				mutex_unlock(&chip->state_lock);
