Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34245 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754004AbeFPPFF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jun 2018 11:05:05 -0400
Received: by mail-pf0-f195.google.com with SMTP id a63-v6so6189891pfl.1
        for <linux-iio@vger.kernel.org>; Sat, 16 Jun 2018 08:05:05 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/4] iio: accel: adxl345: use scan_index for accessing accel registers
Date: Sun, 17 Jun 2018 00:04:41 +0900
Message-Id: <1529161484-28781-3-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1529161484-28781-1-git-send-email-akinobu.mita@gmail.com>
References: <1529161484-28781-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently the address field in iio_chan_spec is filled with an accel
data register address for the corresponding axis.

In preparation for adding calibration offset support, this makes use of
scan_index field to access accel data registers instead of using address
field.  This change makes it easier to access both accel registers and
calibration offset registers with fewer lines of code as these are
located in X-axis, Y-axis, Z-axis order.

Cc: Eva Rachel Retuya <eraretuya@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 8e0d56b..6b62f82 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -49,19 +49,19 @@ struct adxl345_data {
 	u8 data_range;
 };
 
-#define ADXL345_CHANNEL(reg, axis) {					\
+#define ADXL345_CHANNEL(si, axis) {					\
 	.type = IIO_ACCEL,						\
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
-	.address = reg,							\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.scan_index = si,						\
 }
 
 static const struct iio_chan_spec adxl345_channels[] = {
-	ADXL345_CHANNEL(ADXL345_REG_DATAX0, X),
-	ADXL345_CHANNEL(ADXL345_REG_DATAY0, Y),
-	ADXL345_CHANNEL(ADXL345_REG_DATAZ0, Z),
+	ADXL345_CHANNEL(0, X),
+	ADXL345_CHANNEL(1, Y),
+	ADXL345_CHANNEL(2, Z),
 };
 
 static int adxl345_read_raw(struct iio_dev *indio_dev,
@@ -79,8 +79,9 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 		 * ADXL345_REG_DATA(X0/Y0/Z0) contain the least significant byte
 		 * and ADXL345_REG_DATA(X0/Y0/Z0) + 1 the most significant byte
 		 */
-		ret = regmap_bulk_read(data->regmap, chan->address, &regval,
-				       sizeof(regval));
+		ret = regmap_bulk_read(data->regmap, ADXL345_REG_DATAX0 +
+				       sizeof(regval) * chan->scan_index,
+				       &regval, sizeof(regval));
 		if (ret < 0)
 			return ret;
 
-- 
2.7.4

