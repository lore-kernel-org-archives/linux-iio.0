Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	greg@kroah.com
Cc: lars@metafoo.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 3/5] staging:iio:core add in kernel interface mapping and getting IIO channels.
Date: Mon,  5 Dec 2011 21:56:02 +0000
Message-Id: <1323122164-32314-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1323122164-32314-1-git-send-email-jic23@kernel.org>
References: <1323122164-32314-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@cam.ac.uk>

Lifted from proposal for in kernel interface built on the out of staging
branch.

Two elements here:
* Map as defined in "inkern.h"
* Matching code to actually get the iio_dev and channel
that we want from the global list of IIO devices.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/Makefile                |    2 +-
 drivers/staging/iio/Makefile            |    2 +-
 drivers/staging/iio/iio.h               |    6 +-
 drivers/staging/iio/industrialio-core.c |  268 ++++++++++++++++++++++++++++++-
 drivers/staging/iio/inkern.c            |   21 +++
 drivers/staging/iio/inkern.h            |   86 ++++++++++
 6 files changed, 377 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 6e615b6..f59ab89 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -34,7 +34,7 @@ obj-$(CONFIG_VT6656)		+= vt6656/
 obj-$(CONFIG_HYPERV)		+= hv/
 obj-$(CONFIG_VME_BUS)		+= vme/
 obj-$(CONFIG_DX_SEP)            += sep/
-obj-$(CONFIG_IIO)		+= iio/
+obj-y				+= iio/
 obj-$(CONFIG_ZRAM)		+= zram/
 obj-$(CONFIG_XVMALLOC)		+= zram/
 obj-$(CONFIG_ZCACHE)		+= zcache/
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 1340aea..04d6ad2 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for the industrial I/O core.
 #
-
+obj-y = inkern.o
 obj-$(CONFIG_IIO) += industrialio.o
 industrialio-y := industrialio-core.o
 industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 11c2f25..4650a2b 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -230,7 +230,9 @@ struct iio_dev;
  *			Meaning is event dependent.
  * @validate_trigger:	function to validate the trigger when the
  *			current trigger gets changed.
- **/
+ * @			the parent device (actual hardware).  Note that if
+ *			not specified then iio_dev.dev->parent is used.
+ */
 struct iio_info {
 	struct module			*driver_module;
 	struct attribute_group		*event_attrs;
@@ -267,8 +269,10 @@ struct iio_info {
 				 int val);
 	int (*validate_trigger)(struct iio_dev *indio_dev,
 				struct iio_trigger *trig);
+
 	int (*update_scan_mode)(struct iio_dev *indio_dev,
 				const unsigned long *scan_mask);
+	struct device *(*get_hardware_id)(struct iio_dev *indio_dev);
 };
 
 /**
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index dbd1ce1..c108fc9 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -22,11 +22,13 @@
 #include <linux/cdev.h>
 #include <linux/slab.h>
 #include <linux/anon_inodes.h>
+#include <linux/err.h>
 #include "iio.h"
 #include "iio_core.h"
 #include "iio_core_trigger.h"
 #include "sysfs.h"
 #include "events.h"
+#include "inkern.h"
 
 /* IDA to assign each registered device a unique id*/
 static DEFINE_IDA(iio_ida);
@@ -89,6 +91,267 @@ static const char * const iio_chan_info_postfix[] = {
 	= "filter_low_pass_3db_frequency",
 };
 
+static void iio_dev_release(struct device *device);
+static struct device_type iio_dev_type = {
+	.name = "iio_device",
+	.release = iio_dev_release,
+};
+
+static int iio_match_dev(struct device *dev, void *data)
+{
+	struct iio_dev *indio_dev;
+	struct device *dev2 = data;
+
+	if (dev->type != &iio_dev_type)
+		return 0;
+
+	indio_dev = container_of(dev, struct iio_dev, dev);
+	if (indio_dev->info->get_hardware_id)
+		return indio_dev->info->get_hardware_id(indio_dev) == dev2;
+	else
+		return indio_dev->dev.parent == dev2;
+}
+
+static int iio_match_dev_name(struct device *dev, void *data)
+{
+	struct iio_dev *indio_dev;
+	const char *name = data;
+
+	if (dev->type != &iio_dev_type)
+		return 0;
+
+	indio_dev = container_of(dev, struct iio_dev, dev);
+	if (indio_dev->info->get_hardware_id)
+		return !strcmp(dev_name(indio_dev->info
+					->get_hardware_id(indio_dev)),
+			       name);
+	else if (indio_dev->dev.parent)
+		return !strcmp(dev_name(indio_dev->dev.parent), name);
+	return 0;
+}
+
+static const struct iio_chan_spec
+*iio_chan_spec_from_name(const struct iio_dev *indio_dev,
+			 const char *name)
+{
+	int i;
+	const struct iio_chan_spec *chan = NULL;
+	for (i = 0; i < indio_dev->num_channels; i++)
+		if (indio_dev->channels[i].datasheet_name &&
+		    strcmp(name, indio_dev->channels[i].datasheet_name) == 0) {
+			chan = &indio_dev->channels[i];
+			break;
+		}
+	return chan;
+}
+
+struct iio_channel *iio_st_channel_get(const struct device *dev,
+				       const char *name,
+				       const char *channel_name)
+{
+	struct iio_map *c_i = NULL, *c = NULL;
+	struct device *dev_i;
+	struct iio_channel *channel;
+
+	if (dev == NULL && name == NULL && channel_name == NULL)
+		return ERR_PTR(-ENODEV);
+	/* first find matching entry the channel map */
+	list_for_each_entry(c_i, &iio_map_list, l) {
+		if ((dev && dev != c_i->consumer_dev) ||
+		    (name && strcmp(name, c_i->consumer_dev_name) != 0) ||
+		    (channel_name &&
+		     strcmp(channel_name, c_i->consumer_channel) != 0))
+			continue;
+		c = c_i;
+		break;
+	}
+	if (c == NULL)
+		return ERR_PTR(-ENODEV);
+
+	/* now find the iio device if it has been registered */
+	if (c->adc_dev)
+		dev_i = bus_find_device(&iio_bus_type, NULL, c->adc_dev,
+					&iio_match_dev);
+	else if (c->adc_dev_name)
+		dev_i = bus_find_device(&iio_bus_type, NULL,
+					(void *)c->adc_dev_name,
+					&iio_match_dev_name);
+	else
+		return ERR_PTR(-EINVAL);
+	if (IS_ERR(dev_i))
+		return (void *)dev_i;
+	if (dev_i == NULL)
+		return ERR_PTR(-ENODEV);
+
+	channel = kmalloc(sizeof(*channel), GFP_KERNEL);
+	if (channel == NULL)
+		return ERR_PTR(-ENOMEM);
+
+	channel->indio_dev = container_of(dev_i, struct iio_dev, dev);
+
+	if (c->adc_channel_label)
+		channel->channel =
+			iio_chan_spec_from_name(channel->indio_dev,
+						c->adc_channel_label);
+	if (channel->channel == NULL)
+		channel->channel = &channel->indio_dev->
+			channels[c->channel_number];
+
+	return channel;
+}
+EXPORT_SYMBOL_GPL(iio_st_channel_get);
+
+void iio_st_channel_release(struct iio_channel *channel)
+{
+	put_device(&channel->indio_dev->dev);
+	kfree(channel);
+}
+EXPORT_SYMBOL_GPL(iio_st_channel_release);
+
+struct iio_channel **iio_st_channel_get_all(const struct device *dev,
+					    const char *name)
+{
+	struct iio_channel **chans;
+	struct iio_map *c = NULL;
+	int nummaps = 0;
+	int mapind = 0;
+	int i, ret;
+	struct device *dev_i;
+
+	if (dev == NULL && name == NULL) {
+		ret = -EINVAL;
+		goto error_ret;
+	}
+
+	/* first count the matching maps */
+	list_for_each_entry(c, &iio_map_list, l)
+		if ((dev && dev != c->consumer_dev) ||
+		    (name && strcmp(name, c->consumer_dev_name) != 0))
+			continue;
+		else
+			nummaps++;
+
+	if (nummaps == 0) {
+		ret = -ENODEV;
+		goto error_ret;
+	}
+
+	/* NULL terminated array to save passing size */
+	chans = kzalloc(sizeof(*chans)*(nummaps + 1), GFP_KERNEL);
+	if (chans == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+	for (i = 0; i < nummaps; i++) {
+		chans[i] = kzalloc(sizeof(*chans[0]), GFP_KERNEL);
+		if (chans[i] == NULL) {
+			ret = -ENOMEM;
+			goto error_free_chans;
+		}
+	}
+
+	/* for each map fill in the chans element */
+	list_for_each_entry(c, &iio_map_list, l) {
+		dev_i = NULL;
+		if (dev && dev != c->consumer_dev)
+			continue;
+		if (name && strcmp(name, c->consumer_dev_name) != 0)
+			continue;
+		while (1) {
+			if (c->adc_dev) {
+				dev_i = bus_find_device(&iio_bus_type,
+							dev_i,
+							c->adc_dev,
+							&iio_match_dev);
+			} else if (c->adc_dev_name) {
+				dev_i = bus_find_device(&iio_bus_type,
+							dev_i,
+							(void *)c->adc_dev_name,
+							&iio_match_dev_name);
+			} else {
+				ret = -EINVAL;
+				goto error_free_chans;
+			}
+			if (IS_ERR(dev_i)) {
+				ret = PTR_ERR(dev_i);
+				goto error_free_chans;
+			}
+			if (dev_i == NULL)
+				break;
+
+			chans[mapind]->indio_dev =
+				container_of(dev_i, struct iio_dev, dev);
+			chans[mapind]->channel =
+				iio_chan_spec_from_name(chans[mapind]->
+							indio_dev,
+							c->adc_channel_label);
+			if (chans[mapind]->channel == NULL) {
+				ret = -EINVAL;
+				put_device(&chans[mapind]->indio_dev->dev);
+				goto error_free_chans;
+			}
+			mapind++;
+		}
+	}
+	if (mapind == 0) {
+		ret = -ENODEV;
+		goto error_free_chans;
+	}
+	return chans;
+
+error_free_chans:
+	for (i = 0; i < nummaps; i++)
+		if (chans[i]) {
+			if (chans[i]->indio_dev)
+				put_device(&chans[i]->indio_dev->dev);
+			kfree(chans[i]);
+		}
+	kfree(chans);
+error_ret:
+
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(iio_st_channel_get_all);
+
+void iio_st_channel_release_all(struct iio_channel **channels)
+{
+	int i = 0;
+	struct iio_channel *chan = channels[i];
+
+	while (chan) {
+		if (chan->indio_dev)
+			put_device(&chan->indio_dev->dev);
+		kfree(chan);
+		i++;
+		chan = channels[i];
+	}
+	kfree(channels);
+}
+EXPORT_SYMBOL_GPL(iio_st_channel_release_all);
+
+int iio_st_read_channel_raw(struct iio_channel *chan, int *val)
+{
+	int val2;
+	return chan->indio_dev->info->read_raw(chan->indio_dev, chan->channel,
+					       val, &val2, 0);
+}
+EXPORT_SYMBOL_GPL(iio_st_read_channel_raw);
+
+int iio_st_read_channel_scale(struct iio_channel *chan, int *val, int *val2)
+{
+	return chan->indio_dev->info->read_raw(chan->indio_dev,
+					       chan->channel,
+					       val, val2,
+					       IIO_CHAN_INFO_SCALE);
+}
+EXPORT_SYMBOL_GPL(iio_st_read_channel_scale);
+
+enum iio_chan_type iio_st_get_channel_type(struct iio_channel *channel)
+{
+	return channel->channel->type;
+}
+EXPORT_SYMBOL_GPL(iio_st_get_channel_type);
+
 const struct iio_chan_spec
 *iio_find_channel_from_si(struct iio_dev *indio_dev, int si)
 {
@@ -1026,11 +1289,6 @@ static void iio_dev_release(struct device *device)
 	iio_device_unregister_sysfs(indio_dev);
 }
 
-static struct device_type iio_dev_type = {
-	.name = "iio_device",
-	.release = iio_dev_release,
-};
-
 struct iio_dev *iio_allocate_device(int sizeof_priv)
 {
 	struct iio_dev *dev;
diff --git a/drivers/staging/iio/inkern.c b/drivers/staging/iio/inkern.c
new file mode 100644
index 0000000..3e86093
--- /dev/null
+++ b/drivers/staging/iio/inkern.c
@@ -0,0 +1,21 @@
+/* The industrial I/O core in kernel channel mapping
+ *
+ * Copyright (c) 2011 Jonathan Cameron
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+#include "inkern.h"
+#include <linux/err.h>
+#include <linux/export.h>
+
+LIST_HEAD(iio_map_list);
+EXPORT_SYMBOL_GPL(iio_map_list);
+void iio_map_array_register(struct iio_map *map, int nummaps)
+{
+	int i;
+	for (i = 0; i < nummaps; i++)
+		list_add(&map[i].l, &iio_map_list);
+}
+EXPORT_SYMBOL(iio_map_array_register);
diff --git a/drivers/staging/iio/inkern.h b/drivers/staging/iio/inkern.h
new file mode 100644
index 0000000..fc32896
--- /dev/null
+++ b/drivers/staging/iio/inkern.h
@@ -0,0 +1,86 @@
+#include <linux/device.h>
+#include <linux/list.h>
+#include "types.h"
+
+#ifndef _IIO_INKERN_H_
+#define _IIO_INKERN_H_
+
+struct iio_dev;
+struct iio_chan_spec;
+
+struct iio_channel {
+	struct iio_dev *indio_dev;
+	const struct iio_chan_spec *channel;
+};
+
+extern struct list_head iio_map_list;
+
+struct iio_map {
+	/* iio device side */
+	struct device *adc_dev;
+	const char *adc_dev_name;
+	const char *adc_channel_label;
+	int channel_number; /*naughty starting point */
+
+	/* consumer side */
+	struct device *consumer_dev;
+	const char *consumer_dev_name;
+	const char *consumer_channel;
+	/* management - probably neater ways of doing this */
+	struct list_head l;
+};
+
+void iio_map_array_register(struct iio_map *map, int nummaps);
+/**
+ * iio_channel_get() - get an opaque reference to a specified device.
+ */
+struct iio_channel *iio_st_channel_get(const struct device *dev,
+				    const char *name,
+				    const char *consumer_channel);
+void iio_st_channel_release(struct iio_channel *chan);
+
+/**
+ * iio_st_channel_get_all() - get all channels associated with a client
+ *
+ * returns a null terminated array of pointers to iio_channel structures.
+ */
+struct iio_channel **iio_st_channel_get_all(const struct device *dev,
+					const char *name);
+
+void iio_st_channel_release_all(struct iio_channel **chan);
+
+/**
+ * iio_st_read_channel_raw() - read from a given channel
+ * @channel:	the channel being queried.
+ * @val:	value read back.
+ *
+ * Note raw reads from iio channels are in adc counts and hence
+ * scale will need to be applied if standard units required.
+ *
+ * Maybe want to pass the type as a sanity check.
+ */
+int iio_st_read_channel_raw(struct iio_channel *chan,
+			    int *val);
+
+/**
+ * iio_st_get_channel_type() - get the type of a channel
+ * @channel:	the channel being queried.
+ *
+ * returns the enum iio_chan_type of the channel
+ */
+enum iio_chan_type iio_st_get_channel_type(struct iio_channel *channel);
+
+/**
+ * iio_st_read_channel_scale() - read the scale value for a channel
+ * @channel:	the channel being queried.
+ * @val:	first part of value read back.
+ * @val2:	second part of value read back.
+ *
+ * Note returns a description of what is in val and val2, such
+ * as IIO_VAL_INT_PLUS_MICRO telling us we have a value of val
+ * + val2/1e6
+ */
+int iio_st_read_channel_scale(struct iio_channel *chan, int *val,
+			      int *val2);
+
+#endif
-- 
1.7.7.4
