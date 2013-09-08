Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37537 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305Ab3IHM5T (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Sep 2013 08:57:19 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 3/5] iio: add info_mask_[shared_by_dir/shared_by_all]
Date: Sun,  8 Sep 2013 14:57:19 +0100
Message-Id: <1378648641-28280-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1378648641-28280-1-git-send-email-jic23@kernel.org>
References: <1378648641-28280-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These two additional info_mask bitmaps should allow all 'standard'
numeric attributes to be handled using the read_raw and write_raw
callbacks.  Whilst this should reduce code, the more important element
is that this makes these values easily accessible to in kernel users
of IIO devices.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/industrialio-core.c | 30 ++++++++++++++++++++++++++++++
 include/linux/iio/iio.h         | 14 ++++++++++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index d713b20..e3a5d12 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -550,6 +550,14 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 
 	if (chan->differential) { /* Differential can not have modifier */
 		switch (shared_by) {
+		case IIO_SHARED_BY_ALL:
+			name_format = kasprintf(GFP_KERNEL, "%s", full_postfix);
+			break;
+		case IIO_SHARED_BY_DIR:
+			name_format = kasprintf(GFP_KERNEL, "%s_%s",
+						iio_direction[chan->output],
+						full_postfix);
+			break;
 		case IIO_SHARED_BY_TYPE:
 			name_format
 				= kasprintf(GFP_KERNEL, "%s_%s-%s_%s",
@@ -577,6 +585,14 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 		}
 	} else { /* Single ended */
 		switch (shared_by) {
+		case IIO_SHARED_BY_ALL:
+			name_format = kasprintf(GFP_KERNEL, "%s", full_postfix);
+			break;
+		case IIO_SHARED_BY_DIR:
+			name_format = kasprintf(GFP_KERNEL, "%s_%s",
+						iio_direction[chan->output],
+						full_postfix);
+			break;
 		case IIO_SHARED_BY_TYPE:
 			name_format
 				= kasprintf(GFP_KERNEL, "%s_%s_%s",
@@ -735,6 +751,20 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 		return ret;
 	attrcount += ret;
 
+	ret = iio_device_add_info_mask_type(indio_dev, chan,
+					    IIO_SHARED_BY_DIR,
+					    &chan->info_mask_shared_by_dir);
+	if (ret < 0)
+		return ret;
+	attrcount += ret;
+
+	ret = iio_device_add_info_mask_type(indio_dev, chan,
+					    IIO_SHARED_BY_ALL,
+					    &chan->info_mask_shared_by_all);
+	if (ret < 0)
+		return ret;
+	attrcount += ret;
+
 	if (chan->ext_info) {
 		unsigned int i = 0;
 		for (ext_info = chan->ext_info; ext_info->name; ext_info++) {
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 8d769fe..fa0042f 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -40,7 +40,9 @@ enum iio_chan_info_enum {
 
 enum iio_shared_by {
 	IIO_SEPARATE,
-	IIO_SHARED_BY_TYPE
+	IIO_SHARED_BY_TYPE,
+	IIO_SHARED_BY_DIR,
+	IIO_SHARED_BY_ALL
 };
 
 enum iio_endian {
@@ -155,6 +157,10 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
  *			this channel.
  * @info_mask_shared_by_type: What information is to be exported that is shared
  *			by all channels of the same type.
+ * @info_mask_shared_by_dir: What information is to be exported that is shared
+ *			by all channels of the same direction.
+ * @info_mask_shared_by_all: What information is to be exported that is shared
+ *			by all channels.
  * @event_mask:		What events can this channel produce.
  * @ext_info:		Array of extended info attributes for this channel.
  *			The array is NULL terminated, the last element should
@@ -191,6 +197,8 @@ struct iio_chan_spec {
 	} scan_type;
 	long			info_mask_separate;
 	long			info_mask_shared_by_type;
+	long			info_mask_shared_by_dir;
+	long			info_mask_shared_by_all;
 	long			event_mask;
 	const struct iio_chan_spec_ext_info *ext_info;
 	const char		*extend_name;
@@ -214,7 +222,9 @@ static inline bool iio_channel_has_info(const struct iio_chan_spec *chan,
 	enum iio_chan_info_enum type)
 {
 	return (chan->info_mask_separate & BIT(type)) |
-	       (chan->info_mask_shared_by_type & BIT(type));
+		(chan->info_mask_shared_by_type & BIT(type)) |
+		(chan->info_mask_shared_by_dir & BIT(type)) |
+		(chan->info_mask_shared_by_all & BIT(type));
 }
 
 #define IIO_ST(si, rb, sb, sh)						\
-- 
1.8.4

