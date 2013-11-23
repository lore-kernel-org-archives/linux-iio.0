Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59007 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755526Ab3KWR3J (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2013 12:29:09 -0500
Message-ID: <5290F43A.3030008@kernel.org>
Date: Sat, 23 Nov 2013 18:30:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Subject: Re: [PATCH 28/33] staging: iio: tsl2583: Use devm_iio_device_register
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org> <1383046796-329-29-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-29-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/13 11:39, Sachin Kamat wrote:
> devm_iio_device_register simplifies the code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
This driver even has a convenient power off function (which
isn't and should be called after the unregister)

> ---
>  drivers/staging/iio/light/tsl2583.c |   10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index f8c6595..aa5a437 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -861,7 +861,7 @@ static int taos_probe(struct i2c_client *clientp,
>  	indio_dev->dev.parent = &clientp->dev;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->name = chip->client->name;
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&clientp->dev, indio_dev);
>  	if (ret) {
>  		dev_err(&clientp->dev, "iio registration failed\n");
>  		return ret;
> @@ -916,13 +916,6 @@ static SIMPLE_DEV_PM_OPS(taos_pm_ops, taos_suspend, taos_resume);
>  #define TAOS_PM_OPS NULL
>  #endif
>  
> -static int taos_remove(struct i2c_client *client)
> -{
> -	iio_device_unregister(i2c_get_clientdata(client));
> -
> -	return 0;
> -}
> -
>  static struct i2c_device_id taos_idtable[] = {
>  	{ "tsl2580", 0 },
>  	{ "tsl2581", 1 },
> @@ -939,7 +932,6 @@ static struct i2c_driver taos_driver = {
>  	},
>  	.id_table = taos_idtable,
>  	.probe = taos_probe,
> -	.remove = taos_remove,
>  };
>  module_i2c_driver(taos_driver);
>  
> 
