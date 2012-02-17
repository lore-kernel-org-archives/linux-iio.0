Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:57441 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521Ab2BQNrN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 17 Feb 2012 08:47:13 -0500
Message-ID: <4F3E5A2C.3050605@cam.ac.uk>
Date: Fri, 17 Feb 2012 13:46:20 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: jic23@kernel.org, grant.likely@secretlab.ca,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 1/4] iio: core: constitfy available_scan_mask
References: <1329482772-18054-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1329482772-18054-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2/17/2012 12:46 PM, michael.hennerich@analog.com wrote:
> From: Michael Hennerich<michael.hennerich@analog.com>
>
> The core must not modify available_scan_mask, because it causes problems
> with drivers where multiple instances of the driver share the same mask set.
> So make this explicit by marking available scan masks as const.
>
> The max1363 driver needs some minor adjustment to accommodate this change.
That's somewhat of a bigger hammer you've used to crack the nut.  
Nothing wrong with the
refactoring but might be worth saying you also pulled it out to a function.

Otherwise sensible change. Thanks.
>
> Signed-off-by: Michael Hennerich<michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/staging/iio/adc/max1363_core.c    |   36 +++++++++++++++++++---------
>   drivers/staging/iio/iio.h                 |    4 +-
>   drivers/staging/iio/industrialio-buffer.c |    6 ++--
>   3 files changed, 29 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
> index 3a5bd20..7f39ca3 100644
> --- a/drivers/staging/iio/adc/max1363_core.c
> +++ b/drivers/staging/iio/adc/max1363_core.c
> @@ -1245,10 +1245,31 @@ static int max1363_initial_setup(struct max1363_state *st)
>   	return max1363_set_scan_mode(st);
>   }
>
> +static int __devinit max1363_alloc_scan_masks(struct iio_dev *indio_dev)
> +{
> +	struct max1363_state *st = iio_priv(indio_dev);
> +	unsigned long *masks;
> +	int i;
> +
> +	masks = kzalloc(BITS_TO_LONGS(MAX1363_MAX_CHANNELS)*sizeof(long)*
> +			  (st->chip_info->num_modes + 1), GFP_KERNEL);
> +	if (!masks)
> +		return -ENOMEM;
> +
> +	for (i = 0; i<  st->chip_info->num_modes; i++)
> +		bitmap_copy(masks + BITS_TO_LONGS(MAX1363_MAX_CHANNELS)*i,
> +			    max1363_mode_table[st->chip_info->mode_list[i]]
> +			    .modemask, MAX1363_MAX_CHANNELS);
> +
> +	indio_dev->available_scan_masks = masks;
> +
> +	return 0;
> +}
> +
>   static int __devinit max1363_probe(struct i2c_client *client,
>   				   const struct i2c_device_id *id)
>   {
> -	int ret, i;
> +	int ret;
>   	struct max1363_state *st;
>   	struct iio_dev *indio_dev;
>   	struct regulator *reg;
> @@ -1276,19 +1297,10 @@ static int __devinit max1363_probe(struct i2c_client *client,
>   	st->chip_info =&max1363_chip_info_tbl[id->driver_data];
>   	st->client = client;
>
> -	indio_dev->available_scan_masks
> -		= kzalloc(BITS_TO_LONGS(MAX1363_MAX_CHANNELS)*sizeof(long)*
> -			  (st->chip_info->num_modes + 1), GFP_KERNEL);
> -	if (!indio_dev->available_scan_masks) {
> -		ret = -ENOMEM;
> +	ret = max1363_alloc_scan_masks(indio_dev);
> +	if (ret)
>   		goto error_free_device;
> -	}
>
> -	for (i = 0; i<  st->chip_info->num_modes; i++)
> -		bitmap_copy(indio_dev->available_scan_masks +
> -			    BITS_TO_LONGS(MAX1363_MAX_CHANNELS)*i,
> -			    max1363_mode_table[st->chip_info->mode_list[i]]
> -			    .modemask, MAX1363_MAX_CHANNELS);
>   	/* Estabilish that the iio_dev is a child of the i2c device */
>   	indio_dev->dev.parent =&client->dev;
>   	indio_dev->name = id->name;
> diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
> index be6ced3..42a362c 100644
> --- a/drivers/staging/iio/iio.h
> +++ b/drivers/staging/iio/iio.h
> @@ -327,9 +327,9 @@ struct iio_dev {
>   	struct iio_buffer		*buffer;
>   	struct mutex			mlock;
>
> -	unsigned long			*available_scan_masks;
> +	const unsigned long		*available_scan_masks;
>   	unsigned			masklength;
> -	unsigned long			*active_scan_mask;
> +	const unsigned long		*active_scan_mask;
>   	struct iio_trigger		*trig;
>   	struct iio_poll_func		*pollfunc;
>
> diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
> index d7b1e9e..386ba76 100644
> --- a/drivers/staging/iio/industrialio-buffer.c
> +++ b/drivers/staging/iio/industrialio-buffer.c
> @@ -489,9 +489,9 @@ ssize_t iio_buffer_show_enable(struct device *dev,
>   EXPORT_SYMBOL(iio_buffer_show_enable);
>
>   /* note NULL used as error indicator as it doesn't make sense. */
> -static unsigned long *iio_scan_mask_match(unsigned long *av_masks,
> +static const unsigned long *iio_scan_mask_match(const unsigned long *av_masks,
>   					  unsigned int masklength,
> -					  unsigned long *mask)
> +					  const unsigned long *mask)
>   {
>   	if (bitmap_empty(mask, masklength))
>   		return NULL;
> @@ -554,7 +554,7 @@ EXPORT_SYMBOL(iio_sw_buffer_preenable);
>   int iio_scan_mask_set(struct iio_dev *indio_dev,
>   		      struct iio_buffer *buffer, int bit)
>   {
> -	unsigned long *mask;
> +	const unsigned long *mask;
>   	unsigned long *trialmask;
>
>   	trialmask = kmalloc(sizeof(*trialmask)*

