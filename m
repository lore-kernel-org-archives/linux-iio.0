Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60107 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbbC1Mqi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2015 08:46:38 -0400
Message-ID: <5516A2AD.2030701@kernel.org>
Date: Sat, 28 Mar 2015 12:46:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: =?UTF-8?B?Vmlhbm5leSBsZSBDbMOpbWVudCBkZSBTYWludC1NYXJjcQ==?=
	<vianney.leclement@essensium.com>, linux-iio@vger.kernel.org
CC: "Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Subject: Re: [PATCH v2 5/7] iio: mlx90614: Add emissivity setting
References: <1427212459-31585-1-git-send-email-vianney.leclement@essensium.com> <1427212459-31585-6-git-send-email-vianney.leclement@essensium.com>
In-Reply-To: <1427212459-31585-6-git-send-email-vianney.leclement@essensium.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/03/15 15:54, Vianney le Clément de Saint-Marcq wrote:
> The mapping from the 16-bit EEPROM value to the decimal 0-1 range is
> approximate.  A special case ensures 0xFFFF shows as 1.0 instead of
> 0.999998565.
> 
> Writing to EEPROM requires an explicit erase by writing zero.  In
> addition, it takes 20ms for the erase/write to complete.  During this
> time no EEPROM register should be accessed.  Therefore, two msleep()s
> are added to the write function and a mutex protects against concurrent
> access.
> 
> Signed-off-by: Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
> Cc: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>
> 
Fine other than change to calibemissivity.
> ---
> 
> v2: * remove iir, fir, and gain attributes
>     * refactor emissivity to use IIO_CHAN_INFO_EMISSIVITY
> ---
>  drivers/iio/temperature/mlx90614.c | 106 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 103 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> index a112fc9..b981d1e 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -12,12 +12,13 @@
>   *
>   * (7-bit I2C slave address 0x5a, 100KHz bus speed only!)
>   *
> - * TODO: sleep mode, configuration EEPROM
> + * TODO: sleep mode, filter configuration
>   */
>  
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/module.h>
> +#include <linux/delay.h>
>  
>  #include <linux/iio/iio.h>
>  
> @@ -53,8 +54,47 @@
>  
>  struct mlx90614_data {
>  	struct i2c_client *client;
> +	struct mutex lock; /* for EEPROM access only */
>  };
>  
> +/*
> + * Erase an address and write word.
> + * The mutex must be locked before calling.
> + */
> +static s32 mlx90614_write_word(const struct i2c_client *client, u8 command,
> +			       u16 value)
> +{
> +	/*
> +	 * Note: The mlx90614 requires a PEC on writing but does not send us a
> +	 * valid PEC on reading.  Hence, we cannot set I2C_CLIENT_PEC in
> +	 * i2c_client.flags.  As a workaround, we use i2c_smbus_xfer here.
> +	 */
> +	union i2c_smbus_data data;
> +	s32 ret;
> +
> +	dev_dbg(&client->dev, "Writing 0x%x to address 0x%x", value, command);
> +
> +	data.word = 0x0000; /* erase command */
> +	ret = i2c_smbus_xfer(client->adapter, client->addr,
> +			     client->flags | I2C_CLIENT_PEC,
> +			     I2C_SMBUS_WRITE, command,
> +			     I2C_SMBUS_WORD_DATA, &data);
> +	if (ret < 0)
> +		return ret;
> +
> +	msleep(MLX90614_TIMING_EEPROM);
> +
> +	data.word = value; /* actual write */
> +	ret = i2c_smbus_xfer(client->adapter, client->addr,
> +			     client->flags | I2C_CLIENT_PEC,
> +			     I2C_SMBUS_WRITE, command,
> +			     I2C_SMBUS_WORD_DATA, &data);
> +
> +	msleep(MLX90614_TIMING_EEPROM);
> +
> +	return ret;
> +}
> +
>  static int mlx90614_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *channel, int *val,
>  			    int *val2, long mask)
> @@ -97,6 +137,61 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 20;
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_EMISSIVITY: /* 1/65535 / LSB */
> +		mutex_lock(&data->lock);
> +		ret = i2c_smbus_read_word_data(data->client,
> +					       MLX90614_EMISSIVITY);
> +		mutex_unlock(&data->lock);
> +
> +		if (ret < 0)
> +			return ret;
> +
> +		if (ret == 65535) {
> +			*val = 1;
> +			*val2 = 0;
> +		} else {
> +			*val = 0;
> +			*val2 = ret * 15259; /* 1/65535 ~ 0.000015259 */
> +		}
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mlx90614_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *channel, int val,
> +			     int val2, long mask)
> +{
> +	struct mlx90614_data *data = iio_priv(indio_dev);
> +	s32 ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_EMISSIVITY: /* 1/65535 / LSB */
> +		if (val < 0 || val2 < 0 || val > 1 || (val == 1 && val2 != 0))
> +			return -EINVAL;
> +		val = val * 65535 + val2 / 15259; /* 1/65535 ~ 0.000015259 */
> +
> +		mutex_lock(&data->lock);
> +		ret = mlx90614_write_word(data->client, MLX90614_EMISSIVITY,
> +					  val);
> +		mutex_unlock(&data->lock);
> +
> +		if (ret < 0)
> +			return ret;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mlx90614_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec const *channel,
> +				     long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_EMISSIVITY:
> +		return IIO_VAL_INT_PLUS_NANO;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -115,7 +210,8 @@ static const struct iio_chan_spec mlx90614_channels[] = {
>  		.type = IIO_TEMP,
>  		.modified = 1,
>  		.channel2 = IIO_MOD_TEMP_OBJECT,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +		    BIT(IIO_CHAN_INFO_EMISSIVITY),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>  		    BIT(IIO_CHAN_INFO_SCALE),
>  	},
> @@ -125,7 +221,8 @@ static const struct iio_chan_spec mlx90614_channels[] = {
>  		.modified = 1,
>  		.channel = 1,
>  		.channel2 = IIO_MOD_TEMP_OBJECT,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +		    BIT(IIO_CHAN_INFO_EMISSIVITY),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>  		    BIT(IIO_CHAN_INFO_SCALE),
>  	},
> @@ -133,6 +230,8 @@ static const struct iio_chan_spec mlx90614_channels[] = {
>  
>  static const struct iio_info mlx90614_info = {
>  	.read_raw = mlx90614_read_raw,
> +	.write_raw = mlx90614_write_raw,
> +	.write_raw_get_fmt = mlx90614_write_raw_get_fmt,
>  	.driver_module = THIS_MODULE,
>  };
>  
> @@ -166,6 +265,7 @@ static int mlx90614_probe(struct i2c_client *client,
>  	data = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
> +	mutex_init(&data->lock);
>  
>  	indio_dev->dev.parent = &client->dev;
>  	indio_dev->name = id->name;
> 

