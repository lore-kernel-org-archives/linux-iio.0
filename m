Return-Path: <sha@pengutronix.de>
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	Sonic Zhang <sonic.zhang@analog.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/3] staging iio adt7410: fix 13bit mode
Date: Tue,  3 Jul 2012 11:21:27 +0200
Message-Id: <1341307288-1926-3-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1341307288-1926-1-git-send-email-s.hauer@pengutronix.de>
References: <1341307288-1926-1-git-send-email-s.hauer@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

The driver assumes that in 13bit mode the 16bit value has
to be shifted to the right by 3 bits. This is not true, in
both 16bit and 13bit mode the MSB is at the same position.
Currently the driver returns a temperature of 194 degrees
Celsius in 13bit mode and 24 degrees Celsius in 16bit mode.
Fix this by using the same algorithm for 16bit and 13bit
mode and by just masking out the lower three bits in 13bit
mode.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/staging/iio/adc/adt7410.c |   29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
index fa54a40..f9188e5 100644
--- a/drivers/staging/iio/adc/adt7410.c
+++ b/drivers/staging/iio/adc/adt7410.c
@@ -293,26 +293,17 @@ static ssize_t adt7410_convert_temperature(struct adt7410_chip_info *chip,
 {
 	char sign = ' ';
 
-	if (chip->config & ADT7410_RESOLUTION) {
-		if (data & ADT7410_T16_VALUE_SIGN) {
-			/* convert supplement to positive value */
-			data = (u16)((ADT7410_T16_VALUE_SIGN << 1) - (u32)data);
-			sign = '-';
-		}
-		return sprintf(buf, "%c%d.%.7d\n", sign,
-				(data >> ADT7410_T16_VALUE_FLOAT_OFFSET),
-				(data & ADT7410_T16_VALUE_FLOAT_MASK) * 78125);
-	} else {
-		if (data & ADT7410_T13_VALUE_SIGN) {
-			/* convert supplement to positive value */
-			data >>= ADT7410_T13_VALUE_OFFSET;
-			data = (ADT7410_T13_VALUE_SIGN << 1) - data;
-			sign = '-';
-		}
-		return sprintf(buf, "%c%d.%.4d\n", sign,
-				(data >> ADT7410_T13_VALUE_FLOAT_OFFSET),
-				(data & ADT7410_T13_VALUE_FLOAT_MASK) * 625);
+	if (!(chip->config & ADT7410_RESOLUTION))
+		data &= ~0x7;
+
+	if (data & ADT7410_T16_VALUE_SIGN) {
+		/* convert supplement to positive value */
+		data = (u16)((ADT7410_T16_VALUE_SIGN << 1) - (u32)data);
+		sign = '-';
 	}
+	return sprintf(buf, "%c%d.%.7d\n", sign,
+			(data >> ADT7410_T16_VALUE_FLOAT_OFFSET),
+			(data & ADT7410_T16_VALUE_FLOAT_MASK) * 78125);
 }
 
 static ssize_t adt7410_show_value(struct device *dev,
-- 
1.7.10
