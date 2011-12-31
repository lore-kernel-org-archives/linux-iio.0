Return-Path: <jic23@kernel.org>
Message-ID: <4EFF699B.1000802@kernel.org>
Date: Sat, 31 Dec 2011 19:59:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Pirmin Duss <pirmin.duss@flytec.ch>
CC: linux-iio@vger.kernel.org, lars-Peter Clausen <lars@metafoo.de>,
 "J . I . Cameron" <jic23@cam.ac.uk>
Subject: Re: [Patch v2.1] Adds support for the Texas Instruments ADS1110 adc.
References: <Prayer.1.3.4.1112230809290.970@hermes-2.csi.cam.ac.uk> <1324630944-3668-1-git-send-email-pirmin.duss@flytec.ch>
In-Reply-To: <1324630944-3668-1-git-send-email-pirmin.duss@flytec.ch>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 12/23/2011 09:02 AM, Pirmin Duss wrote:
> From: Pirmin Duss (Flytec) <pirmin.duss@flytec.ch>
> 
> Merged patches for review.
Thanks. It is the merged form that Greg will want rather than the
various steps.

Few minor points below. Coming together nicely.
Also note I'm rather anti boiler plate comments (the type
that tells you what is in the next section). As a 'maintainer'
I regularly do reorganization stuff that breaks them so would
rather they weren't there.  That's not to say I don't like
the organized code that results from using them. Keep that,
just not necessarily the comments!

Jonathan
> 
> Signed-off-by: Pirmin Duss (Flytec) <pirmin.duss@flytec.ch>
> ---
>  drivers/staging/iio/adc/Kconfig   |   10 +
>  drivers/staging/iio/adc/Makefile  |    1 +
>  drivers/staging/iio/adc/ads1110.c |  405 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 416 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/staging/iio/adc/ads1110.c
> 
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index d9decea..ab516dd 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
> @@ -145,6 +145,16 @@ config AD7192
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad7192.
>  
> +config ADS1110
> +	tristate "Texas Instruments ADS1110 Analog Digital Converter driver"
> +	depends on I2C
> +	help
> +		Say yes here to build support for Texas Instruments ads1110 ADC.
> +		Provides direct access via sysfs.
> +
> +		To compile this driver as a module, choose M here: the
> +		module will be called ads1110.
> +
>  config ADT7310
>  	tristate "Analog Devices ADT7310 temperature sensor driver"
>  	depends on SPI
> diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
> index ceee7f3..5551e03 100644
> --- a/drivers/staging/iio/adc/Makefile
> +++ b/drivers/staging/iio/adc/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_AD7780) += ad7780.o
>  obj-$(CONFIG_AD7793) += ad7793.o
>  obj-$(CONFIG_AD7816) += ad7816.o
>  obj-$(CONFIG_AD7192) += ad7192.o
> +obj-$(CONFIG_ADS1110) += ads1110.o
>  obj-$(CONFIG_ADT7310) += adt7310.o
>  obj-$(CONFIG_ADT7410) += adt7410.o
>  obj-$(CONFIG_AD7280) += ad7280a.o
> diff --git a/drivers/staging/iio/adc/ads1110.c b/drivers/staging/iio/adc/ads1110.c
> new file mode 100644
> index 0000000..9bb0d24
> --- /dev/null
> +++ b/drivers/staging/iio/adc/ads1110.c
> @@ -0,0 +1,405 @@
> +/*
> + * Driver for Texas Instruments ads1110 ADC.
> + *
> + * Datashhet con be found on: http://www.ti.com/lit/ds/symlink/ads1110.pdf
> + *
> + * Copyright 2011 Flytec AG.
> + *
> + * Licensed under the GPL-2 or later.
> + */
> +
> +#include <linux/interrupt.h>
Not spotted any interrupts here... (get rid of this header!)

> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/err.h>
> +
> +#include "../iio.h"
> +#include "../sysfs.h"
> +
> +/*
> + * ADS1110 definitions
> + */
> +
> +#define ADS1110_DATA_BYTES		2
> +#define ADS1110_CONFIG_BYTES		3
> +
> +#define ADS1110_CYC_MASK		0x0C
> +#define ADS1110_CYC_SHIFT		2
> +#define ADS1110_CYC_15			3
> +#define ADS1110_CYC_30			2
> +#define ADS1110_CYC_60			1
> +#define ADS1110_CYC_240			0
> +
As state below, this is a power of 2, so just do that
directly rather than bothering with defines and a lookup
table.
> +#define ADS1110_PGA_MASK		0x03
> +#define ADS1110_PGA_1			0
> +#define ADS1110_PGA_2			1
> +#define ADS1110_PGA_4			2
> +#define ADS1110_PGA_8			3
> +
> +/*
> + * struct ads1110_chip_info  - chip specifig information
> + */
> +
> +struct ads1110_chip_info {
> +	struct i2c_client	*client;
> +	u8 	config;
> +};
> +
> +static const unsigned int ads1110_frequencies[] = {
> +	[ADS1110_CYC_240] = 240,
> +	[ADS1110_CYC_60] = 60,
> +	[ADS1110_CYC_30] = 30,
> +	[ADS1110_CYC_15] = 15,
> +};
> +
Powers of 2... hmm. feels like the table can be trivialy removed.
If the index is val then...
1 << val will do the same as this table (with range check on val).
> +static const unsigned int ads1110_pga_table[] = {
> +	[ADS1110_PGA_1] = 1,
> +	[ADS1110_PGA_2] = 2,
> +	[ADS1110_PGA_4] = 4,
> +	[ADS1110_PGA_8] = 8,
> +};
> +
> +/*
> + * channel specifications
> + */
> +
> +static const struct iio_chan_spec ads1110_channels[] = {
> +	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0, 0, 0, 0,
> +		IIO_ST('s', 16, 16, 0), 0),
> +};
> +
> +/*
> + * cummunication functions for i2c
> + */
> +
> +static int ads1110_i2c_read_config(struct ads1110_chip_info *chip, u8 *data)
> +{
> +	struct i2c_client *client = chip->client;
Why bother with the pointer copy?  Just use chip->client directly in teh
i2c_master_recv
call.

> +	int ret = 0;
This next line looks rather long.... Have you run checkpatch on this
version?
> +	u8 tmp[ADS1110_CONFIG_BYTES];	/* read three bytes ; first two are data third is the config */
> +
> +	ret = i2c_master_recv(client, tmp, ADS1110_CONFIG_BYTES);
> +	if (ret < ADS1110_CONFIG_BYTES) {
> +		dev_err(&client->dev, "I2C read error\n");
> +		return ret;
> +	}
> +
> +	*data = tmp[2];
> +
> +	return ret;
> +}
> +
> +static int ads1110_i2c_read_data(struct ads1110_chip_info *chip, int *data)
> +{
Why bother with this copy of the client pointer?  Just use chip->client
directly
below. (Note this is a good wrapper function unlike the next one as it hides
some complexity that the rest of the code doesn't care about - endian
conversion).

> +	struct i2c_client *client = chip->client;
> +	int ret = 0;
> +	__be16 tmp;
> +
> +	ret = i2c_master_recv(client, (char *)&tmp, ADS1110_DATA_BYTES);
> +	if (ret < ADS1110_DATA_BYTES) {
> +		dev_err(&client->dev, "I2C read error\n");
> +		return ret;
> +	}
> +
> +	*data = be16_to_cpu(tmp);
> +
> +	return ret;
> +}
> +
> +static int ads1110_i2c_write_config(struct ads1110_chip_info *chip, u8 data)
> +{
> +	struct i2c_client *client = chip->client;
> +	int ret = 0;
Don't set this value.  Try building code with sparse and fix any
relevant warnings (coccicheck and smatch are also useful static
parsers).   If you don't do this Dan will almost instant pick up on
stuff and send you embarassing patches (sometimes he will do that
anyway but running these checks makes it slightly less likely) :)
> +
> +	ret = i2c_master_send(client, &data, 1);	/* there is only one register to write to. */
> +	if (ret < 0)
> +		dev_err(&client->dev, "I2C write error\n");
Whilst I state later that i2c bus flakiness is not unheard off, trivial
wrapper functions like this to just print and error message are a
waste of space.  Please roll all calls to this into the main code
as ret = i2c_master_send(chip->client, &data, 1);
> +
> +	return ret;
> +}
> +
> +/*
> + * setter- / getter functions for the sysfs nodes.
> + */
> +
> +static ssize_t ads1110_read_frequency(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ads1110_chip_info *st = iio_priv(indio_dev);
> +	u8 cfg;
> +
I would lock around st->config for consistency..
> +	cfg = ((st->config & ADS1110_CYC_MASK) >> ADS1110_CYC_SHIFT);
> +
> +	return sprintf(buf, "%d\n", ads1110_frequencies[cfg]);
> +}
> +
> +static ssize_t ads1110_write_frequency(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ads1110_chip_info *st = iio_priv(indio_dev);
> +	unsigned long lval;
> +	int ret, i;
> +	u8 *cfg = &st->config;
> +
> +	mutex_lock(&indio_dev->mlock);
> +	ret = kstrtoul(buf, 10, &lval);
> +	if (ret)
> +		goto out;
> +
> +	if ((lval < ads1110_frequencies[ADS1110_CYC_15]) || 
> +		(lval > ads1110_frequencies[ADS1110_CYC_240])) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(ads1110_frequencies); i++)
> +		if (lval == ads1110_frequencies[i])
> +			break;
> +
> +	if (i == ARRAY_SIZE(ads1110_frequencies)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	*cfg &= ~ADS1110_CYC_MASK;		/* erase old datarate */
> +	*cfg |= (i << ADS1110_CYC_SHIFT);
> +
Error handling for the next line?  Please make sure you handle
all i2c errors (pass on the code the bus calls returns). It's
not exactly unheard of to have a flakey i2c bus and we want to
know about it!
> +	ads1110_i2c_write_config(st, *cfg);
> +
> +out:
> +	mutex_unlock(&indio_dev->mlock);
> +	return ret ? ret : len;
> +}
> +
> +static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
> +		ads1110_read_frequency,
> +		ads1110_write_frequency);
> +
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("240 60 30 15");
> +
> +static ssize_t ads1110_show_gains(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	int i;
> +	int len = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(ads1110_pga_table; i++)
> +		len += sprintf(buf + len, "%d\n", ads1110_pga_table[i]);
format is

a b c \n rather than newline after each please.  (sorry - not sure that
one is documented).
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(scale_available,
> +		S_IRUGO,
> +		ads1110_show_gains, NULL, 0);
> +
> +static ssize_t ads1110_show_gain(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ads1110_chip_info *st = iio_priv(indio_dev);
> +	u8 cfg = st->config;
> +
> +	cfg = (cfg & ADS1110_PGA_MASK);
> +
> +	return sprintf(buf, "%d\n", ads1110_pga_table[cfg]);
> +}
> +
> +static ssize_t ads1110_store_gain(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ads1110_chip_info *st = iio_priv(indio_dev);
> +	unsigned long lval;
> +	u8 *cfg = &st->config;
This defining a local copy of the pointer is to my mind
a confusing distraction.  Although it adds a few characters
here and there I'd prefer to see st->config used throughout
as it makes for more reviewable code.
> +	int ret, i;
> +
> +	mutex_lock(&indio_dev->mlock);
> +	ret = kstrtoul(buf, 10, &lval);
> +	if (ret)
> +		goto out;
> +
> +	if ((lval < ads1110_pga_table[ADS1110_PGA_1]) || 
> +		(lval > ads1110_pga_table[ADS1110_PGA_8])) {
> +		ret = -EINVAL;
Whilst these checks are all very well surely they are caught by
not finding it in the table anyway?  As such why bother with
the extra code path?  Hence probably best to get rid of this check.
> +		goto out;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(ads1110_pga_table); i++)
> +		if (lval == ads1110_pga_table[i])
> +			break;
> +
> +	if (i == ARRAY_SIZE(ads1110_pga_table)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	*cfg &= ~ADS1110_PGA_MASK;		/* erase old gain */
> +	*cfg |= i;
> +
> +	ads1110_i2c_write_config(st, *cfg);
> +
> +out:
> +	mutex_unlock(&indio_dev->mlock);
> +	return ret ? ret : len;
> +}
> +
> +static IIO_DEVICE_ATTR(scale,
> +		S_IRUGO | S_IWUSR,
> +		ads1110_show_gain, ads1110_store_gain, 0);
> +
> +static int ads1110_read_raw(struct iio_dev *indio_dev,
> +		struct iio_chan_spec const *chan,
> +		int *val,
> +		int *val2,
> +		long mask)
> +{
> +	struct ads1110_chip_info *st = iio_priv(indio_dev);
> +	int ret, data;
> +
> +	ret = ads1110_i2c_read_data(st, &data);
> +	if (ret != ADS1110_DATA_BYTES)
> +		return -EIO;
> +
> +	*val = data;
> +	*val2 = 0;
No need to set *val2 as it isn't used if return  is IIO_VAL_INT as here.
(If it is then we have a very weird bug!)
> +
> +	return IIO_VAL_INT;
> +}
> +
> +/*
> + * attributes for sysfs
> + */
> +
> +static struct attribute *ads1110_attributes[] = {
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> +	&iio_dev_attr_scale_available.dev_attr.attr,
> +	&iio_dev_attr_scale.dev_attr.attr,
scale wants to be done via infomask element of the iio_chan_spec and
relevant element of a switch statement in read raw.  That way it will
be available via the inkernel interfaces (once we pin down exactly
how they will be registered - another discussion entirely...)
> +	NULL,
> +};
> +
> +static const struct attribute_group ads1110_attribute_group = {
> +	.attrs = ads1110_attributes,
> +};
Right now I'm wondering why on earth we have an attribute group
for this. It just gets coppied internally anyway.  (Note this
is nothing to do with your driver, just a point I noticed was
'odd' in the core whilst reading your code - thanks!)
> +
> +static const struct iio_info ads1110_info = {
> +	.attrs = &ads1110_attribute_group,
> +	.event_attrs = NULL,
Don't bother filling the null as it will be 0 initialized anyway.

> +	.read_raw = &ads1110_read_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +/*
> + * device probe and remove
> + */
As a general rule I'm anti these sort of comments.  They are useful
in laying out the driver in the first place, but add no benefit
once it is written and have a nasty habbit of being incorrect after
a few changes have gone in (and changes across the entire subsystem
are still not that unusual in IIO making this sort of fiddly maintenance
a nightmare).
> +
> +static int __devinit ads1110_probe(struct i2c_client *client,
> +		const struct i2c_device_id *id)
> +{
> +	int ret = 0;
> +	struct ads1110_chip_info *chip;
> +	struct iio_dev *indio_dev;
> +
> +	indio_dev = iio_allocate_device(sizeof(*chip));
> +	if (indio_dev == NULL) {
> +		ret = -ENOMEM;
> +		goto error_ret;
> +	}
> +	chip = iio_priv(indio_dev);
> +
> +	/* this is only used for device removal purposes  */
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	chip->client = client;
> +
> +	/* Establish that the iio_dev is a child of the i2c device */
> +	indio_dev->name = id->name;
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->info = &ads1110_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ads1110_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ads1110_channels);
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto error_free_dev;
> +
> +	/* read the config register from the chip */
> +	ret = ads1110_i2c_read_config(chip, &chip->config);
> +	if (ret != 3)
> +		goto error_free_dev;
Any chance this could be ret == 2?  If so you are returning a non
error in a case where there has been one...  Odd case, but might as
well get it right.
> +
> +	dev_err(&client->dev, "%s ADC registered.\n", id->name);
> +
> +	return 0;
> +
> +error_free_dev:
> +	iio_free_device(indio_dev);
> +	kfree(chip);
> +error_ret:
> +	return ret;
> +}
> +
> +static int __devexit ads1110_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +	iio_device_unregister(indio_dev);
> +	iio_free_device(indio_dev);
> +
> +	return 0;
> +}
> +
Why the values in this table?  I'm not seeing that field
used anywhere...  Actually, other than address are these
different?  If not from a kernel point of view we almost
certainly don't care, so just have one ads1110 entry in
here...
> +static const struct i2c_device_id ads1110_id[] = {
> +	{ "ads1110-ed0", 0x48 },
> +	{ "ads1110-ed1", 0x49 },
> +	{ "ads1110-ed2", 0x50 },
> +	{ "ads1110-ed3", 0x51 },
> +	{ "ads1110-ed4", 0x52 },
> +	{ "ads1110-ed5", 0x53 },
> +	{ "ads1110-ed6", 0x54 },
> +	{ "ads1110-ed7", 0x55 },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, ads1110_id);
> +
> +static struct i2c_driver ads1110_driver = {
> +	.driver = {
> +		.name = "ads1110",
> +	},
> +	.probe = ads1110_probe,
> +	.remove = __devexit_p(ads1110_remove),
> +	.id_table = ads1110_id,
> +};
> +
> +static int __init ads1110_init(void)
> +{
> +	return i2c_add_driver(&ads1110_driver);
> +}
> +
> +static void __exit ads1110_exit(void)
> +{
> +	i2c_del_driver(&ads1110_driver);
> +}
> +
> +MODULE_AUTHOR("Duss Pirmin <pirmin.duss@flytec.ch>");
> +MODULE_DESCRIPTION("Texas Instruments ads1110 adc driver");
> +MODULE_LICENSE("GPL v2");
> +
> +module_init(ads1110_init);
I believe convension puts immediately after each relevant function.
> +module_exit(ads1110_exit);

There is a whole load of boiler plate removal code from Lars-Peter,
but I'm not entirely sure on what the status is. Either you should
provide him with a patch that uses that stuff or if Lars-Peter
prefers he can just add this to his conversions.
The core support is in driver-core for next (I think - certainly
in linux next).

See  https://lkml.org/lkml/2011/11/16/78
