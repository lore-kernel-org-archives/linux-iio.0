Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-020.synserver.de ([212.40.185.20]:1121 "EHLO
	smtp-out-017.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753401Ab3JGOJm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2013 10:09:42 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 02/20] iio: Extend the event config interface
Date: Mon,  7 Oct 2013 16:11:16 +0200
Message-Id: <1381155094-20166-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1381155094-20166-1-git-send-email-lars@metafoo.de>
References: <1381155094-20166-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The event configuration interface of the IIO framework has not been getting the
same attention as other parts. As a result it has not seen the same improvements
as e.g. the channel interface has seen with the introduction of the channel spec
struct. Currently all the event config callbacks take a u64 (the so called event
code) to pass all the different information about for which event the callback
is invoked. The callback function then has to extract the information it is
interested in using some macros with rather long names. Most information encoded
in the event code comes straight from the iio_chan_spec struct the event was
registered for. Since we always have a handle to the channel spec when we call
the event callbacks the first step is to add the channel spec as a parameter to
the event callbacks. The two remaining things encoded in the event code are the
type and direction of the event. Instead of passing them in one parameter, add
one parameter for each of them and remove the eventcode from the event
callbacks. The patch also adds a new iio_event_info parameter to the
{read,write}_event_value callbacks. This makes it possible, similar to the
iio_chan_info_enum for channels, to specify additional properties other than
just the value for an event. Furthermore the new interface will allow to
register shared events. This is e.g. useful if a device allows configuring a
threshold event, but the threshold setting is the same for all channels.

To implement this the patch adds a new iio_event_spec struct which is similar to
the iio_chan_spec struct. It as two field to specify the type and the direction
of the event. Furthermore it has a mask field for each one of the different
iio_shared_by types. These mask fields holds which kind of attributes should be
registered for the event. Creation of the attributes follows the same rules as
the for the channel attributes. E.g. for the separate_mask there will be a
attribute for each channel with this event, for the shared_by_type there will
only be one attribute per channel type. The iio_chan_spec struct gets two new
fields, 'event_spec' and 'num_event_specs', which is used to specify which the
events for this channel. These two fields are going to replace the channel's
event_mask field.

For now both the old and the new event config interface coexist, but over the
few patches all drivers will be converted from the old to the new interface.
Once that is done all code for supporting the old interface will be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Changes since v1:
	* Add support for fixedpoint and fractional values, similar to
	  {read,write}_raw
---
 drivers/iio/industrialio-event.c | 192 ++++++++++++++++++++++++++++++++++-----
 include/linux/iio/events.h       |  14 ---
 include/linux/iio/iio.h          |  58 ++++++++++++
 include/linux/iio/types.h        |  19 ++++
 4 files changed, 247 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 36f0c8e..8c81e18 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -190,6 +190,26 @@ static const char * const iio_ev_dir_text[] = {
 	[IIO_EV_DIR_FALLING] = "falling"
 };
 
+static const char * const iio_ev_info_text[] = {
+	[IIO_EV_INFO_ENABLE] = "en",
+	[IIO_EV_INFO_VALUE] = "value",
+};
+
+static enum iio_event_direction iio_ev_attr_dir(struct iio_dev_attr *attr)
+{
+	return attr->c->event_spec[attr->address & 0xffff].dir;
+}
+
+static enum iio_event_type iio_ev_attr_type(struct iio_dev_attr *attr)
+{
+	return attr->c->event_spec[attr->address & 0xffff].type;
+}
+
+static enum iio_event_info iio_ev_attr_info(struct iio_dev_attr *attr)
+{
+	return (attr->address >> 16) & 0xffff;
+}
+
 static ssize_t iio_ev_state_store(struct device *dev,
 				  struct device_attribute *attr,
 				  const char *buf,
@@ -204,9 +224,14 @@ static ssize_t iio_ev_state_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	ret = indio_dev->info->write_event_config(indio_dev,
-						  this_attr->address,
-						  val);
+	if (indio_dev->info->write_event_config)
+		ret = indio_dev->info->write_event_config(indio_dev,
+			this_attr->address, val);
+	else
+		ret = indio_dev->info->write_event_config_new(indio_dev,
+			this_attr->c, iio_ev_attr_type(this_attr),
+			iio_ev_attr_dir(this_attr), val);
+
 	return (ret < 0) ? ret : len;
 }
 
@@ -216,9 +241,15 @@ static ssize_t iio_ev_state_show(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int val = indio_dev->info->read_event_config(indio_dev,
-						     this_attr->address);
+	int val;
 
+	if (indio_dev->info->read_event_config)
+		val = indio_dev->info->read_event_config(indio_dev,
+			this_attr->address);
+	else
+		val = indio_dev->info->read_event_config_new(indio_dev,
+			this_attr->c, iio_ev_attr_type(this_attr),
+			iio_ev_attr_dir(this_attr));
 	if (val < 0)
 		return val;
 	else
@@ -231,14 +262,24 @@ static ssize_t iio_ev_value_show(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int val, ret;
-
-	ret = indio_dev->info->read_event_value(indio_dev,
-						this_attr->address, &val);
-	if (ret < 0)
-		return ret;
+	int val, val2;
+	int ret;
 
-	return sprintf(buf, "%d\n", val);
+	if (indio_dev->info->read_event_value) {
+		ret = indio_dev->info->read_event_value(indio_dev,
+			this_attr->address, &val);
+		if (ret < 0)
+			return ret;
+		return sprintf(buf, "%d\n", val);
+	} else {
+		ret = indio_dev->info->read_event_value_new(indio_dev,
+			this_attr->c, iio_ev_attr_type(this_attr),
+			iio_ev_attr_dir(this_attr), iio_ev_attr_info(this_attr),
+			&val, &val2);
+		if (ret < 0)
+			return ret;
+		return iio_format_value(buf, ret, val, val2);
+	}
 }
 
 static ssize_t iio_ev_value_store(struct device *dev,
@@ -248,25 +289,120 @@ static ssize_t iio_ev_value_store(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int val;
+	int val, val2;
 	int ret;
 
-	if (!indio_dev->info->write_event_value)
+	if (!indio_dev->info->write_event_value &&
+		!indio_dev->info->write_event_value_new)
 		return -EINVAL;
 
-	ret = kstrtoint(buf, 10, &val);
-	if (ret)
-		return ret;
-
-	ret = indio_dev->info->write_event_value(indio_dev, this_attr->address,
-						 val);
+	if (indio_dev->info->write_event_value) {
+		ret = kstrtoint(buf, 10, &val);
+		if (ret)
+			return ret;
+		ret = indio_dev->info->write_event_value(indio_dev,
+			this_attr->address, val);
+	} else {
+		ret = iio_str_to_fixpoint(buf, 100000, &val, &val2);
+		if (ret)
+			return ret;
+		ret = indio_dev->info->write_event_value_new(indio_dev,
+			this_attr->c, iio_ev_attr_type(this_attr),
+			iio_ev_attr_dir(this_attr), iio_ev_attr_info(this_attr),
+			val, val2);
+	}
 	if (ret < 0)
 		return ret;
 
 	return len;
 }
 
-static int iio_device_add_event_sysfs(struct iio_dev *indio_dev,
+static int iio_device_add_event(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, unsigned int spec_index,
+	enum iio_event_type type, enum iio_event_direction dir,
+	enum iio_shared_by shared_by, const unsigned long *mask)
+{
+	ssize_t (*show)(struct device *, struct device_attribute *, char *);
+	ssize_t (*store)(struct device *, struct device_attribute *,
+		const char *, size_t);
+	unsigned int attrcount = 0;
+	unsigned int i;
+	char *postfix;
+	int ret;
+
+	for_each_set_bit(i, mask, sizeof(*mask)) {
+		postfix = kasprintf(GFP_KERNEL, "%s_%s_%s",
+				iio_ev_type_text[type], iio_ev_dir_text[dir],
+				iio_ev_info_text[i]);
+		if (postfix == NULL)
+			return -ENOMEM;
+
+		if (i == IIO_EV_INFO_ENABLE) {
+			show = iio_ev_state_show;
+			store = iio_ev_state_store;
+		} else {
+			show = iio_ev_value_show;
+			store = iio_ev_value_store;
+		}
+
+		ret = __iio_add_chan_devattr(postfix, chan, show, store,
+			 (i << 16) | spec_index, shared_by, &indio_dev->dev,
+			&indio_dev->event_interface->dev_attr_list);
+		kfree(postfix);
+
+		if (ret)
+			return ret;
+
+		attrcount++;
+	}
+
+	return attrcount;
+}
+
+static int iio_device_add_event_sysfs_new(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *chan)
+{
+	int ret = 0, i, attrcount = 0;
+	enum iio_event_direction dir;
+	enum iio_event_type type;
+
+	for (i = 0; i < chan->num_event_specs; i++) {
+		type = chan->event_spec[i].type;
+		dir = chan->event_spec[i].dir;
+
+		ret = iio_device_add_event(indio_dev, chan, i, type, dir,
+			IIO_SEPARATE, &chan->event_spec[i].mask_separate);
+		if (ret < 0)
+			goto error_ret;
+		attrcount += ret;
+
+		ret = iio_device_add_event(indio_dev, chan, i, type, dir,
+			IIO_SHARED_BY_TYPE,
+			&chan->event_spec[i].mask_shared_by_type);
+		if (ret < 0)
+			goto error_ret;
+		attrcount += ret;
+
+		ret = iio_device_add_event(indio_dev, chan, i, type, dir,
+			IIO_SHARED_BY_DIR,
+			&chan->event_spec[i].mask_shared_by_dir);
+		if (ret < 0)
+			goto error_ret;
+		attrcount += ret;
+
+		ret = iio_device_add_event(indio_dev, chan, i, type, dir,
+			IIO_SHARED_BY_ALL,
+			&chan->event_spec[i].mask_shared_by_all);
+		if (ret < 0)
+			goto error_ret;
+		attrcount += ret;
+	}
+	ret = attrcount;
+error_ret:
+	return ret;
+}
+
+static int iio_device_add_event_sysfs_old(struct iio_dev *indio_dev,
 				      struct iio_chan_spec const *chan)
 {
 	int ret = 0, i, attrcount = 0;
@@ -339,6 +475,15 @@ error_ret:
 	return ret;
 }
 
+static int iio_device_add_event_sysfs(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan)
+{
+	if (chan->event_mask)
+		return iio_device_add_event_sysfs_old(indio_dev, chan);
+	else
+		return iio_device_add_event_sysfs_new(indio_dev, chan);
+}
+
 static inline void __iio_remove_event_config_attrs(struct iio_dev *indio_dev)
 {
 	struct iio_dev_attr *p, *n;
@@ -369,9 +514,12 @@ static bool iio_check_for_dynamic_events(struct iio_dev *indio_dev)
 {
 	int j;
 
-	for (j = 0; j < indio_dev->num_channels; j++)
+	for (j = 0; j < indio_dev->num_channels; j++) {
 		if (indio_dev->channels[j].event_mask != 0)
 			return true;
+		if (indio_dev->channels[j].num_event_specs != 0)
+			return true;
+	}
 	return false;
 }
 
diff --git a/include/linux/iio/events.h b/include/linux/iio/events.h
index 13ce220..5dab2c4 100644
--- a/include/linux/iio/events.h
+++ b/include/linux/iio/events.h
@@ -26,20 +26,6 @@ struct iio_event_data {
 
 #define IIO_GET_EVENT_FD_IOCTL _IOR('i', 0x90, int)
 
-enum iio_event_type {
-	IIO_EV_TYPE_THRESH,
-	IIO_EV_TYPE_MAG,
-	IIO_EV_TYPE_ROC,
-	IIO_EV_TYPE_THRESH_ADAPTIVE,
-	IIO_EV_TYPE_MAG_ADAPTIVE,
-};
-
-enum iio_event_direction {
-	IIO_EV_DIR_EITHER,
-	IIO_EV_DIR_RISING,
-	IIO_EV_DIR_FALLING,
-};
-
 /**
  * IIO_EVENT_CODE() - create event identifier
  * @chan_type:	Type of the channel. Should be one of enum iio_chan_type.
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index ac1cb8f..256a90a 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -139,6 +139,29 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
 }
 
 /**
+ * struct iio_event_spec - specification for a channel event
+ * @type:		    Type of the event
+ * @dir:		    Direction of the event
+ * @mask_separate:	    Bit mask of enum iio_event_info values. Attributes
+ *			    set in this mask will be registered per channel.
+ * @mask_shared_by_type:    Bit mask of enum iio_event_info values. Attributes
+ *			    set in this mask will be shared by channel type.
+ * @mask_shared_by_dir:	    Bit mask of enum iio_event_info values. Attributes
+ *			    set in this mask will be shared by channel type and
+ *			    direction.
+ * @mask_shared_by_all:	    Bit mask of enum iio_event_info values. Attributes
+ *			    set in this mask will be shared by all channels.
+ */
+struct iio_event_spec {
+	enum iio_event_type type;
+	enum iio_event_direction dir;
+	unsigned long mask_separate;
+	unsigned long mask_shared_by_type;
+	unsigned long mask_shared_by_dir;
+	unsigned long mask_shared_by_all;
+};
+
+/**
  * struct iio_chan_spec - specification of a single channel
  * @type:		What type of measurement is the channel making.
  * @channel:		What number do we wish to assign the channel.
@@ -163,6 +186,9 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
  * @info_mask_shared_by_all: What information is to be exported that is shared
  *			by all channels.
  * @event_mask:		What events can this channel produce.
+ * @event_spec:		Array of events which should be registered for this
+ *			channel.
+ * @num_event_specs:	Size of the event_spec array.
  * @ext_info:		Array of extended info attributes for this channel.
  *			The array is NULL terminated, the last element should
  *			have its name field set to NULL.
@@ -201,6 +227,8 @@ struct iio_chan_spec {
 	long			info_mask_shared_by_dir;
 	long			info_mask_shared_by_all;
 	long			event_mask;
+	const struct iio_event_spec *event_spec;
+	unsigned int		num_event_specs;
 	const struct iio_chan_spec_ext_info *ext_info;
 	const char		*extend_name;
 	const char		*datasheet_name;
@@ -283,6 +311,12 @@ struct iio_dev;
  *			is event dependant. event_code specifies which event.
  * @write_event_value:	write the value associated with the event.
  *			Meaning is event dependent.
+ * @read_event_config_new: find out if the event is enabled. New style interface.
+ * @write_event_config_new: set if the event is enabled. New style interface.
+ * @read_event_value_new: read a configuration value associated with the event.
+ *                         New style interface.
+ * @write_event_value_new: write a configuration value for the event. New style
+ *			   interface.
  * @validate_trigger:	function to validate the trigger when the
  *			current trigger gets changed.
  * @update_scan_mode:	function to configure device and scan buffer when
@@ -323,6 +357,30 @@ struct iio_info {
 	int (*write_event_value)(struct iio_dev *indio_dev,
 				 u64 event_code,
 				 int val);
+
+	int (*read_event_config_new)(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan,
+				 enum iio_event_type type,
+				 enum iio_event_direction dir);
+
+	int (*write_event_config_new)(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan,
+				  enum iio_event_type type,
+				  enum iio_event_direction dir,
+				  int state);
+
+	int (*read_event_value_new)(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info, int *val, int *val2);
+
+	int (*write_event_value_new)(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan,
+				 enum iio_event_type type,
+				 enum iio_event_direction dir,
+				 enum iio_event_info info, int val, int val2);
+
 	int (*validate_trigger)(struct iio_dev *indio_dev,
 				struct iio_trigger *trig);
 	int (*update_scan_mode)(struct iio_dev *indio_dev,
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 88bf0f0..18339ef 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -54,6 +54,25 @@ enum iio_modifier {
 	IIO_MOD_LIGHT_BLUE,
 };
 
+enum iio_event_type {
+	IIO_EV_TYPE_THRESH,
+	IIO_EV_TYPE_MAG,
+	IIO_EV_TYPE_ROC,
+	IIO_EV_TYPE_THRESH_ADAPTIVE,
+	IIO_EV_TYPE_MAG_ADAPTIVE,
+};
+
+enum iio_event_info {
+	IIO_EV_INFO_ENABLE,
+	IIO_EV_INFO_VALUE,
+};
+
+enum iio_event_direction {
+	IIO_EV_DIR_EITHER,
+	IIO_EV_DIR_RISING,
+	IIO_EV_DIR_FALLING,
+};
+
 #define IIO_VAL_INT 1
 #define IIO_VAL_INT_PLUS_MICRO 2
 #define IIO_VAL_INT_PLUS_NANO 3
-- 
1.8.0

