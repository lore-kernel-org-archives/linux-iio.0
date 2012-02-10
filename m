Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:45908 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757927Ab2BJJwX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 10 Feb 2012 04:52:23 -0500
Message-ID: <4F34E8B4.5040203@cam.ac.uk>
Date: Fri, 10 Feb 2012 09:51:48 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Marek Vasut <marek.vasut@gmail.com>
CC: linux-iio@vger.kernel.org, jic23@kernel.org,
	Wolfgang Denk <wd@denx.de>, Stefano Babic <sbabic@denx.de>,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/2] [RFC] Add per-channel oversampling count
References: <1328853126-16578-1-git-send-email-marek.vasut@gmail.com>
In-Reply-To: <1328853126-16578-1-git-send-email-marek.vasut@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2/10/2012 5:52 AM, Marek Vasut wrote:
> This allows each channel to configure it's oversampling count.
Fine, but please also add documention in 
staging/iio/Documentation/sysfs-bus-iio

> Signed-off-by: Marek Vasut<marek.vasut@gmail.com>
> Cc: Wolfgang Denk<wd@denx.de>
> Cc: Stefano Babic<sbabic@denx.de>
> Cc: Fabio Estevam<festevam@gmail.com>
> ---
>   drivers/staging/iio/iio.h               |    5 +++++
>   drivers/staging/iio/industrialio-core.c |    1 +
>   2 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
> index b3a1740..0b626ae 100644
> --- a/drivers/staging/iio/iio.h
> +++ b/drivers/staging/iio/iio.h
> @@ -36,6 +36,7 @@ enum iio_chan_info_enum {
>   	IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW,
>   	IIO_CHAN_INFO_AVERAGE_RAW,
>   	IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY,
> +	IIO_CHAN_INFO_OVERSAMPLE_COUNT,
>   };
>
>   #define IIO_CHAN_INFO_SHARED_BIT(type) BIT(type*2)
> @@ -81,6 +82,10 @@ enum iio_chan_info_enum {
>   #define IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SEPARATE_BIT \
>   	IIO_CHAN_INFO_SEPARATE_BIT(			       \
>   		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY)
> +#define IIO_CHAN_INFO_OVERSAMPLE_COUNT_SEPARATE_BIT		\
> +	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_OVERSAMPLE_COUNT)
> +#define IIO_CHAN_INFO_OVERSAMPLE_COUNT_SHARED_BIT		\
> +	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_OVERSAMPLE_COUNT)
>
>   enum iio_endian {
>   	IIO_CPU,
> diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
> index 9c41c83..05b6fdd 100644
> --- a/drivers/staging/iio/industrialio-core.c
> +++ b/drivers/staging/iio/industrialio-core.c
> @@ -87,6 +87,7 @@ static const char * const iio_chan_info_postfix[] = {
>   	[IIO_CHAN_INFO_AVERAGE_RAW] = "mean_raw",
>   	[IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY]
>   	= "filter_low_pass_3db_frequency",
> +	[IIO_CHAN_INFO_OVERSAMPLE_COUNT] = "oversample_count",
>   };
>
>   const struct iio_chan_spec

