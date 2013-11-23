Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58757 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755526Ab3KWRLF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2013 12:11:05 -0500
Message-ID: <5290EFFB.8050204@kernel.org>
Date: Sat, 23 Nov 2013 18:12:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Subject: Re: [PATCH 19/33] staging: iio: ad7746: Use devm_iio_device_register
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org> <1383046796-329-20-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-20-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/13 11:39, Sachin Kamat wrote:
> devm_iio_device_register simplifies the code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Again, this has an explicit power down that I'd probably expect
to see called after the unregister.


> ---
>  drivers/staging/iio/cdc/ad7746.c |   12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 862d68d..51d56fe 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -749,7 +749,7 @@ static int ad7746_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
>  	if (ret)
>  		return ret;
>  
> @@ -758,15 +758,6 @@ static int ad7746_probe(struct i2c_client *client,
>  	return 0;
>  }
>  
> -static int ad7746_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -
> -	iio_device_unregister(indio_dev);
> -
> -	return 0;
> -}
> -
>  static const struct i2c_device_id ad7746_id[] = {
>  	{ "ad7745", 7745 },
>  	{ "ad7746", 7746 },
> @@ -781,7 +772,6 @@ static struct i2c_driver ad7746_driver = {
>  		.name = KBUILD_MODNAME,
>  	},
>  	.probe = ad7746_probe,
> -	.remove = ad7746_remove,
>  	.id_table = ad7746_id,
>  };
>  module_i2c_driver(ad7746_driver);
> 
