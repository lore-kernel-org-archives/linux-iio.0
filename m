Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58943 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756291Ab3KWRXa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2013 12:23:30 -0500
Message-ID: <5290F2E6.50201@kernel.org>
Date: Sat, 23 Nov 2013 18:24:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Subject: Re: [PATCH 26/33] staging: iio: isl29018: Use devm_iio_device_register
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org> <1383046796-329-27-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-27-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/13 11:39, Sachin Kamat wrote:
> devm_iio_device_register simplifies the code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
In this driver there is even a comment saying there is nothing to do in the suspend
hence, this one is fine.  Applied to the togreg branch of iio.git

Thanks,

> ---
>  drivers/staging/iio/light/isl29018.c |   13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
> index 488e690..3660a43 100644
> --- a/drivers/staging/iio/light/isl29018.c
> +++ b/drivers/staging/iio/light/isl29018.c
> @@ -585,7 +585,7 @@ static int isl29018_probe(struct i2c_client *client,
>  	indio_dev->name = id->name;
>  	indio_dev->dev.parent = &client->dev;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	err = iio_device_register(indio_dev);
> +	err = devm_iio_device_register(&client->dev, indio_dev);
>  	if (err) {
>  		dev_err(&client->dev, "iio registration fails\n");
>  		return err;
> @@ -594,16 +594,6 @@ static int isl29018_probe(struct i2c_client *client,
>  	return 0;
>  }
>  
> -static int isl29018_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -
> -	dev_dbg(&client->dev, "%s()\n", __func__);
> -	iio_device_unregister(indio_dev);> -
> -	return 0;
> -}
> -
>  #ifdef CONFIG_PM_SLEEP
>  static int isl29018_suspend(struct device *dev)
>  {
> @@ -664,7 +654,6 @@ static struct i2c_driver isl29018_driver = {
>  			.of_match_table = isl29018_of_match,
>  		    },
>  	.probe	 = isl29018_probe,
> -	.remove	 = isl29018_remove,
>  	.id_table = isl29018_id,
>  };
>  module_i2c_driver(isl29018_driver);
> 
