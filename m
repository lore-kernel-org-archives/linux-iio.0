Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48377 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbdCSKsn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2017 06:48:43 -0400
Subject: Re: [PATCH v2 01/17] iio: adc: ina2xx: Add OF device ID table
To: Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-kernel@vger.kernel.org
References: <20170315044505.20660-1-javier@osg.samsung.com>
 <20170315044505.20660-2-javier@osg.samsung.com>
Cc: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alison Schofield <amsfield22@gmail.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marc Titinger <mtitinger@baylibre.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <26678fef-12aa-be0e-58e7-b0a96bd87036@kernel.org>
Date: Sun, 19 Mar 2017 10:48:39 +0000
MIME-Version: 1.0
In-Reply-To: <20170315044505.20660-2-javier@osg.samsung.com>
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
Applied to the togreg branch of iio.git - initially pushed out as testing for
the autobuilders to play with it.

Thanks for cleaning this up.

Jonathan
> ---
> 
>  drivers/iio/adc/ina2xx-adc.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index 3263231276ca..db9838230257 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -28,6 +28,7 @@
>  #include <linux/iio/sysfs.h>
>  #include <linux/kthread.h>
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/regmap.h>
>  #include <linux/util_macros.h>
>  
> @@ -635,6 +636,7 @@ static int ina2xx_probe(struct i2c_client *client,
>  	struct iio_dev *indio_dev;
>  	struct iio_buffer *buffer;
>  	unsigned int val;
> +	enum ina2xx_ids type;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
> @@ -652,7 +654,11 @@ static int ina2xx_probe(struct i2c_client *client,
>  		return PTR_ERR(chip->regmap);
>  	}
>  
> -	chip->config = &ina2xx_config[id->driver_data];
> +	if (client->dev.of_node)
> +		type = (enum ina2xx_ids)of_device_get_match_data(&client->dev);
> +	else
> +		type = id->driver_data;
> +	chip->config = &ina2xx_config[type];
>  
>  	mutex_init(&chip->state_lock);
>  
> @@ -726,9 +732,35 @@ static const struct i2c_device_id ina2xx_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, ina2xx_id);
>  
> +static const struct of_device_id ina2xx_of_match[] = {
> +	{
> +		.compatible = "ti,ina219",
> +		.data = (void *)ina219
> +	},
> +	{
> +		.compatible = "ti,ina220",
> +		.data = (void *)ina219
> +	},
> +	{
> +		.compatible = "ti,ina226",
> +		.data = (void *)ina226
> +	},
> +	{
> +		.compatible = "ti,ina230",
> +		.data = (void *)ina226
> +	},
> +	{
> +		.compatible = "ti,ina231",
> +		.data = (void *)ina226
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ina2xx_of_match);
> +
>  static struct i2c_driver ina2xx_driver = {
>  	.driver = {
>  		   .name = KBUILD_MODNAME,
> +		   .of_match_table = ina2xx_of_match,
>  	},
>  	.probe = ina2xx_probe,
>  	.remove = ina2xx_remove,
> 

