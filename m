Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:32836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751003AbeCRIc1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Mar 2018 04:32:27 -0400
Date: Sun, 18 Mar 2018 08:32:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        daniel.baluta@gmail.com, 21cnbao@gmail.com
Subject: Re: [PATCH v2 5/9] Staging: iio: accel: adis16201: Add comments
 about units in read_raw()
Message-ID: <20180318083221.513c18c0@archlinux>
In-Reply-To: <1521230786-18155-6-git-send-email-himanshujha199640@gmail.com>
References: <1521230786-18155-1-git-send-email-himanshujha199640@gmail.com>
        <1521230786-18155-6-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 17 Mar 2018 01:36:22 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Clarify the conversion and formation of resultant data in the
> adis16201_read_raw() with sufficient comments and remove the unnecessary
> comments.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
It is a little illogical to have comments for all but one of the channels, but
given we don't normally comment them unless they are 'odd', this is fine.

Applied, thanks

Jonathan

> ---
> v2:
>    -clarify voltage base conversions.
> 
>  drivers/staging/iio/accel/adis16201.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 8de3f27..97150ea 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -120,31 +120,43 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>  		switch (chan->type) {
>  		case IIO_VOLTAGE:
>  			if (chan->channel == 0) {
> +			/* Voltage base units are mV hence 1.22 mV */
>  				*val = 1;
> -				*val2 = 220000; /* 1.22 mV */
> +				*val2 = 220000;
>  			} else {
> +			/* Voltage base units are mV hence 0.61 mV */
>  				*val = 0;
> -				*val2 = 610000; /* 0.610 mV */
> +				*val2 = 610000;
>  			}
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_TEMP:
> -			*val = -470; /* 0.47 C */
> +			*val = -470;
>  			*val2 = 0;
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_ACCEL:
> +			/*
> +			 * IIO base unit for sensitivity of accelerometer
> +			 * is milli g.
> +			 * 1 LSB represents 0.244 mg.
> +			 */
>  			*val = 0;
> -			*val2 = IIO_G_TO_M_S_2(462400); /* 0.4624 mg */
> +			*val2 = IIO_G_TO_M_S_2(462400);
>  			return IIO_VAL_INT_PLUS_NANO;
>  		case IIO_INCLI:
>  			*val = 0;
> -			*val2 = 100000; /* 0.1 degree */
> +			*val2 = 100000;
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		default:
>  			return -EINVAL;
>  		}
>  		break;
>  	case IIO_CHAN_INFO_OFFSET:
> -		*val = 25000 / -470 - 1278; /* 25 C = 1278 */
> +		/*
> +		 * The raw ADC value is 1278 when the temperature
> +		 * is 25 degrees and the scale factor per milli
> +		 * degree celcius is -470.
> +		 */
> +		*val = 25000 / -470 - 1278;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		switch (chan->type) {
> @@ -252,13 +264,11 @@ static int adis16201_probe(struct spi_device *spi)
>  	struct adis *st;
>  	struct iio_dev *indio_dev;
>  
> -	/* setup the industrialio driver allocated elements */
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
> -	/* this is only used for removal purposes */
>  	spi_set_drvdata(spi, indio_dev);
>  
>  	indio_dev->name = spi->dev.driver->name;
> @@ -277,7 +287,6 @@ static int adis16201_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	/* Get the device into a sane initial state */
>  	ret = adis_initial_startup(st);
>  	if (ret)
>  		goto error_cleanup_buffer_trigger;

