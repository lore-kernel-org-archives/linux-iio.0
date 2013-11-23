Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56066 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304Ab3KWMiD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2013 07:38:03 -0500
Message-ID: <5290B000.9050207@kernel.org>
Date: Sat, 23 Nov 2013 13:39:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Subject: Re: [PATCH 10/33] iio: dac: mcp4725: Use devm_iio_device_register
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org> <1383046796-329-11-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-11-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/13 11:39, Sachin Kamat wrote:
> devm_iio_device_register simplifies the code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Another one that probably should be powering down the device. So not
taking this one either.

Sachin, I would have prefered it if you had taken a quick look at the
drivers to see if there is somehting that they 'should have' been
doing on removal but weren't.
> ---
>  drivers/iio/dac/mcp4725.c |    9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
> index 9f57ae8..0aa921b 100644
> --- a/drivers/iio/dac/mcp4725.c
> +++ b/drivers/iio/dac/mcp4725.c
> @@ -320,13 +320,7 @@ static int mcp4725_probe(struct i2c_client *client,
>  	data->powerdown_mode = pd ? pd-1 : 2; /* 500kohm_to_gnd */
>  	data->dac_value = (inbuf[1] << 4) | (inbuf[2] >> 4);
>  
> -	return iio_device_register(indio_dev);
> -}
> -
> -static int mcp4725_remove(struct i2c_client *client)
> -{
> -	iio_device_unregister(i2c_get_clientdata(client));
> -	return 0;
> +	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
>  static const struct i2c_device_id mcp4725_id[] = {
> @@ -341,7 +335,6 @@ static struct i2c_driver mcp4725_driver = {
>  		.pm	= MCP4725_PM_OPS,
>  	},
>  	.probe		= mcp4725_probe,
> -	.remove		= mcp4725_remove,
>  	.id_table	= mcp4725_id,
>  };
>  module_i2c_driver(mcp4725_driver);
> 
