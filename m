Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:57515 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076Ab1FGM4v (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 7 Jun 2011 08:56:51 -0400
Message-ID: <4DEE21F7.6010202@cam.ac.uk>
Date: Tue, 07 Jun 2011 14:04:55 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] iio: industrialio-core: iio_write_channel_info accept
 IIO_VAL_INT_PLUS_NANO
References: <1307445688-23126-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1307445688-23126-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/07/11 12:21, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Allow iio_write_channel_info() to accept IIO_VAL_INT_PLUS_NANO

Hmm. I wonder if this is the right way around to do it.  This puts a hard
requirement on the number of digits being what the driver expects.

Alternative would be an optional callback (not needed if everything is int_plus_micro)
that allows the driver to be queried for what it wants and then reads data under
the assumption that is what it has.

Which do people think would work better?

The approach here has the flaw that if someone writes a 9 decimal digit value
to something expect 6 decimal digits the core will pass it on whereas it should
have ignored the last 3 digits.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/staging/iio/industrialio-core.c |   27 +++++++++++++++++++++------
>  1 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
> index e5a7663..74158c1 100644
> --- a/drivers/staging/iio/industrialio-core.c
> +++ b/drivers/staging/iio/industrialio-core.c
> @@ -412,25 +412,40 @@ static ssize_t iio_write_channel_info(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -	int ret, integer = 0, micro = 0, micro_mult = 100000;
> +	int ret, fract_digits, integer = 0, fract = 0, fract_mult;
>  	bool integer_part = true, negative = false;
>  
>  	/* Assumes decimal - precision based on number of digits */
>  	if (!indio_dev->info->write_raw)
>  		return -EINVAL;
> +
> +	fract_digits = strnchr(buf, len, '\n') - strnchr(buf, len, '.') - 1;
> +
> +	switch (fract_digits) {
> +	case 6:	/* IIO_VAL_INT_PLUS_MICRO */
> +		fract_mult = 100000;
> +		break;
> +	case 9: /* IIO_VAL_INT_PLUS_NANO */
> +		fract_mult = 100000000;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
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

