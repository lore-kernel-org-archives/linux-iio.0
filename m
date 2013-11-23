Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58571 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339Ab3KWRAW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2013 12:00:22 -0500
Message-ID: <5290ED76.1010900@kernel.org>
Date: Sat, 23 Nov 2013 18:01:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Subject: Re: [PATCH 14/33] staging: iio: adis16220: Use devm_iio_device_register
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org> <1383046796-329-15-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-15-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/13 11:39, Sachin Kamat wrote:
> devm_iio_device_register simplifies the code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Hmm. I've applied this one.  The driver doesn't make use
of it, but there is a power down mode on the device.  However
the part is obsolete so the chances that anyone will ever
implement that are rather low  I guess.

We can always put everything back again if we have to.  Note
for anyone reading this. The driver is a long way from compliant
with our ABI so beware of this one...

Jonathan
> ---
>  drivers/staging/iio/accel/adis16220_core.c |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
> index 4c9364b..6f38ca9 100644
> --- a/drivers/staging/iio/accel/adis16220_core.c
> +++ b/drivers/staging/iio/accel/adis16220_core.c
> @@ -439,13 +439,13 @@ static int adis16220_probe(struct spi_device *spi)
>  	indio_dev->channels = adis16220_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(adis16220_channels);
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&spi->dev, indio_dev);
>  	if (ret)
>  		return ret;
>  
>  	ret = sysfs_create_bin_file(&indio_dev->dev.kobj, &accel_bin);
>  	if (ret)
> -		goto error_unregister_dev;
> +		return ret;
>  
>  	ret = sysfs_create_bin_file(&indio_dev->dev.kobj, &adc1_bin);
>  	if (ret)
> @@ -470,8 +470,6 @@ error_rm_adc1_bin:
>  	sysfs_remove_bin_file(&indio_dev->dev.kobj, &adc1_bin);
>  error_rm_accel_bin:
>  	sysfs_remove_bin_file(&indio_dev->dev.kobj, &accel_bin);
> -error_unregister_dev:
> -	iio_device_unregister(indio_dev);
>  	return ret;
>  }
>  
> @@ -482,7 +480,6 @@ static int adis16220_remove(struct spi_device *spi)
>  	sysfs_remove_bin_file(&indio_dev->dev.kobj, &adc2_bin);
>  	sysfs_remove_bin_file(&indio_dev->dev.kobj, &adc1_bin);
>  	sysfs_remove_bin_file(&indio_dev->dev.kobj, &accel_bin);
> -	iio_device_unregister(indio_dev);
>  
>  	return 0;
>  }
> 
