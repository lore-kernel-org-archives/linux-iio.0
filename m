Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48415 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbdCSKv3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2017 06:51:29 -0400
Subject: Re: [PATCH v2 04/17] iio: dac: mcp4725: Add OF device ID table
To: Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-kernel@vger.kernel.org
References: <20170315044505.20660-1-javier@osg.samsung.com>
 <20170315044505.20660-5-javier@osg.samsung.com>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Tomas Novotny <tomas@novotny.cz>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ec57507d-07e5-c66c-0550-38adb59aaf42@kernel.org>
Date: Sun, 19 Mar 2017 10:51:26 +0000
MIME-Version: 1.0
In-Reply-To: <20170315044505.20660-5-javier@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/03/17 04:44, Javier Martinez Canillas wrote:
> The driver doesn't have a struct of_device_id table but supported devices
> are registered via Device Trees. This is working on the assumption that a
> I2C device registered via OF will always match a legacy I2C device ID and
> that the MODALIAS reported will always be of the form i2c:<device>.
> 
> But this could change in the future so the correct approach is to have an
> OF device ID table if the devices are registered via OF.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Applied.

Thanks,
> ---
> 
>  drivers/iio/dac/mcp4725.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
> index db109f0cdd8c..6ab1f23e5a79 100644
> --- a/drivers/iio/dac/mcp4725.c
> +++ b/drivers/iio/dac/mcp4725.c
> @@ -19,6 +19,7 @@
>  #include <linux/err.h>
>  #include <linux/delay.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/of_device.h>
>  #include <linux/of.h>
>  
>  #include <linux/iio/iio.h>
> @@ -199,7 +200,7 @@ static ssize_t mcp4725_write_powerdown(struct iio_dev *indio_dev,
>  	return len;
>  }
>  
> -enum {
> +enum chip_id {
>  	MCP4725,
>  	MCP4726,
>  };
> @@ -406,7 +407,10 @@ static int mcp4725_probe(struct i2c_client *client,
>  	data = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
> -	data->id = id->driver_data;
> +	if (client->dev.of_node)
> +		data->id = (enum chip_id)of_device_get_match_data(&client->dev);
> +	else
> +		data->id = id->driver_data;
>  	pdata = dev_get_platdata(&client->dev);
>  
>  	if (!pdata) {
> @@ -525,9 +529,25 @@ static const struct i2c_device_id mcp4725_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, mcp4725_id);
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id mcp4725_of_match[] = {
> +	{
> +		.compatible = "microchip,mcp4725",
> +		.data = (void *)MCP4725
> +	},
> +	{
> +		.compatible = "microchip,mcp4726",
> +		.data = (void *)MCP4726
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mcp4725_of_match);
> +#endif
> +
>  static struct i2c_driver mcp4725_driver = {
>  	.driver = {
>  		.name	= MCP4725_DRV_NAME,
> +		.of_match_table = of_match_ptr(mcp4725_of_match),
>  		.pm	= MCP4725_PM_OPS,
>  	},
>  	.probe		= mcp4725_probe,
> 

