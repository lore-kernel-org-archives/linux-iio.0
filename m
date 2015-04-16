Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:60500 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750753AbbDPVGA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 16 Apr 2015 17:06:00 -0400
Message-ID: <55302434.6030809@gmx.de>
Date: Thu, 16 Apr 2015 23:05:56 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Martin Fuzzey <mfuzzey@parkeon.com>, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 3/9] iio: core: add high pass filter attributes
References: <20150219141553.27001.18825.stgit@localhost> <20150219141600.27001.39877.stgit@localhost>
In-Reply-To: <20150219141600.27001.39877.stgit@localhost>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Martin Fuzzey schrieb am 19.02.2015 um 15:16:
> Add a high pass filter attribute for measurements (like the existing low pass)
> 
> Also add both high and low pass attibutes for events.
> 
Some comments inline.

> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio |   30 ++++++++++++++++++++++++++++++
>  drivers/iio/industrialio-core.c         |    2 ++
>  drivers/iio/industrialio-event.c        |    2 ++
>  include/linux/iio/iio.h                 |    1 +
>  include/linux/iio/types.h               |    2 ++
>  5 files changed, 37 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 117521d..ab592dd 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -358,6 +358,16 @@ Description:
>  		to the underlying data channel, then this parameter
>  		gives the 3dB frequency of the filter in Hz.
>  
> +What:		/sys/.../in_accel_filter_high_pass_3db_frequency
> +What:		/sys/.../in_magn_filter_high_pass_3db_frequency
> +What:		/sys/.../in_anglvel_filter_high_pass_3db_frequency
You mind alphabetic order of the filenames below, maybe do so over here, as well?

> +KernelVersion:	3.21
Some folks preferred a change in kernel version counting, now we have to deal
with it. Would 4.1 be appropriate? Same for the two instances below.

> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		If a known or controllable high pass filter is applied
> +		to the underlying data channel, then this parameter
> +		gives the 3dB frequency of the filter in Hz.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_raw
>  KernelVersion:	2.6.37
> @@ -790,6 +800,26 @@ Description:
>  		met before an event is generated. If direction is not
>  		specified then this period applies to both directions.
>  
> +What:		/sys/.../events/in_accel_thresh_rising_low_pass_filter_3db
> +What:		/sys/.../events/in_anglvel_thresh_rising_low_pass_filter_3db
> +What:		/sys/.../events/in_magn_thresh_rising_low_pass_filter_3db
> +KernelVersion:	3.21
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		If a low pass filter can be applied to the event generation
> +		this property gives its 3db frequency in Hz.
> +		A value of zero disables the filter.
> +
> +What:		/sys/.../events/in_accel_thresh_rising_high_pass_filter_3db
> +What:		/sys/.../events/in_anglvel_thresh_rising_high_pass_filter_3db
> +What:		/sys/.../events/in_magn_thresh_rising_high_pass_filter_3db
> +KernelVersion:	3.21
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		If a high pass filter can be applied to the event generation
> +		this property gives its 3db frequency in Hz.
> +		A value of zero disables the filter.
> +
>  What:		/sys/.../iio:deviceX/events/in_accel_mag_en
>  What:		/sys/.../iio:deviceX/events/in_accel_mag_rising_en
>  What:		/sys/.../iio:deviceX/events/in_accel_mag_falling_en
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index f009d05..94b1b28 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -107,6 +107,8 @@ static const char * const iio_chan_info_postfix[] = {
>  	[IIO_CHAN_INFO_AVERAGE_RAW] = "mean_raw",
>  	[IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY]
>  	= "filter_low_pass_3db_frequency",
> +	[IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY]
> +	= "filter_high_pass_3db_frequency",
>  	[IIO_CHAN_INFO_SAMP_FREQ] = "sampling_frequency",
>  	[IIO_CHAN_INFO_FREQUENCY] = "frequency",
>  	[IIO_CHAN_INFO_PHASE] = "phase",
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index 35c02ae..4321380 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -210,6 +210,8 @@ static const char * const iio_ev_info_text[] = {
>  	[IIO_EV_INFO_VALUE] = "value",
>  	[IIO_EV_INFO_HYSTERESIS] = "hysteresis",
>  	[IIO_EV_INFO_PERIOD] = "period",
> +	[IIO_EV_INFO_HIGH_PASS_FILTER_3DB] = "high_pass_filter_3db",
> +	[IIO_EV_INFO_LOW_PASS_FILTER_3DB] = "low_pass_filter_3db",
>  };
>  
>  static enum iio_event_direction iio_ev_attr_dir(struct iio_dev_attr *attr)
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 3642ce7..3ce2793 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -32,6 +32,7 @@ enum iio_chan_info_enum {
>  	IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW,
>  	IIO_CHAN_INFO_AVERAGE_RAW,
>  	IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY,
> +	IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY,
>  	IIO_CHAN_INFO_SAMP_FREQ,
>  	IIO_CHAN_INFO_FREQUENCY,
>  	IIO_CHAN_INFO_PHASE,
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index 4a2af8a..fc5c123 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -75,6 +75,8 @@ enum iio_event_info {
>  	IIO_EV_INFO_VALUE,
>  	IIO_EV_INFO_HYSTERESIS,
>  	IIO_EV_INFO_PERIOD,
> +	IIO_EV_INFO_HIGH_PASS_FILTER_3DB,
> +	IIO_EV_INFO_LOW_PASS_FILTER_3DB,
>  };
>  
>  enum iio_event_direction {
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

