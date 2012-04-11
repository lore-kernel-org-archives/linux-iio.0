Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-106.synserver.de ([212.40.185.106]:1068 "EHLO
	smtp-out-105.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751450Ab2DKIeP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Apr 2012 04:34:15 -0400
Message-ID: <4F854295.4030009@metafoo.de>
Date: Wed, 11 Apr 2012 10:36:37 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org,
	michael.hennerich@analog.com
Subject: Re: [PATCH 01/10] staging:iio: add a value element to the info_mask
References: <1334089663-22900-1-git-send-email-jic23@kernel.org> <1334089663-22900-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1334089663-22900-2-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/10/2012 10:27 PM, Jonathan Cameron wrote:
> This will allow us to have drivers where the channel value
> may not be read or written but other information is available.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/iio.h               |    4 +++-
>  drivers/staging/iio/industrialio-core.c |    5 +++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
> index fa6fca0..d96ee4b 100644
> --- a/drivers/staging/iio/iio.h
> +++ b/drivers/staging/iio/iio.h
> @@ -26,7 +26,7 @@ enum iio_data_type {
>  
>  /* Could add the raw attributes as well - allowing buffer only devices */
>  enum iio_chan_info_enum {
> -	/* 0 is reserved for raw attributes */
> +	IIO_CHAN_INFO_VALUE = 0,

I think it would make sense to introduce both IIO_CHAN_INFO_RAW and
IIO_CHAN_INFO_PROCESSED. This will certainly make the code more simpler and
it also allows drivers to export both processed and raw values.

>  	IIO_CHAN_INFO_SCALE = 1,
>  	IIO_CHAN_INFO_OFFSET,
>  	IIO_CHAN_INFO_CALIBSCALE,
> @@ -41,6 +41,8 @@ enum iio_chan_info_enum {
>  #define IIO_CHAN_INFO_SHARED_BIT(type) BIT(type*2)
>  #define IIO_CHAN_INFO_SEPARATE_BIT(type) BIT(type*2 + 1)
>  
> +#define IIO_CHAN_INFO_VALUE_SEPARATE_BIT			\
> +	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_VALUE)
>  #define IIO_CHAN_INFO_SCALE_SEPARATE_BIT		\
>  	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_SCALE)
>  #define IIO_CHAN_INFO_SCALE_SHARED_BIT			\
> diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
> index d303bfb..a4ac061 100644
> --- a/drivers/staging/iio/industrialio-core.c
> +++ b/drivers/staging/iio/industrialio-core.c
> @@ -575,7 +575,8 @@ error_ret:
>  static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
>  					struct iio_chan_spec const *chan)
>  {
> -	int ret, i, attrcount = 0;
> +	int ret, attrcount = 0;
> +	int i = 2;
>  	const struct iio_chan_spec_ext_info *ext_info;
>  
>  	if (chan->channel < 0)
> @@ -594,7 +595,7 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
>  		goto error_ret;
>  	attrcount++;
>  
> -	for_each_set_bit(i, &chan->info_mask, sizeof(long)*8) {
> +	for_each_set_bit_from(i, &chan->info_mask, sizeof(long)*8) {
>  		ret = __iio_add_chan_devattr(iio_chan_info_postfix[i/2],
>  					     chan,
>  					     &iio_read_channel_info,

