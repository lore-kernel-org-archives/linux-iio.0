Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41952 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754105AbcH2QtO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2016 12:49:14 -0400
Subject: Re: [PATCH v2 2/4] iio: chemical: vz89x: add support for VZ89TE part
To: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
References: <1472107490-11924-1-git-send-email-mranostay@gmail.com>
 <1472107490-11924-3-git-send-email-mranostay@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f5e0492f-ba2a-87e7-76ff-3c5a237ea55a@kernel.org>
Date: Mon, 29 Aug 2016 17:49:12 +0100
MIME-Version: 1.0
In-Reply-To: <1472107490-11924-3-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/08/16 07:44, Matt Ranostay wrote:
> Add support the VZ89TE variant which removes the voc_short channel,
> and has CRC check for data transactions.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
Minor comment inline.

Applied to the togreg branch of iio.git - initially pushed
out as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/chemical/vz89x.c | 113 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 98 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
> index aa6ebc084e19..289d2919deea 100644
> --- a/drivers/iio/chemical/vz89x.c
> +++ b/drivers/iio/chemical/vz89x.c
> @@ -34,8 +34,17 @@
>  #define VZ89X_VOC_TVOC_IDX		2
>  #define VZ89X_VOC_RESISTANCE_IDX	3
>  
> +#define VZ89TE_REG_MEASUREMENT		0x0c
> +#define VZ89TE_REG_MEASUREMENT_RD_SIZE	7
> +#define VZ89TE_REG_MEASUREMENT_WR_SIZE	6
> +
> +#define VZ89TE_VOC_TVOC_IDX		0
> +#define VZ89TE_VOC_CO2_IDX		1
> +#define VZ89TE_VOC_RESISTANCE_IDX	2
> +
>  enum {
>  	VZ89X,
> +	VZ89TE,
>  };
>  
>  struct vz89x_chip_data;
> @@ -47,7 +56,7 @@ struct vz89x_data {
>  	int (*xfer)(struct vz89x_data *data, u8 cmd);
>  
>  	unsigned long last_update;
> -	u8 buffer[VZ89X_REG_MEASUREMENT_RD_SIZE];
> +	u8 buffer[VZ89TE_REG_MEASUREMENT_RD_SIZE];
>  };
>  
>  struct vz89x_chip_data {
> @@ -90,6 +99,40 @@ static const struct iio_chan_spec vz89x_channels[] = {
>  		.info_mask_separate =
>  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>  		.address = VZ89X_VOC_RESISTANCE_IDX,
> +		.scan_index = -1,
> +		.scan_type = {
> +			.endianness = IIO_LE,
> +		},
> +	},
> +};
> +
> +static const struct iio_chan_spec vz89te_channels[] = {
> +	{
> +		.type = IIO_CONCENTRATION,
> +		.channel2 = IIO_MOD_VOC,
> +		.modified = 1,
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_OFFSET) | BIT(IIO_CHAN_INFO_RAW),
> +		.address = VZ89TE_VOC_TVOC_IDX,
> +	},
> +
> +	{
> +		.type = IIO_CONCENTRATION,
> +		.channel2 = IIO_MOD_CO2,
> +		.modified = 1,
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_OFFSET) | BIT(IIO_CHAN_INFO_RAW),
> +		.address = VZ89TE_VOC_CO2_IDX,
> +	},
> +	{
> +		.type = IIO_RESISTANCE,
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.address = VZ89TE_VOC_RESISTANCE_IDX,
> +		.scan_index = -1,
> +		.scan_type = {
> +			.endianness = IIO_BE,
> +		},
>  	},
>  };
>  
> @@ -121,13 +164,28 @@ static bool vz89x_measurement_is_valid(struct vz89x_data *data)
>  	return !!(data->buffer[data->chip->read_size - 1] > 0);
>  }
>  
> +/* VZ89TE device has a modified CRC-8 two complement check */
> +static bool vz89te_measurement_is_valid(struct vz89x_data *data)
> +{
> +	u8 crc = 0;
> +	int i, sum = 0;
> +
> +	for (i = 0; i < (data->chip->read_size - 1); i++) {
> +		sum = crc + data->buffer[i];
> +		crc = sum;
> +		crc += sum / 256;
> +	}
> +
> +	return !((0xff - crc) == data->buffer[data->chip->read_size - 1]);
> +}
> +
>  static int vz89x_i2c_xfer(struct vz89x_data *data, u8 cmd)
>  {
>  	const struct vz89x_chip_data *chip = data->chip;
>  	struct i2c_client *client = data->client;
>  	struct i2c_msg msg[2];
>  	int ret;
> -	u8 buf[3] = { cmd, 0, 0};
> +	u8 buf[6] = { cmd, 0, 0, 0, 0, 0xf3 };
>  
>  	msg[0].addr = client->addr;
>  	msg[0].flags = client->flags;
> @@ -186,11 +244,24 @@ static int vz89x_get_measurement(struct vz89x_data *data)
>  	return 0;
>  }
>  
> -static int vz89x_get_resistance_reading(struct vz89x_data *data)
> +static int vz89x_get_resistance_reading(struct vz89x_data *data,
> +					struct iio_chan_spec const *chan,
> +					int *val)
>  {
> -	u8 *buf = &data->buffer[VZ89X_VOC_RESISTANCE_IDX];
> +	u8 *tmp = (u8 *) &data->buffer[chan->address];
>  
> -	return buf[0] | (buf[1] << 8);
> +	switch (chan->scan_type.endianness) {
> +	case IIO_LE:
> +		*val = le32_to_cpup((__le32 *) tmp) & GENMASK(23, 0);
> +		break;
> +	case IIO_BE:
> +		*val = be32_to_cpup((__be32 *) tmp) >> 8;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
>  }
>  
>  static int vz89x_read_raw(struct iio_dev *indio_dev,
> @@ -209,15 +280,15 @@ static int vz89x_read_raw(struct iio_dev *indio_dev,
>  		if (ret)
>  			return ret;
>  
> -		switch (chan->address) {
> -		case VZ89X_VOC_CO2_IDX:
> -		case VZ89X_VOC_SHORT_IDX:
> -		case VZ89X_VOC_TVOC_IDX:
Hmm. This rework should probably have been in a separate 'pre' patch.
> +		switch (chan->type) {
> +		case IIO_CONCENTRATION:
>  			*val = data->buffer[chan->address];
>  			return IIO_VAL_INT;
> -		case VZ89X_VOC_RESISTANCE_IDX:
> -			*val = vz89x_get_resistance_reading(data);
> -			return IIO_VAL_INT;
> +		case IIO_RESISTANCE:
> +			ret = vz89x_get_resistance_reading(data, chan, val);
> +			if (!ret)
> +				return IIO_VAL_INT;
> +			break;
>  		default:
>  			return -EINVAL;
>  		}
> @@ -232,12 +303,12 @@ static int vz89x_read_raw(struct iio_dev *indio_dev,
>  		}
>  		break;
>  	case IIO_CHAN_INFO_OFFSET:
> -		switch (chan->address) {
> -		case VZ89X_VOC_CO2_IDX:
> +		switch (chan->channel2) {
> +		case IIO_MOD_CO2:
>  			*val = 44;
>  			*val2 = 250000;
>  			return IIO_VAL_INT_PLUS_MICRO;
> -		case VZ89X_VOC_TVOC_IDX:
> +		case IIO_MOD_VOC:
>  			*val = -13;
>  			return IIO_VAL_INT;
>  		default:
> @@ -265,10 +336,21 @@ static const struct vz89x_chip_data vz89x_chips[] = {
>  		.channels = vz89x_channels,
>  		.num_channels = ARRAY_SIZE(vz89x_channels),
>  	},
> +	{
> +		.valid = vz89te_measurement_is_valid,
> +
> +		.cmd = VZ89TE_REG_MEASUREMENT,
> +		.read_size = VZ89TE_REG_MEASUREMENT_RD_SIZE,
> +		.write_size = VZ89TE_REG_MEASUREMENT_WR_SIZE,
> +
> +		.channels = vz89te_channels,
> +		.num_channels = ARRAY_SIZE(vz89te_channels),
> +	},
>  };
>  
>  static const struct of_device_id vz89x_dt_ids[] = {
>  	{ .compatible = "sgx,vz89x", .data = (void *) VZ89X },
> +	{ .compatible = "sgx,vz89te", .data = (void *) VZ89TE },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, vz89x_dt_ids);
> @@ -319,6 +401,7 @@ static int vz89x_probe(struct i2c_client *client,
>  
>  static const struct i2c_device_id vz89x_id[] = {
>  	{ "vz89x", VZ89X },
> +	{ "vz89te", VZ89TE },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, vz89x_id);
> 

