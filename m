Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33438 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbbHTU5b (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Aug 2015 16:57:31 -0400
Date: Thu, 20 Aug 2015 13:57:26 -0700
From: Eduardo Valentin <edubezval@gmail.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rui.zhang@intel.com, jic23@kernel.org, linux-iio@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] thermal: iio device for thermal sensor
Message-ID: <20150820205725.GB5719@localhost.localdomain>
References: <1439855577-17114-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20150819175712.GB6643@localhost.localdomain>
 <1440083499.3841.11.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1440083499.3841.11.camel@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Aug 20, 2015 at 08:11:39AM -0700, Srinivas Pandruvada wrote:
> On Wed, 2015-08-19 at 10:57 -0700, Eduardo Valentin wrote:
> > On Mon, Aug 17, 2015 at 04:52:56PM -0700, Srinivas Pandruvada wrote:
> > > The only method to read temperature of a thermal zone is by reading 
> > > sysfs
> > > entry "temp". This works well when kernel is primarily doing 
> > > thermal
> > > control and user mode tools/applications are reading temperature 
> > > for
> > > display or debug purposes. But when user mode is doing primary 
> > > thermal
> > > control using a "user space" governor, this model causes 
> > > performance
> > > issues and have limitations. For example Linux thermal daemon or 
> > > Intel®
> > > Dynamic Platform and Thermal Framework (DPTF) for Chromium/Chrome 
> > > OS are
> > > currently used as user space thermal controllers in several 
> > > products.
> > > We have platforms with 10+ thermal sensors and thermal conditions 
> > > are not
> > > an isolated cases, so it is important to manage thermal conditions 
> > > without
> > > significantly degrading user experience. So we need an efficient 
> > > way to
> > > read temperature and events, by
> > > - Not using polling from user space
> > > - Avoid sysfs string read for temperature and convert to decimal
> > > - Push model, so that driver can push changes when some temperature
> > > change event occurs, which needs attention
> > > - Let user space registers for some thresholds without using some
> > > passive trips
> > > - Avoid string based kobject uevent notifications
> > 
> > 
> > > - Able to use different external trigger (data ready indications) 
> > > and push
> > > temperature samples
> > 
> > For documentation purposes, can you please elaborate a little more on
> > why the above items cause problems in userspace?
> > 
> Sure, in the next rev.
> > 
> > > 
> > > There are some ways to achieve this using thermal sysfs 2.0, but 
> > > still
> > > doesn't meet all requirements and will introduce backward 
> > > compatibility
> > > issues. Other option is to enhance thermal sysfs by adding a sensor
> > > abstractions and providing a dev interface for poll/select. But 
> > > since
> > > since Linux IIO already provides above capabilities, it is better 
> > > we
> > > reuse IIO temperature sensor device. This change proposes use of 
> > > IIO
> > > temperature sensor device for a thermal zone. Here IIO capabilities
> > > of triggered buffer and events are utilized.
> > > 
> > > The iio device created during call to thermal_zone_device_register.
> > > Samples are pushed to iio buffers when thermal_zone_device_update 
> > > is
> > > called from client drivers and user space governor is selected for 
> > > the
> > > thermal zone. Only two additional callbacks for client driver to 
> > > get/set
> > > thermal temperature thresholds.
> > > 
> > > Signed-off-by: Srinivas Pandruvada <
> > > srinivas.pandruvada@linux.intel.com>
> > > ---
> > >  drivers/thermal/Kconfig        |  11 ++
> > >  drivers/thermal/Makefile       |   1 +
> > >  drivers/thermal/thermal_core.c |   9 +-
> > >  drivers/thermal/thermal_iio.c  | 333 
> > > +++++++++++++++++++++++++++++++++++++++++
> > >  drivers/thermal/user_space.c   |   1 +
> > >  include/linux/thermal.h        |  46 ++++++
> > 
> > Can you please add documentation too?
> OK.
> > 
> > >  6 files changed, 399 insertions(+), 2 deletions(-)
> > >  create mode 100644 drivers/thermal/thermal_iio.c
> > > 
> > > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > > index 118938e..0ea9d8b 100644
> > > --- a/drivers/thermal/Kconfig
> > > +++ b/drivers/thermal/Kconfig
> > > @@ -29,6 +29,17 @@ config THERMAL_HWMON
> > >  	  Say 'Y' here if you want all thermal sensors to
> > >  	  have hwmon sysfs interface too.
> > >  
> > > +config THERMAL_IIO
> > > +	tristate "Thermal sensor from a zone as IIO device"
> > > +	select IIO
> > > +	select IIO_BUFFER
> > > +	select IIO_TRIGGERED_BUFFER
> > > +	help
> > > +	  This will register thermal sensor in a zone as an IIO 
> > > temperature
> > > +	  sensor device.
> > > +	  This will help user space thermal controllers to use IIO 
> > > ABI to
> > > +	  get events and buffered acces to temperature samples.
> > > +
> > >  config THERMAL_OF
> > >  	bool
> > >  	prompt "APIs to parse thermal data out of device tree"
> > > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > > index 535dfee..4b42734 100644
> > > --- a/drivers/thermal/Makefile
> > > +++ b/drivers/thermal/Makefile
> > > @@ -7,6 +7,7 @@ thermal_sys-y			+= 
> > > thermal_core.o
> > >  
> > >  # interface to/from other layers providing sensors
> > >  thermal_sys-$(CONFIG_THERMAL_HWMON)		+= 
> > > thermal_hwmon.o
> > > +thermal_sys-$(CONFIG_THERMAL_IIO)		+= thermal_iio.o
> > >  thermal_sys-$(CONFIG_THERMAL_OF)		+= of-thermal.o
> > >  
> > >  # governors
> > > diff --git a/drivers/thermal/thermal_core.c 
> > > b/drivers/thermal/thermal_core.c
> > > index 04659bf..483a4a1 100644
> > > --- a/drivers/thermal/thermal_core.c
> > > +++ b/drivers/thermal/thermal_core.c
> > > @@ -1833,10 +1833,15 @@ struct thermal_zone_device 
> > > *thermal_zone_device_register(const char *type,
> > >  
> > >  	mutex_unlock(&thermal_governor_lock);
> > >  
> > > +	if (thermal_iio_sensor_register(tz))
> > > +		goto unregister;
> > > +
> > >  	if (!tz->tzp || !tz->tzp->no_hwmon) {
> > >  		result = thermal_add_hwmon_sysfs(tz);
> > > -		if (result)
> > > +		if (result) {
> > > +			thermal_iio_sensor_unregister(tz);
> > >  			goto unregister;
> > > +		}
> > >  	}
> > >  
> > >  	mutex_lock(&thermal_list_lock);
> > > @@ -1919,7 +1924,7 @@ void thermal_zone_device_unregister(struct 
> > > thermal_zone_device *tz)
> > >  	device_remove_file(&tz->device, &dev_attr_policy);
> > >  	remove_trip_attrs(tz);
> > >  	thermal_set_governor(tz, NULL);
> > > -
> > > +	thermal_iio_sensor_unregister(tz);
> > >  	thermal_remove_hwmon_sysfs(tz);
> > >  	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
> > >  	idr_destroy(&tz->idr);
> > > diff --git a/drivers/thermal/thermal_iio.c 
> > > b/drivers/thermal/thermal_iio.c
> > > new file mode 100644
> > > index 0000000..e36ad90
> > > --- /dev/null
> > > +++ b/drivers/thermal/thermal_iio.c
> > > @@ -0,0 +1,333 @@
> > > +/*
> > > + * thermal iio interface driver
> > > + * Copyright (c) 2015, Intel Corporation.
> > > + *
> > > + * This program is free software; you can redistribute it and/or 
> > > modify it
> > > + * under the terms and conditions of the GNU General Public 
> > > License,
> > > + * version 2, as published by the Free Software Foundation.
> > > + *
> > > + * This program is distributed in the hope it will be useful, but 
> > > WITHOUT
> > > + * ANY WARRANTY; without even the implied warranty of 
> > > MERCHANTABILITY or
> > > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public 
> > > License for
> > > + * more details.
> > > + */
> > > +
> > > +#include <linux/thermal.h>
> > > +
> > > +struct thermal_iio_data {
> > > +	struct thermal_zone_device *tz;
> > > +	struct iio_trigger *dready_trig;
> > > +	s16 buffer[8];
> > > +	bool enable;
> > > +	long temp_thres;
> > > +	bool ev_enable_state;
> > > +	struct mutex mutex;
> > > +
> > > +};
> > > +
> > > +static const struct iio_event_spec thermal_event = {
> > > +		.type = IIO_EV_TYPE_THRESH,
> > > +		.dir = IIO_EV_DIR_EITHER,
> > > +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> > > +				 BIT(IIO_EV_INFO_ENABLE)
> > > +};
> > > +
> > > +#define THERMAL_TEMP_CHANNELS {					
> > > \
> > > +	{								
> > > \
> > > +		.type = IIO_TEMP,					
> > > \
> > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	
> > > 	\
> > > +		.scan_index = 0,					
> > > \
> > > +		.scan_type = {					
> > > 	\
> > > +			.sign = 'u',				
> > > 	\
> > > +			.realbits = 32,				
> > > \
> > > +			.storagebits = 32,				
> > > \
> > > +			.shift = 0,				
> > > 	\
> > > +			.endianness = IIO_CPU,			
> > > 	\
> > > +		},							
> > > \
> > > +		.event_spec = &thermal_event,			
> > > 	\
> > > +		.num_event_specs = 1				
> > > 	\
> > > +	},								
> > > \
> > > +}
> > > +
> > > +static const struct iio_chan_spec thermal_iio_channels[] =
> > > +							THERMAL_TE
> > > MP_CHANNELS;
> > > +
> > > +static int thermal_iio_read_raw(struct iio_dev *indio_dev,
> > > +				struct iio_chan_spec const *chan,
> > > +				int *val, int *val2, long mask)
> > > +{
> > > +	struct thermal_iio_data *iio_data = iio_priv(indio_dev);
> > > +	long temp;
> > > +	int ret;
> > > +
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_RAW:
> > > +		ret = thermal_zone_get_temp(iio_data->tz, &temp);
> > > +		if (ret)
> > > +			return ret;
> > > +		*val = (int) temp;
> > > +		return IIO_VAL_INT;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static irqreturn_t thermal_trigger_handler(int irq, void *p)
> > > +{
> > > +	struct iio_poll_func *pf = p;
> > > +	struct iio_dev *indio_dev = pf->indio_dev;
> > > +	struct thermal_iio_data *iio_data = iio_priv(indio_dev);
> > > +	long temp;
> > > +	int ret;
> > > +
> > > +	ret = thermal_zone_get_temp(iio_data->tz, &temp);
> > > +	if (ret)
> > > +		goto err_read;
> > > +
> > > +	*(s32 *)iio_data->buffer = (s32)temp;
> > > +	iio_push_to_buffers(indio_dev, iio_data->buffer);
> > > +err_read:
> > > +	iio_trigger_notify_done(indio_dev->trig);
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static int thermal_data_rdy_trigger_set_state(struct iio_trigger 
> > > *trig,
> > > +					      bool state)
> > > +{
> > > +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> > > +	struct thermal_iio_data *iio_data = iio_priv(indio_dev);
> > > +
> > > +	mutex_lock(&iio_data->mutex);
> > > +	iio_data->enable = state;
> > > +	mutex_unlock(&iio_data->mutex);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct iio_trigger_ops thermal_trigger_ops = {
> > > +	.set_trigger_state = thermal_data_rdy_trigger_set_state,
> > > +	.owner = THIS_MODULE,
> > > +};
> > > +
> > > +static int thermal_iio_read_event(struct iio_dev *indio_dev,
> > > +				  const struct iio_chan_spec 
> > > *chan,
> > > +				  enum iio_event_type type,
> > > +				  enum iio_event_direction dir,
> > > +				  enum iio_event_info info,
> > > +				  int *val, int *val2)
> > > +{
> > > +	struct thermal_iio_data *iio_data = iio_priv(indio_dev);
> > > +	int ret;
> > > +
> > > +	mutex_lock(&iio_data->mutex);
> > > +	*val2 = 0;
> > > +	switch (info) {
> > > +	case IIO_EV_INFO_VALUE:
> > > +		*val = iio_data->temp_thres;
> > > +		ret = IIO_VAL_INT;
> > > +		break;
> > > +	default:
> > > +		ret = -EINVAL;
> > > +		break;
> > > +	}
> > > +	mutex_unlock(&iio_data->mutex);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int thermal_iio_write_event(struct iio_dev *indio_dev,
> > > +				   const struct iio_chan_spec 
> > > *chan,
> > > +				   enum iio_event_type type,
> > > +				   enum iio_event_direction dir,
> > > +				   enum iio_event_info info,
> > > +				   int val, int val2)
> > > +{
> > > +	struct thermal_iio_data *iio_data = iio_priv(indio_dev);
> > > +	int ret = 0;
> > > +
> > > +	mutex_lock(&iio_data->mutex);
> > > +	if (iio_data->ev_enable_state) {
> > > +		ret = -EBUSY;
> > > +		goto done_write_event;
> > > +	}
> > > +	switch (info) {
> > > +	case IIO_EV_INFO_VALUE:
> > > +		iio_data->temp_thres = val;
> > > +		break;
> > > +	default:
> > > +		ret = -EINVAL;
> > > +		break;
> > > +	}
> > > +done_write_event:
> > > +	mutex_unlock(&iio_data->mutex);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int thermal_iio_read_event_config(struct iio_dev 
> > > *indio_dev,
> > > +					 const struct 
> > > iio_chan_spec *chan,
> > > +					 enum iio_event_type type,
> > > +					 enum iio_event_direction 
> > > dir)
> > > +{
> > > +
> > > +	struct thermal_iio_data *iio_data = iio_priv(indio_dev);
> > > +	bool state;
> > > +
> > > +	mutex_lock(&iio_data->mutex);
> > > +	state = iio_data->ev_enable_state;
> > > +	mutex_unlock(&iio_data->mutex);
> > > +
> > > +	return state;
> > > +}
> > > +
> > > +static int thermal_iio_write_event_config(struct iio_dev 
> > > *indio_dev,
> > > +					  const struct 
> > > iio_chan_spec *chan,
> > > +					  enum iio_event_type 
> > > type,
> > > +					  enum iio_event_direction 
> > > dir,
> > > +					  int state)
> > > +{
> > > +	struct thermal_iio_data *iio_data = iio_priv(indio_dev);
> > > +	int ret = 0;
> > > +
> > > +	mutex_lock(&iio_data->mutex);
> > > +	if (state && iio_data->ev_enable_state)
> > > +		goto done_write_event;
> > > +
> > > +	if (iio_data->tz->ops->set_threshold_temp)
> > > +		ret = iio_data->tz->ops
> > > ->set_threshold_temp(iio_data->tz, 0,
> > > +							iio_data
> > > ->temp_thres);
> > > +	iio_data->ev_enable_state = state;
> > > +
> > > +done_write_event:
> > > +	mutex_unlock(&iio_data->mutex);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static const struct iio_info thermal_iio_info = {
> > > +	.read_raw		= thermal_iio_read_raw,
> > > +	.read_event_value	= thermal_iio_read_event,
> > > +	.write_event_value	= thermal_iio_write_event,
> > > +	.write_event_config	= 
> > > thermal_iio_write_event_config,
> > > +	.read_event_config	= thermal_iio_read_event_config,
> > > +	.driver_module		= THIS_MODULE,
> > > +};
> > > +
> > > +int thermal_iio_sensor_register(struct thermal_zone_device *tz)
> > > +{
> > > +	struct thermal_iio_data *iio_data;
> > > +	int ret;
> > > +
> > > +	tz->indio_dev = devm_iio_device_alloc(&tz->device, 
> > > sizeof(*iio_data));
> > > +	if (!tz->indio_dev)
> > > +		return -ENOMEM;
> > > +
> > > +	iio_data = iio_priv(tz->indio_dev);
> > > +	iio_data->tz = tz;
> > > +	mutex_init(&iio_data->mutex);
> > > +
> > > +	tz->indio_dev->dev.parent = &tz->device;
> > > +	tz->indio_dev->channels = thermal_iio_channels;
> > > +	tz->indio_dev->num_channels = 
> > > ARRAY_SIZE(thermal_iio_channels);
> > > +	tz->indio_dev->name = tz->type;
> > > +	tz->indio_dev->info = &thermal_iio_info;
> > > +	tz->indio_dev->modes = INDIO_DIRECT_MODE;
> > > +
> > > +	iio_data->dready_trig = devm_iio_trigger_alloc(&tz
> > > ->device, "%s-dev%d",
> > > +						       tz->type,
> > > +						       tz
> > > ->indio_dev->id);
> > > +	if (iio_data->dready_trig == NULL) {
> > > +		dev_err(&tz->device, "Trigger Allocate Failed\n");
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	iio_data->dready_trig->dev.parent = &tz->device;
> > > +	iio_data->dready_trig->ops = &thermal_trigger_ops;
> > > +	iio_trigger_set_drvdata(iio_data->dready_trig, tz
> > > ->indio_dev);
> > > +	tz->indio_dev->trig = iio_data->dready_trig;
> > > +	iio_trigger_get(tz->indio_dev->trig);
> > > +	ret = iio_trigger_register(iio_data->dready_trig);
> > > +	if (ret) {
> > > +		dev_err(&tz->device, "Trigger Allocate Failed\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = iio_triggered_buffer_setup(tz->indio_dev,
> > > +					 &iio_pollfunc_store_time,
> > > +					 thermal_trigger_handler, 
> > > NULL);
> > > +	if (ret) {
> > > +		dev_err(&tz->device, "failed to initialize trigger 
> > > buffer\n");
> > > +		goto err_unreg_trig;
> > > +	}
> > > +
> > > +	ret = iio_device_register(tz->indio_dev);
> > > +	if (ret < 0) {
> > > +		dev_err(&tz->device, "unable to register iio 
> > > device\n");
> > > +		goto err_cleanup_trig;
> > > +	}
> > > +
> > > +	return 0;
> > > +
> > > +err_cleanup_trig:
> > > +	iio_triggered_buffer_cleanup(tz->indio_dev);
> > > +err_unreg_trig:
> > > +	iio_device_unregister(tz->indio_dev);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +int thermal_iio_sensor_unregister(struct thermal_zone_device *tz)
> > > +{
> > > +	struct thermal_iio_data *iio_data = iio_priv(tz
> > > ->indio_dev);
> > > +
> > > +	iio_device_unregister(tz->indio_dev);
> > > +	iio_triggered_buffer_cleanup(tz->indio_dev);
> > > +	iio_trigger_unregister(iio_data->dready_trig);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +#define IIO_EVENT_CODE_THERMAL_THRES 
> > > IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,\
> > > +							 
> > >  IIO_EV_TYPE_THRESH,\
> > > +							 
> > >  IIO_EV_DIR_EITHER)
> > > +
> > > +#define IIO_EVENT_CODE_TRIP_UPDATE IIO_UNMOD_EVENT_CODE(IIO_TEMP, 
> > > 0,\
> > > +							IIO_EV_TYP
> > > E_CHANGE,\
> > > +							IIO_EV_DIR
> > > _NONE)
> > > +
> > > +int thermal_iio_sensor_notify(struct thermal_zone_device *tz,
> > > +			      enum thermal_zone_event_type event)
> > > +{
> > > +	struct thermal_iio_data *iio_data = iio_priv(tz
> > > ->indio_dev);
> > > +	long temp = 0;
> > > +	int ret;
> > > +
> > > +	mutex_lock(&iio_data->mutex);
> > > +	if (iio_data->ev_enable_state) {
> > > +		if (event == THERMAL_TEMP_THRESHOLD)
> > > +			iio_push_event(tz->indio_dev,
> > > +				      
> > >  IIO_EVENT_CODE_THERMAL_THRES,
> > > +				       iio_get_time_ns());
> > > +		else if (event == THERMAL_TRIP_UPDATE)
> > > +			iio_push_event(tz->indio_dev,
> > > +				       IIO_EVENT_CODE_TRIP_UPDATE,
> > > +				       iio_get_time_ns());
> > > +		else
> > > +			dev_err(&tz->device, "invalid event\n");
> > > +	}
> > > +	if (iio_data->enable) {
> > > +		ret = thermal_zone_get_temp(iio_data->tz, &temp);
> > > +		if (ret)
> > > +			goto err_read;
> > > +		*(u32 *)iio_data->buffer = (u32)temp;
> > > +		iio_push_to_buffers(tz->indio_dev, iio_data
> > > ->buffer);
> > > +	}
> > > +	mutex_unlock(&iio_data->mutex);
> > > +
> > > +	return 0;
> > > +err_read:
> > > +	mutex_unlock(&iio_data->mutex);
> > > +	return ret;
> > > +}
> > > diff --git a/drivers/thermal/user_space.c 
> > > b/drivers/thermal/user_space.c
> > > index 10adcdd..742adec 100644
> > > --- a/drivers/thermal/user_space.c
> > > +++ b/drivers/thermal/user_space.c
> > > @@ -34,6 +34,7 @@
> > >   */
> > >  static int notify_user_space(struct thermal_zone_device *tz, int 
> > > trip)
> > >  {
> > > +	thermal_iio_sensor_notify(tz, THERMAL_TEMP_THRESHOLD);
> > 
> > Do we really need this?
> This the user space governor callback. If we don't add then we need to
> register another user space governor for IIO.
> May be you mean something else.

After the presentation in LPC things get a little clearer. The question
now is, does the IIO core take care of sending the right trigger?
Meaning, what if the user selects driver trigger? Would it make any
sense in sending THERMAL_TEMP_THRESHOLD event?

> 
> > Can't the existing thermal to userspa
> > ce event be used?
> > Also, I would prefer you could separate your changes into smaller
> > patches, when possible.
> > 
> > >  	mutex_lock(&tz->lock);
> > >  	kobject_uevent(&tz->device.kobj, KOBJ_CHANGE);
> > >  	mutex_unlock(&tz->lock);
> > > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > > index 037e9df..4c4c487 100644
> > > --- a/include/linux/thermal.h
> > > +++ b/include/linux/thermal.h
> > > @@ -31,6 +31,16 @@
> > >  #include <linux/workqueue.h>
> > >  #include <uapi/linux/thermal.h>
> > >  
> > > +#if IS_ENABLED(CONFIG_THERMAL_IIO)
> > This is awkward.
> > 
> > Are you sure this is not solved in the iio headers? If not I would
> > suggest fixing the iio headers, allowing their users being compiled
> > when CONFIG_IIO=n
> Currently for IIO drivers are dependent on CONFIG_IIO, so this is not a
> problem. So the iio.h doesn't have dummy interface functions.
> If we go this path, then we can add dummy headers in iio.h.
> 

No, it is not a problem, except that we want the user of that header to
be not aware of the the config dependencies. So, yes, I suggest using
stubs (dummy functions) inside the iio header, for the case in which iio
users needs to be compiled when CONFIG_IIO=n.

> > > +#include <linux/iio/iio.h>
> > > +#include <linux/iio/sysfs.h>
> > > +#include <linux/iio/buffer.h>
> > > +#include <linux/iio/trigger.h>
> > > +#include <linux/iio/events.h>
> > > +#include <linux/iio/trigger_consumer.h>
> > > +#include <linux/iio/triggered_buffer.h>
> > > +#endif
> > > +
> > >  #define THERMAL_TRIPS_NONE	-1
> > >  #define THERMAL_MAX_TRIPS	12
> > >  
> > > @@ -111,6 +121,10 @@ struct thermal_zone_device_ops {
> > >  	int (*set_emul_temp) (struct thermal_zone_device *, 
> > > unsigned long);
> > >  	int (*get_trend) (struct thermal_zone_device *, int,
> > >  			  enum thermal_trend *);
> > > +	int (*get_threshold_temp)(struct thermal_zone_device *, 
> > > int,
> > > +				  unsigned long *);
> > > +	int (*set_threshold_temp)(struct thermal_zone_device *, 
> > > int,
> > > +				  unsigned long);
> > 
> > 
> > Can this change be split?
> You mean different patchset? I will split this part into another
> patchset.

yes, please, separate the changes in smaller patches composing a
patchset.

> > 
> > >  	int (*notify) (struct thermal_zone_device *, int,
> > >  		       enum thermal_trip_type);
> > >  };
> > > @@ -205,6 +219,9 @@ struct thermal_zone_device {
> > >  	struct mutex lock;
> > >  	struct list_head node;
> > >  	struct delayed_work poll_queue;
> > > +#ifdef CONFIG_THERMAL_IIO
> > > +	struct iio_dev *indio_dev;
> > > +#endif
> > >  };
> > >  
> > >  /**
> > > @@ -483,4 +500,33 @@ static inline int 
> > > thermal_generate_netlink_event(struct thermal_zone_device *tz,
> > >  }
> > >  #endif
> > >  
> > > +enum thermal_zone_event_type {
> > > +	THERMAL_TEMP_THRESHOLD,
> > > +	THERMAL_TRIP_UPDATE,
> > > +	THERMAL_EVENT_TYPE_MAX,
> > > +};
> > > +
> > > +#if IS_ENABLED(CONFIG_THERMAL) && IS_ENABLED(CONFIG_THERMAL_IIO)
> > 
> > Maybe CONFIG_THERMAL_IIO is enough, then set THERMAL_IIO depend on
> > THERMAL?
> I will check, why CONFIG_THERMAL dependency is used in thermal.h in
> other cases. I used the same model.
> > 

Yeah, but I meant that if in your Kconfig you add a dependency between
THERMAL_IIO and THERMAL, then this condition could be checked only with
THERMAL_IIO, which makes more sense from code readability.

> > > +int thermal_iio_sensor_register(struct thermal_zone_device *tz);
> > > +int thermal_iio_sensor_unregister(struct thermal_zone_device *tz);
> > > +int thermal_iio_sensor_notify(struct thermal_zone_device *tz,
> > > +			      enum thermal_zone_event_type event);
> > > +#else
> > > +static int thermal_iio_sensor_register(struct thermal_zone_device 
> > > *tz)
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > > +static int thermal_iio_sensor_unregister(struct 
> > > thermal_zone_device *tz)
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > > +static int thermal_iio_sensor_notify(struct thermal_zone_device 
> > > *tz
> > > +				     enum thermal_zone_event_type 
> > > event)
> > > +{
> > > +	return 0;
> > > +}
> > > +#endif
> > > +
> > >  #endif /* __THERMAL_H__ */
> 
> Thanks for the review.


No problem.

> 
> -Srinivas
