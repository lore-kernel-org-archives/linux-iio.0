Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:10572 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756484Ab3GVPQo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jul 2013 11:16:44 -0400
Message-ID: <51ED4CD2.4070600@nvidia.com>
Date: Mon, 22 Jul 2013 11:16:34 -0400
From: Rhyland Klein <rklein@nvidia.com>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"jic23@cam.ac.uk" <jic23@cam.ac.uk>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"patches@linaro.org" <patches@linaro.org>
Subject: Re: [PATCH 7/8] staging: iio: light: isl29018: Use devm_iio_device_alloc
References: <1374490981-24373-1-git-send-email-sachin.kamat@linaro.org> <1374490981-24373-8-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374490981-24373-8-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 7/22/2013 7:03 AM, Sachin Kamat wrote:
> Using devm_iio_device_alloc makes code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Rhyland Klein <rklein@nvidia.com>
> ---
>  drivers/staging/iio/light/isl29018.c |   16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
> index 82478a5..351936c 100644
> --- a/drivers/staging/iio/light/isl29018.c
> +++ b/drivers/staging/iio/light/isl29018.c
> @@ -550,11 +550,10 @@ static int isl29018_probe(struct i2c_client *client,
>  	struct iio_dev *indio_dev;
>  	int err;
>  
> -	indio_dev = iio_device_alloc(sizeof(*chip));
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
>  	if (indio_dev == NULL) {
>  		dev_err(&client->dev, "iio allocation fails\n");
> -		err = -ENOMEM;
> -		goto exit;
> +		return -ENOMEM;
>  	}
>  	chip = iio_priv(indio_dev);
>  
> @@ -572,12 +571,12 @@ static int isl29018_probe(struct i2c_client *client,
>  	if (IS_ERR(chip->regmap)) {
>  		err = PTR_ERR(chip->regmap);
>  		dev_err(chip->dev, "regmap initialization failed: %d\n", err);
> -		goto exit;
> +		return err;
>  	}
>  
>  	err = isl29018_chip_init(chip);
>  	if (err)
> -		goto exit_iio_free;
> +		return err;
>  
>  	indio_dev->info = &isl29108_info;
>  	indio_dev->channels = isl29018_channels;
> @@ -588,14 +587,10 @@ static int isl29018_probe(struct i2c_client *client,
>  	err = iio_device_register(indio_dev);
>  	if (err) {
>  		dev_err(&client->dev, "iio registration fails\n");
> -		goto exit_iio_free;
> +		return err;
>  	}
>  
>  	return 0;
> -exit_iio_free:
> -	iio_device_free(indio_dev);
> -exit:
> -	return err;
>  }
>  
>  static int isl29018_remove(struct i2c_client *client)
> @@ -604,7 +599,6 @@ static int isl29018_remove(struct i2c_client *client)
>  
>  	dev_dbg(&client->dev, "%s()\n", __func__);
>  	iio_device_unregister(indio_dev);
> -	iio_device_free(indio_dev);
>  
>  	return 0;
>  }
> 

Thanks!

Acked-by: Rhyland Klein <rklein@nvidia.com>

-- 
nvpublic
