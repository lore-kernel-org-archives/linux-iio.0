Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 08/15 v2] iio: accel: kxsd9: Drop the buffer lock
Date: Thu,  1 Sep 2016 11:44:42 +0200
Message-Id: <1472723089-25113-8-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1472723089-25113-1-git-send-email-linus.walleij@linaro.org>
References: <1472723089-25113-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

The RX/TX buffers are gone so drop the lock (it should have been
in the transport struct anyway).

Tested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebase on the rest of the series.
---
 drivers/iio/accel/kxsd9.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index c065c6e09fa4..dc0bea7cbf4f 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -41,13 +41,10 @@
 
 /**
  * struct kxsd9_state - device related storage
- * @transport:	transport for the KXSD9
- * @buf_lock:	protect the rx and tx buffers.
- * @us:		spi device
- **/
+ * @map: regmap to the device
+ */
 struct kxsd9_state {
 	struct regmap *map;
-	struct mutex buf_lock;
 };
 
 #define KXSD9_SCALE_2G "0.011978"
@@ -73,7 +70,6 @@ static int kxsd9_write_scale(struct iio_dev *indio_dev, int micro)
 	if (!foundit)
 		return -EINVAL;
 
-	mutex_lock(&st->buf_lock);
 	ret = regmap_read(st->map,
 			  KXSD9_REG_CTRL_C,
 			  &val);
@@ -83,7 +79,6 @@ static int kxsd9_write_scale(struct iio_dev *indio_dev, int micro)
 			   KXSD9_REG_CTRL_C,
 			   (val & ~KXSD9_FS_MASK) | i);
 error_ret:
-	mutex_unlock(&st->buf_lock);
 	return ret;
 }
 
@@ -93,15 +88,11 @@ static int kxsd9_read(struct iio_dev *indio_dev, u8 address)
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
@@ -220,7 +211,6 @@ int kxsd9_common_probe(struct device *parent,
 	st = iio_priv(indio_dev);
 	st->map = map;
 
-	mutex_init(&st->buf_lock);
 	indio_dev->channels = kxsd9_channels;
 	indio_dev->num_channels = ARRAY_SIZE(kxsd9_channels);
 	indio_dev->name = name;
-- 
2.7.4
