Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34190 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753712AbcHPNen (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Aug 2016 09:34:43 -0400
Received: by mail-wm0-f42.google.com with SMTP id q128so29170870wma.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Aug 2016 06:34:42 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 11/17] iio: accel: kxsd9: Fix up offset and scaling
Date: Tue, 16 Aug 2016 15:33:37 +0200
Message-Id: <1471354423-19186-12-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
References: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This fixes several errors in the offset and scaling of the raw
values from the KXSD9 sensor:

- The code did not convert the big endian value from the sensor
  into the endianness of the host CPU. Fix this with
  be16_to_cpu() on the raw obtained value.

- The code did not regard the fact that only the upper 12 bits of
  the accelerometer values are valid. Shift these
  down four bits to yield the real raw value.

- Further the sensor provides 2048 at zero g. This means that an
  offset of 2048 must be subtracted from the raw value before
  scaling. This was not taken into account by the driver,
  yielding a weird value. Fix this by providing this offset in
  sysfs.

To house the scaling code better, the value reading code was
factored into the raw reading function.

This proper scaling and offseting is necessary to get proper
values out of triggered buffer by offsetting, shifting and scaling
them.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/kxsd9.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 14d949a4caf9..152042ef3e3c 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -55,6 +55,8 @@ struct kxsd9_state {
 /* reverse order */
 static const int kxsd9_micro_scales[4] = { 47853, 35934, 23927, 11978 };
 
+#define KXSD9_ZERO_G_OFFSET -2048
+
 static int kxsd9_write_scale(struct iio_dev *indio_dev, int micro)
 {
 	int ret, i;
@@ -82,19 +84,6 @@ error_ret:
 	return ret;
 }
 
-static int kxsd9_read(struct iio_dev *indio_dev, u8 address)
-{
-	int ret;
-	struct kxsd9_state *st = iio_priv(indio_dev);
-	__be16 raw_val;
-
-	ret = regmap_bulk_read(st->map, address, &raw_val, sizeof(raw_val));
-	if (ret)
-		return ret;
-	/* Only 12 bits are valid */
-	return be16_to_cpu(raw_val) & 0xfff0;
-}
-
 static IIO_CONST_ATTR(accel_scale_available,
 		KXSD9_SCALE_2G " "
 		KXSD9_SCALE_4G " "
@@ -131,13 +120,24 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
 	int ret = -EINVAL;
 	struct kxsd9_state *st = iio_priv(indio_dev);
 	unsigned int regval;
+	__be16 raw_val;
+	u16 nval;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = kxsd9_read(indio_dev, chan->address);
-		if (ret < 0)
+		ret = regmap_bulk_read(st->map, chan->address, &raw_val,
+				       sizeof(raw_val));
+		if (ret)
 			goto error_ret;
-		*val = ret;
+		nval = be16_to_cpu(raw_val);
+		/* Only 12 bits are valid */
+		nval >>= 4;
+		*val = nval;
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_OFFSET:
+		/* This has a bias of -2048 */
+		*val = KXSD9_ZERO_G_OFFSET;
 		ret = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SCALE:
@@ -161,7 +161,8 @@ error_ret:
 		.modified = 1,						\
 		.channel2 = IIO_MOD_##axis,				\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
+					BIT(IIO_CHAN_INFO_OFFSET),	\
 		.address = KXSD9_REG_##axis,				\
 	}
 
-- 
2.7.4

