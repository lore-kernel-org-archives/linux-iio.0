Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56228 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab3KWMrh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2013 07:47:37 -0500
Message-ID: <5290B23D.5050609@kernel.org>
Date: Sat, 23 Nov 2013 13:48:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Subject: Re: [PATCH 13/33] iio: light: vcnl4000: Use devm_iio_device_register
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org> <1383046796-329-14-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-14-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/13 11:39, Sachin Kamat wrote:
> devm_iio_device_register simplifies the code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
I don't have a data sheet for this one so can't check if it 'should' be doing
anything on shut down.

Hence applied to the togreg branch of iio.git

Thanks,

> ---
>  drivers/iio/light/vcnl4000.c |    9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index ecb3341..384ac23 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -179,13 +179,7 @@ static int vcnl4000_probe(struct i2c_client *client,
>  	indio_dev->name = VCNL4000_DRV_NAME;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	return iio_device_register(indio_dev);
> -}
> -
> -static int vcnl4000_remove(struct i2c_client *client)
> -{
> -	iio_device_unregister(i2c_get_clientdata(client));
> -	return 0;
> +	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
>  static struct i2c_driver vcnl4000_driver = {
> @@ -194,7 +188,6 @@ static struct i2c_driver vcnl4000_driver = {
>  		.owner  = THIS_MODULE,
>  	},
>  	.probe  = vcnl4000_probe,
> -	.remove = vcnl4000_remove,
>  	.id_table = vcnl4000_id,
>  };
>  
> 
