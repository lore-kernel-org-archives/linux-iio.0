Return-Path: <SRS0=1ODW=YY=pmeerw.net=pmeerw@kernel.org>
Date: Tue, 10 Jan 2017 16:58:51 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Andreas Klinger <ak@it-klinger.de>
cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: distance: srf08: add IIO driver for us ranger
In-Reply-To: <20170110152804.GA29272@andreas>
Message-ID: <alpine.DEB.2.02.1701101635500.3234@pmeerw.net>
References: <20170110152804.GA29272@andreas>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> This is the IIO driver for devantech srf08 ultrasonic ranger which can be
> used to measure the distances to an object.
> 
> The sensor supports I2C with some registers.

comments below
 
> Supported Features include:
> - read the distance in ranging mode in centimeters
> - output of the driver is directly the read value
> - together with the scale the driver delivers the distance in meters
> - only the first echo of the nearest object is delivered
> - set max gain register; userspace enters analogue value
> - set range registers; userspace enters range in millimeters in 43 mm steps
> 
> Features not supported by this driver:
> - ranging mode in inches or in microseconds
> - ANN mode
> - change I2C address through this driver
> - light sensor
> 
> The driver was added in the directory "proximity" of the iio subsystem
> in absence of another directory named "distance".
> There is also a new submenu "distance"
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  drivers/iio/proximity/Kconfig  |  15 ++
>  drivers/iio/proximity/Makefile |   1 +
>  drivers/iio/proximity/srf08.c  | 345 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 361 insertions(+)
>  create mode 100644 drivers/iio/proximity/srf08.c
> 
> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index ef4c73db5b53..7b10a137702b 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
> @@ -46,3 +46,18 @@ config SX9500
>  	  module will be called sx9500.
>  
>  endmenu
> +
> +menu "Distance sensors"
> +
> +config SRF08
> +	tristate "Devantech SRF08 ultrasonic ranger sensor"
> +	depends on I2C
> +	help
> +	  Say Y here to build a driver for Devantech SRF08 ultrasonic
> +	  ranger sensor. This driver can be used to measure the distance
> +	  of objects.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called srf08.
> +
> +endmenu
> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
> index 9aadd9a8ee99..14d8fe4e5cae 100644
> --- a/drivers/iio/proximity/Makefile
> +++ b/drivers/iio/proximity/Makefile
> @@ -6,3 +6,4 @@
>  obj-$(CONFIG_AS3935)		+= as3935.o
>  obj-$(CONFIG_LIDAR_LITE_V2)	+= pulsedlight-lidar-lite-v2.o
>  obj-$(CONFIG_SX9500)		+= sx9500.o
> +obj-$(CONFIG_SRF08)		+= srf08.o

alphabethic order please

> diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
> new file mode 100644
> index 000000000000..a888a230b419
> --- /dev/null
> +++ b/drivers/iio/proximity/srf08.c
> @@ -0,0 +1,345 @@
> +/*
> + * srf08.c - Support for Devantech SRF08 ultrasonic ranger
> + *
> + * Copyright (c) 2016 Andreas Klinger <ak@it-klinger.de>
> + *
> + * This file is subject to the terms and conditions of version 2 of
> + * the GNU General Public License.  See the file COPYING in the main
> + * directory of this archive for more details.
> + *
> + * For details about the device see:
> + * http://www.robot-electronics.co.uk/htm/srf08tech.html
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/bitops.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +/* registers of SRF08 device */
> +#define SRF08_WRITE_COMMAND	0x00	/* Command Register */
> +#define SRF08_WRITE_MAX_GAIN	0x01	/* Max Gain Register: 0 .. 31 */
> +#define SRF08_WRITE_RANGE	0x02	/* Range Register: 0 .. 255 */
> +#define SRF08_READ_SW_REVISION	0x00	/* Software Revision */
> +#define SRF08_READ_LIGHT	0x01	/* Light Sensor during last echo */
> +#define SRF08_READ_ECHO_1_HIGH	0x02	/* range of first echo received */

Range (uppercase for consistency)

> +#define SRF08_READ_ECHO_1_LOW	0x03	/* range of first echo received */
> +
> +#define SRF08_CMD_RANGING_CM	0x51	/* Ranging Mode - Result in cm */
> +
> +struct srf08_data {
> +	struct i2c_client	*client;
> +	int			gain;			/* max gain */
> +	int			range_mm;		/* range in mm */
> +	struct mutex		lock;
> +};
> +
> +static const int srf08_gain[] = {
> +	 94,  97, 100, 103, 107, 110, 114, 118,
> +	123, 128, 133, 139, 145, 152, 159, 168,
> +	177, 187, 199, 212, 227, 245, 265, 288,
> +	317, 352, 395, 450, 524, 626, 777, 1025 };
> +
> +static int srf08_read_ranging(struct srf08_data *data)
> +{
> +	struct i2c_client *client = data->client;
> +	char cmd[2];

u8 or unsigned char would be cleaner, we are dealing with unsigned values
or int/s32 even, see below

> +	int ret, i;
> +
> +	mutex_lock(&data->lock);
> +
> +	ret = i2c_smbus_write_byte_data(data->client,
> +			SRF08_WRITE_COMMAND, SRF08_CMD_RANGING_CM);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "write command - err: %d\n", ret);
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +
> +	/*
> +	 * normally after 65 ms the device should have the read value
> +	 * we round it up to 100 ms
> +	 */
> +	for (i = 0; i < 5; i++) {
> +

delete newline

> +		ret = i2c_smbus_read_byte_data(data->client,
> +						SRF08_READ_SW_REVISION);

is reading the version really used to poll for data valid?
maybe add a comment so the astute reader can lower the eyebrows

> +
> +		/* check if a valid version number is read */
> +		if ((ret < 255) && (ret > 0))

parenthesis not needed (matter of taste)

> +			break;
> +		msleep(20);
> +	}
> +
> +	if ((ret >= 255) || (ret <= 0)) {
> +		dev_err(&client->dev, "device not ready\n");
> +		mutex_unlock(&data->lock);
> +		return -EIO;
> +	}
> +
> +	memset(cmd, 0, sizeof(cmd));
> +
> +	for (i = 0; i < 2; i++) {
> +		ret = i2c_smbus_read_byte_data(data->client,
> +						SRF08_READ_ECHO_1_HIGH + i);

can _read_word_swapped() be used?
ret is not checked for error

> +		cmd[i] = ret;
> +	}
> +
> +	mutex_unlock(&data->lock);
> +

endianness conversion can be avoided using _read_word_swapped()

> +	return (cmd[0] << 8 | cmd[1]);
> +}
> +
> +static int srf08_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *channel, int *val,
> +			    int *val2, long mask)
> +{
> +	struct srf08_data *data = iio_priv(indio_dev);
> +	s32 ret;

why s32 here? srf08_read_ranging() returns int

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:

if (channel->type != IIO_DISTANCE)
   return -EINVAL;

> +		if (channel->type == IIO_DISTANCE) {
> +			ret = srf08_read_ranging(data);

error check of ret missing

> +			*val = ret;
> +		} else {
> +			break;


> +		}
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (channel->type == IIO_DISTANCE) {

same pattern as above; maybe use switch if you are going to add more 
channel types

> +			/* 1 LSB is 1 cm */
> +			*val = 0;
> +			*val2 = 10000;
> +		} else {
> +			break;
> +		}
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		break;

return -EINVAL directly

> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static ssize_t srf08_show_range_mm_available(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	int i, len = 0;
> +
> +	for (i = 0; i < 256; i++)
> +		len += sprintf(buf + len, "%d ", (i + 1) * 43);

many drivers use
len += scnprintf(buf + len, PAGE_SIZE - len, ...

> +
> +	len += sprintf(buf + len, "\n");

buf[len-1]="\n"; as most drivers do?

> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(range_mm_available, S_IRUGO,
> +				srf08_show_range_mm_available, NULL, 0);
> +
> +static ssize_t srf08_show_range_mm(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct srf08_data *data = iio_priv(indio_dev);
> +	int len;
> +
> +	len = sprintf(buf, "%d\n", data->range_mm);

simply return sprintf(...)

> +
> +	return len;
> +}
> +
> +static ssize_t srf08_write_range_mm(struct device *dev,

it's not immediately clear what this is for?

> +					struct device_attribute *attr,
> +					const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct srf08_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	int ret, val;
> +	int regval = -1;

no need to initialize
regval should be u8?

> +	int mod;
> +
> +	ret = kstrtoint(buf, 10, &val);

kstrtouint()?

> +	if (ret)
> +		return ret;
> +
> +	regval = val / 43 - 1;
> +	mod = val % 43;
> +
> +	if (mod || (regval < 0) || (regval > 255))
> +		return -EINVAL;
> +
> +	mutex_lock(&data->lock);
> +
> +	ret = i2c_smbus_write_byte_data(data->client,
> +						SRF08_WRITE_RANGE, regval);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "write_range - err: %d\n", ret);
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +
> +	data->range_mm = val;
> +
> +	mutex_unlock(&data->lock);
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(range_mm, S_IRUGO | S_IWUSR,
> +			srf08_show_range_mm, srf08_write_range_mm, 0);
> +
> +static ssize_t srf08_show_gain_available(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	int i, len = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(srf08_gain); i++)
> +		len += sprintf(buf + len, "%d ", srf08_gain[i]);
> +
> +	len += sprintf(buf + len, "\n");
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(gain_available, S_IRUGO,
> +				srf08_show_gain_available, NULL, 0);
> +
> +static ssize_t srf08_show_gain(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct srf08_data *data = iio_priv(indio_dev);
> +	int len;
> +
> +	len = sprintf(buf, "%d\n", data->gain);
> +
> +	return len;
> +}
> +
> +static ssize_t srf08_write_gain(struct device *dev,
> +						struct device_attribute *attr,
> +						const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct srf08_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	int ret, val, i;
> +	int regval = -1;

u8, no init

> +
> +	ret = kstrtoint(buf, 10, &val);

kstrtouint()

> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(srf08_gain); i++)
> +		if (val == srf08_gain[i])
> +			regval = i;
> +

maybe check i >= ARRAY_SIZE instead of abusing regval

> +	if (regval == -1)
> +		return -EINVAL;
> +
> +	mutex_lock(&data->lock);
> +
> +	ret = i2c_smbus_write_byte_data(data->client,
> +						SRF08_WRITE_MAX_GAIN, regval);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "write_gain - err: %d\n", ret);
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +
> +	data->gain = val;
> +
> +	mutex_unlock(&data->lock);
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(gain, S_IRUGO | S_IWUSR,
> +					srf08_show_gain, srf08_write_gain, 0);
> +
> +static struct attribute *srf08_attributes[] = {
> +	&iio_dev_attr_range_mm.dev_attr.attr,
> +	&iio_dev_attr_range_mm_available.dev_attr.attr,
> +	&iio_dev_attr_gain.dev_attr.attr,
> +	&iio_dev_attr_gain_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group srf08_attribute_group = {
> +	.attrs = srf08_attributes,
> +};
> +
> +static const struct iio_chan_spec srf08_channels[] = {
> +	{
> +		.type = IIO_DISTANCE,
> +		.info_mask_separate =
> +				BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +};
> +
> +static const struct iio_info srf08_info = {
> +	.read_raw = srf08_read_raw,
> +	.attrs = &srf08_attribute_group,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static int srf08_probe(struct i2c_client *client,
> +					 const struct i2c_device_id *id)
> +{
> +	struct iio_dev *indio_dev;
> +	struct srf08_data *data;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +					I2C_FUNC_SMBUS_READ_BYTE_DATA |
> +					I2C_FUNC_SMBUS_WRITE_BYTE_DATA))


WORD_DATA if using word_swapped() above

> +		return -ENODEV;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	/* set default values of device */
> +	data->gain = 1025;

use some defines, where do these magics come from?

> +	data->range_mm = 11008;
> +
> +	indio_dev->name = dev_name(&client->dev);
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &srf08_info;
> +	indio_dev->channels = srf08_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(srf08_channels);
> +
> +	mutex_init(&data->lock);
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id srf08_id[] = {
> +	{ "srf08", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, srf08_id);
> +
> +static struct i2c_driver srf08_driver = {
> +	.driver = {
> +		.name	= "srf08",
> +	},
> +	.probe = srf08_probe,
> +	.id_table = srf08_id,
> +};
> +module_i2c_driver(srf08_driver);
> +
> +MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
> +MODULE_DESCRIPTION("Devantech SRF08 ultrasonic ranger driver");
> +MODULE_LICENSE("GPL");
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
