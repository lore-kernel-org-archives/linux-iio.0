Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbeJMV3C (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Oct 2018 17:29:02 -0400
Date: Sat, 13 Oct 2018 14:51:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matt Weber <matthew.weber@rockwellcollins.com>
Cc: linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
Subject: Re: [PATCH v2 1/2] iio:temperature: Add MAX31856 thermocouple
 support
Message-ID: <20181013145143.16530539@archlinux>
In-Reply-To: <1539275890-38141-1-git-send-email-matthew.weber@rockwellcollins.com>
References: <1539275890-38141-1-git-send-email-matthew.weber@rockwellcollins.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 11 Oct 2018 11:38:09 -0500
Matt Weber <matthew.weber@rockwellcollins.com> wrote:

> From: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
> 
> This patch adds support for Maxim MAX31856 thermocouple
> temperature sensor support.
> 
> More information can be found in:
> https://www.maximintegrated.com/en/ds/MAX31856.pdf
> 
> NOTE: Driver support only Comparator Mode.
> 
> Signed-off-by: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
> Signed-off-by: Matt Weber <matthew.weber@rockwellcollins.com>

Hi Matt,

As others have commented, looking pretty nice.  A few minor
comments and suggestions inline.

Thanks,

Jonathan
> ---
> Changes v1 -> v2
> [Peter
> 	1. Fixed all space & 'return' related comments
> 	2. Removed 'sysfs_create_group' api  because
> 	   iio_device_register function is handling sysfs entry
> 	3. Return -EIO if there is any fault
> 	4. Added check for 'read_size' before spi read call
> 	5. Removed license text from the source file
> 	6. Added .o file in alphabetic order
> 	7. Used #defines instead of magic bits
> 
> ---
>  MAINTAINERS                        |   5 +
>  drivers/iio/temperature/Kconfig    |  10 +
>  drivers/iio/temperature/Makefile   |   1 +
>  drivers/iio/temperature/max31856.c | 372 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 388 insertions(+)
>  create mode 100644 drivers/iio/temperature/max31856.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f642044..dd9a83d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7157,6 +7157,11 @@ F:	drivers/staging/iio/
>  F:	include/linux/iio/
>  F:	tools/iio/
>  
> +MAX31856 IIO DRIVER
> +M:	Matthew Weber <matthew.weber@rockwellcollins.com>
> +S:	Maintained
> +F:	drivers/iio/temperature/max31856.c
> +
>  IIO UNIT CONVERTER
>  M:	Peter Rosin <peda@axentia.se>
>  L:	linux-iio@vger.kernel.org
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> index 82e4a62..c66eeb2 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -97,4 +97,14 @@ config TSYS02D
>  	  This driver can also be built as a module. If so, the module will
>  	  be called tsys02d.
>  
> +config MAX31856
> +	tristate "MAX31856 thermocouple sensor"
> +	depends on SPI
> +	help
> +	  If you say yes here you get support for MAX31856
> +	  thermocouple sensor chip connected via SPI.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called max31856.
> +
>  endmenu
> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
> index 34a31db..baca477 100644
> --- a/drivers/iio/temperature/Makefile
> +++ b/drivers/iio/temperature/Makefile
> @@ -5,6 +5,7 @@
>  
>  obj-$(CONFIG_HID_SENSOR_TEMP) += hid-sensor-temperature.o
>  obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
> +obj-$(CONFIG_MAX31856) += max31856.o
>  obj-$(CONFIG_MLX90614) += mlx90614.o
>  obj-$(CONFIG_MLX90632) += mlx90632.o
>  obj-$(CONFIG_TMP006) += tmp006.o
> diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
> new file mode 100644
> index 0000000..b66ddb0
> --- /dev/null
> +++ b/drivers/iio/temperature/max31856.c
> @@ -0,0 +1,372 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* max31856.c
> + *
> + * Maxim MAX31856 thermocouple sensor driver
> + *
> + * Copyright (C) 2018 Rockwell Collins
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/spi/spi.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define MAX31856_READ_MODE	   0x7F
> +#define MAX31856_WRITE_MODE	   0x80
> +#define MAX31856_CR0_AUTOCONVERT   0x80
> +#define MAX31856_CR0_1SHOT         0x40
> +#define MAX31856_CR0_OCFAULT1      0x20
> +#define MAX31856_CR0_OCFAULT0      0x10
> +#define MAX31856_FAULT_OVUV        0x02
> +#define MAX31856_FAULT_OPEN        0x01
> +
> +/* The MAX31856 registers */
> +#define MAX31856_CR0_REG           0x00
> +#define MAX31856_CR1_REG           0x01
> +#define MAX31856_MASK_REG          0x02
> +#define MAX31856_CJHF_REG          0x03
> +#define MAX31856_CJLF_REG          0x04
> +#define MAX31856_LTHFTH_REG        0x05
> +#define MAX31856_LTHFTL_REG        0x06
> +#define MAX31856_LTLFTH_REG        0x07
> +#define MAX31856_LTLFTL_REG        0x08
> +#define MAX31856_CJTO_REG          0x09
> +#define MAX31856_CJTH_REG          0x0A
> +#define MAX31856_CJTL_REG          0x0B
> +#define MAX31856_LTCBH_REG         0x0C
> +#define MAX31856_LTCBM_REG         0x0D
> +#define MAX31856_LTCBL_REG         0x0E
> +#define MAX31856_SR_REG            0x0F
> +
> +static const struct iio_chan_spec max31856_channels[] = {
> +	{	/* Thermocouple Temperature */
> +		.type = IIO_TEMP,
> +		.address = 2,
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +	{	/* Cold Junction Temperature */
> +		.type = IIO_TEMP,
> +		.channel2 = IIO_MOD_TEMP_AMBIENT,
> +		.address = 0,
> +		.modified = 1,
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +};
> +
> +struct max31856_data {
> +	struct spi_device *spi;
> +	bool one_shot;
> +	u32 thermocouple_type;
> +	int fault_ovuv;
Mentioned below but these should be booleans to make it implicit that they
are only true or false.
> +	int fault_oc;
> +	u8 buf[3] ____cacheline_aligned;
> +};
> +
> +static int max31856_read(struct max31856_data *data, unsigned int reg,
> +			 s32 *val, int read_size)

I think we would be better off having this function deal with val
as a byte array (so a set of register values) and move the endian
conversion that is in here to the calling locations.  I think that would
be somewhat less confusing than doing in here.

I don't think you do any 2 byte reads for example yet we support
in here as it would look odd otherwise.  Move that to the calling locations
and there will only be support if it is needed in future.

> +{
> +	int ret;
> +	u8 *buf = data->buf;
> +
> +	/* Make sure top bit is not set,
/*
 * Make...

> +	 * The MSB(A7) of this byte determines whether the following byte will
> +	 * be written or read. If A7 is 0, one or more byte reads will follow
> +	 * the address byte
> +	 */
> +
> +	reg &= MAX31856_READ_MODE;
This feels a little to paranoid as the only way that top bit can be set is
(I think) a bug.

> +
> +	buf[0] = reg;
> +	buf[1] = 0x00;
> +	buf[2] = 0x00;
> +
> +	if (read_size > 3) {
> +		pr_err("error: Unsupported read_size = %d by %s\n",
> +			read_size,  __func__);
> +		return -EINVAL;
> +	}
> +
> +	ret = spi_write_then_read(data->spi, buf, 1, buf, read_size);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (read_size) {
> +	case 1:
> +		*val = buf[0];
> +		return 0;
> +	case 2:
> +		*val = (buf[0] << 8) | buf[1];
> +		return 0;
Endian conversion function preferred (sometimes there is nothing to do!)

> +	case 3:
> +		*val = (buf[0] << 16) | (buf[1] << 8) | buf[2];
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int max31856_write(struct max31856_data *data, unsigned int reg,
> +			  unsigned int val)
> +{
> +	u8 *buf = data->buf;
> +
> +	/* Make sure top bit is set,
> +	 * The MSB(A7) of this byte determines whether the following byte will
> +	 * be written or read. If A7 is 1, one or more byte writes will follow
> +	 * the address byte
> +	 */
> +
> +	reg |= MAX31856_WRITE_MODE;
> +
> +	buf[0] = reg;
I would roll the two lines above into one.  Separating them doesn't add anything
to readability to my mind.

> +	buf[1] = val;
> +
> +	return spi_write(data->spi, buf, 2);
> +}
> +
> +static int max31856_init(struct max31856_data *data)
> +{
> +	int ret = 0;
Already commented on by others I think... no need to assign.
> +	s32 reg_val;
> +
> +	/* Enable Open circuit fault detection [01]
> +	 * Read datasheet for more information: Table 4.
> +	 * BITS [5:4]    | Fault Test
> +	 * ---------------------------
> +	 *	00    | Disabled
> +	 * ---------------------------
> +	 *	01    | Enabled (Once every 16 seconds)
> +	 * ---------------------------
> +	 *	10    | Enabled (Once every 16 seconds)
> +	 * ---------------------------
> +	 *	11    | Enabled (Once every 16 seconds)
> +	 */
> +	ret = max31856_read(data, MAX31856_CR0_REG, &reg_val, 1);
> +	if (ret)
> +		return ret;
> +	reg_val &= ~MAX31856_CR0_OCFAULT1;
> +	reg_val |= MAX31856_CR0_OCFAULT0;
This is perhaps not the clearest way of doing this.

I would mask and then set to the two bit value.

> +	ret = max31856_write(data, MAX31856_CR0_REG, reg_val);
> +	if (ret)
> +		return ret;
> +
> +	/* Set thermocouple type based on dts property */
> +	ret = max31856_read(data, MAX31856_CR1_REG, &reg_val, 1);
> +	if (ret)
> +		return ret;
> +
> +	reg_val &= 0x00F0;
Preferred if masks etc are handled via a define.  Also use GENMASK
to make it easy to read which bits are being masked.  I think
this is also an 8 bit value.  Better to handle it as such and
treat that mask as a negated form of the the mask for the bit
we are setting rather than being the 'other bits'.

> +	reg_val |= (data->thermocouple_type & 0x0F);
Can we get here with a value that needs masking?  Doing this made
me wonder whether it was a straight forward bit of code so I'd
rather not see the mask if it's not needed.

> +	ret = max31856_write(data, MAX31856_CR1_REG, reg_val);
> +	if (ret)
> +		return ret;
> +
> +	/* Set Conversion Mode (Auto or Oneshot) based on dts property */
> +	ret = max31856_read(data, MAX31856_CR0_REG, &reg_val, 1);
> +	if (ret)
> +		return ret;
> +	if (data->one_shot) {
> +		reg_val &= ~MAX31856_CR0_AUTOCONVERT;
> +		reg_val |= MAX31856_CR0_1SHOT;
> +	} else {
> +		reg_val |= MAX31856_CR0_AUTOCONVERT;
> +		reg_val &= ~MAX31856_CR0_1SHOT;

I mention below that I don't understand why this is coming from dt.
(or for that matter why you pick one option over the other).
> +	}
> +
> +	return max31856_write(data, MAX31856_CR0_REG, reg_val);
> +}
> +
> +static int max31856_thermocouple_read(struct max31856_data *data,
> +				      struct iio_chan_spec const *chan,
> +				      int *val)
> +{
> +	int ret = 0, temp, offset_cjto;
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_TEMP_AMBIENT:
> +		/* Read register from 0x09-0x0B */
This comment is probably not needed.  The nice use of defines provide
all the info we need.
> +		ret = max31856_read(data, MAX31856_CJTO_REG, val, 3);
I would use a local variable here, perhaps even a simple byte array
given we are really looking at 3 separate registers.  I'm fairly
sure we are not handling endianess correctly here.

> +		/* Get Cold Junction Temp. offset register value */
> +		offset_cjto = *val >> 16;
> +		/* Mask last 2 bytes to get CJTH and CJTL reg. value */
> +		*val &= 0x0000FFFF;
> +		temp = *val;
> +		/* last 2 bits unused in CJTL reg*/
> +		*val >>= 2;

Would have been slightly nicer to mask these out as we are shifting them away.

> +		/* As per datasheet add offset into CJTH and CJTL */
> +		*val += offset_cjto;
> +		/* Check 15th bit for sign */
> +		if (temp & 0x8000)
> +			*val -= 0x4000;
> +		break;
> +	default:
This looks like a specific other channel. I'd rather see it labeled
as such with the relevant case entries.  
> +		ret = max31856_read(data, MAX31856_LTCBH_REG, val, 3);
> +		temp = *val;
> +		*val >>= 5;
> +		/* Check 23th bit for sign */
> +		if (temp & 0x800000)
> +			*val -= 0x80000;
> +	}
> +
> +	ret = max31856_read(data, MAX31856_SR_REG, &temp, 1);
> +	/* Check for over voltage/under voltage fault */
> +	data->fault_ovuv = (temp & MAX31856_FAULT_OVUV) ? 1 : 0;
These should be stored in booleans as that is what they are used
for.

> +	/* Check for open circuit fault */
> +	data->fault_oc = (temp & MAX31856_FAULT_OPEN) ? 1 : 0;
> +	if (data->fault_oc || data->fault_ovuv)
> +		return -EIO;
> +
> +	return ret;
> +}
> +
> +static int max31856_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct max31856_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = max31856_thermocouple_read(data, chan, val);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->channel2) {
> +		case IIO_MOD_TEMP_AMBIENT:
> +			/* Cold junction Temp. Data resolution is 0.015625 */
> +			*val = 15;
> +			*val2 = 625000; /* 1000 * 0.015625 */
> +			ret = IIO_VAL_INT_PLUS_MICRO;
> +			break;
> +		default:
> +			/* Thermocouple Temp. Data resolution is 0.0078125 */
> +			*val = 7;
> +			*val2 = 812500; /* 1000 * 0.0078125) */
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		}
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static ssize_t show_fault_ovuv(struct device *dev,
> +			       struct device_attribute *attr,
> +			       char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct max31856_data *data = iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%d\n", data->fault_ovuv);
> +}
> +
> +static ssize_t show_fault_oc(struct device *dev,
> +			     struct device_attribute *attr,
> +			     char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct max31856_data *data = iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%d\n", data->fault_oc);
> +}
> +
> +static IIO_DEVICE_ATTR(fault_ovuv, 0444, show_fault_ovuv, NULL, 0);
> +static IIO_DEVICE_ATTR(fault_oc, 0444, show_fault_oc, NULL, 0);

Please provide documentation for this new ABI (at least I don't remember
seeing it before!)

Documentaiton/ABI/testing/sysfs-bus-iio-*

We'll be back to the usual issue that embedded platforms tend not to
do any unified sort of RAS and there isn't a good way to report a wiring
failure..

So these are nasty device specific interfaces, but they may be the best
we can do :(

> +
> +static struct attribute *max31856_attributes[] = {
> +	&iio_dev_attr_fault_ovuv.dev_attr.attr,
> +	&iio_dev_attr_fault_oc.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group max31856_group = {
> +	.attrs = max31856_attributes,
> +};
> +
> +static const struct iio_info max31856_info = {
> +	.driver_module = THIS_MODULE,
> +	.read_raw = max31856_read_raw,
> +	.attrs = &max31856_group,
> +};
> +
> +static int max31856_probe(struct spi_device *spi)
> +{
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +	struct iio_dev *indio_dev;
> +	struct max31856_data *data;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->spi = spi;
> +
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	indio_dev->info = &max31856_info;
> +	indio_dev->name = id->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = max31856_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(max31856_channels);
> +
> +	data->one_shot = of_property_read_bool(spi->dev.of_node, "one-shot");

This does not look to me like something that should be controlled in devicetree.
Normally we'd switch between oneshot and continuous modes based on some sort
of rule such as whether we are doing buffered reads vs polled ones, or perhaps
switch to oneshot if there hasn't been a reading taken for a 'while'.
(a form of runtime power management).

> +
> +	ret = of_property_read_u32(spi->dev.of_node, "type",
> +				   &data->thermocouple_type);
> +
> +	if (ret) {
> +		pr_info("Could not read thermocouple type DT property, Configuring as a K-Type\n");
> +		data->thermocouple_type = 0x03; /* K-Type */
> +	}
> +
> +	ret = max31856_init(data);
> +	if (ret) {
> +		pr_err("error: Failed to configure max31856\n");
> +		return ret;
> +	}
> +
> +	ret = iio_device_register(indio_dev);
> +
> +	data->fault_ovuv = 0;
> +	data->fault_oc = 0;
This is interesting.   The call to iio_device_register
is the point at which the device is exposed to userspace and
any in kernel consumers.  Having anything set 'after' that
point is almost always a race condition.

Is there a strong reason these can't be done before the iio_device_register?
If there is, we should definitely be seeing a comment saying why.

> +
> +	return ret;
> +}
> +
> +static int max31856_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +

> +	iio_device_unregister(indio_dev);
If this is the only thing we need to do in remove, then
we should be safe to call
devm_iio_device_register and let the managed unwinding
deal with it.  That will let us drop the remove function
entirely.


> +
> +	return 0;
> +}
> +
> +static const struct spi_device_id max31856_id[] = {
> +	{ "max31856", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, max31856_id);
> +
> +static struct spi_driver max31856_driver = {
> +	.driver = {
> +		.name = "max31856",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = max31856_probe,
> +	.remove = max31856_remove,
> +	.id_table = max31856_id,
> +};
> +module_spi_driver(max31856_driver);
> +
> +MODULE_AUTHOR("Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>");
> +MODULE_DESCRIPTION("Maxim MAX31856 thermocouple sensor driver");
> +MODULE_LICENSE("GPL");
