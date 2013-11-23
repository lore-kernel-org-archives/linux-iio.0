Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58989 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755526Ab3KWR1t (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2013 12:27:49 -0500
Message-ID: <5290F3EA.4050004@kernel.org>
Date: Sat, 23 Nov 2013 18:28:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Subject: Re: [PATCH 27/33] staging: iio: isl29028: Use devm_iio_device_register
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org> <1383046796-329-28-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-28-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/13 11:39, Sachin Kamat wrote:
> devm_iio_device_register simplifies the code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
This one has explicit disables for the various functions that ought to be
called after the unregister to save power.

Note for all these patches that I'm refusing to take, there is obviously
plenty of work implementing the power handling etc that should be there.
> ---
>  drivers/staging/iio/light/isl29028.c |   11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index 6014625..aeb830b 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -513,7 +513,7 @@ static int isl29028_probe(struct i2c_client *client,
>  	indio_dev->name = id->name;
>  	indio_dev->dev.parent = &client->dev;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
>  	if (ret < 0) {
>  		dev_err(chip->dev, "iio registration fails with error %d\n",
>  			ret);
> @@ -522,14 +522,6 @@ static int isl29028_probe(struct i2c_client *client,
>  	return 0;
>  }
>  
> -static int isl29028_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -
> -	iio_device_unregister(indio_dev);
> -	return 0;
> -}
> -
>  static const struct i2c_device_id isl29028_id[] = {
>  	{"isl29028", 0},
>  	{}
> @@ -550,7 +542,6 @@ static struct i2c_driver isl29028_driver = {
>  		.of_match_table = isl29028_of_match,
>  	},
>  	.probe	 = isl29028_probe,
> -	.remove  = isl29028_remove,
>  	.id_table = isl29028_id,
>  };
>  
> 
