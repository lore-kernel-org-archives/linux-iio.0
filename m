Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from anchovy3.45ru.net.au ([203.30.46.155]:41183 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751218AbdJECpF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Oct 2017 22:45:05 -0400
From: Phil Reid <preid@electromag.com.au>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, preid@electromag.com.au,
        linux-iio@vger.kernel.org
Subject: [PATCH 1/1] iio: inkern: add helper to enable a channel
Date: Thu,  5 Oct 2017 10:37:46 +0800
Message-Id: <1507171066-83517-1-git-send-email-preid@electromag.com.au>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is done by calling a generic write attribute helper similar
to the existing read attribute helper. Update write raw helper
to use new write attribute function.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/iio/inkern.c         | 17 +++++++++++++++--
 include/linux/iio/consumer.h |  9 +++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 069defc..51c5c967 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -850,7 +850,9 @@ static int iio_channel_write(struct iio_channel *chan, int val, int val2,
 						chan->channel, val, val2, info);
 }
 
-int iio_write_channel_raw(struct iio_channel *chan, int val)
+static int iio_write_channel_attribute(struct iio_channel *chan,
+				       int val, int val2,
+				       enum iio_chan_info_enum attribute)
 {
 	int ret;
 
@@ -860,14 +862,25 @@ int iio_write_channel_raw(struct iio_channel *chan, int val)
 		goto err_unlock;
 	}
 
-	ret = iio_channel_write(chan, val, 0, IIO_CHAN_INFO_RAW);
+	ret = iio_channel_write(chan, val, val2, attribute);
 err_unlock:
 	mutex_unlock(&chan->indio_dev->info_exist_lock);
 
 	return ret;
 }
+
+int iio_write_channel_raw(struct iio_channel *chan, int val)
+{
+	return iio_write_channel_attribute(chan, val, 0, IIO_CHAN_INFO_RAW);
+}
 EXPORT_SYMBOL_GPL(iio_write_channel_raw);
 
+int iio_write_channel_enable(struct iio_channel *chan, int val)
+{
+	return iio_write_channel_attribute(chan, val, 0, IIO_CHAN_INFO_ENABLE);
+}
+EXPORT_SYMBOL_GPL(iio_write_channel_enable);
+
 unsigned int iio_get_channel_ext_info_count(struct iio_channel *chan)
 {
 	const struct iio_chan_spec_ext_info *ext_info;
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 5e347a9..4a5a90d 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -226,6 +226,15 @@ int iio_read_channel_raw(struct iio_channel *chan,
 int iio_write_channel_raw(struct iio_channel *chan, int val);
 
 /**
+ * iio_write_channel_enable() - enable a given channel
+ * @chan:		The channel being queried.
+ * @val:		Value being written.
+ *
+ * Enable / disable the channel.
+ */
+int iio_write_channel_enable(struct iio_channel *chan, int val);
+
+/**
  * iio_read_max_channel_raw() - read maximum available raw value from a given
  *				channel, i.e. the maximum possible value.
  * @chan:		The channel being queried.
-- 
1.8.3.1

