Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0115.outbound.protection.outlook.com ([104.47.2.115]:63901
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756769AbcJWWkh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 23 Oct 2016 18:40:37 -0400
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 2/8] iio: inkern: add helpers to query available values from channels
Date: Mon, 24 Oct 2016 00:39:35 +0200
Message-ID: <1477262381-7800-3-git-send-email-peda@axentia.se>
In-Reply-To: <1477262381-7800-1-git-send-email-peda@axentia.se>
References: <1477262381-7800-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Specifically a helper for reading the available maximum raw value of a
channel and a helper for forwarding read_avail requests for raw values
from one iio driver to an iio channel that is consumed.

These rather specific helpers are in turn built with generic helpers
making it easy to build more helpers for available values as needed.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/inkern.c         | 97 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iio/consumer.h | 29 +++++++++++++
 include/linux/iio/iio.h      | 17 ++++++++
 3 files changed, 143 insertions(+)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index c4757e6367e7..74808f8a187a 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -703,6 +703,103 @@ int iio_read_channel_scale(struct iio_channel *chan, int *val, int *val2)
 }
 EXPORT_SYMBOL_GPL(iio_read_channel_scale);
 
+static int iio_channel_read_avail(struct iio_channel *chan,
+				  const int **vals, int *type, int *length,
+				  enum iio_chan_info_enum info)
+{
+	if (!iio_channel_has_available(chan->channel, info))
+		return -EINVAL;
+
+	return chan->indio_dev->info->read_avail(chan->indio_dev, chan->channel,
+						 vals, type, length, info);
+}
+
+int iio_read_avail_channel_raw(struct iio_channel *chan,
+			       const int **vals, int *type, int *length)
+{
+	int ret;
+
+	mutex_lock(&chan->indio_dev->info_exist_lock);
+	if (!chan->indio_dev->info) {
+		ret = -ENODEV;
+		goto err_unlock;
+	}
+
+	ret = iio_channel_read_avail(chan,
+				     vals, type, length, IIO_CHAN_INFO_RAW);
+err_unlock:
+	mutex_unlock(&chan->indio_dev->info_exist_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iio_read_avail_channel_raw);
+
+static int iio_channel_read_max(struct iio_channel *chan,
+				int *val, int *val2, int *type,
+				enum iio_chan_info_enum info)
+{
+	int unused;
+	const int *vals;
+	int length;
+	int ret;
+
+	if (!val2)
+		val2 = &unused;
+
+	ret = iio_channel_read_avail(chan, &vals, type, &length, info);
+	switch (ret) {
+	case IIO_AVAIL_RANGE:
+		switch (*type) {
+		case IIO_VAL_INT:
+			*val = vals[2];
+			break;
+		default:
+			*val = vals[4];
+			*val2 = vals[5];
+		}
+		return 0;
+
+	case IIO_AVAIL_LIST:
+		if (length <= 0)
+			return -EINVAL;
+		switch (*type) {
+		case IIO_VAL_INT:
+			*val = vals[--length];
+			while (length) {
+				if (vals[--length] > *val)
+					*val = vals[length];
+			}
+			break;
+		default:
+			/* FIXME: learn about max for other iio values */
+			return -EINVAL;
+		}
+		return 0;
+
+	default:
+		return ret;
+	}
+}
+
+int iio_read_max_channel_raw(struct iio_channel *chan, int *val)
+{
+	int ret;
+	int type;
+
+	mutex_lock(&chan->indio_dev->info_exist_lock);
+	if (!chan->indio_dev->info) {
+		ret = -ENODEV;
+		goto err_unlock;
+	}
+
+	ret = iio_channel_read_max(chan, val, NULL, &type, IIO_CHAN_INFO_RAW);
+err_unlock:
+	mutex_unlock(&chan->indio_dev->info_exist_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iio_read_max_channel_raw);
+
 int iio_get_channel_type(struct iio_channel *chan, enum iio_chan_type *type)
 {
 	int ret = 0;
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 9edccfba1ffb..baab5e45734f 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -226,6 +226,35 @@ int iio_read_channel_processed(struct iio_channel *chan, int *val);
 int iio_write_channel_raw(struct iio_channel *chan, int val);
 
 /**
+ * iio_read_max_channel_raw() - read maximum available raw value from a given
+ *				channel
+ * @chan:		The channel being queried.
+ * @val:		Value read back.
+ *
+ * Note raw reads from iio channels are in adc counts and hence
+ * scale will need to be applied if standard units are required.
+ */
+int iio_read_max_channel_raw(struct iio_channel *chan, int *val);
+
+/**
+ * iio_read_avail_channel_raw() - read available raw values from a given channel
+ * @chan:		The channel being queried.
+ * @vals:		Available values read back.
+ * @type:		Type of available values in vals.
+ * @length:		Number of entries in vals.
+ *
+ * Returns an error code, IIO_AVAIL_RANGE or IIO_AVAIL_LIST.
+ *
+ * For ranges, three vals are always returned; min, step and max.
+ * For lists, all the possible values are enumerated.
+ *
+ * Note raw available values from iio channels are in adc counts and
+ * hence scale will need to be applied if standard units are required.
+ */
+int iio_read_avail_channel_raw(struct iio_channel *chan,
+			       const int **vals, int *type, int *length);
+
+/**
  * iio_get_channel_type() - get the type of a channel
  * @channel:		The channel being queried.
  * @type:		The type of the channel.
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 45b781084a4b..e565701d13ce 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -315,6 +315,23 @@ static inline bool iio_channel_has_info(const struct iio_chan_spec *chan,
 		(chan->info_mask_shared_by_all & BIT(type));
 }
 
+/**
+ * iio_channel_has_available() - Checks if a channel has an available attribute
+ * @chan: The channel to be queried
+ * @type: Type of the available attribute to be checked
+ *
+ * Returns true if the channels supports reporting available values for the
+ * given attribute type, false otherwise.
+ */
+static inline bool iio_channel_has_available(const struct iio_chan_spec *chan,
+					     enum iio_chan_info_enum type)
+{
+	return (chan->info_mask_separate_available & BIT(type)) |
+		(chan->info_mask_shared_by_type_available & BIT(type)) |
+		(chan->info_mask_shared_by_dir_available & BIT(type)) |
+		(chan->info_mask_shared_by_all_available & BIT(type));
+}
+
 #define IIO_CHAN_SOFT_TIMESTAMP(_si) {					\
 	.type = IIO_TIMESTAMP,						\
 	.channel = -1,							\
-- 
2.1.4

