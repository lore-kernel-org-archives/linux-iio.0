Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35390 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756517AbcJHQjd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Oct 2016 12:39:33 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 05/18] staging:iio:accel:sca3000 Drop custom ABI for watersheds.
Date: Sat,  8 Oct 2016 17:39:05 +0100
Message-Id: <20161008163918.18758-6-jic23@kernel.org>
In-Reply-To: <20161008163918.18758-1-jic23@kernel.org>
References: <20161008163918.18758-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

For now we support only the 50% watershed interrupt and start and stop it
as part of the buffer bring up.  The 75% case may come back in future.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/sca3000.c | 111 +++++++++++++-----------------------
 1 file changed, 41 insertions(+), 70 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000.c b/drivers/staging/iio/accel/sca3000.c
index 8af7d83e658d..173e9a69d44f 100644
--- a/drivers/staging/iio/accel/sca3000.c
+++ b/drivers/staging/iio/accel/sca3000.c
@@ -1309,73 +1309,6 @@ static size_t sca3000_ring_buf_data_available(struct iio_buffer *r)
 	return r->stufftoread ? r->watermark : 0;
 }
 
-/**
- * sca3000_query_ring_int() is the hardware ring status interrupt enabled
- **/
-static ssize_t sca3000_query_ring_int(struct device *dev,
-				      struct device_attribute *attr,
-				      char *buf)
-{
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int ret, val;
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct sca3000_state *st = iio_priv(indio_dev);
-
-	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_INT_MASK, 1);
-	val = st->rx[0];
-	mutex_unlock(&st->lock);
-	if (ret)
-		return ret;
-
-	return sprintf(buf, "%d\n", !!(val & this_attr->address));
-}
-
-/**
- * sca3000_set_ring_int() set state of ring status interrupt
- **/
-static ssize_t sca3000_set_ring_int(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf,
-				    size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct sca3000_state *st = iio_priv(indio_dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	u8 val;
-	int ret;
-
-	mutex_lock(&st->lock);
-	ret = kstrtou8(buf, 10, &val);
-	if (ret)
-		goto error_ret;
-	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_INT_MASK, 1);
-	if (ret)
-		goto error_ret;
-	if (val)
-		ret = sca3000_write_reg(st,
-					SCA3000_REG_ADDR_INT_MASK,
-					st->rx[0] | this_attr->address);
-	else
-		ret = sca3000_write_reg(st,
-					SCA3000_REG_ADDR_INT_MASK,
-					st->rx[0] & ~this_attr->address);
-error_ret:
-	mutex_unlock(&st->lock);
-
-	return ret ? ret : len;
-}
-
-static IIO_DEVICE_ATTR(50_percent, S_IRUGO | S_IWUSR,
-		       sca3000_query_ring_int,
-		       sca3000_set_ring_int,
-		       SCA3000_INT_MASK_RING_HALF);
-
-static IIO_DEVICE_ATTR(75_percent, S_IRUGO | S_IWUSR,
-		       sca3000_query_ring_int,
-		       sca3000_set_ring_int,
-		       SCA3000_INT_MASK_RING_THREE_QUARTER);
-
 static ssize_t sca3000_show_buffer_scale(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -1399,8 +1332,6 @@ static IIO_DEVICE_ATTR(in_accel_scale,
  * is available via direct reading from registers.
  */
 static const struct attribute *sca3000_ring_attributes[] = {
-	&iio_dev_attr_50_percent.dev_attr.attr,
-	&iio_dev_attr_75_percent.dev_attr.attr,
 	&iio_dev_attr_in_accel_scale.dev_attr.attr,
 	NULL,
 };
@@ -1491,6 +1422,9 @@ error_ret:
  **/
 static int sca3000_hw_ring_preenable(struct iio_dev *indio_dev)
 {
+	int ret;
+	struct sca3000_state *st = iio_priv(indio_dev);
+
 	/*
 	 * Set stuff to read to indicate no data present.
 	 * Need for cases where the interrupt had fired at the
@@ -1504,12 +1438,49 @@ static int sca3000_hw_ring_preenable(struct iio_dev *indio_dev)
 	 */
 	indio_dev->buffer->bytes_per_datum = 6;
 
+	mutex_lock(&st->lock);
+
+	/* Enable the 50% full interrupt */
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_INT_MASK, 1);
+	if (ret)
+		goto error_unlock;
+	ret = sca3000_write_reg(st,
+				SCA3000_REG_ADDR_INT_MASK,
+				st->rx[0] | SCA3000_INT_MASK_RING_HALF);
+	if (ret)
+		goto error_unlock;
+
+	mutex_unlock(&st->lock);
+
 	return __sca3000_hw_ring_state_set(indio_dev, 1);
+
+error_unlock:
+	mutex_unlock(&st->lock);
+
+	return ret;
 }
 
 static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
 {
-	return __sca3000_hw_ring_state_set(indio_dev, 0);
+	int ret;
+	struct sca3000_state *st = iio_priv(indio_dev);
+
+	ret = __sca3000_hw_ring_state_set(indio_dev, 0);
+	if (ret)
+		return ret;
+
+	/* Disable the 50% full interrupt */
+	mutex_lock(&st->lock);
+
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_INT_MASK, 1);
+	if (ret)
+		goto unlock;
+	ret = sca3000_write_reg(st,
+				SCA3000_REG_ADDR_INT_MASK,
+				st->rx[0] & ~SCA3000_INT_MASK_RING_HALF);
+unlock:
+	mutex_unlock(&st->lock);
+	return ret;
 }
 
 static const struct iio_buffer_setup_ops sca3000_ring_setup_ops = {
-- 
2.10.0

