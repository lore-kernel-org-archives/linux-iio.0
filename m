Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50304 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557Ab3KQOOK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Nov 2013 09:14:10 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 01/11] iio:core: add a callback to allow drivers to provide _available attributes
Date: Sun, 17 Nov 2013 15:14:52 +0000
Message-Id: <1384701302-26564-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1384701302-26564-1-git-send-email-jic23@kernel.org>
References: <1384701302-26564-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

A large number of attributes can only take a limited range of values.
Currently in IIO this is handled by directly registering additional
*_available attributes thus providing this information to userspace.

It is desirable to provide this information via the core for much the same
reason this was done for the actual channel information attributes in the
first place.  If it isn't there, then it can only really be accessed from
userspace.  Other in kernel IIO consumers have no access to what valid
parameters are.

Two forms are currently supported:
* list of values in one particular IIO_VAL_* format.
	e.g. 1.300000 1.500000 1.730000
* range specification with a step size:
	e.g. [1.000000 0.500000 2.500000]
	equivalent to 1.000000 1.5000000 2.000000 2.500000

An addition set of masks are used to allow different sharing rules for the
*_available attributes generated.

This allows for example:

in_accel_x_offset
in_accel_y_offset
in_accel_offset_available.

We could have gone with having a specification for each and every
info_mask element but that would have meant changing the existing userspace
ABI.  This approach does not.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/industrialio-core.c | 209 +++++++++++++++++++++++++++++++++++++---
 include/linux/iio/iio.h         |  11 +++
 include/linux/iio/types.h       |   5 +
 3 files changed, 209 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 2fe88c189f74..a0466f3dd2c8 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -367,50 +367,58 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
 }
 EXPORT_SYMBOL_GPL(iio_enum_write);
 
-/**
- * iio_format_value() - Formats a IIO value into its string representation
- * @buf: The buffer to which the formated value gets written
- * @type: One of the IIO_VAL_... constants. This decides how the val and val2
- *        parameters are formatted.
- * @val: First part of the value, exact meaning depends on the type parameter.
- * @val2: Second part of the value, exact meaning depends on the type parameter.
- */
-ssize_t iio_format_value(char *buf, unsigned int type, int val, int val2)
+ssize_t __iio_format_value(char *buf, unsigned int type, int val, int val2)
 {
 	unsigned long long tmp;
 	bool scale_db = false;
 
 	switch (type) {
 	case IIO_VAL_INT:
-		return sprintf(buf, "%d\n", val);
+		return sprintf(buf, "%d", val);
 	case IIO_VAL_INT_PLUS_MICRO_DB:
 		scale_db = true;
 	case IIO_VAL_INT_PLUS_MICRO:
 		if (val2 < 0)
-			return sprintf(buf, "-%ld.%06u%s\n", abs(val), -val2,
+			return sprintf(buf, "-%ld.%06u%s", abs(val), -val2,
 				scale_db ? " dB" : "");
 		else
-			return sprintf(buf, "%d.%06u%s\n", val, val2,
+			return sprintf(buf, "%d.%06u%s", val, val2,
 				scale_db ? " dB" : "");
 	case IIO_VAL_INT_PLUS_NANO:
 		if (val2 < 0)
-			return sprintf(buf, "-%ld.%09u\n", abs(val), -val2);
+			return sprintf(buf, "-%ld.%09u", abs(val), -val2);
 		else
-			return sprintf(buf, "%d.%09u\n", val, val2);
+			return sprintf(buf, "%d.%09u", val, val2);
 	case IIO_VAL_FRACTIONAL:
 		tmp = div_s64((s64)val * 1000000000LL, val2);
 		val2 = do_div(tmp, 1000000000LL);
 		val = tmp;
-		return sprintf(buf, "%d.%09u\n", val, val2);
+		return sprintf(buf, "%d.%09u", val, val2);
 	case IIO_VAL_FRACTIONAL_LOG2:
 		tmp = (s64)val * 1000000000LL >> val2;
 		val2 = do_div(tmp, 1000000000LL);
 		val = tmp;
-		return sprintf(buf, "%d.%09u\n", val, val2);
+		return sprintf(buf, "%d.%09u", val, val2);
 	default:
 		return 0;
 	}
 }
+/**
+ * iio_format_value() - Formats a IIO value into its string representation
+ * @buf: The buffer to which the formated value gets written
+ * @type: One of the IIO_VAL_... constants. This decides how the val and val2
+ *        parameters are formatted.
+ * @val: First part of the value, exact meaning depends on the type parameter.
+ * @val2: Second part of the value, exact meaning depends on the type parameter.
+ */
+ssize_t iio_format_value(char *buf, unsigned int type, int val, int val2)
+{
+	ssize_t len;
+
+	len = __iio_format_value(buf, type, val, val2);
+
+	return len + sprintf(buf + len, "\n");
+}
 
 static ssize_t iio_read_channel_info(struct device *dev,
 				     struct device_attribute *attr,
@@ -428,6 +436,111 @@ static ssize_t iio_read_channel_info(struct device *dev,
 	return iio_format_value(buf, ret, val, val2);
 }
 
+static ssize_t iio_format_avail_list(char *buf, const int *vals, int type, int length)
+{
+	int i;
+	ssize_t len = 0;
+	switch (type) {
+	case IIO_VAL_INT:
+		for (i = 0; i < length; i++) {
+			len += __iio_format_value(buf + len, type, vals[i], 0);
+			if (i < length - 1)
+				len += snprintf(buf + len,
+						PAGE_SIZE - len,
+						" ");
+			else
+				len += snprintf(buf + len,
+						PAGE_SIZE - len,
+						"\n");
+		}
+		break;
+	default:
+		for (i = 0; i < length / 2; i++) {
+			len += __iio_format_value(buf + len,
+						  type,
+						  vals[i * 2],
+						  vals[i * 2 + 1]);
+			if (i < length / 2 - 1)
+				len += snprintf(buf + len,
+						PAGE_SIZE - len,
+						" ");
+			else
+				len += snprintf(buf + len,
+						PAGE_SIZE - len,
+						"\n");
+		}
+	};
+
+	return len;
+}
+
+static ssize_t iio_format_avail_range(char *buf, const int *vals, int type)
+{
+	int i;
+	ssize_t len;
+
+	len = snprintf(buf, PAGE_SIZE, "[");
+	switch (type) {
+	case IIO_VAL_INT:
+		for (i = 0; i < 3; i++) {
+			len += __iio_format_value(buf + len, type, vals[i], 0);
+			if (i < 2)
+				len += snprintf(buf + len,
+						PAGE_SIZE - len,
+						" ");
+			else
+				len += snprintf(buf + len,
+						PAGE_SIZE - len,
+						"]\n");
+		}
+		break;
+	default:
+		for (i = 0; i < 3; i++) {
+			len += __iio_format_value(buf + len,
+						  type,
+						  vals[i * 2],
+						  vals[i * 2 + 1]);
+			if (i < 2)
+				len += snprintf(buf + len,
+						PAGE_SIZE - len,
+						" ");
+			else
+				len += snprintf(buf + len,
+						PAGE_SIZE - len,
+						"]\n");
+		}
+	};
+
+	return len;
+}
+
+static ssize_t iio_read_channel_info_avail(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	const int *vals;
+	int ret;
+	int length;
+	int type;
+
+	ret = indio_dev->info->read_avail(indio_dev, this_attr->c,
+					  &vals, &type, &length,
+					  this_attr->address);
+
+	if (ret < 0)
+		return ret;
+	switch (ret) {
+	case IIO_AVAIL_LIST:
+		return iio_format_avail_list(buf, vals, type, length);
+	case IIO_AVAIL_RANGE:
+		return iio_format_avail_range(buf, vals, type);
+	default:
+		return -EINVAL;
+	}
+}
+
 /**
  * iio_str_to_fixpoint() - Parse a fixed-point number from a string
  * @str: The string to parse
@@ -749,6 +862,40 @@ static int iio_device_add_info_mask_type(struct iio_dev *indio_dev,
 	return attrcount;
 }
 
+static int iio_device_add_info_mask_type_avail(struct iio_dev *indio_dev,
+					       struct iio_chan_spec const *chan,
+					       enum iio_shared_by shared_by,
+					       const long *infomask)
+{
+	int i, ret, attrcount = 0;
+	char *avail_postfix;
+
+	for_each_set_bit(i, infomask, sizeof(infomask)*8) {
+		avail_postfix = kasprintf(GFP_KERNEL,
+					  "%s_available",
+					  iio_chan_info_postfix[i]);
+		if (avail_postfix == NULL)
+			return -ENOMEM;
+
+		ret = __iio_add_chan_devattr(avail_postfix,
+					     chan,
+					     &iio_read_channel_info_avail,
+					     NULL,
+					     i,
+					     shared_by,
+					     &indio_dev->dev,
+					     &indio_dev->channel_attr_list);
+		kfree(avail_postfix);
+		if ((ret == -EBUSY) && (shared_by != IIO_SEPARATE))
+			continue;
+		else if (ret < 0)
+			return ret;
+		attrcount++;
+	}
+
+	return attrcount;
+}
+
 static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 					struct iio_chan_spec const *chan)
 {
@@ -764,6 +911,14 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 		return ret;
 	attrcount += ret;
 
+	ret = iio_device_add_info_mask_type_avail(indio_dev, chan,
+						  IIO_SEPARATE,
+						  &chan->
+						  info_mask_separate_available);
+	if (ret < 0)
+		return ret;
+	attrcount += ret;
+
 	ret = iio_device_add_info_mask_type(indio_dev, chan,
 					    IIO_SHARED_BY_TYPE,
 					    &chan->info_mask_shared_by_type);
@@ -771,6 +926,14 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 		return ret;
 	attrcount += ret;
 
+	ret = iio_device_add_info_mask_type_avail(indio_dev, chan,
+						  IIO_SHARED_BY_TYPE,
+						  &chan->
+						  info_mask_shared_by_type_available);
+	if (ret < 0)
+		return ret;
+	attrcount += ret;
+
 	ret = iio_device_add_info_mask_type(indio_dev, chan,
 					    IIO_SHARED_BY_DIR,
 					    &chan->info_mask_shared_by_dir);
@@ -778,6 +941,13 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 		return ret;
 	attrcount += ret;
 
+	ret = iio_device_add_info_mask_type_avail(indio_dev, chan,
+						  IIO_SHARED_BY_DIR,
+						  &chan->info_mask_shared_by_dir_available);
+	if (ret < 0)
+		return ret;
+	attrcount += ret;
+
 	ret = iio_device_add_info_mask_type(indio_dev, chan,
 					    IIO_SHARED_BY_ALL,
 					    &chan->info_mask_shared_by_all);
@@ -785,6 +955,13 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 		return ret;
 	attrcount += ret;
 
+	ret = iio_device_add_info_mask_type_avail(indio_dev, chan,
+						  IIO_SHARED_BY_ALL,
+						  &chan->info_mask_shared_by_all_available);
+	if (ret < 0)
+		return ret;
+	attrcount += ret;
+
 	if (chan->ext_info) {
 		unsigned int i = 0;
 		for (ext_info = chan->ext_info; ext_info->name; ext_info++) {
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 5b125fd554e4..6ce897840a2b 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -223,9 +223,13 @@ struct iio_chan_spec {
 		enum iio_endian endianness;
 	} scan_type;
 	long			info_mask_separate;
+	long			info_mask_separate_available;
 	long			info_mask_shared_by_type;
+	long			info_mask_shared_by_type_available;
 	long			info_mask_shared_by_dir;
+	long			info_mask_shared_by_dir_available;
 	long			info_mask_shared_by_all;
+	long			info_mask_shared_by_all_available;
 	long			event_mask;
 	const struct iio_event_spec *event_spec;
 	unsigned int		num_event_specs;
@@ -334,6 +338,13 @@ struct iio_info {
 			int *val2,
 			long mask);
 
+	int (*read_avail)(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *chan,
+			  const int **vals,
+			  int *type,
+			  int *length,
+			  long mask_el);
+
 	int (*write_raw)(struct iio_dev *indio_dev,
 			 struct iio_chan_spec const *chan,
 			 int val,
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 4ac928ee31c5..766659dea679 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -81,4 +81,9 @@ enum iio_event_direction {
 #define IIO_VAL_FRACTIONAL 10
 #define IIO_VAL_FRACTIONAL_LOG2 11
 
+enum iio_available_type {
+  IIO_AVAIL_LIST,
+  IIO_AVAIL_RANGE,
+};
+
 #endif /* _IIO_TYPES_H_ */
-- 
1.8.4.2

