Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33712 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938709AbcIXGEM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2016 02:04:12 -0400
Received: by mail-pf0-f193.google.com with SMTP id q2so6166726pfj.0
        for <linux-iio@vger.kernel.org>; Fri, 23 Sep 2016 23:04:12 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH v6 1/2] iio: inkern: add iio_read_channel_offset helper
Date: Fri, 23 Sep 2016 23:04:07 -0700
Message-Id: <1474697048-22355-2-git-send-email-matt@ranostay.consulting>
In-Reply-To: <1474697048-22355-1-git-send-email-matt@ranostay.consulting>
References: <1474697048-22355-1-git-send-email-matt@ranostay.consulting>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Allow access to underlying channel IIO_CHAN_INFO_OFFSET from a consumer.

Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
---
 drivers/iio/inkern.c         | 39 ++++++++++++++++++++++++++-------------
 include/linux/iio/consumer.h | 13 +++++++++++++
 2 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index c4757e6367e7..29df11572858 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -658,6 +658,31 @@ int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
 }
 EXPORT_SYMBOL_GPL(iio_convert_raw_to_processed);
 
+static int iio_read_channel_attribute(struct iio_channel *chan,
+				      int *val, int *val2,
+				      enum iio_chan_info_enum attribute)
+{
+	int ret;
+
+	mutex_lock(&chan->indio_dev->info_exist_lock);
+	if (chan->indio_dev->info == NULL) {
+		ret = -ENODEV;
+		goto err_unlock;
+	}
+
+	ret = iio_channel_read(chan, val, val2, attribute);
+err_unlock:
+	mutex_unlock(&chan->indio_dev->info_exist_lock);
+
+	return ret;
+}
+
+int iio_read_channel_offset(struct iio_channel *chan, int *val, int *val2)
+{
+	return iio_read_channel_attribute(chan, val, val2, IIO_CHAN_INFO_OFFSET);
+}
+EXPORT_SYMBOL_GPL(iio_read_channel_offset);
+
 int iio_read_channel_processed(struct iio_channel *chan, int *val)
 {
 	int ret;
@@ -687,19 +712,7 @@ EXPORT_SYMBOL_GPL(iio_read_channel_processed);
 
 int iio_read_channel_scale(struct iio_channel *chan, int *val, int *val2)
 {
-	int ret;
-
-	mutex_lock(&chan->indio_dev->info_exist_lock);
-	if (chan->indio_dev->info == NULL) {
-		ret = -ENODEV;
-		goto err_unlock;
-	}
-
-	ret = iio_channel_read(chan, val, val2, IIO_CHAN_INFO_SCALE);
-err_unlock:
-	mutex_unlock(&chan->indio_dev->info_exist_lock);
-
-	return ret;
+	return iio_read_channel_attribute(chan, val, val2, IIO_CHAN_INFO_SCALE);
 }
 EXPORT_SYMBOL_GPL(iio_read_channel_scale);
 
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 9edccfba1ffb..638157234357 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -236,6 +236,19 @@ int iio_get_channel_type(struct iio_channel *channel,
 			 enum iio_chan_type *type);
 
 /**
+ * iio_read_channel_offset() - read the offset value for a channel
+ * @chan:		The channel being queried.
+ * @val:		First part of value read back.
+ * @val2:		Second part of value read back.
+ *
+ * Note returns a description of what is in val and val2, such
+ * as IIO_VAL_INT_PLUS_MICRO telling us we have a value of val
+ * + val2/1e6
+ */
+int iio_read_channel_offset(struct iio_channel *chan, int *val,
+			   int *val2);
+
+/**
  * iio_read_channel_scale() - read the scale value for a channel
  * @chan:		The channel being queried.
  * @val:		First part of value read back.
-- 
2.7.4

