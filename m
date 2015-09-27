Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37987 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbbI0SSJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Sep 2015 14:18:09 -0400
Subject: Re: [PATCH 3/6] thermal: iio device for thermal sensor
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org
References: <1443305111-28272-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1443305111-28272-4-git-send-email-srinivas.pandruvada@linux.intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <560832DD.1010505@kernel.org>
Date: Sun, 27 Sep 2015 19:18:05 +0100
MIME-Version: 1.0
In-Reply-To: <1443305111-28272-4-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/09/15 23:05, Srinivas Pandruvada wrote:
> This change registers temperature sensor in a thermal zone as an IIO
> temperature device. This allows user space thermal application to fully
> utilize IIO capability to read temperature events and samples.
> The primary motivation for this change to improve performance for user
> space thermal controllers like Linux thermal daemon or Intel® Dynamic
> Platform and Thermal Framework (DPTF) for Chromium OS.
> The current sysfs has several limitations, which forces the current
> user space to use polling as the safe way. This polling causes performance
> bottlenecks as some devices requires extremely aggressive response to
> changing temperature conditions.
> These are some limitations, which this change tries to address:
> - Temperature reading via sysfs attribute, which needs conversion from
> string to int
> - No way to set threshold settings to avoid polling for temperature change
> without using a RW passive trip point.
> - Event notifications via slow kobject uevents, which needs parsing to id
> the zone and read temperature
> - Only pull interface from user space, kernel drivers can't send samples
> - One sample at a time read from user space
> These limitations can be addressed by registering temperature sensor
> as an IIO device. IIO provides
> - buffered access via /dev/iio:deviceX node with select/poll capability
> - temperature thresholds setting via iio event thresholds
> - Wait and receive events
> - Able to use different external trigger (data ready indications) and push
> samples to buffers
> 
> Next set of patches uses the IIO binding introduced in this patchset.
> The iio device created during call to thermal_zone_device_register. Samples
> are pushed to iio buffers when thermal_zone_device_update is called from
> client drivers.
> 
> New thermal zone device callbacks:
> It introduces three new callbacks for thermal client drivers:
> get_threshold_temp: Get the current threshold temperature
> set_threshold_temp: Set the current threshold temperature
> check_notification_support: Inform that the client driver has asynchronous
> notification mechanism. If it is then polling can be avoided for the
> temperature sensor.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
I think I confused you in a previous review.

To avoid complexity with a non interrupt trigger like this one you
need both the validate_trigger and validate_device callbacks (in the device
and trigger respectively).  See below.

Fix that little bit up (which is really simple!) and you can add
Reviewed-by: Jonathan Cameron <jic23@kernel.org>

Thanks,

Jonathan
> ---
>  drivers/thermal/Kconfig       |  12 ++
>  drivers/thermal/Makefile      |   1 +
>  drivers/thermal/thermal_iio.c | 383 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/thermal/thermal_iio.h |  45 +++++
>  include/linux/thermal.h       |  13 ++
>  5 files changed, 454 insertions(+)
>  create mode 100644 drivers/thermal/thermal_iio.c
>  create mode 100644 drivers/thermal/thermal_iio.h
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 0390044..bc7836e 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -29,6 +29,18 @@ config THERMAL_HWMON
>  	  Say 'Y' here if you want all thermal sensors to
>  	  have hwmon sysfs interface too.
>  
> +config THERMAL_IIO
> +	bool
> +	prompt "Thermal sensor from a zone as IIO sensor device"
> +	select IIO
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  This will register thermal sensor in a zone as an IIO temperature
> +	  sensor device.
> +	  This will help user space thermal controllers to use IIO ABI to
> +	  get events and buffered acces to temperature samples.
> +
>  config THERMAL_OF
>  	bool
>  	prompt "APIs to parse thermal data out of device tree"
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 26f1608..b72a28d 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -7,6 +7,7 @@ thermal_sys-y			+= thermal_core.o
>  
>  # interface to/from other layers providing sensors
>  thermal_sys-$(CONFIG_THERMAL_HWMON)		+= thermal_hwmon.o
> +thermal_sys-$(CONFIG_THERMAL_IIO)		+= thermal_iio.o
>  thermal_sys-$(CONFIG_THERMAL_OF)		+= of-thermal.o
>  
>  # governors
> diff --git a/drivers/thermal/thermal_iio.c b/drivers/thermal/thermal_iio.c
> new file mode 100644
> index 0000000..492eaff
> --- /dev/null
> +++ b/drivers/thermal/thermal_iio.c
> @@ -0,0 +1,383 @@
> +/*
> + * thermal iio interface driver
> + * Copyright (c) 2015, Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +#include <linux/thermal.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +struct thermal_iio_data {
> +	struct thermal_zone_device *tz;
> +	struct iio_trigger *interrupt_trig;
> +	struct iio_chan_spec *channels;
> +	bool enable_trigger;
> +	int temp_thres;
> +	bool ev_enable_state;
> +	struct mutex mutex;
> +};
> +
> +static const struct iio_event_spec thermal_event = {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_ENABLE)
> +};
> +
> +static const struct iio_chan_spec thermal_iio_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 32,
> +			.storagebits = 32,
> +			.endianness = IIO_CPU,
> +		}
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(1)
> +};
> +
> +static const struct iio_chan_spec thermal_iio_channels_with_events[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 32,
> +			.storagebits = 32,
> +			.endianness = IIO_CPU,
> +		},
> +		.event_spec = &thermal_event,
> +		.num_event_specs = 1,
> +
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(1)
> +};
> +
> +static int thermal_iio_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct thermal_iio_data *iio_data = iio_priv(indio_dev);
> +	int temp;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = thermal_zone_get_temp(iio_data->tz, &temp);
> +		if (!ret) {
> +			*val = temp;
> +			ret = IIO_VAL_INT;
> +		}
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static irqreturn_t thermal_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct thermal_iio_data *iio_data = iio_priv(indio_dev);
> +	u32 buffer[4];
> +	int temp;
> +	int ret;
> +
> +	ret = thermal_zone_get_temp(iio_data->tz, &temp);
> +	if (ret)
> +		goto err_read;
> +
> +	*(u32 *)buffer = temp;
Umm. I'm confused by the above.  buffer is a u32 array, so you are
casting it to a u32 pointer then dereferencing that.  Doesn't that
just give you buffer[0] = temp?

(might be too late on a Sunday!)  Given temp is signed, wby not use
s32 buffer[4] and be done with it?

> +	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> +					   iio_get_time_ns());
> +err_read:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int thermal_data_rdy_trigger_set_state(struct iio_trigger *trig,
> +					      bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct thermal_iio_data *iio_data = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	mutex_lock(&iio_data->mutex);
> +	if (iio_data->tz->ops->set_notification_status) {
> +		ret = iio_data->tz->ops->set_notification_status(iio_data->tz,
> +								 state);
> +		if (!ret)
> +			iio_data->enable_trigger = state;
> +	} else
> +		iio_data->enable_trigger = state;
> +	mutex_unlock(&iio_data->mutex);
> +
> +	return ret;
> +}
> +
> +static int thermal_iio_validate_trigger(struct iio_dev *indio_dev,
> +					struct iio_trigger *trig)
> +{
> +	struct thermal_iio_data *iio_data = iio_priv(indio_dev);
> +
> +	if (iio_data->interrupt_trig && iio_data->interrupt_trig != trig)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static const struct iio_trigger_ops thermal_trigger_ops = {
> +	.set_trigger_state = thermal_data_rdy_trigger_set_state,
For reasons explained later, you want validate_device to be defined
as well.
> +	.owner = THIS_MODULE,
> +};
> +
> +static int thermal_iio_read_event(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *chan,
> +				  enum iio_event_type type,
> +				  enum iio_event_direction dir,
> +				  enum iio_event_info info,
> +				  int *val, int *val2)
> +{
> +	struct thermal_iio_data *iio_data = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&iio_data->mutex);
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		*val = iio_data->temp_thres;
> +		ret = IIO_VAL_INT;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +	mutex_unlock(&iio_data->mutex);
> +
> +	return ret;
> +}
> +
> +static int thermal_iio_write_event(struct iio_dev *indio_dev,
> +				   const struct iio_chan_spec *chan,
> +				   enum iio_event_type type,
> +				   enum iio_event_direction dir,
> +				   enum iio_event_info info,
> +				   int val, int val2)
> +{
> +	struct thermal_iio_data *iio_data = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	mutex_lock(&iio_data->mutex);
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		iio_data->temp_thres = val;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +	mutex_unlock(&iio_data->mutex);
> +
> +	return ret;
> +}
> +
> +static int thermal_iio_read_event_config(struct iio_dev *indio_dev,
> +					 const struct iio_chan_spec *chan,
> +					 enum iio_event_type type,
> +					 enum iio_event_direction dir)
> +{
> +	struct thermal_iio_data *iio_data = iio_priv(indio_dev);
> +	bool state;
> +
> +	mutex_lock(&iio_data->mutex);
> +	state = iio_data->ev_enable_state;
> +	mutex_unlock(&iio_data->mutex);
> +
> +	return state;
> +}
> +
> +static int thermal_iio_write_event_config(struct iio_dev *indio_dev,
> +					  const struct iio_chan_spec *chan,
> +					  enum iio_event_type type,
> +					  enum iio_event_direction dir,
> +					  int state)
> +{
> +	struct thermal_iio_data *iio_data = iio_priv(indio_dev);
> +	int temp_thres;
> +	int ret = 0;
> +
> +	mutex_lock(&iio_data->mutex);
> +	if ((state && iio_data->ev_enable_state) ||
> +	    (!state && !iio_data->ev_enable_state))
> +		goto done_write_event;
> +
> +	if (state && !iio_data->temp_thres) {
> +		ret = -EINVAL;
> +		goto done_write_event;
> +	}
> +
> +	if (state)
> +		temp_thres = iio_data->temp_thres;
> +	else
> +		temp_thres = 0;
> +
> +	ret = iio_data->tz->ops->set_threshold_temp(iio_data->tz, 0,
> +						    temp_thres);
> +	if (ret)
> +		goto done_write_event;
> +
> +	if (iio_data->tz->ops->set_notification_status) {
> +		ret = iio_data->tz->ops->set_notification_status(iio_data->tz,
> +								 state > 0);
> +		if (!ret)
> +			iio_data->ev_enable_state = state;
> +	} else
> +		iio_data->ev_enable_state = state;
> +
> +done_write_event:
> +	mutex_unlock(&iio_data->mutex);
> +
> +	return ret;
> +}
> +
> +static int thermal_iio_setup_trig(struct iio_trigger **iio_trig,
> +				  struct thermal_zone_device *tz,
> +				  const char *format)
> +{
> +	struct iio_trigger *trig;
> +	int ret;
> +
> +	trig = devm_iio_trigger_alloc(&tz->device, format, tz->type,
> +				      tz->indio_dev->id);
> +	if (!trig) {
> +		dev_err(&tz->device, "Trigger Allocate Failed\n");
> +		return -ENOMEM;
> +	}
> +	trig->dev.parent = &tz->device;
> +	trig->ops = &thermal_trigger_ops;
> +	iio_trigger_set_drvdata(trig, tz->indio_dev);
> +	ret = iio_trigger_register(trig);
> +	if (ret) {
> +		dev_err(&tz->device, "Trigger Allocate Failed\n");
> +		return ret;
> +	}
> +	*iio_trig = trig;
> +
> +	return 0;
> +}
> +
> +static const struct iio_info thermal_iio_info = {
> +	.read_raw		= thermal_iio_read_raw,
> +	.read_event_value	= thermal_iio_read_event,
> +	.write_event_value	= thermal_iio_write_event,
> +	.write_event_config	= thermal_iio_write_event_config,
> +	.read_event_config	= thermal_iio_read_event_config,
> +	.validate_trigger	= thermal_iio_validate_trigger,
> +	.driver_module		= THIS_MODULE,
> +};
> +
> +int thermal_iio_sensor_register(struct thermal_zone_device *tz)
> +{
> +	struct thermal_iio_data *iio_data;
> +	int ret;
> +
> +	tz->indio_dev = devm_iio_device_alloc(&tz->device, sizeof(*iio_data));
> +	if (!tz->indio_dev)
> +		return -ENOMEM;
> +
> +	iio_data = iio_priv(tz->indio_dev);
> +	iio_data->tz = tz;
> +	mutex_init(&iio_data->mutex);
> +
> +	tz->indio_dev->dev.parent = &tz->device;
> +	if (tz->ops->set_threshold_temp)
> +		tz->indio_dev->channels = thermal_iio_channels_with_events;
> +	else
> +		tz->indio_dev->channels = thermal_iio_channels;
> +	tz->indio_dev->num_channels = ARRAY_SIZE(thermal_iio_channels);
> +	tz->indio_dev->name = tz->type;
> +	tz->indio_dev->info = &thermal_iio_info;
> +	tz->indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	if (tz->ops->check_notification_support &&
> +	    tz->ops->check_notification_support(tz)) {
> +		ret = thermal_iio_setup_trig(&iio_data->interrupt_trig, tz,
> +					     "%s-dev%d");
> +		if (ret)
> +			return ret;
> +
> +		tz->indio_dev->trig = iio_trigger_get(iio_data->interrupt_trig);
> +	}
> +	ret = iio_triggered_buffer_setup(tz->indio_dev,
> +					 &iio_pollfunc_store_time,
> +					 thermal_trigger_handler, NULL);
> +	if (ret) {
> +		dev_err(&tz->device, "failed to init trigger buffer\n");
> +		goto err_unreg_int_trig;
> +	}
> +	ret = iio_device_register(tz->indio_dev);
> +	if (ret < 0) {
> +		dev_err(&tz->device, "unable to register iio device\n");
> +		goto err_cleanup_trig;
> +	}
> +
> +	return 0;
> +
> +err_cleanup_trig:
> +	iio_triggered_buffer_cleanup(tz->indio_dev);
> +err_unreg_int_trig:
> +	if (iio_data->interrupt_trig)
> +		iio_trigger_unregister(iio_data->interrupt_trig);
> +
> +	return ret;
> +}
> +
> +int thermal_iio_sensor_unregister(struct thermal_zone_device *tz)
> +{
> +	struct thermal_iio_data *iio_data = iio_priv(tz->indio_dev);
> +
> +	iio_device_unregister(tz->indio_dev);
> +	iio_triggered_buffer_cleanup(tz->indio_dev);
> +	if (iio_data->interrupt_trig)
> +		iio_trigger_unregister(iio_data->interrupt_trig);
> +
> +	return 0;
> +}
> +
> +int thermal_iio_sensor_notify(struct thermal_zone_device *tz,
> +			      enum thermal_device_event_type event)
> +{
> +	struct thermal_iio_data *iio_data = iio_priv(tz->indio_dev);
> +
> +	mutex_lock(&iio_data->mutex);
> +	if (iio_data->ev_enable_state &&
> +	    event == THERMAL_DEVICE_EVENT_THRESHOLD)
> +		iio_push_event(tz->indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_EITHER),
> +			       iio_get_time_ns());
> +	if (iio_data->enable_trigger)

I didn't pick up on this earlier, but is this running in interrupt context
or not?  iio_trigger_poll is generally assumed to do so and I suspect this
is not guaranteed to be given the mutex!

Validating the trigger means that only the right trigger can drive the
thermal buffer, but unless you validate the other way as well there is nothing
stopping something else registering to use this trigger.  If it's not
a true interrupt, all sorts of mess can occur.

What you need is the validate_device callback for the trigger to check the
device is the one providing the trigger.

Once you've validated both ways, using iio_trigger_poll_chained is fine and
makes it clear we are calling a bottom half (these days normally an interrupt
thread, but not one here).

The alternative is to go through the irq_work dance, but I doubt there is
any reason to do that here.
> +		iio_trigger_poll(tz->indio_dev->trig);
> +	mutex_unlock(&iio_data->mutex);
> +
> +	return 0;
> +}
> diff --git a/drivers/thermal/thermal_iio.h b/drivers/thermal/thermal_iio.h
> new file mode 100644
> index 0000000..850ea7d
> --- /dev/null
> +++ b/drivers/thermal/thermal_iio.h
> @@ -0,0 +1,45 @@
> +/*
> + * thermal iio interface driver interface file
> + * Copyright (c) 2015, Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +#ifndef __THERMAL_IIO_H__
> +#define __THERMAL_IIO_H__
> +
> +#if defined(CONFIG_THERMAL_IIO)
> +
> +int thermal_iio_sensor_register(struct thermal_zone_device *tz);
> +int thermal_iio_sensor_unregister(struct thermal_zone_device *tz);
> +int thermal_iio_sensor_notify(struct thermal_zone_device *tz,
> +			      enum thermal_device_event_type event);
> +
> +#else
> +
> +static int thermal_iio_sensor_register(struct thermal_zone_device *tz)
> +{
> +	return 0;
> +}
> +
> +static int thermal_iio_sensor_unregister(struct thermal_zone_device *tz)
> +{
> +	return 0;
> +}
> +
> +static int thermal_iio_sensor_notify(struct thermal_zone_device *tz,
> +				     enum thermal_device_event_type event)
> +
> +{
> +	return 0;
> +}
> +
> +#endif
> +#endif
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index c074f6a..925d1e5 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -114,6 +114,13 @@ struct thermal_zone_device_ops {
>  	int (*set_emul_temp) (struct thermal_zone_device *, int);
>  	int (*get_trend) (struct thermal_zone_device *, int,
>  			  enum thermal_trend *);
> +	int (*get_threshold_temp)(struct thermal_zone_device *, int,
> +				  int *);
> +	int (*set_threshold_temp)(struct thermal_zone_device *, int,
> +				  int);
> +	int (*set_notification_status)(struct thermal_zone_device *,
> +				       bool status);
> +	bool (*check_notification_support)(struct thermal_zone_device *);
>  	int (*notify) (struct thermal_zone_device *, int,
>  		       enum thermal_trip_type);
>  };
> @@ -148,6 +155,8 @@ struct thermal_attr {
>  	char name[THERMAL_NAME_LENGTH];
>  };
>  
> +struct iio_dev;
> +
>  /**
>   * struct thermal_zone_device - structure for a thermal zone
>   * @id:		unique id number for each thermal zone
> @@ -182,6 +191,7 @@ struct thermal_attr {
>   * @lock:	lock to protect thermal_instances list
>   * @node:	node in thermal_tz_list (in thermal_core.c)
>   * @poll_queue:	delayed work for polling
> + * @indio_dev:	pointer to instance of an IIO dev for this zone
>   */
>  struct thermal_zone_device {
>  	int id;
> @@ -208,6 +218,9 @@ struct thermal_zone_device {
>  	struct mutex lock;
>  	struct list_head node;
>  	struct delayed_work poll_queue;
> +#if defined(CONFIG_THERMAL_IIO)
> +	struct iio_dev *indio_dev;
> +#endif
>  };
>  
>  /**
> 

