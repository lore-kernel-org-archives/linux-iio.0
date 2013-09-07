Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58040 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812Ab3IGTxY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 7 Sep 2013 15:53:24 -0400
Message-ID: <522B924D.3070905@kernel.org>
Date: Sat, 07 Sep 2013 21:53:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH 01/12] staging: iio: ad5933: Use devm_* APIs
References: <1378373397-22919-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378373397-22919-1-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/05/13 10:29, Sachin Kamat wrote:
> devm_* APIs are device managed and make code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
> This series is compile tested.
> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c |   18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 6330af6..23a0d71 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -703,7 +703,9 @@ static int ad5933_probe(struct i2c_client *client,
>  	int ret, voltage_uv = 0;
>  	struct ad5933_platform_data *pdata = client->dev.platform_data;
>  	struct ad5933_state *st;
> -	struct iio_dev *indio_dev = iio_device_alloc(sizeof(*st));
> +	struct iio_dev *indio_dev;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
>  	if (indio_dev == NULL)
>  		return -ENOMEM;
>  
> @@ -716,11 +718,11 @@ static int ad5933_probe(struct i2c_client *client,
>  	else
>  		st->pdata = pdata;
>  
> -	st->reg = regulator_get(&client->dev, "vcc");
> +	st->reg = devm_regulator_get(&client->dev, "vcc");
>  	if (!IS_ERR(st->reg)) {
>  		ret = regulator_enable(st->reg);
>  		if (ret)
> -			goto error_put_reg;
> +			return ret;
>  		voltage_uv = regulator_get_voltage(st->reg);
>  	}
>  
> @@ -778,11 +780,6 @@ error_unreg_ring:
>  error_disable_reg:
>  	if (!IS_ERR(st->reg))
>  		regulator_disable(st->reg);
> -error_put_reg:
> -	if (!IS_ERR(st->reg))
> -		regulator_put(st->reg);
> -
> -	iio_device_free(indio_dev);
>  
>  	return ret;
>  }
> @@ -795,11 +792,8 @@ static int ad5933_remove(struct i2c_client *client)
>  	iio_device_unregister(indio_dev);
>  	iio_buffer_unregister(indio_dev);
>  	iio_kfifo_free(indio_dev->buffer);
> -	if (!IS_ERR(st->reg)) {
> +	if (!IS_ERR(st->reg))
>  		regulator_disable(st->reg);
> -		regulator_put(st->reg);
> -	}
> -	iio_device_free(indio_dev);
>  
>  	return 0;
>  }
> 
