Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 001/111] staging:iio: allow channels to be set up using a table of iio_channel_spec structures.
Date: Wed, 18 May 2011 14:40:51 +0100
Message-Id: <1305726161-5606-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

V8: Add missing address in IIO_CHAN macro. Spotted by Michael Hennerich.
V7: Document additions to iio_dev structure.
V6: Fixup the docs for iio_chan_spec structure.
V5: Actually have the macro handle the _input type channels (oops)
V4: Add ability to do, _input and modified channel naming in a coherent fashion.
    Scrap all the messy IIO_CHAN_* macros and move to only one.

V3: Added more types - intensity and light.

V2: Various fixes - some thanks to Arnd.
    Bug fix for unregistering of event attr group
    Changed iio_read_channel_info to have two part value - use for
    raw value read as well.
    constify the channelspec structures
    raw write support for calibbias and similar
    Additional strings for buidling attribute names.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/chrdev.h            |    3 +
 drivers/staging/iio/iio.h               |  208 +++++++++-
 drivers/staging/iio/industrialio-core.c |  738 +++++++++++++++++++++++++++++--
 drivers/staging/iio/industrialio-ring.c |  188 ++++++++-
 drivers/staging/iio/ring_generic.h      |   20 +
 drivers/staging/iio/sysfs.h             |   58 ++-
 6 files changed, 1161 insertions(+), 54 deletions(-)

diff --git a/drivers/staging/iio/chrdev.h b/drivers/staging/iio/chrdev.h
index 4fcb99c..62c4285 100644
--- a/drivers/staging/iio/chrdev.h
+++ b/drivers/staging/iio/chrdev.h
@@ -91,6 +91,9 @@ struct iio_event_interface {
 	void					*private;
 	char					_name[35];
 	char					_attrname[20];
+
+	struct list_head event_attr_list;
+	struct list_head dev_attr_list;
 };
 
 /**
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 80ef2cf..440704c 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -26,6 +26,161 @@
 
 struct iio_dev;
 
+/* naughty temporary hack to match these against the event version
+   - need to flattern these together */
+enum iio_chan_type {
+	/* Need this here for now to support buffer events
+	 * set to 0  to avoid changes to ring_generic.c */
+	IIO_BUFFER = 0,
+
+	/* real channel types */
+	IIO_IN,
+	IIO_ACCEL,
+	IIO_IN_DIFF,
+	IIO_GYRO,
+	IIO_MAGN,
+	IIO_LIGHT,
+	IIO_INTENSITY,
+	IIO_PROXIMITY,
+	IIO_TEMP,
+	IIO_INCLI,
+	IIO_ROT,
+	IIO_ANGL,
+	IIO_TIMESTAMP,
+};
+
+#define IIO_MOD_X			0
+#define IIO_MOD_LIGHT_BOTH		0
+#define IIO_MOD_Y			1
+#define IIO_MOD_LIGHT_IR		1
+#define IIO_MOD_Z			2
+#define IIO_MOD_X_AND_Y			3
+#define IIO_MOD_X_ANX_Z			4
+#define IIO_MOD_Y_AND_Z			5
+#define IIO_MOD_X_AND_Y_AND_Z		6
+#define IIO_MOD_X_OR_Y			7
+#define IIO_MOD_X_OR_Z			8
+#define IIO_MOD_Y_OR_Z			9
+#define IIO_MOD_X_OR_Y_OR_Z		10
+
+/* Could add the raw attributes as well - allowing buffer only devices */
+enum iio_chan_info_enum {
+	IIO_CHAN_INFO_SCALE_SHARED,
+	IIO_CHAN_INFO_SCALE_SEPARATE,
+	IIO_CHAN_INFO_OFFSET_SHARED,
+	IIO_CHAN_INFO_OFFSET_SEPARATE,
+	IIO_CHAN_INFO_CALIBSCALE_SHARED,
+	IIO_CHAN_INFO_CALIBSCALE_SEPARATE,
+	IIO_CHAN_INFO_CALIBBIAS_SHARED,
+	IIO_CHAN_INFO_CALIBBIAS_SEPARATE
+};
+
+/**
+ * struct iio_chan_spec - specification of a single channel
+ * @type:		What type of measurement is the channel making.
+ * @channel:		What number or name do we wish to asign the channel.
+ * @channel2:		If there is a second number for a differential
+ *			channel then this is it. If modified is set then the
+ *			value here specifies the modifier.
+ * @address:		Driver specific identifier.
+ * @scan_index:	Monotonic index to give ordering in scans when read
+ *			from a buffer.
+ * @scan_type:		Sign:		's' or 'u' to specify signed or unsigned
+ *			realbits:	Number of valid bits of data
+ *			storage_bits:	Realbits + padding
+ *			shift:		Shift right by this before masking out
+ *					realbits.
+ * @info_mask:		What information is to be exported about this channel.
+ *			This includes calibbias, scale etc.
+ * @event_mask:	What events can this channel produce.
+ * @extend_name:	Allows labeling of channel attributes with an
+ *			informative name. Note this has no effect codes etc,
+ *			unlike modifiers.
+ * @processed_val:	Flag to specify the data access attribute should be
+ *			*_input rather than *_raw.
+ * @modified:		Does a modifier apply to this channel. What these are
+ *			depends on the channel type.  Modifier is set in
+ *			channel2. Examples are IIO_MOD_X for axial sensors about
+ *			the 'x' axis.
+ * @indexed:		Specify the channel has a numerical index. If not,
+ *			the value in channel will be suppressed for attribute
+ *			but not for event codes. Typically set it to 0 when
+ *			the index is false.
+ * @shared_handler:	Single handler for the events registered.
+ */
+struct iio_chan_spec {
+	enum iio_chan_type	type;
+	int			channel;
+	int			channel2;
+	unsigned long		address;
+	int			scan_index;
+	struct {
+		char	sign;
+		u8	realbits;
+		u8	storagebits;
+		u8	shift;
+	} scan_type;
+	const long		info_mask;
+	const long		event_mask;
+	const char		*extend_name;
+	unsigned		processed_val:1;
+	unsigned		modified:1;
+	unsigned		indexed:1;
+	/* TODO: investigate pushing shared event handling out to
+	 * the drivers */
+	struct iio_event_handler_list *shared_handler;
+};
+/* Meant for internal use only */
+void __iio_device_attr_deinit(struct device_attribute *dev_attr);
+int __iio_device_attr_init(struct device_attribute *dev_attr,
+			   const char *postfix,
+			   struct iio_chan_spec const *chan,
+			   ssize_t (*readfunc)(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf),
+			   ssize_t (*writefunc)(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf,
+						size_t len),
+			   bool generic);
+#define IIO_ST(si, rb, sb, sh)						\
+	{ .sign = si, .realbits = rb, .storagebits = sb, .shift = sh }
+
+#define IIO_CHAN(_type, _mod, _indexed, _proc, _name, _chan, _chan2,	\
+		 _inf_mask, _address, _si, _stype, _event_mask,		\
+		 _handler)						\
+	{ .type = _type,						\
+	  .modified = _mod,						\
+	  .indexed = _indexed,						\
+	  .processed_val = _proc,					\
+	  .extend_name = _name,						\
+	  .channel = _chan,						\
+	  .channel2 = _chan2,						\
+	  .info_mask = _inf_mask,					\
+	  .address = _address,						\
+	  .scan_index = _si,						\
+	  .scan_type = _stype,						\
+	  .event_mask = _event_mask,					\
+	  .shared_handler = _handler }
+
+#define IIO_CHAN_SOFT_TIMESTAMP(_si)					\
+	{ .type = IIO_TIMESTAMP, .channel = -1,				\
+			.scan_index = _si, .scan_type = IIO_ST('s', 64, 64, 0) }
+
+int __iio_add_chan_devattr(const char *postfix,
+			   const char *group,
+			   struct iio_chan_spec const *chan,
+			   ssize_t (*func)(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf),
+			   ssize_t (*writefunc)(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf,
+						size_t len),
+			   int mask,
+			   bool generic,
+			   struct device *dev,
+			   struct list_head *attr_list);
 /**
  * iio_get_time_ns() - utility function to get a time stamp for events etc
  **/
@@ -70,7 +225,8 @@ void iio_remove_event_from_list(struct iio_event_handler_list *el,
 
 /* Vast majority of this is set by the industrialio subsystem on a
  * call to iio_device_register. */
-
+#define IIO_VAL_INT 1
+#define IIO_VAL_INT_PLUS_MICRO 2
 /**
  * struct iio_dev - industrial I/O device
  * @id:			[INTERN] used to identify device internally
@@ -93,6 +249,24 @@ void iio_remove_event_from_list(struct iio_event_handler_list *el,
  * @available_scan_masks: [DRIVER] optional array of allowed bitmasks
  * @trig:		[INTERN] current device trigger (ring buffer modes)
  * @pollfunc:		[DRIVER] function run on trigger being received
+ * @channels:		[DRIVER] channel specification structure table
+ * @num_channels:	[DRIVER] number of chanels specified in @channels.
+ * @channel_attr_list:	[INTERN] keep track of automatically created channel
+ *			attributes.
+ * @name:		[DRIVER] name of the device.
+ * @read_raw:		[DRIVER] function to request a value from the device.
+ *			mask specifies which value. Note 0 means a reading of
+ *			the channel in question.  Return value will specify the
+ *			type of value returned by the device. val and val2 will
+ *			contain the elements making up the returned value.
+ * @write_raw:		[DRIVER] function to write a value to the device.
+ *			Parameters are the same as for read_raw.
+ * @read_event_config:	[DRIVER] find out if the event is enabled.
+ * @write_event_config:	[DRIVER] set if the event is enabled.
+ * @read_event_value:	[DRIVER] read a value associated with the event. Meaning
+ *			is event dependant. event_code specifies which event.
+ * @write_event_value:	[DRIVER] write the value associate with the event.
+ *			Meaning is event dependent.
  **/
 struct iio_dev {
 	int				id;
@@ -116,6 +290,38 @@ struct iio_dev {
 	u32				*available_scan_masks;
 	struct iio_trigger		*trig;
 	struct iio_poll_func		*pollfunc;
+
+	struct iio_chan_spec const *channels;
+	int num_channels;
+	struct list_head channel_attr_list;
+
+	char *name; /*device name - IMPLEMENT */
+	int (*read_raw)(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan,
+			int *val,
+			int *val2,
+			long mask);
+
+	int (*write_raw)(struct iio_dev *indio_dev,
+			 struct iio_chan_spec const *chan,
+			 int val,
+			 int val2,
+			 long mask);
+
+	int (*read_event_config)(struct iio_dev *indio_dev,
+				 int event_code);
+
+	int (*write_event_config)(struct iio_dev *indio_dev,
+				  int event_code,
+				  struct iio_event_handler_list *listel,
+				  int state);
+
+	int (*read_event_value)(struct iio_dev *indio_dev,
+				int event_code,
+				int *val);
+	int (*write_event_value)(struct iio_dev *indio_dev,
+				 int event_code,
+				 int val);
 };
 
 /**
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 3a82414..b67394c 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -44,6 +44,44 @@ struct bus_type iio_bus_type = {
 };
 EXPORT_SYMBOL(iio_bus_type);
 
+static const char * const iio_chan_type_name_spec_shared[] = {
+	[IIO_TIMESTAMP] = "timestamp",
+	[IIO_ACCEL] = "accel",
+	[IIO_IN] = "in",
+	[IIO_IN_DIFF] = "in-in",
+	[IIO_GYRO] = "gyro",
+	[IIO_TEMP] = "temp",
+	[IIO_MAGN] = "magn",
+	[IIO_INCLI] = "incli",
+	[IIO_ROT] = "rot",
+	[IIO_INTENSITY] = "intensity",
+	[IIO_LIGHT] = "illuminance",
+	[IIO_ANGL] = "angl",
+};
+
+static const char * const iio_chan_type_name_spec_complex[] = {
+	[IIO_IN_DIFF] = "in%d-in%d",
+};
+
+static const char * const iio_modifier_names_light[] = {
+	[IIO_MOD_LIGHT_BOTH] = "both",
+	[IIO_MOD_LIGHT_IR] = "ir",
+};
+
+static const char * const iio_modifier_names_axial[] = {
+	[IIO_MOD_X] = "x",
+	[IIO_MOD_Y] = "y",
+	[IIO_MOD_Z] = "z",
+};
+
+/* relies on pairs of these shared then separate */
+static const char * const iio_chan_info_postfix[] = {
+	[IIO_CHAN_INFO_SCALE_SHARED/2] = "scale",
+	[IIO_CHAN_INFO_OFFSET_SHARED/2] = "offset",
+	[IIO_CHAN_INFO_CALIBSCALE_SHARED/2] = "calibscale",
+	[IIO_CHAN_INFO_CALIBBIAS_SHARED/2] = "calibbias",
+};
+
 void __iio_change_event(struct iio_detected_event_list *ev,
 			int ev_code,
 			s64 timestamp)
@@ -488,24 +526,375 @@ static void __exit iio_exit(void)
 	bus_unregister(&iio_bus_type);
 }
 
-static int iio_device_register_sysfs(struct iio_dev *dev_info)
+static ssize_t iio_read_channel_info(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
 {
-	int ret = 0;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int val, val2;
+	int ret = indio_dev->read_raw(indio_dev, this_attr->c,
+				      &val, &val2, this_attr->address);
 
-	ret = sysfs_create_group(&dev_info->dev.kobj, dev_info->attrs);
-	if (ret) {
-		dev_err(dev_info->dev.parent,
-			"Failed to register sysfs hooks\n");
+	if (ret < 0)
+		return ret;
+
+	if (ret == IIO_VAL_INT)
+		return sprintf(buf, "%d\n", val);
+	else if (ret == IIO_VAL_INT_PLUS_MICRO) {
+		if (val2 < 0)
+			return sprintf(buf, "-%d.%06u\n", val, -val2);
+		else
+			return sprintf(buf, "%d.%06u\n", val, val2);
+	} else
+		return 0;
+}
+
+static ssize_t iio_write_channel_info(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf,
+				      size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int ret, integer = 0, micro = 0, micro_mult = 100000;
+	bool integer_part = true, negative = false;
+
+	/* Assumes decimal - precision based on number of digits */
+	if (!indio_dev->write_raw)
+		return -EINVAL;
+	if (buf[0] == '-') {
+		negative = true;
+		buf++;
+	}
+	while (*buf) {
+		if ('0' <= *buf && *buf <= '9') {
+			if (integer_part)
+				integer = integer*10 + *buf - '0';
+			else {
+				micro += micro_mult*(*buf - '0');
+				if (micro_mult == 1)
+					break;
+				micro_mult /= 10;
+			}
+		} else if (*buf == '\n') {
+			if (*(buf + 1) == '\0')
+				break;
+			else
+				return -EINVAL;
+		} else if (*buf == '.') {
+			integer_part = false;
+		} else {
+			return -EINVAL;
+		}
+		buf++;
+	}
+	if (negative) {
+		if (integer)
+			integer = -integer;
+		else
+			micro = -micro;
+	}
+
+	ret = indio_dev->write_raw(indio_dev, this_attr->c,
+				       integer, micro, this_attr->address);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static int __iio_build_postfix(struct iio_chan_spec const *chan,
+			       bool generic,
+			       const char *postfix,
+			       char **result)
+{
+	char *all_post;
+	/* 3 options - generic, extend_name, modified - if generic, extend_name
+	* and modified cannot apply.*/
+
+	if (generic || (!chan->modified && !chan->extend_name)) {
+		all_post = kasprintf(GFP_KERNEL, "%s", postfix);
+	} else if (chan->modified) {
+		const char *intermediate;
+		switch (chan->type) {
+		case IIO_INTENSITY:
+			intermediate
+				= iio_modifier_names_light[chan->channel2];
+			break;
+		case IIO_ACCEL:
+		case IIO_GYRO:
+		case IIO_MAGN:
+		case IIO_INCLI:
+		case IIO_ROT:
+		case IIO_ANGL:
+			intermediate
+				= iio_modifier_names_axial[chan->channel2];
+			break;
+		default:
+			return -EINVAL;
+		}
+		if (chan->extend_name)
+			all_post = kasprintf(GFP_KERNEL, "%s_%s_%s",
+					     intermediate,
+					     chan->extend_name,
+					     postfix);
+		else
+			all_post = kasprintf(GFP_KERNEL, "%s_%s",
+					     intermediate,
+					     postfix);
+	} else
+		all_post = kasprintf(GFP_KERNEL, "%s_%s", chan->extend_name,
+				     postfix);
+	if (all_post == NULL)
+		return -ENOMEM;
+	*result = all_post;
+	return 0;
+}
+
+int __iio_device_attr_init(struct device_attribute *dev_attr,
+			   const char *postfix,
+			   struct iio_chan_spec const *chan,
+			   ssize_t (*readfunc)(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf),
+			   ssize_t (*writefunc)(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf,
+						size_t len),
+			   bool generic)
+{
+	int ret;
+	char *name_format, *full_postfix;
+	sysfs_attr_init(&dev_attr->attr);
+	ret = __iio_build_postfix(chan, generic, postfix, &full_postfix);
+	if (ret)
+		goto error_ret;
+
+	/* Special case for types that uses both channel numbers in naming */
+	if (chan->type == IIO_IN_DIFF && !generic)
+		name_format
+			= kasprintf(GFP_KERNEL, "%s_%s",
+				    iio_chan_type_name_spec_complex[chan->type],
+				    full_postfix);
+	else if (generic || !chan->indexed)
+		name_format
+			= kasprintf(GFP_KERNEL, "%s_%s",
+				    iio_chan_type_name_spec_shared[chan->type],
+				    full_postfix);
+	else
+		name_format
+			= kasprintf(GFP_KERNEL, "%s%d_%s",
+				    iio_chan_type_name_spec_shared[chan->type],
+				    chan->channel,
+				    full_postfix);
+
+	if (name_format == NULL) {
+		ret = -ENOMEM;
+		goto error_free_full_postfix;
+	}
+	dev_attr->attr.name = kasprintf(GFP_KERNEL,
+					name_format,
+					chan->channel,
+					chan->channel2);
+	if (dev_attr->attr.name == NULL) {
+		ret = -ENOMEM;
+		goto error_free_name_format;
+	}
+
+	if (readfunc) {
+		dev_attr->attr.mode |= S_IRUGO;
+		dev_attr->show = readfunc;
+	}
+
+	if (writefunc) {
+		dev_attr->attr.mode |= S_IWUSR;
+		dev_attr->store = writefunc;
+	}
+	kfree(name_format);
+	kfree(full_postfix);
+
+	return 0;
+
+error_free_name_format:
+	kfree(name_format);
+error_free_full_postfix:
+	kfree(full_postfix);
+error_ret:
+	return ret;
+}
+
+void __iio_device_attr_deinit(struct device_attribute *dev_attr)
+{
+	kfree(dev_attr->attr.name);
+}
+
+int __iio_add_chan_devattr(const char *postfix,
+			   const char *group,
+			   struct iio_chan_spec const *chan,
+			   ssize_t (*readfunc)(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf),
+			   ssize_t (*writefunc)(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf,
+						size_t len),
+			   int mask,
+			   bool generic,
+			   struct device *dev,
+			   struct list_head *attr_list)
+{
+	int ret;
+	struct iio_dev_attr *iio_attr, *t;
+
+	iio_attr = kzalloc(sizeof *iio_attr, GFP_KERNEL);
+	if (iio_attr == NULL) {
+		ret = -ENOMEM;
 		goto error_ret;
 	}
+	ret = __iio_device_attr_init(&iio_attr->dev_attr,
+				     postfix, chan,
+				     readfunc, writefunc, generic);
+	if (ret)
+		goto error_iio_dev_attr_free;
+	iio_attr->c = chan;
+	iio_attr->address = mask;
+	list_for_each_entry(t, attr_list, l)
+		if (strcmp(t->dev_attr.attr.name,
+			   iio_attr->dev_attr.attr.name) == 0) {
+			if (!generic)
+				dev_err(dev, "tried to double register : %s\n",
+					t->dev_attr.attr.name);
+			ret = -EBUSY;
+			goto error_device_attr_deinit;
+		}
+
+	ret = sysfs_add_file_to_group(&dev->kobj,
+				      &iio_attr->dev_attr.attr, group);
+	if (ret < 0)
+		goto error_device_attr_deinit;
+
+	list_add(&iio_attr->l, attr_list);
+
+	return 0;
+
+error_device_attr_deinit:
+	__iio_device_attr_deinit(&iio_attr->dev_attr);
+error_iio_dev_attr_free:
+	kfree(iio_attr);
+error_ret:
+	return ret;
+}
+
+static int iio_device_add_channel_sysfs(struct iio_dev *dev_info,
+					struct iio_chan_spec const *chan)
+{
+	int ret, i;
+
+
+	if (chan->channel < 0)
+		return 0;
+	if (chan->processed_val)
+		ret = __iio_add_chan_devattr("input", NULL, chan,
+					     &iio_read_channel_info,
+					     NULL,
+					     0,
+					     0,
+					     &dev_info->dev,
+					     &dev_info->channel_attr_list);
+	else
+		ret = __iio_add_chan_devattr("raw", NULL, chan,
+					     &iio_read_channel_info,
+					     NULL,
+					     0,
+					     0,
+					     &dev_info->dev,
+					     &dev_info->channel_attr_list);
+	if (ret)
+		goto error_ret;
+
+	for_each_set_bit(i, &chan->info_mask, sizeof(long)*8) {
+		ret = __iio_add_chan_devattr(iio_chan_info_postfix[i/2],
+					     NULL, chan,
+					     &iio_read_channel_info,
+					     &iio_write_channel_info,
+					     (1 << i),
+					     !(i%2),
+					     &dev_info->dev,
+					     &dev_info->channel_attr_list);
+		if (ret == -EBUSY && (i%2 == 0)) {
+			ret = 0;
+			continue;
+		}
+		if (ret < 0)
+			goto error_ret;
+	}
+error_ret:
+	return ret;
+}
+
+static void iio_device_remove_and_free_read_attr(struct iio_dev *dev_info,
+						 struct iio_dev_attr *p)
+{
+	sysfs_remove_file_from_group(&dev_info->dev.kobj,
+				     &p->dev_attr.attr, NULL);
+	kfree(p->dev_attr.attr.name);
+	kfree(p);
+}
+
+static int iio_device_register_sysfs(struct iio_dev *dev_info)
+{
+	int i, ret = 0;
+	struct iio_dev_attr *p, *n;
+
+	if (dev_info->attrs) {
+		ret = sysfs_create_group(&dev_info->dev.kobj, dev_info->attrs);
+		if (ret) {
+			dev_err(dev_info->dev.parent,
+				"Failed to register sysfs hooks\n");
+			goto error_ret;
+		}
+	}
 
+	/*
+	 * New channel registration method - relies on the fact a group does
+	 *  not need to be initialized if it is name is NULL.
+	 */
+	INIT_LIST_HEAD(&dev_info->channel_attr_list);
+	if (dev_info->channels)
+		for (i = 0; i < dev_info->num_channels; i++) {
+			ret = iio_device_add_channel_sysfs(dev_info,
+							   &dev_info
+							   ->channels[i]);
+			if (ret < 0)
+				goto error_clear_attrs;
+		}
+
+	return 0;
+error_clear_attrs:
+	list_for_each_entry_safe(p, n,
+				 &dev_info->channel_attr_list, l) {
+		list_del(&p->l);
+		iio_device_remove_and_free_read_attr(dev_info, p);
+	}
+	if (dev_info->attrs)
+		sysfs_remove_group(&dev_info->dev.kobj, dev_info->attrs);
 error_ret:
 	return ret;
+
 }
 
 static void iio_device_unregister_sysfs(struct iio_dev *dev_info)
 {
-	sysfs_remove_group(&dev_info->dev.kobj, dev_info->attrs);
+
+	struct iio_dev_attr *p, *n;
+	list_for_each_entry_safe(p, n, &dev_info->channel_attr_list, l) {
+		list_del(&p->l);
+		iio_device_remove_and_free_read_attr(dev_info, p);
+	}
+
+	if (dev_info->attrs)
+		sysfs_remove_group(&dev_info->dev.kobj, dev_info->attrs);
 }
 
 /* Return a negative errno on failure */
@@ -552,8 +941,277 @@ static void iio_device_unregister_id(struct iio_dev *dev_info)
 	iio_free_ida_val(&iio_ida, dev_info->id);
 }
 
+static const char * const iio_ev_type_text[] = {
+	[IIO_EV_TYPE_THRESH] = "thresh",
+	[IIO_EV_TYPE_MAG] = "mag",
+	[IIO_EV_TYPE_ROC] = "roc"
+};
+
+static const char * const iio_ev_dir_text[] = {
+	[IIO_EV_DIR_EITHER] = "either",
+	[IIO_EV_DIR_RISING] = "rising",
+	[IIO_EV_DIR_FALLING] = "falling"
+};
+
+static ssize_t iio_ev_state_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf,
+				  size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
+	int ret;
+	unsigned long val;
+	ret = strict_strtoul(buf, 10, &val);
+	if (ret || val < 0 || val > 1)
+		return -EINVAL;
+
+	ret = indio_dev->write_event_config(indio_dev, this_attr->mask,
+					    this_attr->listel,
+					    val);
+	return (ret < 0) ? ret : len;
+}
+
+static ssize_t iio_ev_state_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
+	int val = indio_dev->read_event_config(indio_dev, this_attr->mask);
+
+	if (val < 0)
+		return val;
+	else
+		return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t iio_ev_value_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int val, ret;
+
+	ret = indio_dev->read_event_value(indio_dev,
+					  this_attr->address, &val);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t iio_ev_value_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf,
+				  size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	unsigned long val;
+	int ret;
+
+	ret = strict_strtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	ret = indio_dev->write_event_value(indio_dev, this_attr->address,
+					   val);
+	if (ret < 0)
+		return ret;
+
+	return len;
+}
+
+static int __iio_add_chan_event_attr(const char *postfix,
+				     const char *group,
+				     struct iio_chan_spec const *chan,
+				     unsigned int mask,
+				     struct device *dev,
+				     struct list_head *attr_list)
+{
+	char *name_format, *full_postfix;
+	int ret;
+	struct iio_event_attr *iio_ev_attr;
+
+	iio_ev_attr = kzalloc(sizeof *iio_ev_attr, GFP_KERNEL);
+	if (iio_ev_attr == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	sysfs_attr_init(&iio_ev_attr->dev_attr.attr);
+	ret = __iio_build_postfix(chan, 0, postfix, &full_postfix);
+	if (ret)
+		goto error_ret;
+	/* Special case for types that uses both channel numbers in naming */
+	if (chan->type == IIO_IN_DIFF)
+		name_format
+			= kasprintf(GFP_KERNEL, "%s_%s",
+				    iio_chan_type_name_spec_complex[chan->type],
+				    full_postfix);
+	else if (!chan->indexed)
+		name_format
+			= kasprintf(GFP_KERNEL, "%s_%s",
+				    iio_chan_type_name_spec_shared[chan->type],
+				    full_postfix);
+	else
+		name_format
+			= kasprintf(GFP_KERNEL, "%s%d_%s",
+				    iio_chan_type_name_spec_shared[chan->type],
+				    chan->channel,
+				    full_postfix);
+	if (name_format == NULL) {
+		ret = -ENOMEM;
+		goto error_free_attr;
+	}
+
+	iio_ev_attr->dev_attr.attr.name = kasprintf(GFP_KERNEL,
+						    name_format,
+						    chan->channel,
+						    chan->channel2);
+	if (iio_ev_attr->dev_attr.attr.name == NULL) {
+		ret = -ENOMEM;
+		goto error_free_name_format;
+	}
+
+	iio_ev_attr->dev_attr.attr.mode = S_IRUGO | S_IWUSR;
+	iio_ev_attr->dev_attr.show = &iio_ev_state_show;
+	iio_ev_attr->dev_attr.store = &iio_ev_state_store;
+	iio_ev_attr->mask = mask;
+	iio_ev_attr->listel = chan->shared_handler;
+	ret = sysfs_add_file_to_group(&dev->kobj,
+				      &iio_ev_attr->dev_attr.attr,
+				      group);
+	if (ret < 0)
+		goto error_free_name;
+	list_add(&iio_ev_attr->l, attr_list);
+	kfree(name_format);
+	return 0;
+
+error_free_name:
+	kfree(iio_ev_attr->dev_attr.attr.name);
+error_free_name_format:
+	kfree(name_format);
+error_free_attr:
+	kfree(iio_ev_attr);
+error_ret:
+	return ret;
+}
+
+
+static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
+				      struct iio_chan_spec const *chan)
+{
+
+	int ret = 0, i, mask;
+	char *postfix;
+	if (!chan->event_mask)
+		return 0;
+
+	for_each_set_bit(i, &chan->event_mask, sizeof(chan->event_mask)*8) {
+		postfix = kasprintf(GFP_KERNEL, "%s_%s_en",
+				    iio_ev_type_text[i/IIO_EV_TYPE_MAX],
+				    iio_ev_dir_text[i%IIO_EV_TYPE_MAX]);
+		if (postfix == NULL) {
+			ret = -ENOMEM;
+			goto error_ret;
+		}
+		switch (chan->type) {
+			/* Switch this to a table at some point */
+		case IIO_IN:
+			mask = IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
+						    i/IIO_EV_TYPE_MAX,
+						    i%IIO_EV_TYPE_MAX);
+			break;
+		case IIO_ACCEL:
+			mask = IIO_MOD_EVENT_CODE(chan->type, 0, chan->channel,
+						  i/IIO_EV_TYPE_MAX,
+						  i%IIO_EV_TYPE_MAX);
+			break;
+		case IIO_IN_DIFF:
+			mask = IIO_MOD_EVENT_CODE(chan->type, chan->channel,
+						  chan->channel2,
+						  i/IIO_EV_TYPE_MAX,
+						  i%IIO_EV_TYPE_MAX);
+			break;
+		default:
+			printk(KERN_INFO "currently unhandled type of event\n");
+		}
+		ret = __iio_add_chan_event_attr(postfix,
+						NULL,
+						chan,
+						mask,
+						/*HACK. - limits us to one
+						  event interface - fix by
+						  extending the bitmask - but
+						  how far*/
+						&dev_info->event_interfaces[0]
+						.dev,
+						&dev_info->event_interfaces[0].
+						event_attr_list);
+		kfree(postfix);
+		if (ret)
+			goto error_ret;
+
+		postfix = kasprintf(GFP_KERNEL, "%s_%s_value",
+				    iio_ev_type_text[i/IIO_EV_TYPE_MAX],
+				    iio_ev_dir_text[i%IIO_EV_TYPE_MAX]);
+		if (postfix == NULL) {
+			ret = -ENOMEM;
+			goto error_ret;
+		}
+		ret = __iio_add_chan_devattr(postfix, NULL, chan,
+					     iio_ev_value_show,
+					     iio_ev_value_store,
+					     mask,
+					     0,
+					     &dev_info->event_interfaces[0]
+					     .dev,
+					     &dev_info->event_interfaces[0]
+					     .dev_attr_list);
+		kfree(postfix);
+		if (ret)
+			goto error_ret;
+
+	}
+
+error_ret:
+	return ret;
+}
+
+static inline void __iio_remove_all_event_sysfs(struct iio_dev *dev_info,
+						const char *groupname,
+						int num)
+{
+	struct iio_dev_attr *p, *n;
+	struct iio_event_attr *q, *m;
+	list_for_each_entry_safe(p, n,
+				 &dev_info->event_interfaces[num].
+				 dev_attr_list, l) {
+		sysfs_remove_file_from_group(&dev_info
+					     ->event_interfaces[num].dev.kobj,
+					     &p->dev_attr.attr,
+					     groupname);
+		kfree(p->dev_attr.attr.name);
+		kfree(p);
+	}
+	list_for_each_entry_safe(q, m,
+				 &dev_info->event_interfaces[num].
+				 event_attr_list, l) {
+		sysfs_remove_file_from_group(&dev_info
+					     ->event_interfaces[num].dev.kobj,
+					     &q->dev_attr.attr,
+					     groupname);
+		kfree(q->dev_attr.attr.name);
+		kfree(q);
+	}
+}
+
 static inline int __iio_add_event_config_attrs(struct iio_dev *dev_info, int i)
 {
+	int j;
 	int ret;
 	/*p for adding, q for removing */
 	struct attribute **attrp, **attrq;
@@ -561,23 +1219,42 @@ static inline int __iio_add_event_config_attrs(struct iio_dev *dev_info, int i)
 	if (dev_info->event_conf_attrs && dev_info->event_conf_attrs[i].attrs) {
 		attrp = dev_info->event_conf_attrs[i].attrs;
 		while (*attrp) {
-			ret =  sysfs_add_file_to_group(&dev_info->dev.kobj,
+			ret =  sysfs_add_file_to_group(&dev_info
+						       ->event_interfaces[0]
+						       .dev.kobj,
 						       *attrp,
-						       dev_info
-						       ->event_attrs[i].name);
+						       NULL);
 			if (ret)
 				goto error_ret;
 			attrp++;
 		}
 	}
+	INIT_LIST_HEAD(&dev_info->event_interfaces[0].event_attr_list);
+	INIT_LIST_HEAD(&dev_info->event_interfaces[0].dev_attr_list);
+	/* Dynically created from the channels array */
+	if (dev_info->channels) {
+		for (j = 0; j < dev_info->num_channels; j++) {
+			ret = iio_device_add_event_sysfs(dev_info,
+							 &dev_info
+							 ->channels[j]);
+			if (ret)
+				goto error_clear_attrs;
+		}
+	}
 	return 0;
 
+error_clear_attrs:
+	__iio_remove_all_event_sysfs(dev_info,
+				     NULL,
+				     i);
 error_ret:
 	attrq = dev_info->event_conf_attrs[i].attrs;
 	while (attrq != attrp) {
-			sysfs_remove_file_from_group(&dev_info->dev.kobj,
-					     *attrq,
-					     dev_info->event_attrs[i].name);
+			sysfs_remove_file_from_group(&dev_info
+						     ->event_interfaces[0]
+						     .dev.kobj,
+						     *attrq,
+						     NULL);
 		attrq++;
 	}
 
@@ -588,15 +1265,18 @@ static inline int __iio_remove_event_config_attrs(struct iio_dev *dev_info,
 						  int i)
 {
 	struct attribute **attrq;
-
+	__iio_remove_all_event_sysfs(dev_info,
+				     NULL,
+				     i);
 	if (dev_info->event_conf_attrs
 		&& dev_info->event_conf_attrs[i].attrs) {
 		attrq = dev_info->event_conf_attrs[i].attrs;
 		while (*attrq) {
-			sysfs_remove_file_from_group(&dev_info->dev.kobj,
+			sysfs_remove_file_from_group(&dev_info
+						     ->event_interfaces[0]
+						     .dev.kobj,
 						     *attrq,
-						     dev_info
-						     ->event_attrs[i].name);
+						     NULL);
 			attrq++;
 		}
 	}
@@ -650,10 +1330,12 @@ static int iio_device_register_eventset(struct iio_dev *dev_info)
 
 		dev_set_drvdata(&dev_info->event_interfaces[i].dev,
 				(void *)dev_info);
-		ret = sysfs_create_group(&dev_info
-					->event_interfaces[i]
-					.dev.kobj,
-					&dev_info->event_attrs[i]);
+
+		if (dev_info->event_attrs != NULL)
+			ret = sysfs_create_group(&dev_info
+						 ->event_interfaces[i]
+						 .dev.kobj,
+						 &dev_info->event_attrs[i]);
 
 		if (ret) {
 			dev_err(&dev_info->dev,
@@ -676,7 +1358,8 @@ error_unregister_config_attrs:
 	i = dev_info->num_interrupt_lines - 1;
 error_remove_sysfs_interfaces:
 	for (j = 0; j < i; j++)
-		sysfs_remove_group(&dev_info
+		if (dev_info->event_attrs != NULL)
+			sysfs_remove_group(&dev_info
 				   ->event_interfaces[j].dev.kobj,
 				   &dev_info->event_attrs[j]);
 error_free_setup_ev_ints:
@@ -696,10 +1379,13 @@ static void iio_device_unregister_eventset(struct iio_dev *dev_info)
 
 	if (dev_info->num_interrupt_lines == 0)
 		return;
-	for (i = 0; i < dev_info->num_interrupt_lines; i++)
-		sysfs_remove_group(&dev_info
-				   ->event_interfaces[i].dev.kobj,
-				   &dev_info->event_attrs[i]);
+	for (i = 0; i < dev_info->num_interrupt_lines; i++) {
+		__iio_remove_event_config_attrs(dev_info, i);
+		if (dev_info->event_attrs != NULL)
+			sysfs_remove_group(&dev_info
+					   ->event_interfaces[i].dev.kobj,
+					   &dev_info->event_attrs[i]);
+	}
 
 	for (i = 0; i < dev_info->num_interrupt_lines; i++)
 		iio_free_ev_int(&dev_info->event_interfaces[i]);
diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
index 3f6bee0..d6b4bb7 100644
--- a/drivers/staging/iio/industrialio-ring.c
+++ b/drivers/staging/iio/industrialio-ring.c
@@ -233,9 +233,162 @@ void iio_ring_buffer_init(struct iio_ring_buffer *ring,
 }
 EXPORT_SYMBOL(iio_ring_buffer_init);
 
-int iio_ring_buffer_register(struct iio_ring_buffer *ring, int id)
+static ssize_t iio_show_scan_index(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	return sprintf(buf, "%u\n", this_attr->c->scan_index);
+}
+
+static ssize_t iio_show_fixed_type(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	return sprintf(buf, "%c%d/%d>>%u\n",
+		       this_attr->c->scan_type.sign,
+		       this_attr->c->scan_type.realbits,
+		       this_attr->c->scan_type.storagebits,
+		       this_attr->c->scan_type.shift);
+}
+
+static int __iio_add_chan_scan_elattr(const char *postfix,
+				      const char *group,
+				      const struct iio_chan_spec *chan,
+				      struct device *dev,
+				      struct list_head *attr_list)
 {
 	int ret;
+	struct iio_scan_el *scan_el;
+
+	scan_el = kzalloc(sizeof *scan_el, GFP_KERNEL);
+	if (scan_el == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+	if (chan->type != IIO_TIMESTAMP)
+		ret = __iio_device_attr_init(&scan_el->dev_attr, postfix, chan,
+					     iio_scan_el_show,
+					     iio_scan_el_store, 0);
+	else /*
+	      * Timestamp handled separately because it simplifies a lot of
+	      * drivers by ensuring they don't have to know its magic index
+	      */
+		ret = __iio_device_attr_init(&scan_el->dev_attr, postfix, chan,
+					     iio_scan_el_ts_show,
+					     iio_scan_el_ts_store, 0);
+	if (ret)
+		goto error_free_scan_el;
+
+	scan_el->number = chan->scan_index;
+
+	ret = sysfs_add_file_to_group(&dev->kobj,
+				      &scan_el->dev_attr.attr,
+				      group);
+	if (ret < 0)
+		goto error_device_attr_deinit;
+
+	list_add(&scan_el->l, attr_list);
+
+	return 0;
+error_device_attr_deinit:
+	__iio_device_attr_deinit(&scan_el->dev_attr);
+error_free_scan_el:
+	kfree(scan_el);
+error_ret:
+	return ret;
+}
+
+static int iio_ring_add_channel_sysfs(struct iio_ring_buffer *ring,
+				      const struct iio_chan_spec *chan)
+{
+	int ret;
+
+	ret = __iio_add_chan_devattr("index", "scan_elements",
+				     chan,
+				     &iio_show_scan_index,
+				     NULL,
+				     0,
+				     0,
+				     &ring->dev,
+				     &ring->scan_el_dev_attr_list);
+	if (ret)
+		goto error_ret;
+
+	ret = __iio_add_chan_devattr("type", "scan_elements",
+				     chan,
+				     &iio_show_fixed_type,
+				     NULL,
+				     0,
+				     0,
+				     &ring->dev,
+				     &ring->scan_el_dev_attr_list);
+
+	if (ret)
+		goto error_ret;
+
+	ret = __iio_add_chan_scan_elattr("en", "scan_elements",
+					 chan, &ring->dev,
+					 &ring->scan_el_en_attr_list);
+
+error_ret:
+	return ret;
+}
+
+static void iio_ring_remove_and_free_scan_el_attr(struct iio_ring_buffer *ring,
+						  struct iio_scan_el *p)
+{
+	sysfs_remove_file_from_group(&ring->dev.kobj,
+				     &p->dev_attr.attr, "scan_elements");
+	kfree(p->dev_attr.attr.name);
+	kfree(p);
+}
+
+static void iio_ring_remove_and_free_scan_dev_attr(struct iio_ring_buffer *ring,
+						   struct iio_dev_attr *p)
+{
+	sysfs_remove_file_from_group(&ring->dev.kobj,
+				     &p->dev_attr.attr, "scan_elements");
+	kfree(p->dev_attr.attr.name);
+	kfree(p);
+}
+
+static struct attribute *iio_scan_el_dummy_attrs[] = {
+	NULL
+};
+
+static struct attribute_group iio_scan_el_dummy_group = {
+	.name = "scan_elements",
+	.attrs = iio_scan_el_dummy_attrs
+};
+
+static void __iio_ring_attr_cleanup(struct iio_ring_buffer *ring)
+{
+	struct iio_dev_attr *p, *n;
+	struct iio_scan_el *q, *m;
+	int anydynamic = !(list_empty(&ring->scan_el_dev_attr_list) &&
+			   list_empty(&ring->scan_el_en_attr_list));
+	list_for_each_entry_safe(p, n,
+				 &ring->scan_el_dev_attr_list, l)
+		iio_ring_remove_and_free_scan_dev_attr(ring, p);
+	list_for_each_entry_safe(q, m,
+				 &ring->scan_el_en_attr_list, l)
+		iio_ring_remove_and_free_scan_el_attr(ring, q);
+
+	if (ring->scan_el_attrs)
+		sysfs_remove_group(&ring->dev.kobj,
+				   ring->scan_el_attrs);
+	else if (anydynamic)
+		sysfs_remove_group(&ring->dev.kobj,
+				   &iio_scan_el_dummy_group);
+}
+
+int iio_ring_buffer_register_ex(struct iio_ring_buffer *ring, int id,
+				const struct iio_chan_spec *channels,
+				int num_channels)
+{
+	int ret, i;
 
 	ring->id = id;
 
@@ -268,9 +421,28 @@ int iio_ring_buffer_register(struct iio_ring_buffer *ring, int id)
 				"Failed to add sysfs scan elements\n");
 			goto error_free_ring_buffer_event_chrdev;
 		}
+	} else if (channels) {
+		ret = sysfs_create_group(&ring->dev.kobj,
+					 &iio_scan_el_dummy_group);
+		if (ret)
+			goto error_free_ring_buffer_event_chrdev;
 	}
 
-	return ret;
+
+	INIT_LIST_HEAD(&ring->scan_el_dev_attr_list);
+	INIT_LIST_HEAD(&ring->scan_el_en_attr_list);
+	if (channels) {
+		/* new magic */
+		for (i = 0; i < num_channels; i++) {
+			ret = iio_ring_add_channel_sysfs(ring, &channels[i]);
+			if (ret < 0)
+				goto error_cleanup_dynamic;
+		}
+	}
+
+	return 0;
+error_cleanup_dynamic:
+	__iio_ring_attr_cleanup(ring);
 error_free_ring_buffer_event_chrdev:
 	__iio_free_ring_buffer_event_chrdev(ring);
 error_remove_device:
@@ -278,14 +450,17 @@ error_remove_device:
 error_ret:
 	return ret;
 }
+EXPORT_SYMBOL(iio_ring_buffer_register_ex);
+
+int iio_ring_buffer_register(struct iio_ring_buffer *ring, int id)
+{
+	return iio_ring_buffer_register_ex(ring, id, NULL, 0);
+}
 EXPORT_SYMBOL(iio_ring_buffer_register);
 
 void iio_ring_buffer_unregister(struct iio_ring_buffer *ring)
 {
-	if (ring->scan_el_attrs)
-		sysfs_remove_group(&ring->dev.kobj,
-				   ring->scan_el_attrs);
-
+	__iio_ring_attr_cleanup(ring);
 	__iio_free_ring_buffer_access_chrdev(ring);
 	__iio_free_ring_buffer_event_chrdev(ring);
 	device_del(&ring->dev);
@@ -540,4 +715,3 @@ error_ret:
 	return ret ? ret : len;
 }
 EXPORT_SYMBOL(iio_scan_el_ts_store);
-
diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index 780c6aa..ada51c2 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -140,6 +140,8 @@ struct iio_ring_buffer {
 	int				(*predisable)(struct iio_dev *);
 	int				(*postdisable)(struct iio_dev *);
 
+	struct list_head scan_el_dev_attr_list;
+	struct list_head scan_el_en_attr_list;
 };
 
 /**
@@ -177,6 +179,7 @@ struct iio_scan_el {
 	struct device_attribute		dev_attr;
 	unsigned int			number;
 	unsigned int			label;
+	struct list_head l;
 
 	int (*set_state)(struct iio_scan_el *scanel,
 			 struct iio_dev *dev_info,
@@ -430,6 +433,14 @@ static inline void iio_put_ring_buffer(struct iio_ring_buffer *ring)
  **/
 int iio_ring_buffer_register(struct iio_ring_buffer *ring, int id);
 
+/** iio_ring_buffer_register_ex() - register the buffer with IIO core
+ * @ring: the buffer to be registered
+ * @id: the id of the buffer (typically 0)
+ **/
+int iio_ring_buffer_register_ex(struct iio_ring_buffer *ring, int id,
+				const struct iio_chan_spec *channels,
+				int num_channels);
+
 /**
  * iio_ring_buffer_unregister() - unregister the buffer from IIO core
  * @ring: the buffer to be unregistered
@@ -481,6 +492,15 @@ static inline int iio_ring_buffer_register(struct iio_ring_buffer *ring, int id)
 {
 	return 0;
 };
+
+static inline int iio_ring_buffer_register_ex(struct iio_ring_buffer *ring,
+					      int id,
+					      struct iio_chan_spec *channels,
+					      int num_channels)
+{
+	return 0;
+}
+
 static inline void iio_ring_buffer_unregister(struct iio_ring_buffer *ring)
 {};
 
diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index 8f4d547..44bd575 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -24,6 +24,7 @@ struct iio_event_attr {
 	struct device_attribute dev_attr;
 	int mask;
 	struct iio_event_handler_list *listel;
+	struct list_head l;
 };
 
 #define to_iio_event_attr(_dev_attr) \
@@ -34,11 +35,14 @@ struct iio_event_attr {
  * @dev_attr:	underlying device attribute
  * @address:	associated register address
  * @val2:	secondary attribute value
+ * @l:		list head for maintaining list of dynamically created attrs.
  */
 struct iio_dev_attr {
 	struct device_attribute dev_attr;
 	int address;
 	int val2;
+	struct list_head l;
+	struct iio_chan_spec const *c;
 };
 
 #define to_iio_dev_attr(_dev_attr)				\
@@ -259,26 +263,28 @@ struct iio_const_attr {
 #define IIO_EVENT_ATTR_DATA_RDY(_show, _store, _mask, _handler) \
 	IIO_EVENT_ATTR(data_rdy, _show, _store, _mask, _handler)
 
-#define IIO_EV_CLASS_BUFFER		0
-#define IIO_EV_CLASS_IN			1
-#define IIO_EV_CLASS_ACCEL		2
-#define IIO_EV_CLASS_GYRO		3
-#define IIO_EV_CLASS_MAGN		4
-#define IIO_EV_CLASS_LIGHT		5
-#define IIO_EV_CLASS_PROXIMITY		6
-#define IIO_EV_CLASS_TEMP		7
-
-#define IIO_EV_MOD_X			0
-#define IIO_EV_MOD_Y			1
-#define IIO_EV_MOD_Z			2
-#define IIO_EV_MOD_X_AND_Y		3
-#define IIO_EV_MOD_X_ANX_Z		4
-#define IIO_EV_MOD_Y_AND_Z		5
-#define IIO_EV_MOD_X_AND_Y_AND_Z	6
-#define IIO_EV_MOD_X_OR_Y		7
-#define IIO_EV_MOD_X_OR_Z		8
-#define IIO_EV_MOD_Y_OR_Z		9
-#define IIO_EV_MOD_X_OR_Y_OR_Z		10
+/* must match our channel defs */
+#define IIO_EV_CLASS_IN			IIO_IN
+#define IIO_EV_CLASS_IN_DIFF		IIO_IN_DIFF
+#define IIO_EV_CLASS_ACCEL		IIO_ACCEL
+#define IIO_EV_CLASS_GYRO		IIO_GYRO
+#define IIO_EV_CLASS_MAGN		IIO_MAGN
+#define IIO_EV_CLASS_LIGHT		IIO_LIGHT
+#define IIO_EV_CLASS_PROXIMITY		IIO_PROXIMITY
+#define IIO_EV_CLASS_TEMP		IIO_TEMP
+#define IIO_EV_CLASS_BUFFER		IIO_BUFFER
+
+#define IIO_EV_MOD_X			IIO_MOD_X
+#define IIO_EV_MOD_Y			IIO_MOD_Y
+#define IIO_EV_MOD_Z			IIO_MOD_Z
+#define IIO_EV_MOD_X_AND_Y		IIO_MOD_X_AND_Y
+#define IIO_EV_MOD_X_ANX_Z		IIO_MOD_X_AND_Z
+#define IIO_EV_MOD_Y_AND_Z		IIO_MOD_Y_AND_Z
+#define IIO_EV_MOD_X_AND_Y_AND_Z	IIO_MOD_X_AND_Y_AND_Z
+#define IIO_EV_MOD_X_OR_Y		IIO_MOD_X_OR_Y
+#define IIO_EV_MOD_X_OR_Z		IIO_MOD_X_OR_Z
+#define IIO_EV_MOD_Y_OR_Z		IIO_MOD_Y_OR_Z
+#define IIO_EV_MOD_X_OR_Y_OR_Z		IIO_MOD_X_OR_Y_OR_Z
 
 #define IIO_EV_TYPE_THRESH		0
 #define IIO_EV_TYPE_MAG			1
@@ -288,6 +294,10 @@ struct iio_const_attr {
 #define IIO_EV_DIR_RISING		1
 #define IIO_EV_DIR_FALLING		2
 
+#define IIO_EV_TYPE_MAX 8
+#define IIO_EV_BIT(type, direction)			\
+	(1 << (type*IIO_EV_TYPE_MAX + direction))
+
 #define IIO_EVENT_CODE(channelclass, orient_bit, number,		\
 		       modifier, type, direction)			\
 	(channelclass | (orient_bit << 8) | ((number) << 9) |		\
@@ -304,6 +314,14 @@ struct iio_const_attr {
 #define IIO_BUFFER_EVENT_CODE(code)		\
 	(IIO_EV_CLASS_BUFFER | (code << 8))
 
+#define IIO_EVENT_CODE_EXTRACT_DIR(mask) ((mask >> 24) & 0xf)
+
+/* Event code number extraction depends on which type of event we have.
+ * Perhaps review this function in the future*/
+#define IIO_EVENT_CODE_EXTRACT_NUM(mask) ((mask >> 9) & 0x0f)
+
+#define IIO_EVENT_CODE_EXTRACT_MODIFIER(mask) ((mask >> 13) & 0x7)
+
 /**
  * IIO_EVENT_ATTR_RING_50_FULL - ring buffer event to indicate 50% full
  * @_show: output method for the attribute
-- 
1.7.3.4
