Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53375 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab3G0KZi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jul 2013 06:25:38 -0400
Message-ID: <51F3AE34.7080402@kernel.org>
Date: Sat, 27 Jul 2013 12:25:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk, patches@linaro.org
Subject: Re: [PATCH 3/8] iio: max1363: Use devm_iio_device_alloc
References: <1374490981-24373-1-git-send-email-sachin.kamat@linaro.org> <1374490981-24373-4-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374490981-24373-4-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/22/13 12:02, Sachin Kamat wrote:
> Using devm_iio_device_alloc makes code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied to the togreg branch of iio.git.  Thanks.
> ---
>  drivers/iio/adc/max1363.c |   15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index f148d00..4fb35d1 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -1498,16 +1498,15 @@ static int max1363_probe(struct i2c_client *client,
>  	struct iio_dev *indio_dev;
>  	struct regulator *vref;
>  
> -	indio_dev = iio_device_alloc(sizeof(struct max1363_state));
> -	if (indio_dev == NULL) {
> -		ret = -ENOMEM;
> -		goto error_out;
> -	}
> +	indio_dev = devm_iio_device_alloc(&client->dev,
> +					  sizeof(struct max1363_state));
> +	if (!indio_dev)
> +		return -ENOMEM;
>  
>  	indio_dev->dev.of_node = client->dev.of_node;
>  	ret = iio_map_array_register(indio_dev, client->dev.platform_data);
>  	if (ret < 0)
> -		goto error_free_device;
> +		return ret;
>  
>  	st = iio_priv(indio_dev);
>  
> @@ -1590,9 +1589,6 @@ error_disable_reg:
>  	regulator_disable(st->reg);
>  error_unregister_map:
>  	iio_map_array_unregister(indio_dev);
> -error_free_device:
> -	iio_device_free(indio_dev);
> -error_out:
>  	return ret;
>  }
>  
> @@ -1607,7 +1603,6 @@ static int max1363_remove(struct i2c_client *client)
>  		regulator_disable(st->vref);
>  	regulator_disable(st->reg);
>  	iio_map_array_unregister(indio_dev);
> -	iio_device_free(indio_dev);
>  
>  	return 0;
>  }
> 
