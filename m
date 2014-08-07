Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38384 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757478AbaHGOmR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 Aug 2014 10:42:17 -0400
Message-ID: <53E39047.2000305@kernel.org>
Date: Thu, 07 Aug 2014 15:42:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Martin Fuzzey <mfuzzey@parkeon.com>, linux-iio@vger.kernel.org
CC: pmeerw@pmeerw.net
Subject: Re: [PATCH V2 5/8] iio: core: add high pass filter attributes
References: <20140729090128.4618.92936.stgit@localhost> <20140729090139.4618.13962.stgit@localhost>
In-Reply-To: <20140729090139.4618.13962.stgit@localhost>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/07/14 10:01, Martin Fuzzey wrote:
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
Looks good.
> ---
>  Documentation/ABI/testing/sysfs-bus-iio |   10 ++++++++++
>  drivers/iio/industrialio-core.c         |    2 ++
>  include/linux/iio/iio.h                 |    1 +
>  3 files changed, 13 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index a9757dc..4825139 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -340,6 +340,16 @@ Description:
>  		to the underlying data channel, then this parameter
>  		gives the 3dB frequency of the filter in Hz.
>  
> +What:		/sys/.../in_accel_filter_high_pass_3db_frequency
> +What:		/sys/.../in_magn_filter_high_pass_3db_frequency
> +What:		/sys/.../in_anglvel_filter_high_pass_3db_frequency
> +KernelVersion:	3.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		If a known or controllable high pass filter is applied
> +		to the underlying data channel, then this parameter
> +		gives the 3dB frequency of the filter in Hz.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_raw
>  KernelVersion:	2.6.37
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index fa06197..967468d 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -103,6 +103,8 @@ static const char * const iio_chan_info_postfix[] = {
>  	[IIO_CHAN_INFO_AVERAGE_RAW] = "mean_raw",
>  	[IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY]
>  	= "filter_low_pass_3db_frequency",
> +	[IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY]
> +	= "filter_high_pass_3db_frequency",
>  	[IIO_CHAN_INFO_SAMP_FREQ] = "sampling_frequency",
>  	[IIO_CHAN_INFO_FREQUENCY] = "frequency",
>  	[IIO_CHAN_INFO_PHASE] = "phase",
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index ccde917..88a255d 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -31,6 +31,7 @@ enum iio_chan_info_enum {
>  	IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW,
>  	IIO_CHAN_INFO_AVERAGE_RAW,
>  	IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY,
> +	IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY,
>  	IIO_CHAN_INFO_SAMP_FREQ,
>  	IIO_CHAN_INFO_FREQUENCY,
>  	IIO_CHAN_INFO_PHASE,
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
