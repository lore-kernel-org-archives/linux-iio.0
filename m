Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: greg@kroah.com,
	guenter.roeck@ericsson.com,
	khali@linux-fr.org,
	dmitry.torokhov@gmail.com,
	broonie@opensource.wolfsonmicro.com,
	alan@lxorguk.ukuu.org.uk,
	arnd@arndb.de,
	linus.walleij@linaro.org,
	maxime.ripard@free-electrons.com,
	thomas.petazzoni@free-electrons.com,
	zdevai@gmail.com,
	w.sang@pengutronix.de,
	marek.vasut@gmail.com,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/6] staging:iio:core add in kernel interface mapping and getting IIO channels.
Date: Wed, 15 Feb 2012 19:48:01 +0000
Message-Id: <1329335285-31006-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1329335285-31006-1-git-send-email-jic23@kernel.org>
References: <1329335285-31006-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@cam.ac.uk>

Lifted from proposal for in kernel interface built on the out of staging
branch.

Two elements here:
* Map as defined in "inkern.h"
* Matching code to actually get the iio_dev and channel
that we want from the global list of IIO devices.
V4: Everything now built if iio is built (rather than being optional)
    Removal race condition prevented by using info pointer as a check
    of removal under a lock.
V3: Drop the option of registering / getting channels using dev pointer.
Stick to name only as suggested by Mark Brown (this has caused user
confusion in the regulator framework.)
V2: As per Greg KH suggestion, move over to registration by passing
the tables into the provider drivers (how regulator does it).
This does not prevent us using the original more flexible approach
if at a later date there is a usecase that demands it.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/Makefile   |    2 +-
 drivers/staging/iio/consumer.h |   96 +++++++++++++
 drivers/staging/iio/driver.h   |   34 +++++
 drivers/staging/iio/inkern.c   |  292 ++++++++++++++++++++++++++++++++++++++++
 drivers/staging/iio/machine.h  |   24 ++++
 5 files changed, 447 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 657710b..ff059d4 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -3,7 +3,7 @@
 #
 
 obj-$(CONFIG_IIO) += industrialio.o
-industrialio-y := industrialio-core.o industrialio-event.o
+industrialio-y := industrialio-core.o industrialio-event.o inkern.o
 industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
 industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
 
diff --git a/drivers/staging/iio/consumer.h b/drivers/staging/iio/consumer.h
new file mode 100644
index 0000000..36a060c
--- /dev/null
+++ b/drivers/staging/iio/consumer.h
@@ -0,0 +1,96 @@
+/*
+ * Industrial I/O in kernel consumer interface
+ *
+ * Copyright (c) 2011 Jonathan Cameron
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+#ifndef _IIO_INKERN_CONSUMER_H_
+#define _IIO_INKERN_CONSUMER_H
+#include "types.h"
+
+struct iio_dev;
+struct iio_chan_spec;
+
+/**
+ * struct iio_channel - everything needed for a consumer to use a channel
+ * @indio_dev:		Device on which the channel exists.
+ * @channel:		Full description of the channel.
+ */
+struct iio_channel {
+	struct iio_dev *indio_dev;
+	const struct iio_chan_spec *channel;
+};
+
+/**
+ * iio_channel_get() - get description of all that is needed to access channel.
+ * @name:		Unique name of the device as provided in the iio_map
+ *			with which the desired provider to consumer mapping
+ *			was registered.
+ * @consumer_channel:	Unique name to identify the channel on the consumer
+ *			side. This typically describes the channels use within
+ *			the consumer. E.g. 'battery_voltage'
+ */
+struct iio_channel *iio_st_channel_get(const char *name,
+				       const char *consumer_channel);
+
+/**
+ * iio_st_channel_release() - release channels obtained via iio_st_channel_get
+ * @chan:		The channel to be released.
+ */
+void iio_st_channel_release(struct iio_channel *chan);
+
+/**
+ * iio_st_channel_get_all() - get all channels associated with a client
+ * @name:		name of consumer device.
+ *
+ * Returns an array of iio_channel structures terminated with one with
+ * null iio_dev pointer.
+ * This function is used by fairly generic consumers to get all the
+ * channels registered as having this consumer.
+ */
+struct iio_channel *iio_st_channel_get_all(const char *name);
+
+/**
+ * iio_st_channel_release_all() - reverse iio_st_get_all
+ * @chan:		Array of channels to be released.
+ */
+void iio_st_channel_release_all(struct iio_channel *chan);
+
+/**
+ * iio_st_read_channel_raw() - read from a given channel
+ * @channel:		The channel being queried.
+ * @val:		Value read back.
+ *
+ * Note raw reads from iio channels are in adc counts and hence
+ * scale will need to be applied if standard units required.
+ */
+int iio_st_read_channel_raw(struct iio_channel *chan,
+			    int *val);
+
+/**
+ * iio_st_get_channel_type() - get the type of a channel
+ * @channel:		The channel being queried.
+ * @type:		The type of the channel.
+ *
+ * returns the enum iio_chan_type of the channel
+ */
+int iio_st_get_channel_type(struct iio_channel *channel,
+			    enum iio_chan_type *type);
+
+/**
+ * iio_st_read_channel_scale() - read the scale value for a channel
+ * @channel:		The channel being queried.
+ * @val:		First part of value read back.
+ * @val2:		Second part of value read back.
+ *
+ * Note returns a description of what is in val and val2, such
+ * as IIO_VAL_INT_PLUS_MICRO telling us we have a value of val
+ * + val2/1e6
+ */
+int iio_st_read_channel_scale(struct iio_channel *chan, int *val,
+			      int *val2);
+
+#endif
diff --git a/drivers/staging/iio/driver.h b/drivers/staging/iio/driver.h
new file mode 100644
index 0000000..a4f8b2e
--- /dev/null
+++ b/drivers/staging/iio/driver.h
@@ -0,0 +1,34 @@
+/*
+ * Industrial I/O in kernel access map interface.
+ *
+ * Copyright (c) 2011 Jonathan Cameron
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#ifndef _IIO_INKERN_H_
+#define _IIO_INKERN_H_
+
+struct iio_map;
+
+/**
+ * iio_map_array_register() - tell the core about inkernel consumers
+ * @indio_dev:	provider device
+ * @map:	array of mappings specifying association of channel with client
+ */
+int iio_map_array_register(struct iio_dev *indio_dev,
+			   struct iio_map *map);
+
+/**
+ * iio_map_array_unregister() - tell the core to remove consumer mappings
+ * @indio_dev:	provider device
+ * @map:	array of mappings to remove. Note these must have same memory
+ *		addresses as those originally added not just equal parameter
+ *		values.
+ */
+int iio_map_array_unregister(struct iio_dev *indio_dev,
+			     struct iio_map *map);
+
+#endif
diff --git a/drivers/staging/iio/inkern.c b/drivers/staging/iio/inkern.c
new file mode 100644
index 0000000..de2c8ea
--- /dev/null
+++ b/drivers/staging/iio/inkern.c
@@ -0,0 +1,292 @@
+/* The industrial I/O core in kernel channel mapping
+ *
+ * Copyright (c) 2011 Jonathan Cameron
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/slab.h>
+#include <linux/mutex.h>
+
+#include "iio.h"
+#include "iio_core.h"
+#include "machine.h"
+#include "driver.h"
+#include "consumer.h"
+
+struct iio_map_internal {
+	struct iio_dev *indio_dev;
+	struct iio_map *map;
+	struct list_head l;
+};
+
+static LIST_HEAD(iio_map_list);
+static DEFINE_MUTEX(iio_map_list_lock);
+
+int iio_map_array_register(struct iio_dev *indio_dev, struct iio_map *maps)
+{
+	int i = 0, ret = 0;
+	struct iio_map_internal *mapi;
+
+	if (maps == NULL)
+		return 0;
+
+	mutex_lock(&iio_map_list_lock);
+	while (maps[i].consumer_dev_name != NULL) {
+		mapi = kzalloc(sizeof(*mapi), GFP_KERNEL);
+		if (mapi == NULL) {
+			ret = -ENOMEM;
+			goto error_ret;
+		}
+		mapi->map = &maps[i];
+		mapi->indio_dev = indio_dev;
+		list_add(&mapi->l, &iio_map_list);
+		i++;
+	}
+error_ret:
+	mutex_unlock(&iio_map_list_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iio_map_array_register);
+
+
+/* Assumes the exact same array (e.g. memory locations)
+ * used at unregistration as used at registration rather than
+ * more complex checking of contents.
+ */
+int iio_map_array_unregister(struct iio_dev *indio_dev,
+			     struct iio_map *maps)
+{
+	int i = 0, ret = 0;
+	bool found_it;
+	struct iio_map_internal *mapi;
+
+	if (maps == NULL)
+		return 0;
+
+	mutex_lock(&iio_map_list_lock);
+	while (maps[i].consumer_dev_name != NULL) {
+		found_it = false;
+		list_for_each_entry(mapi, &iio_map_list, l)
+			if (&maps[i] == mapi->map) {
+				list_del(&mapi->l);
+				kfree(mapi);
+				found_it = true;
+				break;
+			}
+		if (found_it == false) {
+			ret = -ENODEV;
+			goto error_ret;
+		}
+	}
+error_ret:
+	mutex_unlock(&iio_map_list_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iio_map_array_unregister);
+
+static const struct iio_chan_spec
+*iio_chan_spec_from_name(const struct iio_dev *indio_dev,
+			 const char *name)
+{
+	int i;
+	const struct iio_chan_spec *chan = NULL;
+
+	for (i = 0; i < indio_dev->num_channels; i++)
+		if (indio_dev->channels[i].datasheet_name &&
+		    strcmp(name, indio_dev->channels[i].datasheet_name) == 0) {
+			chan = &indio_dev->channels[i];
+			break;
+		}
+	return chan;
+}
+
+
+struct iio_channel *iio_st_channel_get(const char *name,
+				       const char *channel_name)
+{
+	struct iio_map_internal *c_i = NULL, *c = NULL;
+	struct iio_channel *channel;
+
+	if (name == NULL && channel_name == NULL)
+		return ERR_PTR(-ENODEV);
+
+	/* first find matching entry the channel map */
+	mutex_lock(&iio_map_list_lock);
+	list_for_each_entry(c_i, &iio_map_list, l) {
+		if ((name && strcmp(name, c_i->map->consumer_dev_name) != 0) ||
+		    (channel_name &&
+		     strcmp(channel_name, c_i->map->consumer_channel) != 0))
+			continue;
+		c = c_i;
+		get_device(&c->indio_dev->dev);
+		break;
+	}
+	mutex_unlock(&iio_map_list_lock);
+	if (c == NULL)
+		return ERR_PTR(-ENODEV);
+
+	channel = kmalloc(sizeof(*channel), GFP_KERNEL);
+	if (channel == NULL)
+		return ERR_PTR(-ENOMEM);
+
+	channel->indio_dev = c->indio_dev;
+
+	if (c->map->adc_channel_label)
+		channel->channel =
+			iio_chan_spec_from_name(channel->indio_dev,
+						c->map->adc_channel_label);
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
+struct iio_channel *iio_st_channel_get_all(const char *name)
+{
+	struct iio_channel *chans;
+	struct iio_map_internal *c = NULL;
+	int nummaps = 0;
+	int mapind = 0;
+	int i, ret;
+
+	if (name == NULL)
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&iio_map_list_lock);
+	/* first count the matching maps */
+	list_for_each_entry(c, &iio_map_list, l)
+		if (name && strcmp(name, c->map->consumer_dev_name) != 0)
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
+
+	/* for each map fill in the chans element */
+	list_for_each_entry(c, &iio_map_list, l) {
+		if (name && strcmp(name, c->map->consumer_dev_name) != 0)
+			continue;
+		chans[mapind].indio_dev = c->indio_dev;
+		chans[mapind].channel =
+			iio_chan_spec_from_name(chans[mapind].indio_dev,
+						c->map->adc_channel_label);
+		if (chans[mapind].channel == NULL) {
+			ret = -EINVAL;
+			put_device(&chans[mapind].indio_dev->dev);
+			goto error_free_chans;
+		}
+		get_device(&chans[mapind].indio_dev->dev);
+		mapind++;
+	}
+	mutex_unlock(&iio_map_list_lock);
+	if (mapind == 0) {
+		ret = -ENODEV;
+		goto error_free_chans;
+	}
+	return chans;
+
+error_free_chans:
+	for (i = 0; i < nummaps; i++)
+		if (chans[i].indio_dev)
+			put_device(&chans[i].indio_dev->dev);
+	kfree(chans);
+error_ret:
+	mutex_unlock(&iio_map_list_lock);
+
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(iio_st_channel_get_all);
+
+void iio_st_channel_release_all(struct iio_channel *channels)
+{
+	struct iio_channel *chan = &channels[0];
+
+	while (chan->indio_dev) {
+		put_device(&chan->indio_dev->dev);
+		chan++;
+	}
+	kfree(channels);
+}
+EXPORT_SYMBOL_GPL(iio_st_channel_release_all);
+
+int iio_st_read_channel_raw(struct iio_channel *chan, int *val)
+{
+	int val2, ret;
+
+	mutex_lock(&chan->indio_dev->info_exist_lock);
+	if (chan->indio_dev->info == NULL) {
+		ret = -ENODEV;
+		goto err_unlock;
+	}
+
+	ret = chan->indio_dev->info->read_raw(chan->indio_dev, chan->channel,
+					      val, &val2, 0);
+err_unlock:
+	mutex_unlock(&chan->indio_dev->info_exist_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iio_st_read_channel_raw);
+
+int iio_st_read_channel_scale(struct iio_channel *chan, int *val, int *val2)
+{
+	int ret;
+
+	mutex_lock(&chan->indio_dev->info_exist_lock);
+	if (chan->indio_dev->info == NULL) {
+		ret = -ENODEV;
+		goto err_unlock;
+	}
+
+	ret = chan->indio_dev->info->read_raw(chan->indio_dev,
+					      chan->channel,
+					      val, val2,
+					      IIO_CHAN_INFO_SCALE);
+err_unlock:
+	mutex_unlock(&chan->indio_dev->info_exist_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iio_st_read_channel_scale);
+
+int iio_st_get_channel_type(struct iio_channel *chan,
+			    enum iio_chan_type *type)
+{
+	int ret = 0;
+	/* Need to verify underlying driver has not gone away */
+
+	mutex_lock(&chan->indio_dev->info_exist_lock);
+	if (chan->indio_dev->info == NULL) {
+		ret = -ENODEV;
+		goto err_unlock;
+	}
+
+	*type = chan->channel->type;
+err_unlock:
+	mutex_unlock(&chan->indio_dev->info_exist_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iio_st_get_channel_type);
diff --git a/drivers/staging/iio/machine.h b/drivers/staging/iio/machine.h
new file mode 100644
index 0000000..0b1f19b
--- /dev/null
+++ b/drivers/staging/iio/machine.h
@@ -0,0 +1,24 @@
+/*
+ * Industrial I/O in kernel access map definitions for board files.
+ *
+ * Copyright (c) 2011 Jonathan Cameron
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+/**
+ * struct iio_map - description of link between consumer and device channels
+ * @adc_channel_label:	Label used to identify the channel on the provider.
+ *			This is matched against the datasheet_name element
+ *			of struct iio_chan_spec.
+ * @consumer_dev_name:	Name to uniquely identify the consumer device.
+ * @consumer_channel:	Unique name used to idenitify the channel on the
+ *			consumer side.
+ */
+struct iio_map {
+	const char *adc_channel_label;
+	const char *consumer_dev_name;
+	const char *consumer_channel;
+};
-- 
1.7.8.4
