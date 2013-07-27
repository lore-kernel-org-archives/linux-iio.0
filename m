Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53456 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab3G0Kbm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jul 2013 06:31:42 -0400
Message-ID: <51F3AFA0.2010802@kernel.org>
Date: Sat, 27 Jul 2013 12:31:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, patches@linaro.org,
	Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH 8/8] staging: iio: light: isl29028: Use devm_iio_device_alloc
References: <1374490981-24373-1-git-send-email-sachin.kamat@linaro.org> <1374490981-24373-9-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374490981-24373-9-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/22/13 12:03, Sachin Kamat wrote:
> Using devm_iio_device_alloc makes code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Laxman Dewangan <ldewangan@nvidia.com>
Applied to the togreg branch of iio.git

Thanks for all of these.

> ---
>  drivers/staging/iio/light/isl29028.c |   13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index 8bb0d03..6014625 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -482,7 +482,7 @@ static int isl29028_probe(struct i2c_client *client,
>  	struct iio_dev *indio_dev;
>  	int ret;
>  
> -	indio_dev = iio_device_alloc(sizeof(*chip));
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
>  	if (!indio_dev) {
>  		dev_err(&client->dev, "iio allocation fails\n");
>  		return -ENOMEM;
> @@ -498,13 +498,13 @@ static int isl29028_probe(struct i2c_client *client,
>  	if (IS_ERR(chip->regmap)) {
>  		ret = PTR_ERR(chip->regmap);
>  		dev_err(chip->dev, "regmap initialization failed: %d\n", ret);
> -		goto exit_iio_free;
> +		return ret;
>  	}
>  
>  	ret = isl29028_chip_init(chip);
>  	if (ret < 0) {
>  		dev_err(chip->dev, "chip initialization failed: %d\n", ret);
> -		goto exit_iio_free;
> +		return ret;
>  	}
>  
>  	indio_dev->info = &isl29028_info;
> @@ -517,13 +517,9 @@ static int isl29028_probe(struct i2c_client *client,
>  	if (ret < 0) {
>  		dev_err(chip->dev, "iio registration fails with error %d\n",
>  			ret);
> -		goto exit_iio_free;
> +		return ret;
>  	}
>  	return 0;
> -
> -exit_iio_free:
> -	iio_device_free(indio_dev);
> -	return ret;
>  }
>  
>  static int isl29028_remove(struct i2c_client *client)
> @@ -531,7 +527,6 @@ static int isl29028_remove(struct i2c_client *client)
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  
>  	iio_device_unregister(indio_dev);
> -	iio_device_free(indio_dev);
>  	return 0;
>  }
>  
> 
