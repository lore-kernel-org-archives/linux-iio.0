Return-Path: <dbaryshkov@gmail.com>
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH] iio: inkern: add iio_write_channel_raw
Date: Thu, 27 Nov 2014 01:42:45 +0300
Message-Id: <1417041765-12782-1-git-send-email-dbaryshkov@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Introduce API for easy in-kernel setting of DAC values.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/iio/inkern.c         | 29 +++++++++++++++++++++++++++++
 include/linux/iio/consumer.h | 11 +++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index f084610..5b03e69 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -608,3 +608,32 @@ err_unlock:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iio_get_channel_type);
+
+static int iio_channel_write(struct iio_channel *chan, int val, int val2,
+	enum iio_chan_info_enum info)
+{
+	int ret;
+
+	ret = chan->indio_dev->info->write_raw(chan->indio_dev,
+			chan->channel, val, val2, info);
+
+	return ret;
+}
+
+int iio_write_channel_raw(struct iio_channel *chan, int val)
+{
+	int ret;
+
+	mutex_lock(&chan->indio_dev->info_exist_lock);
+	if (chan->indio_dev->info == NULL) {
+		ret = -ENODEV;
+		goto err_unlock;
+	}
+
+	ret = iio_channel_write(chan, val, 0, IIO_CHAN_INFO_RAW);
+err_unlock:
+	mutex_unlock(&chan->indio_dev->info_exist_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iio_write_channel_raw);
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 651f9a0..06f4688 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -151,6 +151,17 @@ int iio_read_channel_average_raw(struct iio_channel *chan, int *val);
 int iio_read_channel_processed(struct iio_channel *chan, int *val);
 
 /**
+ * iio_write_channel_raw() - write to a given channel
+ * @chan:		The channel being queried.
+ * @val:		Value being written.
+ *
+ * Note raw writes to iio channels are in dac counts and hence
+ * scale will need to be applied if standard units required.
+ */
+int iio_write_channel_raw(struct iio_channel *chan,
+			 int val);
+
+/**
  * iio_get_channel_type() - get the type of a channel
  * @channel:		The channel being queried.
  * @type:		The type of the channel.
-- 
2.1.3
