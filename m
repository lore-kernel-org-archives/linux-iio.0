Return-Path: <lars@metafoo.de>
Message-ID: <53918706.4040006@metafoo.de>
Date: Fri, 06 Jun 2014 11:16:54 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: AK09911 : 3 axis compass support
References: <1401996824-24032-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1401996824-24032-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1401996824-24032-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 06/05/2014 09:33 PM, Srinivas Pandruvada wrote:
[...]

> +
> +#define AK09911_RAW_TO_GAUSS(asa)	((((asa) + 128) * 6000) / 256)

Instead of doing the conversion in kernel, how about specifing offset and 
scale attributes?

> +
'...]
> +static int ak09911_verify_chip_id(struct i2c_client *client)
> +{
> +	u8 wia_val[2];
> +	int ret;
> +
> +	ret = i2c_smbus_read_i2c_block_data(client, AK09911_REG_WIA1,
> +					    2, wia_val);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Error reading WIA\n");
> +		return ret;
> +	}
> +
> +	dev_dbg(&client->dev, "WIA %02x %02x\n", wia_val[0], wia_val[1]);
> +
> +	if (wia_val[0] != AK09911_WIA1_VALUE ||
> +					wia_val[1] != AK09911_WIA2_VALUE) {

strange alignment here

> +		dev_err(&client->dev, "Device ak09911 not found\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
[...]
> +static int ak09911_read_axis(struct iio_dev *indio_dev, int index, int *val)
> +{
> +	struct ak09911_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +
> +	ret = ak09911_set_mode(client, AK09911_MODE_SNG_MEASURE);
> +	if (ret < 0)
> +		goto fn_exit;
> +
> +	ret = wait_conversion_complete_polled(data);
> +	if (ret < 0)
> +		goto fn_exit;
> +
> +	/* Read data */
> +	ret = i2c_smbus_read_word_data(client, ak09911_index_to_reg[index]);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Read axis data fails\n");
> +		goto fn_exit;
> +	}
> +
> +	mutex_unlock(&data->lock);
> +
> +	/* Clamp to valid range. */
> +	*val  = clamp_t(s16, ret, -8192, 8191);

how about usign sign_extend32 here?


extra space between val and =

> +
> +	return IIO_VAL_INT;
> +
> +fn_exit:
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
> +
> +static int ak09911_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2,
> +			   long mask)
> +{
> +	struct ak09911_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return ak09911_read_axis(indio_dev, chan->address, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		*val2 = data->raw_to_gauss[chan->address];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +#define AK09911_CHANNEL(axis, index)					\
> +	{								\
> +		.type = IIO_MAGN,					\
> +		.modified = 1,						\
> +		.channel2 = IIO_MOD_##axis,				\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +			     BIT(IIO_CHAN_INFO_SCALE),			\
> +		.address = index,					\
> +	}
> +
> +static const struct iio_chan_spec ak09911_channels[] = {
> +	AK09911_CHANNEL(X, 0), AK09911_CHANNEL(Y, 1), AK09911_CHANNEL(Z, 2),
> +};
> +
> +static const struct iio_info ak09911_info = {
> +	.read_raw = &ak09911_read_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static const struct acpi_device_id ak_acpi_match[] = {
> +	{"AK009911", 0},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, ak_acpi_match);
> +
> +static int ak09911_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ak09911_data *data;
> +	char *name;
> +	int ret;
> +
> +	ret = ak09911_verify_chip_id(client);
> +	if (ret) {
> +		dev_err(&client->dev, "AK00911 not detected\n");
> +		return -ENODEV;
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (indio_dev == NULL)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	data->client = client;
> +	mutex_init(&data->lock);
> +
> +	ret = ak09911_get_asa(client);
> +	if (ret)
> +		return ret;
> +
> +	if (id)
> +		name = (char *) id->name;
> +	else if (ACPI_HANDLE(&client->dev))
> +		name = (char *)dev_name(&client->dev);

Don't cast the const of the string away. Rather make your name const char *

> +	else
> +		return -ENODEV;
> +
> +	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->channels = ak09911_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ak09911_channels);
> +	indio_dev->info = &ak09911_info;
> +	indio_dev->name = id->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->name = name;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
[...]
