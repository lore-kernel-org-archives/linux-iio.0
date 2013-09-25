Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34671 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab3IYUAe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Sep 2013 16:00:34 -0400
Message-ID: <52434F08.2060708@kernel.org>
Date: Wed, 25 Sep 2013 22:00:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH 08/32] iio: dac: max517: Use devm_iio_device_register
References: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org> <1380106208-6948-9-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380106208-6948-9-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/25/13 11:49, Sachin Kamat wrote:
> devm_iio_device_register simplifies the code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

This device clearly has a power down mode. Is it sensible to assume that if it is fine
to power it down in suspend it is fine to power it down if the remove is called?

If so that should happen after the unregister.

Sachin, you are doing a fine job of showing up where we don't have the best handling
in our remove functions!

A few devices seem to be so 'stupid' that there really is nothing to do (unless we cut
the power supply) but they aren't that common.

> ---
>  drivers/iio/dac/max517.c |    9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
> index 83adcbf..959207f 100644
> --- a/drivers/iio/dac/max517.c
> +++ b/drivers/iio/dac/max517.c
> @@ -194,7 +194,7 @@ static int max517_probe(struct i2c_client *client,
>  		data->vref_mv[1] = platform_data->vref_mv[1];
>  	}
>  
> -	err = iio_device_register(indio_dev);
> +	err = devm_iio_device_register(&client->dev, indio_dev);
>  	if (err)
>  		return err;
>  
> @@ -203,12 +203,6 @@ static int max517_probe(struct i2c_client *client,
>  	return 0;
>  }
>  
> -static int max517_remove(struct i2c_client *client)
> -{
> -	iio_device_unregister(i2c_get_clientdata(client));
> -	return 0;
> -}
> -
>  static const struct i2c_device_id max517_id[] = {
>  	{ "max517", ID_MAX517 },
>  	{ "max518", ID_MAX518 },
> @@ -223,7 +217,6 @@ static struct i2c_driver max517_driver = {
>  		.pm		= MAX517_PM_OPS,
>  	},
>  	.probe		= max517_probe,
> -	.remove		= max517_remove,
>  	.id_table	= max517_id,
>  };
>  module_i2c_driver(max517_driver);
> 
