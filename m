Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37080 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751246AbeF3QdG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jun 2018 12:33:06 -0400
Received: by mail-pl0-f68.google.com with SMTP id 31-v6so5927552plc.4
        for <linux-iio@vger.kernel.org>; Sat, 30 Jun 2018 09:33:06 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v5 3/4] iio: accel: adxl345: add calibration offset support
Date: Sun,  1 Jul 2018 01:32:44 +0900
Message-Id: <1530376365-23946-4-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1530376365-23946-1-git-send-email-akinobu.mita@gmail.com>
References: <1530376365-23946-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ADXL345 provides the offset adjustment registers for each axis.
This adds the iio channel information for the calibraion offsets with
that feature.

Cc: Eva Rachel Retuya <eraretuya@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v5
- No changes from v4

 drivers/iio/accel/adxl345_core.c | 41 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 7a25840..7b29ae8 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -18,6 +18,10 @@
 #include "adxl345.h"
 
 #define ADXL345_REG_DEVID		0x00
+#define ADXL345_REG_OFSX		0x1e
+#define ADXL345_REG_OFSY		0x1f
+#define ADXL345_REG_OFSZ		0x20
+#define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
 #define ADXL345_REG_POWER_CTL		0x2D
 #define ADXL345_REG_DATA_FORMAT		0x31
 #define ADXL345_REG_DATAX0		0x32
@@ -56,7 +60,8 @@ struct adxl345_data {
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
 	.address = index,						\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
+		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
 }
 
@@ -72,6 +77,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 {
 	struct adxl345_data *data = iio_priv(indio_dev);
 	__le16 accel;
+	unsigned int regval;
 	int ret;
 
 	switch (mask) {
@@ -94,6 +100,38 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 		*val2 = adxl345_uscale;
 
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		ret = regmap_read(data->regmap,
+				  ADXL345_REG_OFS_AXIS(chan->address), &regval);
+		if (ret < 0)
+			return ret;
+		/*
+		 * 8-bit resolution at +/- 2g, that is 4x accel data scale
+		 * factor
+		 */
+		*val = sign_extend32(regval, 7) * 4;
+
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static int adxl345_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct adxl345_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_CALIBBIAS:
+		/*
+		 * 8-bit resolution at +/- 2g, that is 4x accel data scale
+		 * factor
+		 */
+		return regmap_write(data->regmap,
+				    ADXL345_REG_OFS_AXIS(chan->address),
+				    val / 4);
 	}
 
 	return -EINVAL;
@@ -101,6 +139,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info adxl345_info = {
 	.read_raw	= adxl345_read_raw,
+	.write_raw	= adxl345_write_raw,
 };
 
 int adxl345_core_probe(struct device *dev, struct regmap *regmap,
-- 
2.7.4

