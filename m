Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48589 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751565AbdCSLHa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2017 07:07:30 -0400
Subject: Re: [PATCH v2 09/17] iio: accel: bma180: Add OF device ID table
To: Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-kernel@vger.kernel.org
References: <20170315044505.20660-1-javier@osg.samsung.com>
 <20170315044505.20660-10-javier@osg.samsung.com>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alison Schofield <amsfield22@gmail.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e9885bc6-dcfb-bafb-2129-7acb74e20f34@kernel.org>
Date: Sun, 19 Mar 2017 10:55:30 +0000
MIME-Version: 1.0
In-Reply-To: <20170315044505.20660-10-javier@osg.samsung.com>
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
> ---
> 
>  drivers/iio/accel/bma180.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 0890934ef66f..e3f97757e72d 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -18,6 +18,7 @@
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
> +#include <linux/of_device.h>
>  #include <linux/of.h>
>  #include <linux/bitops.h>
>  #include <linux/slab.h>
> @@ -32,7 +33,7 @@
>  #define BMA180_DRV_NAME "bma180"
>  #define BMA180_IRQ_NAME "bma180_event"
>  
> -enum {
> +enum chip_ids {
>  	BMA180,
>  	BMA250,
>  };
> @@ -707,6 +708,7 @@ static int bma180_probe(struct i2c_client *client,
>  {
>  	struct bma180_data *data;
>  	struct iio_dev *indio_dev;
> +	enum chip_ids chip;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> @@ -716,7 +718,11 @@ static int bma180_probe(struct i2c_client *client,
>  	data = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
> -	data->part_info = &bma180_part_info[id->driver_data];
> +	if (client->dev.of_node)
> +		chip = (enum chip_ids)of_device_get_match_data(&client->dev);
> +	else
> +		chip = id->driver_data;
> +	data->part_info = &bma180_part_info[chip];
>  
>  	ret = data->part_info->chip_config(data);
>  	if (ret < 0)
> @@ -844,10 +850,24 @@ static struct i2c_device_id bma180_ids[] = {
>  
>  MODULE_DEVICE_TABLE(i2c, bma180_ids);
>  
> +static const struct of_device_id bma180_of_match[] = {
> +	{
> +		.compatible = "bosch,bma180",
> +		.data = (void *)BMA180
> +	},
> +	{
> +		.compatible = "bosch,bma250",
> +		.data = (void *)BMA250
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, bma180_of_match);
> +
>  static struct i2c_driver bma180_driver = {
>  	.driver = {
>  		.name	= "bma180",
>  		.pm	= BMA180_PM_OPS,
> +		.of_match_table = bma180_of_match,
>  	},
>  	.probe		= bma180_probe,
>  	.remove		= bma180_remove,
> 

