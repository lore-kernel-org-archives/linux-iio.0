Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53350 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109Ab3HSSio (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Aug 2013 14:38:44 -0400
Message-ID: <52127444.4030009@kernel.org>
Date: Mon, 19 Aug 2013 20:38:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, lars@metafoo.de, jic23@cam.ac.uk,
	Roland Stigge <stigge@antcom.de>
Subject: Re: [PATCH 14/14] iio: dac: max517: Use devm_iio_device_alloc
References: <1376912305-6423-1-git-send-email-sachin.kamat@linaro.org> <1376912305-6423-14-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1376912305-6423-14-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/19/13 12:38, Sachin Kamat wrote:
> Using devm_iio_device_alloc makes code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Roland Stigge <stigge@antcom.de>
Applied to the togreg branch of iio.git

p.s. Roland, hope you don't mind. This one seems trivial
enough that I didn't think you'd mind me applying it without an
ack.

Jonathan
> ---
>  drivers/iio/dac/max517.c |   17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
> index ebfaa41..83adcbf 100644
> --- a/drivers/iio/dac/max517.c
> +++ b/drivers/iio/dac/max517.c
> @@ -164,11 +164,9 @@ static int max517_probe(struct i2c_client *client,
>  	struct max517_platform_data *platform_data = client->dev.platform_data;
>  	int err;
>  
> -	indio_dev = iio_device_alloc(sizeof(*data));
> -	if (indio_dev == NULL) {
> -		err = -ENOMEM;
> -		goto exit;
> -	}
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
>  	data = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
> @@ -198,23 +196,16 @@ static int max517_probe(struct i2c_client *client,
>  
>  	err = iio_device_register(indio_dev);
>  	if (err)
> -		goto exit_free_device;
> +		return err;
>  
>  	dev_info(&client->dev, "DAC registered\n");
>  
>  	return 0;
> -
> -exit_free_device:
> -	iio_device_free(indio_dev);
> -exit:
> -	return err;
>  }
>  
>  static int max517_remove(struct i2c_client *client)
>  {
>  	iio_device_unregister(i2c_get_clientdata(client));
> -	iio_device_free(i2c_get_clientdata(client));
> -
>  	return 0;
>  }
>  
> 
