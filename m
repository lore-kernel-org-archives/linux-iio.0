Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/5] iio: refactor info mask attribute creation.
Date: Sat, 17 Aug 2013 15:39:01 +0100
Message-Id: <1376750344-12817-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1376750344-12817-1-git-send-email-jic23@kernel.org>
References: <1376750344-12817-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Introduce an enum to specify whether the attribute is separate or
shared.

Factor out the bitmap handling for loop into a separate function.

Tidy up error handling and add a NULL assignment to squish a false
positive warning from GCC.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/iio_core.h            |   5 +-
 drivers/iio/industrialio-buffer.c |   2 +-
 drivers/iio/industrialio-core.c   | 148 ++++++++++++++++++++------------------
 3 files changed, 84 insertions(+), 71 deletions(-)

diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 05c1b74..75470ef 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -20,6 +20,9 @@ struct iio_dev;
 
 extern struct device_type iio_device_type;
 
+enum iio_shared_by { __IIO_SEPARATE,
+		     __IIO_SHARED_BY_TYPE };
+
 int __iio_add_chan_devattr(const char *postfix,
 			   struct iio_chan_spec const *chan,
 			   ssize_t (*func)(struct device *dev,
@@ -30,7 +33,7 @@ int __iio_add_chan_devattr(const char *postfix,
 						const char *buf,
 						size_t len),
 			   u64 mask,
-			   bool generic,
+			   enum iio_shared_by generic,
 			   struct device *dev,
 			   struct list_head *attr_list);
 
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index e73033f..69e4a45 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -214,7 +214,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 				     &iio_show_scan_index,
 				     NULL,
 				     0,
-				     0,
+				     __IIO_SEPARATE,
 				     &indio_dev->dev,
 				     &buffer->scan_el_dev_attr_list);
 	if (ret)
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 97f0297..720cea1 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -516,14 +516,15 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 						struct device_attribute *attr,
 						const char *buf,
 						size_t len),
-			   bool generic)
+			   enum iio_shared_by shared_by)
 {
-	int ret;
-	char *name_format, *full_postfix;
+	int ret = 0;
+	char *name_format = NULL;
+	char *full_postfix;
 	sysfs_attr_init(&dev_attr->attr);
 
 	/* Build up postfix of <extend_name>_<modifier>_postfix */
-	if (chan->modified && !generic) {
+	if (chan->modified && (shared_by == __IIO_SEPARATE)) {
 		if (chan->extend_name)
 			full_postfix = kasprintf(GFP_KERNEL, "%s_%s_%s",
 						 iio_modifier_names[chan
@@ -544,53 +545,62 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 						 chan->extend_name,
 						 postfix);
 	}
-	if (full_postfix == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	if (full_postfix == NULL)
+		return -ENOMEM;
 
 	if (chan->differential) { /* Differential can not have modifier */
-		if (generic)
+		switch (shared_by) {
+		case __IIO_SHARED_BY_TYPE:
 			name_format
 				= kasprintf(GFP_KERNEL, "%s_%s-%s_%s",
 					    iio_direction[chan->output],
 					    iio_chan_type_name_spec[chan->type],
 					    iio_chan_type_name_spec[chan->type],
 					    full_postfix);
-		else if (chan->indexed)
+			break;
+		case __IIO_SEPARATE:
+			if (!chan->indexed) {
+				WARN_ON("Differential channels must be indexed\n");
+				ret = -EINVAL;
+				goto error_free_full_postfix;
+			}
 			name_format
-				= kasprintf(GFP_KERNEL, "%s_%s%d-%s%d_%s",
+				= kasprintf(GFP_KERNEL,
+					    "%s_%s%d-%s%d_%s",
 					    iio_direction[chan->output],
 					    iio_chan_type_name_spec[chan->type],
 					    chan->channel,
 					    iio_chan_type_name_spec[chan->type],
 					    chan->channel2,
 					    full_postfix);
-		else {
-			WARN_ON("Differential channels must be indexed\n");
-			ret = -EINVAL;
-			goto error_free_full_postfix;
+			break;
 		}
 	} else { /* Single ended */
-		if (generic)
-			name_format
-				= kasprintf(GFP_KERNEL, "%s_%s_%s",
-					    iio_direction[chan->output],
-					    iio_chan_type_name_spec[chan->type],
-					    full_postfix);
-		else if (chan->indexed)
-			name_format
-				= kasprintf(GFP_KERNEL, "%s_%s%d_%s",
-					    iio_direction[chan->output],
-					    iio_chan_type_name_spec[chan->type],
-					    chan->channel,
-					    full_postfix);
-		else
+		switch (shared_by) {
+		case __IIO_SHARED_BY_TYPE:
 			name_format
 				= kasprintf(GFP_KERNEL, "%s_%s_%s",
 					    iio_direction[chan->output],
 					    iio_chan_type_name_spec[chan->type],
 					    full_postfix);
+			break;
+
+		case __IIO_SEPARATE:
+			if (chan->indexed)
+				name_format
+					= kasprintf(GFP_KERNEL, "%s_%s%d_%s",
+						    iio_direction[chan->output],
+						    iio_chan_type_name_spec[chan->type],
+						    chan->channel,
+						    full_postfix);
+			else
+				name_format
+					= kasprintf(GFP_KERNEL, "%s_%s_%s",
+						    iio_direction[chan->output],
+						    iio_chan_type_name_spec[chan->type],
+						    full_postfix);
+			break;
+		}
 	}
 	if (name_format == NULL) {
 		ret = -ENOMEM;
@@ -614,16 +624,11 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 		dev_attr->attr.mode |= S_IWUSR;
 		dev_attr->store = writefunc;
 	}
-	kfree(name_format);
-	kfree(full_postfix);
-
-	return 0;
-
 error_free_name_format:
 	kfree(name_format);
 error_free_full_postfix:
 	kfree(full_postfix);
-error_ret:
+
 	return ret;
 }
 
@@ -642,7 +647,7 @@ int __iio_add_chan_devattr(const char *postfix,
 						const char *buf,
 						size_t len),
 			   u64 mask,
-			   bool generic,
+			   enum iio_shared_by shared_by,
 			   struct device *dev,
 			   struct list_head *attr_list)
 {
@@ -656,7 +661,7 @@ int __iio_add_chan_devattr(const char *postfix,
 	}
 	ret = __iio_device_attr_init(&iio_attr->dev_attr,
 				     postfix, chan,
-				     readfunc, writefunc, generic);
+				     readfunc, writefunc, shared_by);
 	if (ret)
 		goto error_iio_dev_attr_free;
 	iio_attr->c = chan;
@@ -664,7 +669,7 @@ int __iio_add_chan_devattr(const char *postfix,
 	list_for_each_entry(t, attr_list, l)
 		if (strcmp(t->dev_attr.attr.name,
 			   iio_attr->dev_attr.attr.name) == 0) {
-			if (!generic)
+			if (shared_by == __IIO_SEPARATE)
 				dev_err(dev, "tried to double register : %s\n",
 					t->dev_attr.attr.name);
 			ret = -EBUSY;
@@ -682,46 +687,53 @@ error_ret:
 	return ret;
 }
 
-static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
-					struct iio_chan_spec const *chan)
+static int iio_device_add_info_mask_type(struct iio_dev *indio_dev,
+					 struct iio_chan_spec const *chan,
+					 enum iio_shared_by shared_by,
+					 const long *infomask)
 {
-	int ret, attrcount = 0;
-	int i;
-	const struct iio_chan_spec_ext_info *ext_info;
+	int i, ret, attrcount = 0;
 
-	if (chan->channel < 0)
-		return 0;
-	for_each_set_bit(i, &chan->info_mask_separate, sizeof(long)*8) {
+	for_each_set_bit(i, infomask, sizeof(infomask)*8) {
 		ret = __iio_add_chan_devattr(iio_chan_info_postfix[i],
 					     chan,
 					     &iio_read_channel_info,
 					     &iio_write_channel_info,
 					     i,
-					     0,
+					     shared_by,
 					     &indio_dev->dev,
 					     &indio_dev->channel_attr_list);
-		if (ret < 0)
-			goto error_ret;
-		attrcount++;
-	}
-	for_each_set_bit(i, &chan->info_mask_shared_by_type, sizeof(long)*8) {
-		ret = __iio_add_chan_devattr(iio_chan_info_postfix[i],
-					     chan,
-					     &iio_read_channel_info,
-					     &iio_write_channel_info,
-					     i,
-					     1,
-					     &indio_dev->dev,
-					     &indio_dev->channel_attr_list);
-		if (ret == -EBUSY) {
-			ret = 0;
+		if ((ret == -EBUSY) && (shared_by != __IIO_SEPARATE))
 			continue;
-		} else if (ret < 0) {
-			goto error_ret;
-		}
+		else if (ret < 0)
+			return ret;
 		attrcount++;
 	}
 
+	return attrcount;
+}
+
+static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
+					struct iio_chan_spec const *chan)
+{
+	int ret, attrcount = 0;
+	const struct iio_chan_spec_ext_info *ext_info;
+
+	if (chan->channel < 0)
+		return 0;
+	ret = iio_device_add_info_mask_type(indio_dev, chan,
+					    __IIO_SEPARATE,
+					    &chan->info_mask_separate);
+	if (ret < 0)
+		return ret;
+	attrcount += ret;
+
+	ret = iio_device_add_info_mask_type(indio_dev, chan,
+					    __IIO_SHARED_BY_TYPE,
+					    &chan->info_mask_shared_by_type);
+	if (ret < 0)
+		return ret;
+	attrcount += ret;
 	if (chan->ext_info) {
 		unsigned int i = 0;
 		for (ext_info = chan->ext_info; ext_info->name; ext_info++) {
@@ -740,15 +752,13 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 				continue;
 
 			if (ret)
-				goto error_ret;
+				return ret;
 
 			attrcount++;
 		}
 	}
 
-	ret = attrcount;
-error_ret:
-	return ret;
+	return attrcount;
 }
 
 static void iio_device_remove_and_free_read_attr(struct iio_dev *indio_dev,
-- 
1.8.3.4
