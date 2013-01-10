Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-053.synserver.de ([212.40.185.53]:1061 "EHLO
	smtp-out-052.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751613Ab3AJQR2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jan 2013 11:17:28 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Jon Brenner <jbrenner@taosinc.com>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio:tsl2x7x: Use iio_str_to_fixedpoint instead of open-coding it
Date: Thu, 10 Jan 2013 17:18:01 +0100
Message-Id: <1357834681-14126-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The tsl2x7x driver has a copy'n'pasted version of the iio_str_to_fixedpoint()
function from the IIO core. Replace this custom copy and use
iio_str_to_fixedpoint instead.

The patch also introduces a slight functional change in that it makes sure that
in case of a parsing error the error is reported back to userspace instead of
silently ignoring it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Only compile tested.
---
 drivers/staging/iio/light/tsl2x7x_core.c | 78 +++++---------------------------
 1 file changed, 12 insertions(+), 66 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index 9e50fbba..a58731e 100644
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -292,59 +292,6 @@ static const u8 device_channel_config[] = {
 };
 
 /**
- * tsl2x7x_parse_buffer() - parse a decimal result from a buffer.
- * @*buf:                   pointer to char buffer to parse
- * @*result:                pointer to buffer to contain
- *                          resulting interger / decimal as ints.
- *
- */
-static int
-tsl2x7x_parse_buffer(const char *buf, struct tsl2x7x_parse_result *result)
-{
-	int integer = 0, fract = 0, fract_mult = 100000;
-	bool integer_part = true, negative = false;
-
-	if (buf[0] == '-') {
-		negative = true;
-		buf++;
-	}
-
-	while (*buf) {
-		if ('0' <= *buf && *buf <= '9') {
-			if (integer_part)
-				integer = integer*10 + *buf - '0';
-			else {
-				fract += fract_mult*(*buf - '0');
-				if (fract_mult == 1)
-					break;
-				fract_mult /= 10;
-			}
-		} else if (*buf == '\n') {
-			if (*(buf + 1) == '\0')
-				break;
-			else
-				return -EINVAL;
-		} else if (*buf == '.') {
-			integer_part = false;
-		} else {
-			return -EINVAL;
-		}
-		buf++;
-	}
-	if (negative) {
-		if (integer)
-			integer = -integer;
-		else
-			fract = -fract;
-	}
-
-	result->integer = integer;
-	result->fract = fract;
-
-	return 0;
-}
-
-/**
  * tsl2x7x_i2c_read() - Read a byte from a register.
  * @client:	i2c client
  * @reg:	device register to read from
@@ -1036,13 +983,12 @@ static ssize_t tsl2x7x_als_time_store(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
 	struct tsl2x7x_parse_result result;
+	int ret;
 
-	result.integer = 0;
-	result.fract = 0;
-
-	tsl2x7x_parse_buffer(buf, &result);
+	ret = iio_str_to_fixpoint(buf, 100, &result.integer, &result.fract);
+	if (ret)
+		return ret;
 
-	result.fract /= 1000;
 	result.fract /= 3;
 	chip->tsl2x7x_settings.als_time =
 			(TSL2X7X_MAX_TIMER_CNT - (u8)result.fract);
@@ -1109,12 +1055,12 @@ static ssize_t tsl2x7x_als_persistence_store(struct device *dev,
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
 	struct tsl2x7x_parse_result result;
 	int y, z, filter_delay;
+	int ret;
 
-	result.integer = 0;
-	result.fract = 0;
-	tsl2x7x_parse_buffer(buf, &result);
+	ret = iio_str_to_fixpoint(buf, 100, &result.integer, &result.fract);
+	if (ret)
+		return ret;
 
-	result.fract /= 1000;
 	y = (TSL2X7X_MAX_TIMER_CNT - (u8)chip->tsl2x7x_settings.als_time) + 1;
 	z = y * TSL2X7X_MIN_ITIME;
 
@@ -1155,12 +1101,12 @@ static ssize_t tsl2x7x_prox_persistence_store(struct device *dev,
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
 	struct tsl2x7x_parse_result result;
 	int y, z, filter_delay;
+	int ret;
 
-	result.integer = 0;
-	result.fract = 0;
-	tsl2x7x_parse_buffer(buf, &result);
+	ret = iio_str_to_fixpoint(buf, 100, &result.integer, &result.fract);
+	if (ret)
+		return ret;
 
-	result.fract /= 1000;
 	y = (TSL2X7X_MAX_TIMER_CNT - (u8)chip->tsl2x7x_settings.prx_time) + 1;
 	z = y * TSL2X7X_MIN_ITIME;
 
-- 
1.8.0

