Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53896 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab3G0LEx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jul 2013 07:04:53 -0400
Message-ID: <51F3B768.6020207@kernel.org>
Date: Sat, 27 Jul 2013 13:04:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 14/15] staging:iio:adis16260: Remove sampling_frequency_available
 attribute
References: <1374072279-7140-1-git-send-email-lars@metafoo.de> <1374072279-7140-14-git-send-email-lars@metafoo.de>
In-Reply-To: <1374072279-7140-14-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/17/13 15:44, Lars-Peter Clausen wrote:
> The values presented here are completely bogus. Also ..._available attributes
> are supposed to be used for properties that only support discrete sets of
> values, but we accept continuous values and will round to the next supported
> frequency.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied.

Thanks
> ---
>  drivers/staging/iio/gyro/adis16260_core.c | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
> index d4e3dd7..b4cf800 100644
> --- a/drivers/staging/iio/gyro/adis16260_core.c
> +++ b/drivers/staging/iio/gyro/adis16260_core.c
> @@ -101,18 +101,6 @@
>  #define ADIS16260_SCAN_TEMP	3
>  #define ADIS16260_SCAN_ANGL	4
>  
> -static ssize_t adis16260_read_frequency_available(struct device *dev,
> -						  struct device_attribute *attr,
> -						  char *buf)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct adis *adis = iio_priv(indio_dev);
> -	if (spi_get_device_id(adis->spi)->driver_data)
> -		return sprintf(buf, "%s\n", "0.129 ~ 256");
> -	else
> -		return sprintf(buf, "%s\n", "256 2048");
> -}
> -
>  static ssize_t adis16260_read_frequency(struct device *dev,
>  		struct device_attribute *attr,
>  		char *buf)
> @@ -190,9 +178,6 @@ static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
>  		adis16260_read_frequency,
>  		adis16260_write_frequency);
>  
> -static IIO_DEVICE_ATTR(sampling_frequency_available,
> -		       S_IRUGO, adis16260_read_frequency_available, NULL, 0);
> -
>  static const struct iio_chan_spec adis16260_channels[] = {
>  	ADIS_GYRO_CHAN(X, ADIS16260_GYRO_OUT, ADIS16260_SCAN_GYRO,
>  		BIT(IIO_CHAN_INFO_CALIBBIAS) |
> @@ -306,7 +291,6 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
>  
>  static struct attribute *adis16260_attributes[] = {
>  	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> -	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>  	NULL
>  };
>  
> 
