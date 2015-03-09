Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44222 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398AbbCIPSk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2015 11:18:40 -0400
Message-ID: <54FDB9CE.2060104@kernel.org>
Date: Mon, 09 Mar 2015 15:18:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: =?UTF-8?B?Vmlhbm5leSBsZSBDbMOpbWVudCBkZSBTYWludC1NYXJjcQ==?=
	<vianney.leclement@essensium.com>, linux-iio@vger.kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: "Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Subject: Re: [PATCH 4/7] iio: mlx90614: Support devices with dual IR sensor
References: <1424879712-28304-1-git-send-email-vianney.leclement@essensium.com> <1424879712-28304-5-git-send-email-vianney.leclement@essensium.com>
In-Reply-To: <1424879712-28304-5-git-send-email-vianney.leclement@essensium.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/02/15 15:55, Vianney le Clément de Saint-Marcq wrote:
> The model is detected by reading the EEPROM configuration during
> probing.  In the dual IR sensor model, the ambient temperature is
> exported twice to userspace.  This makes the two channels appear
> completely symmetrical.
Why do we want it to be symmetrical?  

Is there a part number difference for the dual sensor version?  If so we can still
autoprobe for it, but want to make sure we have it listed as a supported part.

Otherwise one small comment inline.  Ideally I'd like Peter to take a look at this
series as well as he is a lot more familiar with the driver than I am.

Peter, shout if you are snowed under and don't have time!

Jonathan
> 
> Signed-off-by: Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
> Cc: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>
> ---
>  drivers/iio/temperature/mlx90614.c | 78 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 68 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> index d5b41fd..0b36746 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -60,6 +60,7 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
>  			    int *val2, long mask)
>  {
>  	struct mlx90614_data *data = iio_priv(indio_dev);
> +	u8 cmd;
>  	s32 ret;
>  
>  	switch (mask) {
> @@ -67,20 +68,28 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_PROCESSED:
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
> +
>  		switch (mask) {
>  		case IIO_CHAN_INFO_RAW:
>  			*val = ret;
> @@ -121,6 +130,28 @@ static const struct iio_chan_spec mlx90614_channels[] = {
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>  		    BIT(IIO_CHAN_INFO_SCALE),
>  	},
> +	{
> +		.type = IIO_TEMP,
> +		.indexed = 1,
> +		.modified = 1,
> +		.channel = 1,
> +		.channel2 = IIO_MOD_TEMP_AMBIENT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +		    BIT(IIO_CHAN_INFO_PROCESSED),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> +		    BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +	{
> +		.type = IIO_TEMP,
> +		.indexed = 1,
> +		.modified = 1,
> +		.channel = 1,
> +		.channel2 = IIO_MOD_TEMP_OBJECT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +		    BIT(IIO_CHAN_INFO_PROCESSED),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> +		    BIT(IIO_CHAN_INFO_SCALE),
> +	},
>  };
>  
>  static const struct iio_info mlx90614_info = {
> @@ -128,11 +159,25 @@ static const struct iio_info mlx90614_info = {
>  	.driver_module = THIS_MODULE,
>  };
>  
> +/* Return 0 for single sensor, 1 for dual sensor, <0 on error. */
> +static int mlx90614_probe_model(struct i2c_client *client)
I'd give this a more specific name.  probe_num_ir_sensors or similar.

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
> @@ -150,8 +195,21 @@ static int mlx90614_probe(struct i2c_client *client,
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &mlx90614_info;
>  
> -	indio_dev->channels = mlx90614_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(mlx90614_channels);
> +	ret = mlx90614_probe_model(client);
> +	switch (ret) {
> +	case 0:
> +		dev_dbg(&client->dev, "Found single sensor");
> +		indio_dev->channels = mlx90614_channels;
> +		indio_dev->num_channels = 2;
> +		break;
> +	case 1:
> +		dev_dbg(&client->dev, "Found dual sensor");
> +		indio_dev->channels = mlx90614_channels;
> +		indio_dev->num_channels = 4;
> +		break;
> +	default:
> +		return ret;
> +	}
>  
>  	return iio_device_register(indio_dev);
>  }
> 

