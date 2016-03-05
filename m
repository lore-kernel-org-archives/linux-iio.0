Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56839 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbcCERvv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Mar 2016 12:51:51 -0500
Subject: Re: [PATCH] iio: imu: mpu6050: fix possible NULL dereferences
To: Matt Ranostay <matt.ranostay@intel.com>
References: <1456975092-17992-1-git-send-email-matt.ranostay@intel.com>
Cc: linux-iio@vger.kernel.org, dan.carpenter@oracle.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56DB1CB5.7090300@kernel.org>
Date: Sat, 5 Mar 2016 17:51:49 +0000
MIME-Version: 1.0
In-Reply-To: <1456975092-17992-1-git-send-email-matt.ranostay@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/03/16 03:18, Matt Ranostay wrote:
> Fix possible null dereferencing of i2c and spi driver data.
> 
> Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>
Changed my mind and applied this as is rather than leaving it hanging.
If it really makes no sense we can clear it out at a later date, along with
the other case.
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 3 ++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index f581256d9d4c..d0c0e20c7122 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -117,6 +117,7 @@ static int inv_mpu_probe(struct i2c_client *client,
>  	struct inv_mpu6050_state *st;
>  	int result;
>  	const char *name = id ? id->name : NULL;
> +	const int chip_type = id ? id->driver_data : 0;
>  	struct regmap *regmap;
>  
>  	if (!i2c_check_functionality(client->adapter,
> @@ -131,7 +132,7 @@ static int inv_mpu_probe(struct i2c_client *client,
>  	}
>  
>  	result = inv_mpu_core_probe(regmap, client->irq, name,
> -				    NULL, id->driver_data);
> +				    NULL, chip_type);
>  	if (result < 0)
>  		return result;
>  
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> index dea6c4361de0..7bcb8d839f05 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> @@ -46,6 +46,7 @@ static int inv_mpu_probe(struct spi_device *spi)
>  	struct regmap *regmap;
>  	const struct spi_device_id *id = spi_get_device_id(spi);
>  	const char *name = id ? id->name : NULL;
> +	const int chip_type = id ? id->driver_data : 0;
>  
>  	regmap = devm_regmap_init_spi(spi, &inv_mpu_regmap_config);
>  	if (IS_ERR(regmap)) {
> @@ -55,7 +56,7 @@ static int inv_mpu_probe(struct spi_device *spi)
>  	}
>  
>  	return inv_mpu_core_probe(regmap, spi->irq, name,
> -				  inv_mpu_i2c_disable, id->driver_data);
> +				  inv_mpu_i2c_disable, chip_type);
>  }
>  
>  static int inv_mpu_remove(struct spi_device *spi)
> 

