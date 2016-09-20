Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36183 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753149AbcITCxo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Sep 2016 22:53:44 -0400
Received: by mail-pa0-f67.google.com with SMTP id my20so223636pab.3
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2016 19:53:44 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH v5 1/2] iio: inkern: add iio_read_channel_offset helper
Date: Mon, 19 Sep 2016 19:53:37 -0700
Message-Id: <1474340018-26647-2-git-send-email-matt@ranostay.consulting>
In-Reply-To: <1474340018-26647-1-git-send-email-matt@ranostay.consulting>
References: <1474340018-26647-1-git-send-email-matt@ranostay.consulting>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Allow access to underlying channel IIO_CHAN_INFO_OFFSET from a consumer

Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
---
 drivers/iio/inkern.c         | 18 ++++++++++++++++++
 include/linux/iio/consumer.h | 13 +++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index c4757e6367e7..d90af439b0a3 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -658,6 +658,24 @@ err_unlock:
 }
 EXPORT_SYMBOL_GPL(iio_convert_raw_to_processed);
 
+int iio_read_channel_offset(struct iio_channel *chan, int *val, int *val2)
+{
+	int ret;
+
+	mutex_lock(&chan->indio_dev->info_exist_lock);
+	if (chan->indio_dev->info == NULL) {
+		ret = -ENODEV;
+		goto err_unlock;
+	}
+
+	ret = iio_channel_read(chan, val, val2, IIO_CHAN_INFO_OFFSET);
+err_unlock:
+	mutex_unlock(&chan->indio_dev->info_exist_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iio_read_channel_offset);
+
 int iio_read_channel_processed(struct iio_channel *chan, int *val)
 {
 	int ret;
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

