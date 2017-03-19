Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48559 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbdCSLDN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2017 07:03:13 -0400
Subject: Re: [PATCH v2 08/17] iio: imu: inv_mpu6050: Add OF device ID table
To: Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-kernel@vger.kernel.org
References: <20170315044505.20660-1-javier@osg.samsung.com>
 <20170315044505.20660-9-javier@osg.samsung.com>
Cc: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Wolfram Sang <wsa@the-dreams.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ge Gao <ggao@invensense.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Peter Rosin <peda@axentia.se>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b436a465-a4ae-2826-c9da-d60faa89db1a@kernel.org>
Date: Sun, 19 Mar 2017 10:54:52 +0000
MIME-Version: 1.0
In-Reply-To: <20170315044505.20660-9-javier@osg.samsung.com>
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
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 38 +++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index 2c3f8964a3ea..a8e6330cb906 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -17,6 +17,7 @@
>  #include <linux/i2c.h>
>  #include <linux/iio/iio.h>
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include "inv_mpu_iio.h"
>  
>  static const struct regmap_config inv_mpu_regmap_config = {
> @@ -69,7 +70,8 @@ static int inv_mpu6050_deselect_bypass(struct i2c_mux_core *muxc, u32 chan_id)
>  	return 0;
>  }
>  
> -static const char *inv_mpu_match_acpi_device(struct device *dev, int *chip_id)
> +static const char *inv_mpu_match_acpi_device(struct device *dev,
> +					     enum inv_devices *chip_id)
>  {
>  	const struct acpi_device_id *id;
>  
> @@ -93,7 +95,8 @@ static int inv_mpu_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
>  	struct inv_mpu6050_state *st;
> -	int result, chip_type;
> +	int result;
> +	enum inv_devices chip_type;
>  	struct regmap *regmap;
>  	const char *name;
>  
> @@ -101,8 +104,13 @@ static int inv_mpu_probe(struct i2c_client *client,
>  				     I2C_FUNC_SMBUS_I2C_BLOCK))
>  		return -EOPNOTSUPP;
>  
> -	if (id) {
> -		chip_type = (int)id->driver_data;
> +	if (client->dev.of_node) {
> +		chip_type = (enum inv_devices)
> +			of_device_get_match_data(&client->dev);
> +		name = client->name;
> +	} else if (id) {
> +		chip_type = (enum inv_devices)
> +			id->driver_data;
>  		name = id->name;
>  	} else if (ACPI_HANDLE(&client->dev)) {
>  		name = inv_mpu_match_acpi_device(&client->dev, &chip_type);
> @@ -176,6 +184,27 @@ static const struct i2c_device_id inv_mpu_id[] = {
>  
>  MODULE_DEVICE_TABLE(i2c, inv_mpu_id);
>  
> +static const struct of_device_id inv_of_match[] = {
> +	{
> +		.compatible = "invensense,mpu6050",
> +		.data = (void *)INV_MPU6050
> +	},
> +	{
> +		.compatible = "invensense,mpu6500",
> +		.data = (void *)INV_MPU6500
> +	},
> +	{
> +		.compatible = "invensense,mpu9150",
> +		.data = (void *)INV_MPU9150
> +	},
> +	{
> +		.compatible = "invensense,icm20608",
> +		.data = (void *)INV_ICM20608
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, inv_of_match);
> +
>  static const struct acpi_device_id inv_acpi_match[] = {
>  	{"INVN6500", INV_MPU6500},
>  	{ },
> @@ -188,6 +217,7 @@ static struct i2c_driver inv_mpu_driver = {
>  	.remove		=	inv_mpu_remove,
>  	.id_table	=	inv_mpu_id,
>  	.driver = {
> +		.of_match_table = inv_of_match,
>  		.acpi_match_table = ACPI_PTR(inv_acpi_match),
>  		.name	=	"inv-mpu6050-i2c",
>  		.pm     =       &inv_mpu_pmops,
> 

