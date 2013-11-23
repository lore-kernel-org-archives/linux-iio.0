Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58730 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755526Ab3KWRJj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2013 12:09:39 -0500
Message-ID: <5290EFA8.604@kernel.org>
Date: Sat, 23 Nov 2013 18:10:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Subject: Re: [PATCH 18/33] staging: iio: ad7150: Use devm_iio_device_register
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org> <1383046796-329-19-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-19-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/13 11:39, Sachin Kamat wrote:
> devm_iio_device_register simplifies the code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Whilst not implemented, this device has an explicit power down control that I'd
like to see called in the remove function after the unregister.
As such I'm not taking this one.


> ---
>  drivers/staging/iio/cdc/ad7150.c |   12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index 7e7f989..d9f2191 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -640,7 +640,7 @@ static int ad7150_probe(struct i2c_client *client,
>  			return ret;
>  	}
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
>  	if (ret)
>  		return ret;
>  
> @@ -650,15 +650,6 @@ static int ad7150_probe(struct i2c_client *client,
>  	return 0;
>  }
>  
> -static int ad7150_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -
> -	iio_device_unregister(indio_dev);
> -
> -	return 0;
> -}
> -
>  static const struct i2c_device_id ad7150_id[] = {
>  	{ "ad7150", 0 },
>  	{ "ad7151", 0 },
> @@ -673,7 +664,6 @@ static struct i2c_driver ad7150_driver = {
>  		.name = "ad7150",
>  	},
>  	.probe = ad7150_probe,
> -	.remove = ad7150_remove,
>  	.id_table = ad7150_id,
>  };
>  module_i2c_driver(ad7150_driver);
> 
