Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Milo Kim <Milo.Kim@ti.com>,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [RFC 2/4] iio:inkern: Add function to read the processed value
Date: Thu, 16 Aug 2012 11:18:43 +0200
Message-Id: <1345108725-22120-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1345108725-22120-1-git-send-email-lars@metafoo.de>
References: <1345108725-22120-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Add a function to read a processed value from a channel. The function will first
attempt to read the IIO_CHAN_INFO_PROCESSED attribute. If that fails it will
read the IIO_CHAN_INFO_RAW attribute and convert the result from a raw value to
a processed value.

The patch also introduces a function to convert raw value to a processed value
and exports it, in case a user needs or wants to do the conversion by itself.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

---
Documentation is still missing.
---
 drivers/iio/inkern.c         |  118 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/iio/consumer.h |    4 ++
 2 files changed, 118 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index b5afc2f..9bb3391 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -248,6 +248,118 @@ err_unlock:
 }
 EXPORT_SYMBOL_GPL(iio_read_channel_raw);
 
+static int iio_read_channel_scale_unlocked(struct iio_channel *chan, int *val,
+	int *val2)
+{
+	return chan->indio_dev->info->read_raw(chan->indio_dev,
+					      chan->channel,
+					      val, val2,
+					      IIO_CHAN_INFO_SCALE);
+}
+
+static int iio_read_channel_offset_unlocked(struct iio_channel *chan, int *val)
+{
+	int val2;
+
+	return chan->indio_dev->info->read_raw(chan->indio_dev,
+					      chan->channel,
+					      val, &val2,
+					      IIO_CHAN_INFO_OFFSET);
+}
+
+/* It may make sense to a add a extra scale attribute here to avoid precession
+ * loss if the user wants a more fine grained value than the IIO default, e.g.
+ * micro instead of milli volt. */
+static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
+	int raw, int *processed)
+{
+	int scale_type, scale_val, scale_val2, offset;
+	s64 raw64 = raw;
+	int ret;
+
+
+	ret = iio_read_channel_offset_unlocked(chan, &offset);
+	if (ret == 0)
+		raw64 += offset;
+
+	scale_type = iio_read_channel_scale_unlocked(chan, &scale_val, &scale_val2);
+	if (scale_type < 0)
+		return scale_type;
+
+	switch (scale_type) {
+	case IIO_VAL_INT:
+		*processed = raw * scale_val;
+		break;
+	case IIO_VAL_INT_PLUS_MICRO:
+		if (scale_val2 < 0)
+			*processed = -raw * scale_val;
+		else
+			*processed = raw * scale_val;
+		*processed += div_s64(raw * (s64)scale_val2, 1000000LL);
+		break;
+	case IIO_VAL_INT_PLUS_NANO:
+		if (scale_val2 < 0)
+			*processed = -raw * scale_val;
+		else
+			*processed = raw * scale_val;
+		*processed += div_s64(raw * (s64)scale_val2, 1000000000LL);
+		break;
+	case IIO_VAL_FRACTIONAL:
+		*processed = div_s64(raw * (s64)scale_val, scale_val2);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+
+int iio_convert_raw_to_processed(struct iio_channel *chan, int raw, int *processed)
+{
+	int ret;
+
+	mutex_lock(&chan->indio_dev->info_exist_lock);
+	if (chan->indio_dev->info == NULL) {
+		ret = -ENODEV;
+		goto err_unlock;
+	}
+
+	ret = iio_convert_raw_to_processed_unlocked(chan, raw, processed);
+
+err_unlock:
+	mutex_unlock(&chan->indio_dev->info_exist_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iio_convert_raw_to_processed);
+
+int iio_read_channel_processed(struct iio_channel *chan, int *val)
+{
+	int val2, ret;
+
+	mutex_lock(&chan->indio_dev->info_exist_lock);
+	if (chan->indio_dev->info == NULL) {
+		ret = -ENODEV;
+		goto err_unlock;
+	}
+
+	ret = chan->indio_dev->info->read_raw(chan->indio_dev, chan->channel,
+					      val, &val2, IIO_CHAN_INFO_PROCESSED);
+	if (ret < 0) {
+		ret = chan->indio_dev->info->read_raw(chan->indio_dev, chan->channel,
+					      val, &val2, IIO_CHAN_INFO_RAW);
+		if (ret < 0)
+			goto err_unlock;
+		ret = iio_convert_raw_to_processed_unlocked(chan, *val, val);
+	}
+err_unlock:
+	mutex_unlock(&chan->indio_dev->info_exist_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iio_read_channel_processed);
+
 int iio_read_channel_scale(struct iio_channel *chan, int *val, int *val2)
 {
 	int ret;
@@ -258,10 +370,8 @@ int iio_read_channel_scale(struct iio_channel *chan, int *val, int *val2)
 		goto err_unlock;
 	}
 
-	ret = chan->indio_dev->info->read_raw(chan->indio_dev,
-					      chan->channel,
-					      val, val2,
-					      IIO_CHAN_INFO_SCALE);
+	ret = iio_read_channel_scale_unlocked(chan, val, val2);
+
 err_unlock:
 	mutex_unlock(&chan->indio_dev->info_exist_lock);
 
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index e2657e6..ef99ceb 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -93,4 +93,8 @@ int iio_get_channel_type(struct iio_channel *channel,
 int iio_read_channel_scale(struct iio_channel *chan, int *val,
 			   int *val2);
 
+int iio_read_channel_processed(struct iio_channel *chan, int *val);
+int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
+	int *processed);
+
 #endif
-- 
1.7.10.4
