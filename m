Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51274 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbaECKcx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 May 2014 06:32:53 -0400
Message-ID: <5364C633.6060800@kernel.org>
Date: Sat, 03 May 2014 11:34:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: Add Freescale MPL115A2 pressure / temperature
 sensor driver
References: <1399046294-6731-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1399046294-6731-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/05/14 16:58, Peter Meerwald wrote:
> I2C-controlled sensor with 10-bit pressure and temperature measurement
>
> datasheet: http://cache.freescale.com/files/sensors/doc/data_sheet/MPL3115A2.pdf
>
> v2:
> * use devm_iio_device_register()
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Nice driver.

Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>   drivers/iio/pressure/Kconfig  |  10 ++
>   drivers/iio/pressure/Makefile |   1 +
>   drivers/iio/pressure/mpl115.c | 211 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 222 insertions(+)
>   create mode 100644 drivers/iio/pressure/mpl115.c
>
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index d88ff17..ffac8ac 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -19,6 +19,16 @@ config HID_SENSOR_PRESS
>             To compile this driver as a module, choose M here: the module
>             will be called hid-sensor-press.
>
> +config MPL115
> +	tristate "Freescale MPL115A2 pressure sensor driver"
> +	depends on I2C
> +	help
> +	  Say yes here to build support for the Freescale MPL115A2
> +	  pressure sensor connected via I2C.
> +
> +          To compile this driver as a module, choose M here: the module
> +          will be called mpl115.
> +
>   config MPL3115
>   	tristate "Freescale MPL3115A2 pressure sensor driver"
>   	depends on I2C
> diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
> index 4a57bf6..c53d250 100644
> --- a/drivers/iio/pressure/Makefile
> +++ b/drivers/iio/pressure/Makefile
> @@ -4,6 +4,7 @@
>
>   # When adding new entries keep the list in alphabetical order
>   obj-$(CONFIG_HID_SENSOR_PRESS)   += hid-sensor-press.o
> +obj-$(CONFIG_MPL115) += mpl115.o
>   obj-$(CONFIG_MPL3115) += mpl3115.o
>   obj-$(CONFIG_IIO_ST_PRESS) += st_pressure.o
>   st_pressure-y := st_pressure_core.o
> diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
> new file mode 100644
> index 0000000..f5ecd6e
> --- /dev/null
> +++ b/drivers/iio/pressure/mpl115.c
> @@ -0,0 +1,211 @@
> +/*
> + * mpl115.c - Support for Freescale MPL115A2 pressure/temperature sensor
> + *
> + * Copyright (c) 2014 Peter Meerwald <pmeerw@pmeerw.net>
> + *
> + * This file is subject to the terms and conditions of version 2 of
> + * the GNU General Public License.  See the file COPYING in the main
> + * directory of this archive for more details.
> + *
> + * (7-bit I2C slave address 0x60)
> + *
> + * TODO: shutdown pin
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/delay.h>
> +
> +#define MPL115_PADC 0x00 /* pressure ADC output value, MSB first, 10 bit */
> +#define MPL115_TADC 0x02 /* temperature ADC output value, MSB first, 10 bit */
> +#define MPL115_A0 0x04 /* 12 bit integer, 3 bit fraction */
> +#define MPL115_B1 0x06 /* 2 bit integer, 13 bit fraction */
> +#define MPL115_B2 0x08 /* 1 bit integer, 14 bit fraction */
> +#define MPL115_C12 0x0a /* 0 bit integer, 13 bit fraction */
> +#define MPL115_CONVERT 0x12 /* convert temperature and pressure */
> +
> +struct mpl115_data {
> +	struct i2c_client *client;
> +	struct mutex lock;
> +	s16 a0;
> +	s16 b1, b2;
> +	s16 c12;
> +};
> +
> +static int mpl115_request(struct mpl115_data *data)
> +{
> +	int ret = i2c_smbus_write_byte_data(data->client, MPL115_CONVERT, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	usleep_range(3000, 4000);
> +
> +	return 0;
> +}
> +
> +static int mpl115_comp_pressure(struct mpl115_data *data, int *val, int *val2)
> +{
> +	int ret;
> +	u16 padc, tadc;
> +	int a1, y1, pcomp;
> +	unsigned kpa;
> +
> +	mutex_lock(&data->lock);
> +	ret = mpl115_request(data);
> +	if (ret < 0)
> +		goto done;
> +
> +	ret = i2c_smbus_read_word_swapped(data->client, MPL115_PADC);
> +	if (ret < 0)
> +		goto done;
> +	padc = ret >> 6;
> +
> +	ret = i2c_smbus_read_word_swapped(data->client, MPL115_TADC);
> +	if (ret < 0)
> +		goto done;
> +	tadc = ret >> 6;
> +
> +	/* see Freescale AN3785 */
> +	a1 = data->b1 + ((data->c12 * tadc) >> 11);
> +	y1 = (data->a0 << 10) + a1 * padc;
> +
> +	/* compensated pressure with 4 fractional bits */
> +	pcomp = (y1 + ((data->b2 * (int) tadc) >> 1)) >> 9;
> +
> +	kpa = pcomp * (115 - 50) / 1023 + (50 << 4);
> +	*val = kpa >> 4;
> +	*val2 = (kpa & 15) * (1000000 >> 4);
> +done:
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
> +static int mpl115_read_temp(struct mpl115_data *data)
> +{
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	ret = mpl115_request(data);
> +	if (ret < 0)
> +		goto done;
> +	ret = i2c_smbus_read_word_swapped(data->client, MPL115_TADC);
> +done:
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
> +static int mpl115_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct mpl115_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret = mpl115_comp_pressure(data, val, val2);
> +		if (ret < 0)
> +			return ret;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_RAW:
> +		/* temperature -5.35 C / LSB, 472 LSB is 25 C */
> +		ret = mpl115_read_temp(data);
> +		if (ret < 0)
> +			return ret;
> +		*val = ret >> 6;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = 605;
> +		*val2 = 750000;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = -186;
> +		*val2 = 915888;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +	return -EINVAL;
> +}
> +
> +static const struct iio_chan_spec mpl115_channels[] = {
> +	{
> +		.type = IIO_PRESSURE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +	},
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +			BIT(IIO_CHAN_INFO_OFFSET) | BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +};
> +
> +static const struct iio_info mpl115_info = {
> +	.read_raw = &mpl115_read_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static int mpl115_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct mpl115_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
> +		return -ENODEV;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +	mutex_init(&data->lock);
> +
> +	i2c_set_clientdata(client, indio_dev);
> +	indio_dev->info = &mpl115_info;
> +	indio_dev->name = id->name;
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = mpl115_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(mpl115_channels);
> +
> +	ret = i2c_smbus_read_word_swapped(data->client, MPL115_A0);
> +	if (ret < 0)
> +		return ret;
> +	data->a0 = ret;
> +	ret = i2c_smbus_read_word_swapped(data->client, MPL115_B1);
> +	if (ret < 0)
> +		return ret;
> +	data->b1 = ret;
> +	ret = i2c_smbus_read_word_swapped(data->client, MPL115_B2);
> +	if (ret < 0)
> +		return ret;
> +	data->b2 = ret;
> +	ret = i2c_smbus_read_word_swapped(data->client, MPL115_C12);
> +	if (ret < 0)
> +		return ret;
> +	data->c12 = ret;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id mpl115_id[] = {
> +	{ "mpl115", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, mpl115_id);
> +
> +static struct i2c_driver mpl115_driver = {
> +	.driver = {
> +		.name	= "mpl115",
> +	},
> +	.probe = mpl115_probe,
> +	.id_table = mpl115_id,
> +};
> +module_i2c_driver(mpl115_driver);
> +
> +MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
> +MODULE_DESCRIPTION("Freescale MPL115 pressure/temperature driver");
> +MODULE_LICENSE("GPL");
>

