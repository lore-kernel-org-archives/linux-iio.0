Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH] iio: accel: Add driver for dmard10 3-axis Accelerometer
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20160912074409.8089-1-hdegoede@redhat.com>
 <alpine.DEB.2.02.1609120953300.21869@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <28a10da8-8f83-af10-29b1-3986a04d84ff@redhat.com>
Date: Mon, 12 Sep 2016 10:12:45 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1609120953300.21869@pmeerw.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi,

On 12-09-16 10:03, Peter Meerwald-Stadler wrote:
>
>> Add a driver for the Domintech ARD10 3-axis Accelerometer, based on the
>> android driver found here: https://github.com/domintech/dmard10
>
> needs some cleanup

Ok.

<snip>

>> +/* Init sequence taken from the android driver */
>> +static int dmard10_reset(struct i2c_client *client)
>> +{
>> +	unsigned char buffer[7];
>> +	int ret;
>> +
>> +	/* 1. Powerdown reset */
>> +	buffer[0] = REG_PD;
>> +	buffer[1] = VALUE_PD_RST;
>> +	ret = i2c_master_send(client, buffer, 2);
>
> can't we just use i2c_smbus_write_byte_data()?
>
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/*
>> +	 * 2. ACTR => Standby mode => Download OTP to parameter reg =>
>> +	 *    Standby mode => Reset data path => Standby mode
>> +	 */
>> +	buffer[0] = REG_ACTR;
>> +	buffer[1] = MODE_Standby;
>> +	buffer[2] = MODE_ReadOTP;
>> +	buffer[3] = MODE_Standby;
>> +	buffer[4] = MODE_ResetDataPath;
>> +	buffer[5] = MODE_Standby;
>> +	ret = i2c_master_send(client, buffer, 6);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* 3. OSCA_EN = 1 ,TSTO = b'000(INT1 = normal, TEST0 = normal) */
>
> comments could use some typographic love (space after comma not before,
> space after pharenthesis)
>
>> +	buffer[0] = REG_MISC2;
>> +	buffer[1] = VALUE_MISC2_OSCA_EN;
>> +	ret = i2c_master_send(client, buffer, 2);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* 4. AFEN = 1(AFE will powerdown after ADC) */
>> +	buffer[0] = REG_AFEM;
>> +	buffer[1] = VALUE_AFEM_AFEN_Normal;
>> +	buffer[2] = VALUE_CKSEL_ODR_100_204;
>> +	buffer[3] = VALUE_INTC;
>> +	buffer[4] = VALUE_TAPNS_Ave_2;
>> +	buffer[5] = 0x00; /* DLYC, no delay timing */
>> +	buffer[6] = 0x07; /* INTD=1 push-pull, INTA=1 active high, AUTOT=1 */
>> +	ret = i2c_master_send(client, buffer, 7);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* 5. Activation mode */
>> +	buffer[0] = REG_ACTR;
>> +	buffer[1] = MODE_Active;
>> +	ret = i2c_master_send(client, buffer, 2);
>> +	if (ret < 0)
>> +		return ret;
>
> just return

I would prefer not to, that will make the diff
for adding an other step to the reset sequence
a bit messy, more importantly, there is a clear
structure / flow to this function and your suggested
change would break that.

I agree with all your other comments, and I'll do
a v2 fixing them.

Regards,

Hans



>
>> +
>> +	return 0;
>> +}
>> +
>> +/* Shutdown sequence taken from the android driver */
>> +static int dmard10_shutdown(struct i2c_client *client)
>> +{
>> +	unsigned char buffer[7];
>
> buffer too big
>
>> +
>> +	buffer[0] = REG_ACTR;
>> +	buffer[1] = MODE_Standby;
>> +	buffer[2] = MODE_Off;
>> +
>> +	return i2c_master_send(client, buffer, 3);
>> +}
>> +
>> +static int dmard10_read_raw(struct iio_dev *indio_dev,
>> +				struct iio_chan_spec const *chan,
>> +				int *val, int *val2, long mask)
>> +{
>> +	struct dmard10_data *data = iio_priv(indio_dev);
>> +	unsigned char buf[8];
>
> __le16 buf[4]
>
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		/*
>> +		 * Read 8 bytes starting at the REG_STADR register, trying to
>> +		 * read the individual X, Y, Z registers will always read 0.
>> +		 */
>> +		ret = i2c_smbus_read_i2c_block_data(data->client, REG_STADR,
>> +						    8, buf);
>
> sizeof(buf)
>
>> +		if (ret < 0)
>> +			return ret;
>> +		ret = get_unaligned_le16(&buf[chan->address]);
>> +		*val = sign_extend32(ret, 12);
>> +		return IIO_VAL_INT;
>> +	case IIO_CHAN_INFO_SCALE:
>> +		*val = 0;
>> +		*val2 = dmard10_nscale;
>> +		return IIO_VAL_INT_PLUS_NANO;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static const struct iio_info dmard10_info = {
>> +	.driver_module	= THIS_MODULE,
>> +	.read_raw	= dmard10_read_raw,
>> +	.attrs		= &dmard10_attribute_group,
>> +};
>> +
>> +static int dmard10_probe(struct i2c_client *client,
>> +			const struct i2c_device_id *id)
>> +{
>> +	int ret;
>> +	struct iio_dev *indio_dev;
>> +	struct dmard10_data *data;
>> +
>> +	/* These 2 registers have special POR reset values used for id */
>> +	ret = i2c_smbus_read_byte_data(client, REG_STADR);
>> +	if (ret != VALUE_STADR)
>> +		return (ret < 0) ? ret : -ENODEV;
>> +
>> +	ret = i2c_smbus_read_byte_data(client, REG_STAINT);
>> +	if (ret != VALUE_STAINT)
>> +		return (ret < 0) ? ret : -ENODEV;
>> +
>> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>> +	if (!indio_dev) {
>> +		dev_err(&client->dev, "iio allocation failed!\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	data = iio_priv(indio_dev);
>> +	data->client = client;
>> +	i2c_set_clientdata(client, indio_dev);
>> +
>> +	indio_dev->dev.parent = &client->dev;
>> +	indio_dev->info = &dmard10_info;
>> +	indio_dev->name = "dmard10";
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->channels = dmard10_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(dmard10_channels);
>> +
>> +	ret = dmard10_reset(client);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = iio_device_register(indio_dev);
>> +	if (ret < 0) {
>> +		dev_err(&client->dev, "device_register failed\n");
>> +		dmard10_shutdown(client);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int dmard10_remove(struct i2c_client *client)
>> +{
>> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>> +
>> +	iio_device_unregister(indio_dev);
>> +
>> +	return dmard10_shutdown(client);
>> +}
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int dmard10_suspend(struct device *dev)
>> +{
>> +	return dmard10_shutdown(to_i2c_client(dev));
>> +}
>> +
>> +static int dmard10_resume(struct device *dev)
>> +{
>> +	return dmard10_reset(to_i2c_client(dev));
>> +}
>> +#endif
>> +
>> +static SIMPLE_DEV_PM_OPS(dmard10_pm_ops, dmard10_suspend, dmard10_resume);
>> +
>> +static const struct i2c_device_id dmard10_i2c_id[] = {
>> +	{"dmard10", 0},
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(i2c, dmard10_i2c_id);
>> +
>> +static struct i2c_driver dmard10_driver = {
>> +	.driver = {
>> +		.name = "dmard10",
>> +		.pm = &dmard10_pm_ops,
>> +	},
>> +	.probe		= dmard10_probe,
>> +	.remove		= dmard10_remove,
>> +	.id_table	= dmard10_i2c_id,
>> +};
>> +
>> +module_i2c_driver(dmard10_driver);
>> +
>> +MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
>> +MODULE_DESCRIPTION("Domintech ARD10 3-Axis Accelerometer driver");
>> +MODULE_LICENSE("GPL v2");
>>
>
