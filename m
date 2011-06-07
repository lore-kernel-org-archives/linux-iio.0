Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:37750 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756664Ab1FGPQa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 7 Jun 2011 11:16:30 -0400
Message-ID: <4DEE42B2.7090003@cam.ac.uk>
Date: Tue, 07 Jun 2011 16:24:34 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] iio: industrialio-core: iio_write_channel_info accept
 IIO_VAL_INT_PLUS_NANO
References: <1307458678-10889-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1307458678-10889-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/07/11 15:57, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Allow iio_write_channel_info() to accept IIO_VAL_INT_PLUS_NANO
> 
> Changes since V1:
> use callback to query expected format/precision
Looks good to me, thanks.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/iio.h               |    7 +++++++
>  drivers/staging/iio/industrialio-core.c |   27 +++++++++++++++++++++------
>  2 files changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
> index 9bf8b11..8ea03c5 100644
> --- a/drivers/staging/iio/iio.h
> +++ b/drivers/staging/iio/iio.h
> @@ -219,6 +219,9 @@ static inline s64 iio_get_time_ns(void)
>   *			contain the elements making up the returned value.
>   * @write_raw:		function to write a value to the device.
>   *			Parameters are the same as for read_raw.
> + * @write_raw_get_fmt:	callback function to query the expected
> + *			format/precision. If not set by the driver, write_raw
> + *			returns IIO_VAL_INT_PLUS_MICRO.
>   * @read_event_config:	find out if the event is enabled.
>   * @write_event_config:	set if the event is enabled.
>   * @read_event_value:	read a value associated with the event. Meaning
> @@ -246,6 +249,10 @@ struct iio_info {
>  			 int val2,
>  			 long mask);
>  
> +	int (*write_raw_get_fmt)(struct iio_dev *indio_dev,
> +			 struct iio_chan_spec const *chan,
> +			 long mask);
> +
>  	int (*read_event_config)(struct iio_dev *indio_dev,
>  				 int event_code);
>  
> diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
> index e5a7663..744153e 100644
> --- a/drivers/staging/iio/industrialio-core.c
> +++ b/drivers/staging/iio/industrialio-core.c
> @@ -412,25 +412,40 @@ static ssize_t iio_write_channel_info(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -	int ret, integer = 0, micro = 0, micro_mult = 100000;
> +	int ret, integer = 0, fract = 0, fract_mult = 100000;
>  	bool integer_part = true, negative = false;
>  
>  	/* Assumes decimal - precision based on number of digits */
>  	if (!indio_dev->info->write_raw)
>  		return -EINVAL;
> +
> +	if (indio_dev->info->write_raw_get_fmt)
> +		switch (indio_dev->info->write_raw_get_fmt(indio_dev,
> +			this_attr->c, this_attr->address)) {
> +		case IIO_VAL_INT_PLUS_MICRO:
> +			fract_mult = 100000;
> +			break;
> +		case IIO_VAL_INT_PLUS_NANO:
> +			fract_mult = 100000000;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
>  	if (buf[0] == '-') {
>  		negative = true;
>  		buf++;
>  	}
> +
>  	while (*buf) {
>  		if ('0' <= *buf && *buf <= '9') {
>  			if (integer_part)
>  				integer = integer*10 + *buf - '0';
>  			else {
> -				micro += micro_mult*(*buf - '0');
> -				if (micro_mult == 1)
> +				fract += fract_mult*(*buf - '0');
> +				if (fract_mult == 1)
>  					break;
> -				micro_mult /= 10;
> +				fract_mult /= 10;
>  			}
>  		} else if (*buf == '\n') {
>  			if (*(buf + 1) == '\0')
> @@ -448,11 +463,11 @@ static ssize_t iio_write_channel_info(struct device *dev,
>  		if (integer)
>  			integer = -integer;
>  		else
> -			micro = -micro;
> +			fract = -fract;
>  	}
>  
>  	ret = indio_dev->info->write_raw(indio_dev, this_attr->c,
> -					 integer, micro, this_attr->address);
> +					 integer, fract, this_attr->address);
>  	if (ret)
>  		return ret;
>  

