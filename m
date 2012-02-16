Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-249.synserver.de ([212.40.185.249]:1095 "EHLO
	smtp-out-240.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750907Ab2BPKrp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Feb 2012 05:47:45 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/5] staging:iio: Add extended IIO channel info
Date: Thu, 16 Feb 2012 11:49:07 +0100
Message-Id: <1329389351-21584-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Sometimes devices have per channel properties which either do not map nicely to
the current channel info scheme (e.g. string properties) or are very device
specific, so it does not make sense to add generic support for them.

Currently drivers define these attributes by hand for each channel. Depending on
the number of channels this can amount to quite a few lines of boilerplate code.
Especially if a driver supports multiple variations of a chip with different
numbers of channels. In this case it becomes necessary to have a individual
attribute list per chip variation and also a individual iio_info struct.

This patch introduces a new scheme for handling such per channel attributes
called extended channel info attributes. A extended channel info attribute
consist of a name, a flag whether it is shared and read and write callbacks.
The read and write callbacks are similar to the {read,write}_raw callbacks and
take a IIO device and a channel as their first parameters, but instead of
pre-parsed integer values they directly get passed the raw string value, which
has been written to the sysfs file.

It is possible to assign a list of extended channel info attributes to a
channel. For each extended channel info attribute the IIO core will create a new
sysfs attribute conforming to the IIO channel naming spec for the channels type,
similar as for normal info attributes. Read and write access to this sysfs
attribute will be redirected to the extended channel info attributes read and
write callbacks.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/iio.h               |   23 ++++++++++++
 drivers/staging/iio/industrialio-core.c |   61 ++++++++++++++++++++++++++++---
 2 files changed, 78 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index be6ced3..2a0cfbb 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -88,6 +88,25 @@ enum iio_endian {
 	IIO_LE,
 };
 
+struct iio_chan_spec;
+struct iio_dev;
+
+/**
+ * struct iio_chan_spec_ext_info - Extended channel info attribute
+ * @name:	Info attribute name
+ * @shared:	Whether this attribute is shared between all channels.
+ * @read:	Read callback for this info attribute, may be NULL.
+ * @write:	Write callback for this info attribute, may be NULL.
+ */
+struct iio_chan_spec_ext_info {
+	const char *name;
+	bool shared;
+	ssize_t (*read)(struct iio_dev *, struct iio_chan_spec const *,
+			char *buf);
+	ssize_t (*write)(struct iio_dev *, struct iio_chan_spec const *,
+			const char *buf, size_t len);
+};
+
 /**
  * struct iio_chan_spec - specification of a single channel
  * @type:		What type of measurement is the channel making.
@@ -107,6 +126,9 @@ enum iio_endian {
  * @info_mask:		What information is to be exported about this channel.
  *			This includes calibbias, scale etc.
  * @event_mask:	What events can this channel produce.
+ * @ext_info:		List of extended info attributes for this channel.
+ *			The list is NULL terminated, the last element should
+ *			have it's name field set to NULL.
  * @extend_name:	Allows labeling of channel attributes with an
  *			informative name. Note this has no effect codes etc,
  *			unlike modifiers.
@@ -141,6 +163,7 @@ struct iio_chan_spec {
 	} scan_type;
 	long			info_mask;
 	long			event_mask;
+	const struct iio_chan_spec_ext_info *ext_info;
 	char			*extend_name;
 	const char		*datasheet_name;
 	unsigned		processed_val:1;
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index e4824fe..a02b6ec 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -144,6 +144,33 @@ static void __exit iio_exit(void)
 	bus_unregister(&iio_bus_type);
 }
 
+static ssize_t iio_read_channel_ext_info(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	const struct iio_chan_spec_ext_info *ext_info;
+
+	ext_info = &this_attr->c->ext_info[this_attr->address];
+
+	return ext_info->read(indio_dev, this_attr->c, buf);
+}
+
+static ssize_t iio_write_channel_ext_info(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf,
+					 size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	const struct iio_chan_spec_ext_info *ext_info;
+
+	ext_info = &this_attr->c->ext_info[this_attr->address];
+
+	return ext_info->write(indio_dev, this_attr->c, buf, len);
+}
+
 static ssize_t iio_read_channel_info(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
@@ -401,10 +428,13 @@ int __iio_add_chan_devattr(const char *postfix,
 	list_for_each_entry(t, attr_list, l)
 		if (strcmp(t->dev_attr.attr.name,
 			   iio_attr->dev_attr.attr.name) == 0) {
-			if (!generic)
+			if (!generic) {
 				dev_err(dev, "tried to double register : %s\n",
 					t->dev_attr.attr.name);
-			ret = -EBUSY;
+				ret = -EBUSY;
+			} else {
+				ret = 0;
+			}
 			goto error_device_attr_deinit;
 		}
 	list_add(&iio_attr->l, attr_list);
@@ -423,6 +453,7 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 					struct iio_chan_spec const *chan)
 {
 	int ret, i, attrcount = 0;
+	const struct iio_chan_spec_ext_info *ext_info;
 
 	if (chan->channel < 0)
 		return 0;
@@ -449,14 +480,32 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 					     !(i%2),
 					     &indio_dev->dev,
 					     &indio_dev->channel_attr_list);
-		if (ret == -EBUSY && (i%2 == 0)) {
-			ret = 0;
-			continue;
-		}
 		if (ret < 0)
 			goto error_ret;
 		attrcount++;
 	}
+
+	if (chan->ext_info) {
+		unsigned int i = 0;
+		for (ext_info = chan->ext_info; ext_info->name; ext_info++) {
+			ret = __iio_add_chan_devattr(ext_info->name,
+					chan,
+					ext_info->read ?
+					    &iio_read_channel_ext_info : NULL,
+					ext_info->write ?
+					    &iio_write_channel_ext_info : NULL,
+					i,
+					ext_info->shared,
+					&indio_dev->dev,
+					&indio_dev->channel_attr_list);
+			if (ret)
+				goto error_ret;
+			i++;
+		}
+
+		attrcount += i;
+	}
+
 	ret = attrcount;
 error_ret:
 	return ret;
-- 
1.7.9

