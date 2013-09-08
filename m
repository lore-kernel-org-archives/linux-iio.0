Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37534 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271Ab3IHM5T (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Sep 2013 08:57:19 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/5] iio: refactor info mask and ext_info attribute creation.
Date: Sun,  8 Sep 2013 14:57:18 +0100
Message-Id: <1378648641-28280-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1378648641-28280-1-git-send-email-jic23@kernel.org>
References: <1378648641-28280-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Introduce an enum to specify whether the attribute is separate or
shared.

Factor out the bitmap handling for loop into a separate function.

Tidy up error handling and add a NULL assignment to squish a false
positive warning from GCC.

Change ext_info shared type from boolean to enum and update in all
drivers.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/dac/ad5064.c          |   3 +-
 drivers/iio/dac/ad5380.c          |   4 +-
 drivers/iio/dac/ad5446.c          |   3 +-
 drivers/iio/dac/ad5504.c          |   4 +-
 drivers/iio/dac/ad5624r_spi.c     |   4 +-
 drivers/iio/dac/ad5686.c          |   3 +-
 drivers/iio/dac/ad5755.c          |   1 +
 drivers/iio/dac/ad5791.c          |   5 +-
 drivers/iio/dac/ad7303.c          |   1 +
 drivers/iio/dac/mcp4725.c         |   3 +-
 drivers/iio/frequency/adf4350.c   |   1 +
 drivers/iio/iio_core.h            |   2 +-
 drivers/iio/industrialio-buffer.c |   2 +-
 drivers/iio/industrialio-core.c   | 149 ++++++++++++++++++++------------------
 include/linux/iio/iio.h           |   9 ++-
 15 files changed, 112 insertions(+), 82 deletions(-)

diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index aa26d50..af66841 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -285,8 +285,9 @@ static const struct iio_chan_spec_ext_info ad5064_ext_info[] = {
 		.name = "powerdown",
 		.read = ad5064_read_dac_powerdown,
 		.write = ad5064_write_dac_powerdown,
+		.shared = IIO_SEPARATE,
 	},
-	IIO_ENUM("powerdown_mode", false, &ad5064_powerdown_mode_enum),
+	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ad5064_powerdown_mode_enum),
 	IIO_ENUM_AVAILABLE("powerdown_mode", &ad5064_powerdown_mode_enum),
 	{ },
 };
diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index bf2db02..3f1b9c3 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -247,8 +247,10 @@ static struct iio_chan_spec_ext_info ad5380_ext_info[] = {
 		.name = "powerdown",
 		.read = ad5380_read_dac_powerdown,
 		.write = ad5380_write_dac_powerdown,
+		.shared = IIO_SEPARATE,
 	},
-	IIO_ENUM("powerdown_mode", true, &ad5380_powerdown_mode_enum),
+	IIO_ENUM("powerdown_mode", IIO_SHARED_BY_TYPE,
+		 &ad5380_powerdown_mode_enum),
 	IIO_ENUM_AVAILABLE("powerdown_mode", &ad5380_powerdown_mode_enum),
 	{ },
 };
diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index cae8f60..3fcc900 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -132,8 +132,9 @@ static const struct iio_chan_spec_ext_info ad5446_ext_info_powerdown[] = {
 		.name = "powerdown",
 		.read = ad5446_read_dac_powerdown,
 		.write = ad5446_write_dac_powerdown,
+		.shared = IIO_SEPARATE,
 	},
-	IIO_ENUM("powerdown_mode", false, &ad5446_powerdown_mode_enum),
+	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ad5446_powerdown_mode_enum),
 	IIO_ENUM_AVAILABLE("powerdown_mode", &ad5446_powerdown_mode_enum),
 	{ },
 };
diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 139206e..06848d5 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -248,8 +248,10 @@ static const struct iio_chan_spec_ext_info ad5504_ext_info[] = {
 		.name = "powerdown",
 		.read = ad5504_read_dac_powerdown,
 		.write = ad5504_write_dac_powerdown,
+		.shared = IIO_SEPARATE,
 	},
-	IIO_ENUM("powerdown_mode", true, &ad5504_powerdown_mode_enum),
+	IIO_ENUM("powerdown_mode", IIO_SHARED_BY_TYPE,
+		 &ad5504_powerdown_mode_enum),
 	IIO_ENUM_AVAILABLE("powerdown_mode", &ad5504_powerdown_mode_enum),
 	{ },
 };
diff --git a/drivers/iio/dac/ad5624r_spi.c b/drivers/iio/dac/ad5624r_spi.c
index bb298aa..5f944ac 100644
--- a/drivers/iio/dac/ad5624r_spi.c
+++ b/drivers/iio/dac/ad5624r_spi.c
@@ -163,8 +163,10 @@ static const struct iio_chan_spec_ext_info ad5624r_ext_info[] = {
 		.name = "powerdown",
 		.read = ad5624r_read_dac_powerdown,
 		.write = ad5624r_write_dac_powerdown,
+		.shared = IIO_SEPARATE,
 	},
-	IIO_ENUM("powerdown_mode", true, &ad5624r_powerdown_mode_enum),
+	IIO_ENUM("powerdown_mode", IIO_SHARED_BY_TYPE,
+		 &ad5624r_powerdown_mode_enum),
 	IIO_ENUM_AVAILABLE("powerdown_mode", &ad5624r_powerdown_mode_enum),
 	{ },
 };
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 06439b1..faf8ab5 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -265,8 +265,9 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
 		.name = "powerdown",
 		.read = ad5686_read_dac_powerdown,
 		.write = ad5686_write_dac_powerdown,
+		.shared = IIO_SEPARATE,
 	},
-	IIO_ENUM("powerdown_mode", false, &ad5686_powerdown_mode_enum),
+	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ad5686_powerdown_mode_enum),
 	IIO_ENUM_AVAILABLE("powerdown_mode", &ad5686_powerdown_mode_enum),
 	{ },
 };
diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index 12bb315..24f5d30 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -386,6 +386,7 @@ static const struct iio_chan_spec_ext_info ad5755_ext_info[] = {
 		.name = "powerdown",
 		.read = ad5755_read_powerdown,
 		.write = ad5755_write_powerdown,
+		.shared = IIO_SEPARATE,
 	},
 	{ },
 };
diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index 97c1e5d..70866e1 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -287,11 +287,12 @@ static int ad5791_read_raw(struct iio_dev *indio_dev,
 static const struct iio_chan_spec_ext_info ad5791_ext_info[] = {
 	{
 		.name = "powerdown",
-		.shared = true,
+		.shared = IIO_SHARED_BY_TYPE,
 		.read = ad5791_read_dac_powerdown,
 		.write = ad5791_write_dac_powerdown,
 	},
-	IIO_ENUM("powerdown_mode", true, &ad5791_powerdown_mode_enum),
+	IIO_ENUM("powerdown_mode", IIO_SHARED_BY_TYPE,
+		 &ad5791_powerdown_mode_enum),
 	IIO_ENUM_AVAILABLE("powerdown_mode", &ad5791_powerdown_mode_enum),
 	{ },
 };
diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
index d546f50..3e0cb67 100644
--- a/drivers/iio/dac/ad7303.c
+++ b/drivers/iio/dac/ad7303.c
@@ -169,6 +169,7 @@ static const struct iio_chan_spec_ext_info ad7303_ext_info[] = {
 		.name = "powerdown",
 		.read = ad7303_read_dac_powerdown,
 		.write = ad7303_write_dac_powerdown,
+		.shared = IIO_SEPARATE,
 	},
 	{ },
 };
diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 1f4a48e..6711a33 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -195,8 +195,9 @@ static const struct iio_chan_spec_ext_info mcp4725_ext_info[] = {
 		.name = "powerdown",
 		.read = mcp4725_read_powerdown,
 		.write = mcp4725_write_powerdown,
+		.shared = IIO_SEPARATE,
 	},
-	IIO_ENUM("powerdown_mode", false, &mcp4725_powerdown_mode_enum),
+	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &mcp4725_powerdown_mode_enum),
 	IIO_ENUM_AVAILABLE("powerdown_mode", &mcp4725_powerdown_mode_enum),
 	{ },
 };
diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index a7b30be..85152547 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -351,6 +351,7 @@ static ssize_t adf4350_read(struct iio_dev *indio_dev,
 	.read = adf4350_read, \
 	.write = adf4350_write, \
 	.private = _ident, \
+	.shared = IIO_SEPARATE, \
 }
 
 static const struct iio_chan_spec_ext_info adf4350_ext_info[] = {
diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 05c1b74..6be5ab8 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -30,7 +30,7 @@ int __iio_add_chan_devattr(const char *postfix,
 						const char *buf,
 						size_t len),
 			   u64 mask,
-			   bool generic,
+			   enum iio_shared_by shared_by,
 			   struct device *dev,
 			   struct list_head *attr_list);
 
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index e73033f..80a2e27 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -214,7 +214,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 				     &iio_show_scan_index,
 				     NULL,
 				     0,
-				     0,
+				     IIO_SEPARATE,
 				     &indio_dev->dev,
 				     &buffer->scan_el_dev_attr_list);
 	if (ret)
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 97f0297..d713b20 100644
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
+	if (chan->modified && (shared_by == IIO_SEPARATE)) {
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
+		case IIO_SHARED_BY_TYPE:
 			name_format
 				= kasprintf(GFP_KERNEL, "%s_%s-%s_%s",
 					    iio_direction[chan->output],
 					    iio_chan_type_name_spec[chan->type],
 					    iio_chan_type_name_spec[chan->type],
 					    full_postfix);
-		else if (chan->indexed)
+			break;
+		case IIO_SEPARATE:
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
+		case IIO_SHARED_BY_TYPE:
 			name_format
 				= kasprintf(GFP_KERNEL, "%s_%s_%s",
 					    iio_direction[chan->output],
 					    iio_chan_type_name_spec[chan->type],
 					    full_postfix);
+			break;
+
+		case IIO_SEPARATE:
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
+			if (shared_by == IIO_SEPARATE)
 				dev_err(dev, "tried to double register : %s\n",
 					t->dev_attr.attr.name);
 			ret = -EBUSY;
@@ -682,46 +687,54 @@ error_ret:
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
+		if ((ret == -EBUSY) && (shared_by != IIO_SEPARATE))
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
+					    IIO_SEPARATE,
+					    &chan->info_mask_separate);
+	if (ret < 0)
+		return ret;
+	attrcount += ret;
+
+	ret = iio_device_add_info_mask_type(indio_dev, chan,
+					    IIO_SHARED_BY_TYPE,
+					    &chan->info_mask_shared_by_type);
+	if (ret < 0)
+		return ret;
+	attrcount += ret;
+
 	if (chan->ext_info) {
 		unsigned int i = 0;
 		for (ext_info = chan->ext_info; ext_info->name; ext_info++) {
@@ -740,15 +753,13 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
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
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index cdb034d..8d769fe 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -38,6 +38,11 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_HYSTERESIS,
 };
 
+enum iio_shared_by {
+	IIO_SEPARATE,
+	IIO_SHARED_BY_TYPE
+};
+
 enum iio_endian {
 	IIO_CPU,
 	IIO_BE,
@@ -57,7 +62,7 @@ struct iio_dev;
  */
 struct iio_chan_spec_ext_info {
 	const char *name;
-	bool shared;
+	enum iio_shared_by shared;
 	ssize_t (*read)(struct iio_dev *, uintptr_t private,
 			struct iio_chan_spec const *, char *buf);
 	ssize_t (*write)(struct iio_dev *, uintptr_t private,
@@ -125,7 +130,7 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
 #define IIO_ENUM_AVAILABLE(_name, _e) \
 { \
 	.name = (_name "_available"), \
-	.shared = true, \
+	.shared = IIO_SHARED_BY_TYPE, \
 	.read = iio_enum_available_read, \
 	.private = (uintptr_t)(_e), \
 }
-- 
1.8.4

