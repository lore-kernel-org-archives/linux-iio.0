Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56043 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab3KWMg1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2013 07:36:27 -0500
Message-ID: <5290AF9F.5040607@kernel.org>
Date: Sat, 23 Nov 2013 13:37:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Subject: Re: [PATCH 09/33] iio: dac: max517: Use devm_iio_device_register
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org> <1383046796-329-10-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-10-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/13 11:39, Sachin Kamat wrote:
> devm_iio_device_register simplifies the code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Another driver where it should probably be putting the device into power down
mode on driver removal.   The give away again is that there is something
that makes sense when going into suspend.

Jonathan
> ---
>  drivers/iio/dac/max517.c |    9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
> index 6e19035..073b705 100644
> --- a/drivers/iio/dac/max517.c
> +++ b/drivers/iio/dac/max517.c
> @@ -191,13 +191,7 @@ static int max517_probe(struct i2c_client *client,
>  		data->vref_mv[1] = platform_data->vref_mv[1];
>  	}
>  
> -	return iio_device_register(indio_dev);
> -}
> -
> -static int max517_remove(struct i2c_client *client)
> -{
> -	iio_device_unregister(i2c_get_clientdata(client));
> -	return 0;
> +	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
>  static const struct i2c_device_id max517_id[] = {
> @@ -214,7 +208,6 @@ static struct i2c_driver max517_driver = {
>  		.pm		= MAX517_PM_OPS,
>  	},
>  	.probe		= max517_probe,
> -	.remove		= max517_remove,
>  	.id_table	= max517_id,
>  };
>  module_i2c_driver(max517_driver);
> 
