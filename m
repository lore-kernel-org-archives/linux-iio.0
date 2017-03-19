Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48490 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbdCSK5Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2017 06:57:24 -0400
Subject: Re: [PATCH v2 12/17] iio: adc: ti-ads1015: Add OF device ID table
To: Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-kernel@vger.kernel.org
References: <20170315044505.20660-1-javier@osg.samsung.com>
 <20170315044505.20660-13-javier@osg.samsung.com>
Cc: Matt Ranostay <mranostay@gmail.com>,
        Giorgio Dal Molin <giorgio.nicole@arcor.de>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3372e181-5296-c99a-1d76-c2f792b600ad@kernel.org>
Date: Sun, 19 Mar 2017 10:57:10 +0000
MIME-Version: 1.0
In-Reply-To: <20170315044505.20660-13-javier@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/03/17 04:45, Javier Martinez Canillas wrote:
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
>  drivers/iio/adc/ti-ads1015.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 422b314f5a3f..f76d979fb7e8 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -15,6 +15,7 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/init.h>
>  #include <linux/i2c.h>
>  #include <linux/regmap.h>
> @@ -55,7 +56,7 @@
>  #define ADS1015_DEFAULT_DATA_RATE	4
>  #define ADS1015_DEFAULT_CHAN		0
>  
> -enum {
> +enum chip_ids {
>  	ADS1015,
>  	ADS1115,
>  };
> @@ -578,6 +579,7 @@ static int ads1015_probe(struct i2c_client *client,
>  	struct iio_dev *indio_dev;
>  	struct ads1015_data *data;
>  	int ret;
> +	enum chip_ids chip;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
> @@ -593,7 +595,11 @@ static int ads1015_probe(struct i2c_client *client,
>  	indio_dev->name = ADS1015_DRV_NAME;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	switch (id->driver_data) {
> +	if (client->dev.of_node)
> +		chip = (enum chip_ids)of_device_get_match_data(&client->dev);
> +	else
> +		chip = id->driver_data;
> +	switch (chip) {
>  	case ADS1015:
>  		indio_dev->channels = ads1015_channels;
>  		indio_dev->num_channels = ARRAY_SIZE(ads1015_channels);
> @@ -698,9 +704,23 @@ static const struct i2c_device_id ads1015_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, ads1015_id);
>  
> +static const struct of_device_id ads1015_of_match[] = {
> +	{
> +		.compatible = "ti,ads1015",
> +		.data = (void *)ADS1015
> +	},
> +	{
> +		.compatible = "ti,ads1115",
> +		.data = (void *)ADS1115
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ads1015_of_match);
> +
>  static struct i2c_driver ads1015_driver = {
>  	.driver = {
>  		.name = ADS1015_DRV_NAME,
> +		.of_match_table = ads1015_of_match,
>  		.pm = &ads1015_pm_ops,
>  	},
>  	.probe		= ads1015_probe,
> 

