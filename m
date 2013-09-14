Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39599 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589Ab3INJqG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2013 05:46:06 -0400
Message-ID: <52343E7A.3040302@kernel.org>
Date: Sat, 14 Sep 2013 11:46:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org,
	Shubhrajyoti Datta <shubhrajyoti@ti.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH 01/10] staging: iio: hmc5843: Use devm_iio_device_alloc
References: <1378893325-31764-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378893325-31764-1-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/11/13 10:55, Sachin Kamat wrote:
> devm_iio_device_alloc makes code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Shubhrajyoti Datta <shubhrajyoti@ti.com>
This one clashes with Peter's more general cleanup of the driver.
> ---
> Series compile tested.
> ---
>  drivers/staging/iio/magnetometer/hmc5843.c |   16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index 67c1ce7..790f456 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -643,11 +643,9 @@ static int hmc5843_probe(struct i2c_client *client,
>  	struct iio_dev *indio_dev;
>  	int err = 0;
>  
> -	indio_dev = iio_device_alloc(sizeof(*data));
> -	if (indio_dev == NULL) {
> -		err = -ENOMEM;
> -		goto exit;
> -	}
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
>  
>  	/* default settings at probe */
>  	data = iio_priv(indio_dev);
> @@ -665,14 +663,9 @@ static int hmc5843_probe(struct i2c_client *client,
>  
>  	err = iio_device_register(indio_dev);
>  	if (err)
> -		goto exit_free2;
> +		return err;
>  
>  	return 0;
> -
> -exit_free2:
> -	iio_device_free(indio_dev);
> -exit:
> -	return err;
>  }
>  
>  static int hmc5843_remove(struct i2c_client *client)
> @@ -682,7 +675,6 @@ static int hmc5843_remove(struct i2c_client *client)
>  	iio_device_unregister(indio_dev);
>  	 /*  sleep mode to save power */
>  	hmc5843_configure(client, HMC5843_MODE_SLEEP);
> -	iio_device_free(indio_dev);
>  
>  	return 0;
>  }
> 
