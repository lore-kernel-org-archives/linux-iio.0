Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 3/5] iio: add info_mask_[shared_by_dir/shared_by_all]
Date: Sat, 17 Aug 2013 15:39:02 +0100
Message-Id: <1376750344-12817-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1376750344-12817-1-git-send-email-jic23@kernel.org>
References: <1376750344-12817-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

These two additional info_mask bitmaps should allow all 'standard'
numeric attributes to be handled using the read_raw and write_raw
callbacks.  Whilst this should reduce code, the more important element
is that this makes these values easily accessible to in kernel users
of IIO devices.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/iio_core.h          |  4 +++-
 drivers/iio/industrialio-core.c | 31 +++++++++++++++++++++++++++++++
 include/linux/iio/iio.h         |  9 ++++++++-
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 75470ef..8d94d79 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -21,7 +21,9 @@ struct iio_dev;
 extern struct device_type iio_device_type;
 
 enum iio_shared_by { __IIO_SEPARATE,
-		     __IIO_SHARED_BY_TYPE };
+		     __IIO_SHARED_BY_TYPE,
+		     __IIO_SHARED_BY_DIR,
+		     __IIO_SHARED_BY_ALL };
 
 int __iio_add_chan_devattr(const char *postfix,
 			   struct iio_chan_spec const *chan,
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 720cea1..5459848 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -550,6 +550,14 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 
 	if (chan->differential) { /* Differential can not have modifier */
 		switch (shared_by) {
+		case __IIO_SHARED_BY_ALL:
+			name_format = kasprintf(GFP_KERNEL, "%s", full_postfix);
+			break;
+		case __IIO_SHARED_BY_DIR:
+			name_format = kasprintf(GFP_KERNEL, "%s_%s",
+						iio_direction[chan->output],
+						full_postfix);
+			break;
 		case __IIO_SHARED_BY_TYPE:
 			name_format
 				= kasprintf(GFP_KERNEL, "%s_%s-%s_%s",
@@ -577,6 +585,14 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 		}
 	} else { /* Single ended */
 		switch (shared_by) {
+		case __IIO_SHARED_BY_ALL:
+			name_format = kasprintf(GFP_KERNEL, "%s", full_postfix);
+			break;
+		case __IIO_SHARED_BY_DIR:
+			name_format = kasprintf(GFP_KERNEL, "%s_%s",
+						iio_direction[chan->output],
+						full_postfix);
+			break;
 		case __IIO_SHARED_BY_TYPE:
 			name_format
 				= kasprintf(GFP_KERNEL, "%s_%s_%s",
@@ -734,6 +750,21 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 	if (ret < 0)
 		return ret;
 	attrcount += ret;
+
+	ret = iio_device_add_info_mask_type(indio_dev, chan,
+					    __IIO_SHARED_BY_DIR,
+					    &chan->info_mask_shared_by_dir);
+	if (ret < 0)
+		return ret;
+	attrcount += ret;
+
+	ret = iio_device_add_info_mask_type(indio_dev, chan,
+					    __IIO_SHARED_BY_ALL,
+					    &chan->info_mask_shared_by_all);
+	if (ret < 0)
+		return ret;
+	attrcount += ret;
+
 	if (chan->ext_info) {
 		unsigned int i = 0;
 		for (ext_info = chan->ext_info; ext_info->name; ext_info++) {
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index dbaa55b..7b8d2ff 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -150,6 +150,10 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
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
@@ -186,6 +190,8 @@ struct iio_chan_spec {
 	} scan_type;
 	long			info_mask_separate;
 	long			info_mask_shared_by_type;
+	long			info_mask_shared_by_dir;
+	long			info_mask_shared_by_all;
 	long			event_mask;
 	const struct iio_chan_spec_ext_info *ext_info;
 	const char		*extend_name;
@@ -209,7 +215,8 @@ static inline bool iio_channel_has_info(const struct iio_chan_spec *chan,
 	enum iio_chan_info_enum type)
 {
 	return (chan->info_mask_separate & BIT(type)) |
-	       (chan->info_mask_shared_by_type & BIT(type));
+		(chan->info_mask_shared_by_type & BIT(type)) |
+		(chan->info_mask_shared_by_all & BIT(type));
 }
 
 #define IIO_ST(si, rb, sb, sh)						\
-- 
1.8.3.4
