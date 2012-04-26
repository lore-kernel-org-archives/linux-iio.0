Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:55560 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756214Ab2DZNJa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 26 Apr 2012 09:09:30 -0400
Message-ID: <4F994908.8030200@cam.ac.uk>
Date: Thu, 26 Apr 2012 14:09:28 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: jic23@kernel.org, linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 2/4] iio: core: Introduce IIO_ALTVOLTAGE and appropriate
 channel info elements
References: <1335443643-20439-1-git-send-email-michael.hennerich@analog.com> <1335443643-20439-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1335443643-20439-2-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 4/26/2012 1:34 PM, michael.hennerich@analog.com wrote:
> From: Michael Hennerich<michael.hennerich@analog.com>
>
> Signed-off-by: Michael Hennerich<michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/iio/industrialio-core.c |    3 +++
>   include/linux/iio/iio.h         |   10 ++++++++++
>   include/linux/iio/types.h       |    1 +
>   3 files changed, 14 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index dd1a6a2..1c55d2b 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -63,6 +63,7 @@ static const char * const iio_chan_type_name_spec[] = {
>   	[IIO_ANGL] = "angl",
>   	[IIO_TIMESTAMP] = "timestamp",
>   	[IIO_CAPACITANCE] = "capacitance",
> +	[IIO_ALTVOLTAGE] = "altvoltage",
>   };
>
>   static const char * const iio_modifier_names[] = {
> @@ -88,6 +89,8 @@ static const char * const iio_chan_info_postfix[] = {
>   	[IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY]
>   	= "filter_low_pass_3db_frequency",
>   	[IIO_CHAN_INFO_SAMP_FREQ] = "sampling_frequency",
> +	[IIO_CHAN_INFO_FREQUENCY] = "frequency",
> +	[IIO_CHAN_INFO_PHASE] = "phase",
>   };
>
>   const struct iio_chan_spec
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 9c0908a..0e826af 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -32,6 +32,8 @@ enum iio_chan_info_enum {
>   	IIO_CHAN_INFO_AVERAGE_RAW,
>   	IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY,
>   	IIO_CHAN_INFO_SAMP_FREQ,
> +	IIO_CHAN_INFO_FREQUENCY,
> +	IIO_CHAN_INFO_PHASE,
>   };
>
>   #define IIO_CHAN_INFO_SHARED_BIT(type) BIT(type*2)
> @@ -85,6 +87,14 @@ enum iio_chan_info_enum {
>   	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_SAMP_FREQ)
>   #define IIO_CHAN_INFO_SAMP_FREQ_SHARED_BIT			\
>   	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_SAMP_FREQ)
> +#define IIO_CHAN_INFO_FREQUENCY_SEPARATE_BIT			\
> +	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_FREQUENCY)
> +#define IIO_CHAN_INFO_FREQUENCY_SHARED_BIT			\
> +	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_FREQUENCY)
> +#define IIO_CHAN_INFO_PHASE_SEPARATE_BIT			\
> +	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_PHASE)
> +#define IIO_CHAN_INFO_PHASE_SHARED_BIT			\
> +	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_PHASE)
>
>   enum iio_endian {
>   	IIO_CPU,
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index 0c32136..a471fd5 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -27,6 +27,7 @@ enum iio_chan_type {
>   	IIO_ANGL,
>   	IIO_TIMESTAMP,
>   	IIO_CAPACITANCE,
> +	IIO_ALTVOLTAGE,
>   };
>
>   enum iio_modifier {

