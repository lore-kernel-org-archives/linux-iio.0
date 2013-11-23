Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59151 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755609Ab3KWRiZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2013 12:38:25 -0500
Message-ID: <5290F665.6080309@kernel.org>
Date: Sat, 23 Nov 2013 18:39:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Subject: Re: [PATCH 33/33] staging: iio: ad7152: Use devm_iio_device_register
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org> <1383046796-329-34-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-34-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/13 11:39, Sachin Kamat wrote:
> devm_iio_device_register simplifies the code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Another device that has an explicit power down mode that I would like to see turned on after the
unregister is called.


> ---
>  drivers/staging/iio/cdc/ad7152.c |   12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
> index f2c309d..f925ecb 100644
> --- a/drivers/staging/iio/cdc/ad7152.c
> +++ b/drivers/staging/iio/cdc/ad7152.c
> @@ -502,7 +502,7 @@ static int ad7152_probe(struct i2c_client *client,
>  	indio_dev->num_channels = ARRAY_SIZE(ad7152_channels);
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
>  	if (ret)
>  		return ret;
>  
> @@ -511,15 +511,6 @@ static int ad7152_probe(struct i2c_client *client,
>  	return 0;
>  }
>  
> -static int ad7152_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -
> -	iio_device_unregister(indio_dev);
> -
> -	return 0;
> -}
> -
>  static const struct i2c_device_id ad7152_id[] = {
>  	{ "ad7152", 0 },
>  	{ "ad7153", 1 },
> @@ -533,7 +524,6 @@ static struct i2c_driver ad7152_driver = {
>  		.name = KBUILD_MODNAME,
>  	},
>  	.probe = ad7152_probe,
> -	.remove = ad7152_remove,
>  	.id_table = ad7152_id,
>  };
>  module_i2c_driver(ad7152_driver);
> 
