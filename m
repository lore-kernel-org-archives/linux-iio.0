Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60087 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbbC1MoO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2015 08:44:14 -0400
Message-ID: <5516A21B.10409@kernel.org>
Date: Sat, 28 Mar 2015 12:44:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: =?UTF-8?B?Vmlhbm5leSBsZSBDbMOpbWVudCBkZSBTYWludC1NYXJjcQ==?=
	<vianney.leclement@essensium.com>, linux-iio@vger.kernel.org
CC: "Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Subject: Re: [PATCH v2 3/7] iio: mlx90614: Support devices with dual IR sensor
References: <1427212459-31585-1-git-send-email-vianney.leclement@essensium.com> <1427212459-31585-4-git-send-email-vianney.leclement@essensium.com>
In-Reply-To: <1427212459-31585-4-git-send-email-vianney.leclement@essensium.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/03/15 15:54, Vianney le Clément de Saint-Marcq wrote:
> The model is detected by reading the EEPROM configuration during
> probing.
> 
> Signed-off-by: Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
> Cc: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>
> 
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.

Thanks,
> ---
> 
> v2: * remove symmetrical ambient channel
>     * rename _probe_model to _probe_num_ir_sensors
> ---
>  drivers/iio/temperature/mlx90614.c | 67 ++++++++++++++++++++++++++++++++------
>  1 file changed, 57 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> index a2e3aa6..a112fc9 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -2,6 +2,7 @@
>   * mlx90614.c - Support for Melexis MLX90614 contactless IR temperature sensor
>   *
>   * Copyright (c) 2014 Peter Meerwald <pmeerw@pmeerw.net>
> + * Copyright (c) 2015 Essensium NV
>   *
>   * This file is subject to the terms and conditions of version 2 of
>   * the GNU General Public License.  See the file COPYING in the main
> @@ -59,26 +60,34 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
>  			    int *val2, long mask)
>  {
>  	struct mlx90614_data *data = iio_priv(indio_dev);
> +	u8 cmd;
>  	s32 ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW: /* 0.02K / LSB */
>  		switch (channel->channel2) {
>  		case IIO_MOD_TEMP_AMBIENT:
> -			ret = i2c_smbus_read_word_data(data->client,
> -			    MLX90614_TA);
> -			if (ret < 0)
> -				return ret;
> +			cmd = MLX90614_TA;
>  			break;
>  		case IIO_MOD_TEMP_OBJECT:
> -			ret = i2c_smbus_read_word_data(data->client,
> -			    MLX90614_TOBJ1);
> -			if (ret < 0)
> -				return ret;
> +			switch (channel->channel) {
> +			case 0:
> +				cmd = MLX90614_TOBJ1;
> +				break;
> +			case 1:
> +				cmd = MLX90614_TOBJ2;
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
>  			break;
>  		default:
>  			return -EINVAL;
>  		}
> +
> +		ret = i2c_smbus_read_word_data(data->client, cmd);
> +		if (ret < 0)
> +			return ret;
>  		*val = ret;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_OFFSET:
> @@ -110,6 +119,16 @@ static const struct iio_chan_spec mlx90614_channels[] = {
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>  		    BIT(IIO_CHAN_INFO_SCALE),
>  	},
> +	{
> +		.type = IIO_TEMP,
> +		.indexed = 1,
> +		.modified = 1,
> +		.channel = 1,
> +		.channel2 = IIO_MOD_TEMP_OBJECT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> +		    BIT(IIO_CHAN_INFO_SCALE),
> +	},
>  };
>  
>  static const struct iio_info mlx90614_info = {
> @@ -117,11 +136,25 @@ static const struct iio_info mlx90614_info = {
>  	.driver_module = THIS_MODULE,
>  };
>  
> +/* Return 0 for single sensor, 1 for dual sensor, <0 on error. */
> +static int mlx90614_probe_num_ir_sensors(struct i2c_client *client)
> +{
> +	s32 ret;
> +
> +	ret = i2c_smbus_read_word_data(client, MLX90614_CONFIG);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return (ret & MLX90614_CONFIG_DUAL_MASK) ? 1 : 0;
> +}
> +
>  static int mlx90614_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
>  	struct iio_dev *indio_dev;
>  	struct mlx90614_data *data;
> +	int ret;
>  
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
>  		return -ENODEV;
> @@ -139,8 +172,21 @@ static int mlx90614_probe(struct i2c_client *client,
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &mlx90614_info;
>  
> -	indio_dev->channels = mlx90614_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(mlx90614_channels);
> +	ret = mlx90614_probe_num_ir_sensors(client);
> +	switch (ret) {
> +	case 0:
> +		dev_dbg(&client->dev, "Found single sensor");
> +		indio_dev->channels = mlx90614_channels;
> +		indio_dev->num_channels = 2;
> +		break;
> +	case 1:
> +		dev_dbg(&client->dev, "Found dual sensor");
> +		indio_dev->channels = mlx90614_channels;
> +		indio_dev->num_channels = 3;
> +		break;
> +	default:
> +		return ret;
> +	}
>  
>  	return iio_device_register(indio_dev);
>  }
> @@ -170,5 +216,6 @@ static struct i2c_driver mlx90614_driver = {
>  module_i2c_driver(mlx90614_driver);
>  
>  MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
> +MODULE_AUTHOR("Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>");
>  MODULE_DESCRIPTION("Melexis MLX90614 contactless IR temperature sensor driver");
>  MODULE_LICENSE("GPL");
> 

