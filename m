Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48119 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756246AbbHYT7e (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 25 Aug 2015 15:59:34 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org, edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC PATCH v1 1/3] thermal: iio device for thermal sensor
Date: Tue, 25 Aug 2015 12:58:30 -0700
Message-Id: <1440532712-5025-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1440532712-5025-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1440532712-5025-1-git-send-email-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This change registers temperature sensor in a thermal zone as an IIO
temperature device. This allows user space thermal application to fully
utilize IIO capability to read temperature events and samples.
The primary motivation for this change to improve performance for user
space thermal controllers like Linux thermal daemon or Intel® Dynamic
Platform and Thermal Framework (DPTF) for Chromium OS.
The current sysfs has several limitations, which forces the current
user space to use polling as the safe way. This polling causes performance
bottlenecks as some devices requires extremely aggressive response to
changing temperature conditions.
These are some limitations, which this change tries to address:
- Temperature reading via sysfs attribute, which needs conversion from
string to int
- No way to set threshold settings to avoid polling for temperature change
without using a RW passive trip point.
- Event notifications via slow kobject uevents, which needs parsing to id
the zone and read temperature
- Only pull interface from user space, kernel drivers can't send samples
- One sample at a time read from user space
These limitations can be addressed by registering temperature sensor
as an IIO device. IIO provides
- buffered access via /dev/iio:deviceX node with select/poll capability
- temperature thresholds setting via iio event thresholds
- Wait and receive events
- Able to use different external trigger (data ready indications) and push
samples to buffers

Next set of patches uses the IIO binding introduced in this patchset.
The iio device created during call to thermal_zone_device_register. Samples
are pushed to iio buffers when thermal_zone_device_update is called from
client drivers and user space governor is selected for the thermal zone.
Only two additional callbacks for client driver to get/set thermal
temperature thresholds.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/Kconfig       |  11 ++
 drivers/thermal/Makefile      |   1 +
 drivers/thermal/thermal_iio.c | 341 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/thermal.h       |  31 ++++
 4 files changed, 384 insertions(+)
 create mode 100644 drivers/thermal/thermal_iio.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 0e3b576..861314f 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -29,6 +29,17 @@ config THERMAL_HWMON
 	  Say 'Y' here if you want all thermal sensors to
 	  have hwmon sysfs interface too.
 
+config THERMAL_IIO
+	tristate "Thermal sensor from a zone as IIO device"
+	select IIO
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  This will register thermal sensor in a zone as an IIO temperature
+	  sensor device.
+	  This will help user space thermal controllers to use IIO ABI to
+	  get events and buffered acces to temperature samples.
+
 config THERMAL_OF
 	bool
 	prompt "APIs to parse thermal data out of device tree"
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 535dfee..4b42734 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -7,6 +7,7 @@ thermal_sys-y			+= thermal_core.o
 
 # interface to/from other layers providing sensors
 thermal_sys-$(CONFIG_THERMAL_HWMON)		+= thermal_hwmon.o
+thermal_sys-$(CONFIG_THERMAL_IIO)		+= thermal_iio.o
 thermal_sys-$(CONFIG_THERMAL_OF)		+= of-thermal.o
 
 # governors
diff --git a/drivers/thermal/thermal_iio.c b/drivers/thermal/thermal_iio.c
new file mode 100644
index 0000000..38ede5a
--- /dev/null
+++ b/drivers/thermal/thermal_iio.c
@@ -0,0 +1,341 @@
+/*
+ * thermal iio interface driver
+ * Copyright (c) 2015, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/thermal.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/events.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+struct thermal_iio_data {
+	struct thermal_zone_device *tz;
+	struct iio_trigger *interrupt_trig;
+	struct iio_chan_spec *channels;
+	bool enable_trigger;
+	long temp_thres;
+	bool ev_enable_state;
+	struct mutex mutex;
+
+};
+
+static const struct iio_event_spec thermal_event = {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE)
+};
+
+#define THERMAL_TEMP_CHANNELS {					\
+	{								\
+		.type = IIO_TEMP,					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.scan_index = 0,					\
+		.scan_type = {						\
+			.sign = 'u',					\
+			.realbits = 32,				\
+			.storagebits = 32,				\
+			.endianness = IIO_CPU,				\
+		},							\
+		.event_spec = &thermal_event,				\
+	},								\
+	IIO_CHAN_SOFT_TIMESTAMP(1),					\
+}
+
+static const struct iio_chan_spec thermal_iio_channels[] =
+						THERMAL_TEMP_CHANNELS;
+
+static int thermal_iio_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
+{
+	struct thermal_iio_data *iio_data = iio_priv(indio_dev);
+	long temp;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = thermal_zone_get_temp(iio_data->tz, &temp);
+		if (ret)
+			return ret;
+		*val = (int) temp;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static irqreturn_t thermal_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct thermal_iio_data *iio_data = iio_priv(indio_dev);
+	unsigned long buffer[3];
+	unsigned long temp;
+	int ret;
+
+	ret = thermal_zone_get_temp(iio_data->tz, &temp);
+	if (ret)
+		goto err_read;
+
+	*(unsigned long *)buffer = temp;
+	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
+					   iio_get_time_ns());
+err_read:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int thermal_data_rdy_trigger_set_state(struct iio_trigger *trig,
+					      bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct thermal_iio_data *iio_data = iio_priv(indio_dev);
+
+	mutex_lock(&iio_data->mutex);
+	iio_data->enable_trigger = state;
+	mutex_unlock(&iio_data->mutex);
+
+	return 0;
+}
+
+static const struct iio_trigger_ops thermal_trigger_ops = {
+	.set_trigger_state = thermal_data_rdy_trigger_set_state,
+	.owner = THIS_MODULE,
+};
+
+static int thermal_iio_read_event(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan,
+				  enum iio_event_type type,
+				  enum iio_event_direction dir,
+				  enum iio_event_info info,
+				  int *val, int *val2)
+{
+	struct thermal_iio_data *iio_data = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&iio_data->mutex);
+	*val2 = 0;
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		*val = iio_data->temp_thres;
+		ret = IIO_VAL_INT;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	mutex_unlock(&iio_data->mutex);
+
+	return ret;
+}
+
+static int thermal_iio_write_event(struct iio_dev *indio_dev,
+				   const struct iio_chan_spec *chan,
+				   enum iio_event_type type,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info,
+				   int val, int val2)
+{
+	struct thermal_iio_data *iio_data = iio_priv(indio_dev);
+	int ret = 0;
+
+	mutex_lock(&iio_data->mutex);
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		iio_data->temp_thres = val;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	mutex_unlock(&iio_data->mutex);
+
+	return ret;
+}
+
+static int thermal_iio_read_event_config(struct iio_dev *indio_dev,
+					 const struct iio_chan_spec *chan,
+					 enum iio_event_type type,
+					 enum iio_event_direction dir)
+{
+	struct thermal_iio_data *iio_data = iio_priv(indio_dev);
+	bool state;
+
+	mutex_lock(&iio_data->mutex);
+	state = iio_data->ev_enable_state;
+	mutex_unlock(&iio_data->mutex);
+
+	return state;
+}
+
+static int thermal_iio_write_event_config(struct iio_dev *indio_dev,
+					  const struct iio_chan_spec *chan,
+					  enum iio_event_type type,
+					  enum iio_event_direction dir,
+					  int state)
+{
+	struct thermal_iio_data *iio_data = iio_priv(indio_dev);
+	int ret = 0;
+
+	mutex_lock(&iio_data->mutex);
+	if ((state && iio_data->ev_enable_state) ||
+	    (!state && !iio_data->ev_enable_state))
+		goto done_write_event;
+
+	if (iio_data->tz->ops->set_threshold_temp)
+		ret = iio_data->tz->ops->set_threshold_temp(iio_data->tz, 0,
+							iio_data->temp_thres);
+	else
+		ret = iio_data->tz->ops->set_threshold_temp(iio_data->tz, 0, 0);
+
+	iio_data->ev_enable_state = state;
+
+done_write_event:
+	mutex_unlock(&iio_data->mutex);
+
+	return ret;
+}
+
+static int thermal_iio_setup_trig(struct iio_trigger **iio_trig,
+				  struct thermal_zone_device *tz,
+				  const char *format)
+{
+	struct iio_trigger *trig;
+	int ret;
+
+	trig = devm_iio_trigger_alloc(&tz->device, format, tz->type,
+				      tz->indio_dev->id);
+	if (!trig) {
+		dev_err(&tz->device, "Trigger Allocate Failed\n");
+		return -ENOMEM;
+	}
+	trig->dev.parent = &tz->device;
+	trig->ops = &thermal_trigger_ops;
+	iio_trigger_set_drvdata(trig, tz->indio_dev);
+	ret = iio_trigger_register(trig);
+	if (ret) {
+		dev_err(&tz->device, "Trigger Allocate Failed\n");
+		return ret;
+	}
+	*iio_trig = trig;
+
+	return 0;
+}
+
+static const struct iio_info thermal_iio_info = {
+	.read_raw		= thermal_iio_read_raw,
+	.read_event_value	= thermal_iio_read_event,
+	.write_event_value	= thermal_iio_write_event,
+	.write_event_config	= thermal_iio_write_event_config,
+	.read_event_config	= thermal_iio_read_event_config,
+	.driver_module		= THIS_MODULE,
+};
+
+int thermal_iio_sensor_register(struct thermal_zone_device *tz)
+{
+	struct thermal_iio_data *iio_data;
+	struct iio_chan_spec *channels;
+	int ret;
+
+	tz->indio_dev = devm_iio_device_alloc(&tz->device, sizeof(*iio_data));
+	if (!tz->indio_dev)
+		return -ENOMEM;
+
+	iio_data = iio_priv(tz->indio_dev);
+	iio_data->tz = tz;
+	mutex_init(&iio_data->mutex);
+
+	channels = devm_kmemdup(&tz->device, thermal_iio_channels,
+				sizeof(thermal_iio_channels),
+				GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	tz->indio_dev->dev.parent = &tz->device;
+	tz->indio_dev->channels = channels;
+	tz->indio_dev->num_channels = ARRAY_SIZE(thermal_iio_channels);
+	tz->indio_dev->name = tz->type;
+	tz->indio_dev->info = &thermal_iio_info;
+	tz->indio_dev->modes = INDIO_DIRECT_MODE;
+
+	if (tz->ops->set_threshold_temp) {
+		ret = thermal_iio_setup_trig(&iio_data->interrupt_trig, tz,
+					     "%s-dev%d");
+		if (ret)
+			return ret;
+
+		channels->num_event_specs = 1;
+	}
+	ret = iio_triggered_buffer_setup(tz->indio_dev,
+					 &iio_pollfunc_store_time,
+					 thermal_trigger_handler, NULL);
+	if (ret) {
+		dev_err(&tz->device, "failed to init trigger buffer\n");
+		goto err_unreg_int_trig;
+	}
+	ret = iio_device_register(tz->indio_dev);
+	if (ret < 0) {
+		dev_err(&tz->device, "unable to register iio device\n");
+		goto err_cleanup_trig;
+	}
+
+	return 0;
+
+err_cleanup_trig:
+	iio_triggered_buffer_cleanup(tz->indio_dev);
+err_unreg_int_trig:
+	if (iio_data->interrupt_trig)
+		iio_trigger_unregister(iio_data->interrupt_trig);
+
+	return ret;
+}
+
+int thermal_iio_sensor_unregister(struct thermal_zone_device *tz)
+{
+	struct thermal_iio_data *iio_data = iio_priv(tz->indio_dev);
+
+	iio_device_unregister(tz->indio_dev);
+	iio_triggered_buffer_cleanup(tz->indio_dev);
+
+	if (iio_data->interrupt_trig)
+		iio_trigger_unregister(iio_data->interrupt_trig);
+
+	return 0;
+}
+
+#define IIO_EVENT_CODE_THERMAL_THRES IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,\
+							  IIO_EV_TYPE_THRESH,\
+							  IIO_EV_DIR_EITHER)
+
+int thermal_iio_sensor_threshold_notify(struct thermal_zone_device *tz)
+{
+	struct thermal_iio_data *iio_data = iio_priv(tz->indio_dev);
+
+	mutex_lock(&iio_data->mutex);
+	if (iio_data->ev_enable_state)
+		iio_push_event(tz->indio_dev,
+			       IIO_EVENT_CODE_THERMAL_THRES,
+			       iio_get_time_ns());
+
+	if (iio_data->enable_trigger)
+		iio_trigger_poll_chained(tz->indio_dev->trig);
+
+	mutex_unlock(&iio_data->mutex);
+
+	return 0;
+}
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 037e9df..4f239a1 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -111,6 +111,10 @@ struct thermal_zone_device_ops {
 	int (*set_emul_temp) (struct thermal_zone_device *, unsigned long);
 	int (*get_trend) (struct thermal_zone_device *, int,
 			  enum thermal_trend *);
+	int (*get_threshold_temp)(struct thermal_zone_device *, int,
+				  unsigned long *);
+	int (*set_threshold_temp)(struct thermal_zone_device *, int,
+				  unsigned long);
 	int (*notify) (struct thermal_zone_device *, int,
 		       enum thermal_trip_type);
 };
@@ -145,6 +149,8 @@ struct thermal_attr {
 	char name[THERMAL_NAME_LENGTH];
 };
 
+struct iio_dev;
+
 /**
  * struct thermal_zone_device - structure for a thermal zone
  * @id:		unique id number for each thermal zone
@@ -179,6 +185,7 @@ struct thermal_attr {
  * @lock:	lock to protect thermal_instances list
  * @node:	node in thermal_tz_list (in thermal_core.c)
  * @poll_queue:	delayed work for polling
+ * @indio_dev:	pointer to instance of an IIO dev for this zone
  */
 struct thermal_zone_device {
 	int id;
@@ -205,6 +212,9 @@ struct thermal_zone_device {
 	struct mutex lock;
 	struct list_head node;
 	struct delayed_work poll_queue;
+#if defined(CONFIG_THERMAL_IIO)
+	struct iio_dev *indio_dev;
+#endif
 };
 
 /**
@@ -483,4 +493,25 @@ static inline int thermal_generate_netlink_event(struct thermal_zone_device *tz,
 }
 #endif
 
+#if defined(CONFIG_THERMAL_IIO)
+int thermal_iio_sensor_register(struct thermal_zone_device *tz);
+int thermal_iio_sensor_unregister(struct thermal_zone_device *tz);
+int thermal_iio_sensor_threshold_notify(struct thermal_zone_device *tz);
+#else
+static int thermal_iio_sensor_register(struct thermal_zone_device *tz)
+{
+	return 0;
+}
+
+static int thermal_iio_sensor_unregister(struct thermal_zone_device *tz)
+{
+	return 0;
+}
+
+static int thermal_iio_sensor_threshold_notify(struct thermal_zone_device *tz)
+{
+	return 0;
+}
+#endif
+
 #endif /* __THERMAL_H__ */
-- 
2.4.3

