Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33500 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220AbcHPNej (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Aug 2016 09:34:39 -0400
Received: by mail-wm0-f51.google.com with SMTP id d196so29238239wmd.0
        for <linux-iio@vger.kernel.org>; Tue, 16 Aug 2016 06:34:39 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 09/17] iio: accel: kxsd9: Drop the buffer lock
Date: Tue, 16 Aug 2016 15:33:35 +0200
Message-Id: <1471354423-19186-10-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
References: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The RX/TX buffers are gone so drop the lock (it should have been
in the transport struct anyway).

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/kxsd9.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index fe85f61cfa9d..a8ee041dd4e4 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -41,14 +41,10 @@
 
 /**
  * struct kxsd9_state - device related storage
- * @buf_lock:	protect the rx and tx buffers.
- * @us:		spi device
- * @rx:		single rx buffer storage
- * @tx:		single tx buffer storage
- **/
+ * @map: regmap to the device
+ */
 struct kxsd9_state {
 	struct regmap *map;
-	struct mutex buf_lock;
 };
 
 #define KXSD9_SCALE_2G "0.011978"
@@ -74,7 +70,6 @@ static int kxsd9_write_scale(struct iio_dev *indio_dev, int micro)
 	if (!foundit)
 		return -EINVAL;
 
-	mutex_lock(&st->buf_lock);
 	ret = regmap_read(st->map,
 			  KXSD9_REG_CTRL_C,
 			  &val);
@@ -84,7 +79,6 @@ static int kxsd9_write_scale(struct iio_dev *indio_dev, int micro)
 			   KXSD9_REG_CTRL_C,
 			   (val & ~KXSD9_FS_MASK) | i);
 error_ret:
-	mutex_unlock(&st->buf_lock);
 	return ret;
 }
 
@@ -94,15 +88,11 @@ static int kxsd9_read(struct iio_dev *indio_dev, u8 address)
 	struct kxsd9_state *st = iio_priv(indio_dev);
 	__be16 raw_val;
 
-	mutex_lock(&st->buf_lock);
 	ret = regmap_bulk_read(st->map, address, &raw_val, sizeof(raw_val));
 	if (ret)
-		goto out_fail_read;
+		return ret;
 	/* Only 12 bits are valid */
-	ret = be16_to_cpu(raw_val) & 0xfff0;
-out_fail_read:
-	mutex_unlock(&st->buf_lock);
-	return ret;
+	return be16_to_cpu(raw_val) & 0xfff0;
 }
 
 static IIO_CONST_ATTR(accel_scale_available,
@@ -220,7 +210,6 @@ int kxsd9_common_probe(struct device *parent,
 	st = iio_priv(indio_dev);
 	st->map = map;
 
-	mutex_init(&st->buf_lock);
 	indio_dev->channels = kxsd9_channels;
 	indio_dev->num_channels = ARRAY_SIZE(kxsd9_channels);
 	indio_dev->name = name;
-- 
2.7.4

