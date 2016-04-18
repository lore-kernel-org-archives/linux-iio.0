Return-Path: <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 18 Apr 2016 14:52:58 +0100
From: jic23@jic23.retrosnub.co.uk
To: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 linux-iio-owner@vger.kernel.org
Subject: RE: [PATCH 1/2] iio: temperature: Add support for AM2315
In-Reply-To: <4586F61A4A291F4DA44D32824E7C0F4023587F34@IRSMSX109.ger.corp.intel.com>
References: <1460734568-6306-1-git-send-email-tiberiu.a.breana@intel.com>
 <1460734568-6306-2-git-send-email-tiberiu.a.breana@intel.com>
 <57121974.80103@kernel.org>
 <4586F61A4A291F4DA44D32824E7C0F4023587F34@IRSMSX109.ger.corp.intel.com>
Message-ID: <a985a9957318023184762e2fd546421e@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>

On 18.04.2016 10:40, Breana, Tiberiu A wrote:
>> -----Original Message-----
>> From: Jonathan Cameron [mailto:jic23@kernel.org]
>> Sent: Saturday, April 16, 2016 1:53 PM
>> To: Breana, Tiberiu A <tiberiu.a.breana@intel.com>; linux-
>> iio@vger.kernel.org
>> Subject: Re: [PATCH 1/2] iio: temperature: Add support for AM2315
>> 
>> On 15/04/16 16:36, Tiberiu Breana wrote:
>> > Add basic support for the Aosong AM2315 ambient temperature and
>> > humidity sensor.
>> > Includes support for raw readings and ACPI detection.
>> >
>> > Datasheet:
>> > http://www.aosong.com/asp_bin/Products/en/AM2315.pdf
>> >
>> > Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
>> I think I'd prefer this in drivers/iio/humidty/.  If people just want 
>> a
>> temperature sensor they'll not use the much more complex device needed
>> to measure humidity, whereas to measure humidity you have to know what
>> the temperature is.  Hence I'd argue that here the humidity side of 
>> the
>> device in the primary one.
>> 'Interestingly' temperature and humidity seems to sound better to me 
>> in
>> English than humidity and temperature... hohum.
>> 
>> I suppose we could roll these two directories together if people think 
>> that is
>> sensible?
> 
> Sounds logical. I'll move it to iio/humidity.
> 
>> 
>> Various little bits inline..
>> 
>> Jonathan
>> > ---
>> >  drivers/iio/temperature/Kconfig  |  10 ++
>> >  drivers/iio/temperature/Makefile |   1 +
>> >  drivers/iio/temperature/am2315.c | 216
>> > +++++++++++++++++++++++++++++++++++++++
>> >  3 files changed, 227 insertions(+)
>> >  create mode 100644 drivers/iio/temperature/am2315.c
>> >
>> > diff --git a/drivers/iio/temperature/Kconfig
>> > b/drivers/iio/temperature/Kconfig index c4664e5..79e4409 100644
>> > --- a/drivers/iio/temperature/Kconfig
>> > +++ b/drivers/iio/temperature/Kconfig
>> > @@ -3,6 +3,16 @@
>> >  #
>> >  menu "Temperature sensors"
>> >
>> > +config AM2315
>> > +	tristate "Aosong AM2315 temperature and humidity sensor"
>> > +	depends on I2C
>> > +	help
>> > +	  If you say yes here you get support for the Aosong AM2315
>> > +	  ambient temperature and humidity sensor.
>> > +
>> > +	  This driver can also be built as a module. If so, the module will
>> > +	  be called am2315.
>> > +
>> >  config MLX90614
>> >  	tristate "MLX90614 contact-less infrared sensor"
>> >  	depends on I2C
>> > diff --git a/drivers/iio/temperature/Makefile
>> > b/drivers/iio/temperature/Makefile
>> > index 02bc79d..2e7521b 100644
>> > --- a/drivers/iio/temperature/Makefile
>> > +++ b/drivers/iio/temperature/Makefile
>> > @@ -2,6 +2,7 @@
>> >  # Makefile for industrial I/O temperature drivers  #
>> >
>> > +obj-$(CONFIG_AM2315) += am2315.o
>> >  obj-$(CONFIG_MLX90614) += mlx90614.o
>> >  obj-$(CONFIG_TMP006) += tmp006.o
>> >  obj-$(CONFIG_TSYS01) += tsys01.o
>> > diff --git a/drivers/iio/temperature/am2315.c
>> > b/drivers/iio/temperature/am2315.c
>> > new file mode 100644
>> > index 0000000..2642bae
>> > --- /dev/null
>> > +++ b/drivers/iio/temperature/am2315.c
>> > @@ -0,0 +1,216 @@
>> > +/**
>> > + * Aosong AM2315 ambient temperature & humidity sensor driver
>> > + *
>> > + * Copyright (c) 2016, Intel Corporation.
>> > + *
>> > + * This file is subject to the terms and conditions of version 2 of
>> > + * the GNU General Public License. See the file COPYING in the main
>> > + * directory of this archive for more details.
>> > + *
>> > + * 7-bit I2C address: 0x5C.
>> > + */
>> > +
>> > +#include <linux/acpi.h>
>> > +#include <linux/delay.h>
>> > +#include <linux/i2c.h>
>> > +#include <linux/kernel.h>
>> > +#include <linux/module.h>
>> > +#include <linux/iio/iio.h>
>> > +#include <linux/iio/sysfs.h>
>> > +
>> > +#define AM2315_REG_HUM_MSB			0x00
>> > +#define AM2315_REG_HUM_LSB			0x01
>> > +#define AM2315_REG_TEMP_MSB			0x02
>> > +#define AM2315_REG_TEMP_LSB			0x03
>> > +
>> > +#define AM2315_FUNCTION_READ			0x03
>> > +#define AM2315_HUM_OFFSET			0
>> > +#define AM2315_TEMP_OFFSET			2
>> > +
>> > +#define AM2315_DRIVER_NAME			"am2315"
>> > +
>> > +struct am2315_data {
>> > +	struct i2c_client *client;
>> > +};
>> > +
>> > +static const struct iio_chan_spec am2315_channels[] = {
>> > +	{
>> > +		.type = IIO_HUMIDITYRELATIVE,
>> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> > +				      BIT(IIO_CHAN_INFO_SCALE)
>> > +	},
>> > +	{
>> > +		.type = IIO_TEMP,
>> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> > +				      BIT(IIO_CHAN_INFO_SCALE)
>> > +	},
>> > +};
>> > +
>> > +/* CRC calculation algorithm, as specified in the datasheet (page
>> > +13). */ static u16 am2315_crc(u8 *data, u8 nr_bytes)
>> 
>> I think this 'might' be reverse CRC16-IBM according to wikipedia...
>> Which is obscure enough that it probably doesn't have a generic
>> implementation already in the kernel...
>> 
>> There is one other user of this polynomial that I can fine, not enough 
>> to
>> justify a common implementation at this point I guess.
>> 
>> Note that 16bit polynomials tend to get implemented as lookup tables 
>> if
>> generalized.  Speed isn't that important here though I guess.
> 
> Given the already slow nature of the device - see sleep time before 
> data
> retrieval, recommended 2s wait time before measurements, indeed,
> speed is not very important here.
> 
>> 
>> > +{
>> > +	int i;
>> > +	u16 crc = 0xffff;
>> > +
>> > +	while (nr_bytes--) {
>> > +		crc ^= *data++;
>> > +		for (i = 0; i < 8; i++) {
>> > +			if (crc & 0x01) {
>> > +				crc >>= 1;
>> > +				crc ^= 0xA001;
>> > +			} else {
>> > +				crc >>= 1;
>> > +			}
>> > +		}
>> > +	}
>> > +
>> > +	return crc;
>> > +}
>> > +
>> > +/* Simple function that sends a few bytes to the device to wake it
>> > +up. */
>> We always like novel hardware corners <groans>
>> > +static inline void am2315_ping(struct i2c_client *client) {
>> > +	i2c_smbus_read_byte_data(client, AM2315_REG_HUM_MSB); }
>> > +
>> > +static int am2315_read_data(struct i2c_client *client, u8 *rx_buf) {
>> > +	int ret;
>> > +	/* tx_buf format: <function code> <start addr> <nr of regs to read>
>> */
>> > +	u8 tx_buf[3] = { AM2315_FUNCTION_READ,
>> AM2315_REG_HUM_MSB, 4 };
>> > +	u16 crc;
>> > +
>> > +	/* First wake up the device. */
>> > +	am2315_ping(client);
>> > +
>> > +	ret = i2c_master_send(client, tx_buf, sizeof(tx_buf));
>> > +	if (ret < 0) {
>> > +		dev_err(&client->dev, "failed to send read request\n");
>> > +		return ret;
>> > +	}
>> > +	/* Wait 2-3 ms, then read back the data sent by the device. */
>> > +	usleep_range(2000, 3000);
>> > +
>> > +	ret = i2c_master_recv(client, rx_buf, sizeof(rx_buf));
>> > +	if (ret < 0) {
>> > +		dev_err(&client->dev, "failed to read sensor data\n");
>> > +		return ret;
>> > +	}
>> > +	/*
>> > +	 * Do a CRC check on the data and compare it to the value
>> > +	 * calculated by the device.
>> > +	 */
>> > +	crc = am2315_crc(rx_buf, sizeof(rx_buf) - 2);
>> > +	if ((crc & 0xff) != rx_buf[6] || (crc >> 8) != rx_buf[7]) {
>> > +		dev_err(&client->dev, "failed to verify sensor data\n");
>> > +		return -1;
>> Provide a more informative error code... -EIO maybe...
> 
> Will do this in v2.
> 
>> > +	}
>> > +
>> > +	return ret;
>> > +}
>> > +
>> > +static int am2315_read_raw(struct iio_dev *indio_dev,
>> > +			   struct iio_chan_spec const *chan,
>> > +			   int *val, int *val2, long mask) {
>> > +	int ret;
>> > +	s16 value;
>> > +	u8 rx_buf[8];
>> > +	u8 offset;
>> > +	struct am2315_data *data = iio_priv(indio_dev);
>> > +	struct i2c_client *client = data->client;
>> > +
>> > +	switch (mask) {
>> > +	case IIO_CHAN_INFO_RAW:
>> > +		offset = (chan->type == IIO_HUMIDITYRELATIVE) ?
>> > +				AM2315_HUM_OFFSET :
>> AM2315_TEMP_OFFSET;
>> > +		/* Do a bulk data read, then pick out what we need. */
>> > +		ret = am2315_read_data(client, rx_buf);
>> > +		if (ret < 0)
>> > +			return ret;
>> > +		/*
>> > +		 * rx_buf format:
>> > +		 * <function code> <number of registers read>
>> > +		 * <humidity MSB> <humidity LSB> <temp MSB> <temp LSB>
>> > +		 * <CRC LSB> <CRC MSB>
>> > +		 */
>> > +		value = (rx_buf[offset + 2] << 8) | rx_buf[offset + 3];
>> > +		*val = value / 10;
>> > +		*val2 = (value % 10) * 100000;
>> 
>> So for temperature this is outputing a value in degrees?  Give you are
>> outputting as raw, don't divide by 10 and just return IIO_VAL_INT;  
>> Leave the
>> maths to userspace.
> 
> Ok, will output raw values in v2.
> 
>> 
>> > +		return IIO_VAL_INT_PLUS_MICRO;
>> > +	case IIO_CHAN_INFO_SCALE:
>> > +		*val = 0;
>> > +		*val2 = 100000;
>> For temp to be presented in standard base units (milli degrees C) this 
>> should
>> be
>> *val2 = 1000 I think...
>> 
>> Same for humidity - obviously this will change if you don't do the 
>> divide by
>> 10 in the raw read out.
> 
> Actually if we're aiming for milli units, the scale should be 100.
Yeah, I was getting of these wrong yesterday for some reason!

Jonathan
> 
>> 
>> 
>> > +		return IIO_VAL_INT_PLUS_MICRO;
>> > +	}
>> > +
>> > +	return -EINVAL;
>> > +}
>> > +
>> > +static const struct iio_info am2315_info = {
>> > +	.driver_module		= THIS_MODULE,
>> > +	.read_raw		= am2315_read_raw,
>> > +};
>> > +
>> > +static int am2315_probe(struct i2c_client *client,
>> > +			const struct i2c_device_id *id)
>> > +{
>> > +	struct iio_dev *indio_dev;
>> > +	struct am2315_data *data;
>> > +
>> > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>> > +	if (!indio_dev) {
>> > +		dev_err(&client->dev, "iio allocation failed!\n");
>> > +		return -ENOMEM;
>> > +	}
>> > +
>> > +	data = iio_priv(indio_dev);
>> > +	data->client = client;
>> > +	i2c_set_clientdata(client, indio_dev);
>> > +
>> > +	indio_dev->dev.parent = &client->dev;
>> > +	indio_dev->info = &am2315_info;
>> > +	indio_dev->name = AM2315_DRIVER_NAME;
>> > +	indio_dev->modes = INDIO_DIRECT_MODE;
>> > +	indio_dev->channels = am2315_channels;
>> > +	indio_dev->num_channels = ARRAY_SIZE(am2315_channels);
>> > +
>> > +	return iio_device_register(indio_dev); }
>> > +
>> > +static int am2315_remove(struct i2c_client *client) {
>> > +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>> > +
>> 
>> If all you have in remove is the iio_device_unregister, you are safe 
>> to use
>> devm_iio_device_unregister in probe and drop the remove entirely. 
>> (It's
>> relatively rare that there is nothing to do in remove, but it is to 
>> simiplify that
>> rare case that we have the devm_iio_device_register
>> call)
> 
> I initially used the devm variant, but to reduce patch 2 diff, I've
> decided to add
> the .remove function here and in v2 just add a
> iio_triggered_buffer_cleanup call.
> If you don't agree with this, I can change it.
That's fine as is.
> 
>> > +	iio_device_unregister(indio_dev);
>> > +
>> > +	return 0;
>> > +}
>> > +
>> > +static const struct i2c_device_id am2315_i2c_id[] = {
>> > +	{"am2315", 0},
>> > +	{}
>> > +};
>> > +
>> > +static const struct acpi_device_id am2315_acpi_id[] = {
>> > +	{"AOS2315", 0},
>> > +	{}
>> > +};
>> > +
>> > +MODULE_DEVICE_TABLE(acpi, am2315_acpi_id);
>> > +
>> > +static struct i2c_driver am2315_driver = {
>> > +	.driver = {
>> > +		.name = "am2315",
>> > +		.acpi_match_table = ACPI_PTR(am2315_acpi_id),
>> > +	},
>> > +	.probe =            am2315_probe,
>> > +	.remove =	    am2315_remove,
>> > +	.id_table =         am2315_i2c_id,
>> > +};
>> > +
>> > +module_i2c_driver(am2315_driver);
>> > +
>> > +MODULE_AUTHOR("Tiberiu Breana <tiberiu.a.breana@intel.com>");
>> > +MODULE_DESCRIPTION("Aosong AM2315 ambient temperature &
>> humidity
>> > +sensor driver"); MODULE_LICENSE("GPL v2");
>> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
