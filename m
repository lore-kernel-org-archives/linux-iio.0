Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35709 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544Ab3CBQRd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:17:33 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 01/67] iio: Add broken out info_mask fields for shared_by_type and separate
Date: Sat,  2 Mar 2013 16:16:18 +0000
Message-Id: <1362241044-3534-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This simplifies the code, removes an extensive layer of 'helper' macros
and gives us twice as much room to play with in these masks before we
have any need to be clever.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/industrialio-core.c | 30 ++++++++++++++++++++++++++++++
 include/linux/iio/iio.h         | 10 +++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 8848f16..6f1a998 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -708,6 +708,36 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 			goto error_ret;
 		attrcount++;
 	}
+	for_each_set_bit(i, &chan->info_mask_separate, sizeof(long)*8) {
+		ret = __iio_add_chan_devattr(iio_chan_info_postfix[i],
+					     chan,
+					     &iio_read_channel_info,
+					     &iio_write_channel_info,
+					     i,
+					     0,
+					     &indio_dev->dev,
+					     &indio_dev->channel_attr_list);
+		if (ret < 0)
+			goto error_ret;
+		attrcount++;
+	}
+	for_each_set_bit(i, &chan->info_mask_shared_by_type, sizeof(long)*8) {
+		ret = __iio_add_chan_devattr(iio_chan_info_postfix[i],
+					     chan,
+					     &iio_read_channel_info,
+					     &iio_write_channel_info,
+					     i,
+					     1,
+					     &indio_dev->dev,
+					     &indio_dev->channel_attr_list);
+		if (ret == -EBUSY) {
+			ret = 0;
+			continue;
+		} else if (ret < 0) {
+			goto error_ret;
+		}
+		attrcount++;
+	}
 
 	if (chan->ext_info) {
 		unsigned int i = 0;
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index da8c776..7697650 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -218,6 +218,10 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
  *			endianness:	little or big endian
  * @info_mask:		What information is to be exported about this channel.
  *			This includes calibbias, scale etc.
+ * @info_mask_separate: What information is to be exported that is specific to
+ *			this channel.
+ * @info_mask_shared_by_type: What information is to be exported that is shared
+*			by all channels of the same type.
  * @event_mask:		What events can this channel produce.
  * @ext_info:		Array of extended info attributes for this channel.
  *			The array is NULL terminated, the last element should
@@ -253,6 +257,8 @@ struct iio_chan_spec {
 		enum iio_endian endianness;
 	} scan_type;
 	long			info_mask;
+	long			info_mask_separate;
+	long			info_mask_shared_by_type;
 	long			event_mask;
 	const struct iio_chan_spec_ext_info *ext_info;
 	const char		*extend_name;
@@ -275,7 +281,9 @@ struct iio_chan_spec {
 static inline bool iio_channel_has_info(const struct iio_chan_spec *chan,
 	enum iio_chan_info_enum type)
 {
-	return chan->info_mask & IIO_CHAN_INFO_BITS(type);
+	return (chan->info_mask & IIO_CHAN_INFO_BITS(type)) |
+	       (chan->info_mask_separate & type) |
+	       (chan->info_mask_shared_by_type & type);
 }
 
 #define IIO_ST(si, rb, sb, sh)						\
-- 
1.8.1.4

