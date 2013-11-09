Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54876 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753392Ab3KIQxm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 Nov 2013 11:53:42 -0500
Message-ID: <527E76DE.9020008@kernel.org>
Date: Sat, 09 Nov 2013 17:54:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de, Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: Re: [PATCH 04/33] iio: adc: mcp3422: Use devm_iio_device_register
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org> <1383046796-329-5-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-5-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/13 11:39, Sachin Kamat wrote:
> devm_iio_device_register simplifies the code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied to the togreg branch of iio.git

This one should have had Angelo cc'd
> ---
>  drivers/iio/adc/mcp3422.c |    9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index 1294832..dbdbd77 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -362,7 +362,7 @@ static int mcp3422_probe(struct i2c_client *client,
>  		| MCP3422_SAMPLE_RATE_VALUE(MCP3422_SRATE_240));
>  	mcp3422_update_config(adc, config);
>  
> -	err = iio_device_register(indio_dev);
> +	err = devm_iio_device_register(&client->dev, indio_dev);
>  	if (err < 0)
>  		return err;
>  
> @@ -371,12 +371,6 @@ static int mcp3422_probe(struct i2c_client *client,
>  	return 0;
>  }
>  
> -static int mcp3422_remove(struct i2c_client *client)
> -{
> -	iio_device_unregister(i2c_get_clientdata(client));
> -	return 0;
> -}
> -
>  static const struct i2c_device_id mcp3422_id[] = {
>  	{ "mcp3422", 2 },
>  	{ "mcp3423", 3 },
> @@ -400,7 +394,6 @@ static struct i2c_driver mcp3422_driver = {
>  		.of_match_table = of_match_ptr(mcp3422_of_match),
>  	},
>  	.probe = mcp3422_probe,
> -	.remove = mcp3422_remove,
>  	.id_table = mcp3422_id,
>  };
>  module_i2c_driver(mcp3422_driver);
> 
