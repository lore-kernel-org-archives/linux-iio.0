Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-060.synserver.de ([212.40.185.60]:1052 "EHLO
	smtp-out-056.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752113Ab2BURgt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 21 Feb 2012 12:36:49 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/6] staging:iio: Add extended IIO channel info
Date: Tue, 21 Feb 2012 18:38:12 +0100
Message-Id: <1329845897-23364-1-git-send-email-lars@metafoo.de>
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
Acked-by: Jonathan Cameron <jic23@kernel.org>

---
 drivers/staging/iio/iio.h               |   23 +++++++++++++
 drivers/staging/iio/industrialio-core.c |   53 +++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index be6ced3..9140c2a 100644
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
+ * @ext_info:		Array of extended info attributes for this channel.
+ *			The array is NULL terminated, the last element should
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
index e4824fe..c1f116c 100644
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
@@ -423,6 +450,7 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 					struct iio_chan_spec const *chan)
 {
 	int ret, i, attrcount = 0;
+	const struct iio_chan_spec_ext_info *ext_info;
 
 	if (chan->channel < 0)
 		return 0;
@@ -457,6 +485,31 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
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
+			i++;
+			if (ret == -EBUSY && ext_info->shared)
+				continue;
+
+			if (ret)
+				goto error_ret;
+
+			attrcount++;
+		}
+	}
+
 	ret = attrcount;
 error_ret:
 	return ret;
-- 
1.7.9

