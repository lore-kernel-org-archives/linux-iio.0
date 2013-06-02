Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48650 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891Ab3FBPmC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jun 2013 11:42:02 -0400
Message-ID: <51AB67C5.3000207@kernel.org>
Date: Sun, 02 Jun 2013 16:41:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org,
	Jon Brenner - TAOS <jbrenner@taosinc.com>
Subject: Re: [PATCH] iio: add tsl45315 als driver
References: <1370122842-27056-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1370122842-27056-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/01/2013 10:40 PM, Peter Meerwald wrote:
> Add driver for the TAOS 4531x family of I2C ambient light sensors; the chip 
> outputs a 16-bit lux value.
> 
> RFCs:
> (1) naming: tsl45315 or tsl4531x or tsl4531? I just happend to have/test the 45315
tsl45315 (first product supported).  I always argue against wild cards unless there
is a fairly strong guarantee that another incompatible part won't have a number covered
by the wild card (i.e. if all possible options already exist ;)

> (2) tsl45315_id is not really used, the variants just have different i2c addresses 
> and i2c voltages; drop?
Yes.
> (3) integration_time: driver uses tsl45315_ext_info to set/get the interation time
> in_illuminance_integration_time (0 .. 400ms, 1 .. 200ms, 2 .. 100ms) which affects
> in_illuminance_scale (1x, 2x, 4x) in order to produce lux when multiplied with
> in_illuminance_raw; ok? better way to represent?
Hmm.. If it doesn't effect anything else, I'd probably drop integration_time
and just have it controlled by in_illuminance_scale.  From a userspace point of
view, I doubt any application will care about the difference. Anyone else have
any thoughts on this?  This is far from the first device with controllable integration
times, but I guess we have just fudged around it so far?

Incindentally it is refereshing to not have to deal with horrible non linear
conversions in a light sensor :)  Nice clean driver btw. Only bit
I'd pick you up on is that you didn't add documentation for the integration_time
attribute but as you were asking whether to do it that way we can let that go ;)

Have cc'd Jon as he is usually responsive on drivers for TAOS parts when he
is not snowed under.

Jonathan
> 
> ---
>  drivers/iio/light/Kconfig    |  10 ++
>  drivers/iio/light/Makefile   |   1 +
>  drivers/iio/light/tsl45315.c | 263 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 274 insertions(+)
>  create mode 100644 drivers/iio/light/tsl45315.c
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 5ef1a39..c1dfd57 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -42,6 +42,16 @@ config SENSORS_TSL2563
>  	 This driver can also be built as a module.  If so, the module
>  	 will be called tsl2563.
>  
> +config TSL45315
> +	tristate "TAOS TSL45311, TSL45313, TSL45315, TSL45317 ambient light sensors"
> +	depends on I2C
> +	help
> +	 Say Y here if you want to build a driver for the TAOS TSL4531x family
> +	 of ambient light sensors with direct lux output.
> +
> +	 To compile this driver as a module, choose M here: the
> +	 module will be called tsl45315.
> +
>  config VCNL4000
>  	tristate "VCNL4000 combined ALS and proximity sensor"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index 040d9c7..333c292 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -5,5 +5,6 @@
>  obj-$(CONFIG_ADJD_S311)		+= adjd_s311.o
>  obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
>  obj-$(CONFIG_SENSORS_TSL2563)	+= tsl2563.o
> +obj-$(CONFIG_TSL45315)		+= tsl45315.o
>  obj-$(CONFIG_VCNL4000)		+= vcnl4000.o
>  obj-$(CONFIG_HID_SENSOR_ALS)	+= hid-sensor-als.o
> diff --git a/drivers/iio/light/tsl45315.c b/drivers/iio/light/tsl45315.c
> new file mode 100644
> index 0000000..41c173d
> --- /dev/null
> +++ b/drivers/iio/light/tsl45315.c
> @@ -0,0 +1,263 @@
> +/*
> + * tsl45315.c - Support for TAOS TSL45315 ambient light sensor
> + *
> + * Copyright 2013 Peter Meerwald <pmeerw@pmeerw.net>
> + *
> + * This file is subject to the terms and conditions of version 2 of
> + * the GNU General Public License.  See the file COPYING in the main
> + * directory of this archive for more details.
> + *
> + * IIO driver for the TSL4531x family
> + *   TSL45311/TSL45313: 7-bit I2C slave address 0x39
> + *   TSL45315/TSL45317: 7-bit I2C slave address 0x29
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/err.h>
> +#include <linux/delay.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define TSL45315_DRV_NAME "tsl45315"
> +
> +#define TSL45315_CONTROL 0x80
> +#define TSL45315_CONFIG 0x81
> +#define TSL45315_DATALOW 0x84
> +#define TSL45315_DATAHIGH 0x85
> +#define TSL45315_ID 0x8a
> +
> +#define TSL45315_MODE_POWERDOWN 0x00
> +#define TSL45315_MODE_SINGLE_ADC 0x02
> +#define TSL45315_MODE_NORMAL 0x03
> +
> +struct tsl45315_data {
> +	struct i2c_client *client;
> +	int int_time; /* 0 .. 400ms, 1 .. 200ms, 2 .. 100ms */
> +};
> +
> +static const struct i2c_device_id tsl45315_id[] = {
> +	{ "tsl45311", 0 },
> +	{ "tsl45313", 1 },
> +	{ "tsl45315", 2 },
> +	{ "tsl45317", 3 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, tsl45315_id);
> +
> +static int tsl45315_measure(struct tsl45315_data *data, int *val)
> +{
> +	u16 buf;
> +	int ret;
> +
> +	ret = i2c_smbus_read_i2c_block_data(data->client,
> +		TSL45315_DATALOW, sizeof(buf), (u8 *) &buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = le16_to_cpu(buf);
> +
> +	return 0;
> +}
> +
> +static ssize_t tsl45315_read_int_time(struct iio_dev *indio_dev,
> +	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
> +{
> +	struct tsl45315_data *data = iio_priv(indio_dev);
> +	s32 ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, TSL45315_CONFIG);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n", ret & 0x03);
> +}
> +
> +static ssize_t tsl45315_write_int_time(struct iio_dev *indio_dev,
> +	 uintptr_t private, const struct iio_chan_spec *chan, const char *buf,
> +	 size_t len)
> +{
> +	struct tsl45315_data *data = iio_priv(indio_dev);
> +	unsigned long int_time;
> +	int ret;
> +
> +	ret = kstrtoul(buf, 10, &int_time);
> +	if (ret)
> +		return ret;
> +
> +	if (int_time > 2)
> +		return -EINVAL;
> +
> +	ret = i2c_smbus_write_byte_data(data->client,
> +		TSL45315_CONFIG, int_time);
> +	if (ret < 0)
> +		return ret;
> +
> +	data->int_time = int_time;
> +
> +	return len;
> +}
> +
> +static const struct iio_chan_spec_ext_info tsl45315_ext_info[] = {
> +	{
> +		.name = "integration_time",
> +		.read = tsl45315_read_int_time,
> +		.write = tsl45315_write_int_time,
> +	},
> +	{ }
> +};
> +
> +static const struct iio_chan_spec tsl45315_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.ext_info = tsl45315_ext_info,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE)
> +	}
> +};
> +
> +static int tsl45315_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	int ret = -EINVAL;
> +	struct tsl45315_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			ret = tsl45315_measure(data, val);
> +			if (ret < 0)
> +				return ret;
> +			ret = IIO_VAL_INT;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_LIGHT) {
> +			/* 0.. 1x, 1 .. 2x, 2 .. 4x */
> +			*val = 1 << data->int_time; 
> +			ret = IIO_VAL_INT;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct iio_info tsl45315_info = {
> +	.read_raw = tsl45315_read_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static int tsl45315_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	struct tsl45315_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = iio_device_alloc(sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, TSL45315_ID);
> +	if (ret < 0)
> +		goto error_free_dev;
> +
> +	dev_info(&client->dev, "TSL4531x Ambient light sensor, Id %02x\n",
> +		ret >> 4);
> +
> +	ret = i2c_smbus_write_byte_data(data->client, TSL45315_CONTROL,
> +		TSL45315_MODE_NORMAL);
> +	if (ret < 0)
> +		goto error_free_dev;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, TSL45315_CONFIG, 0);
> +	if (ret < 0)
> +		goto error_free_dev;
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->info = &tsl45315_info;
> +	indio_dev->channels = tsl45315_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(tsl45315_channels);
> +	indio_dev->name = TSL45315_DRV_NAME;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0)
> +		goto error_free_dev;
> +
> +	return 0;
> +
> +error_free_dev:
> +	iio_device_free(indio_dev);
> +	return ret;
> +}
> +
> +static int tsl45315_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +	iio_device_unregister(indio_dev);
> +	iio_device_free(indio_dev);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int tsl45315_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct tsl45315_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, TSL45315_CONTROL,
> +		TSL45315_MODE_POWERDOWN);
> +
> +	return ret;
> +}
> +
> +static int tsl45315_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, TSL45315_CONTROL,
> +		TSL45315_MODE_NORMAL);
> +
> +	return ret;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(tsl45315_pm_ops, tsl45315_suspend, tsl45315_resume);
> +#define TSL45315_PM_OPS (&tsl45315_pm_ops)
> +#else
> +#define TSL45315_PM_OPS NULL
> +#endif
> +
> +static struct i2c_driver tsl45315_driver = {
> +	.driver = {
> +		.name   = TSL45315_DRV_NAME,
> +		.pm	= TSL45315_PM_OPS,
> +		.owner  = THIS_MODULE,
> +	},
> +	.probe  = tsl45315_probe,
> +	.remove = tsl45315_remove,
> +	.id_table = tsl45315_id,
> +};
> +
> +module_i2c_driver(tsl45315_driver);
> +
> +MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
> +MODULE_DESCRIPTION("TAOS TSL45315 ambient light sensor driver");
> +MODULE_LICENSE("GPL");
> 
