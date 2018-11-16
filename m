Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727462AbeKQEYP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 16 Nov 2018 23:24:15 -0500
Date: Fri, 16 Nov 2018 18:10:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Slawomir Stepien <sst@poczta.fm>
Cc: Chris Coffey <cmc@babblebit.net>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: potentiometer: Add driver for Microchip
 MCP41xxx/42xxx
Message-ID: <20181116181043.7a8d48dc@archlinux>
In-Reply-To: <20181114103015.GB1214@x220.localdomain>
References: <20181114095241.27037-1-cmc@babblebit.net>
        <20181114095241.27037-3-cmc@babblebit.net>
        <20181114103015.GB1214@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 14 Nov 2018 11:30:15 +0100
Slawomir Stepien <sst@poczta.fm> wrote:

> On lis 14, 2018 09:52, Chris Coffey wrote:
> > This patch adds driver support for the Microchip MCP41xxx/42xxx family
> > of digital potentiometers:
> > 
> > DEVICE      Wipers  Positions   Resistance (kOhm)
> > MCP41010    1       256         10
> > MCP41050    1       256         50
> > MCP41100    1       256         100
> > MCP42010    2       256         10
> > MCP42050    2       256         50
> > MCP42100    2       256         100
> > 
> > Datasheet: http://ww1.microchip.com/downloads/en/devicedoc/11195c.pdf  
> 
> Hi
> 
> Some hints inline.
A few minor comments from me.

Thanks,

Jonathan

> 
> > Signed-off-by: Chris Coffey <cmc@babblebit.net>
> > ---
> >  drivers/iio/potentiometer/Kconfig    |  12 ++
> >  drivers/iio/potentiometer/Makefile   |   1 +
> >  drivers/iio/potentiometer/mcp41010.c | 216 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 229 insertions(+)
> >  create mode 100644 drivers/iio/potentiometer/mcp41010.c
> > 
> > diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
> > index 79ec2eba49..6303cbe799 100644
> > --- a/drivers/iio/potentiometer/Kconfig
> > +++ b/drivers/iio/potentiometer/Kconfig
> > @@ -90,6 +90,18 @@ config MCP4531
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called mcp4531.
> >  
> > +config MCP41010
> > +	tristate "Microchip MCP41xxx/MCP42xxx Digital Potentiometer driver"
> > +	depends on SPI
> > +	help
> > +	  Say yes here to build support for the Microchip
> > +	  MCP41010, MCP41050, MCP41100,
> > +	  MCP42010, MCP42050, MCP42100
> > +	  digital potentiometer chips.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called mcp41010.
> > +
> >  config TPL0102
> >  	tristate "Texas Instruments digital potentiometer driver"
> >  	depends on I2C
> > diff --git a/drivers/iio/potentiometer/Makefile b/drivers/iio/potentiometer/Makefile
> > index 4af657883c..8ff55138cf 100644
> > --- a/drivers/iio/potentiometer/Makefile
> > +++ b/drivers/iio/potentiometer/Makefile
> > @@ -11,4 +11,5 @@ obj-$(CONFIG_MAX5487) += max5487.o
> >  obj-$(CONFIG_MCP4018) += mcp4018.o
> >  obj-$(CONFIG_MCP4131) += mcp4131.o
> >  obj-$(CONFIG_MCP4531) += mcp4531.o
> > +obj-$(CONFIG_MCP41010) += mcp41010.o
> >  obj-$(CONFIG_TPL0102) += tpl0102.o
> > diff --git a/drivers/iio/potentiometer/mcp41010.c b/drivers/iio/potentiometer/mcp41010.c
> > new file mode 100644
> > index 0000000000..19fa50c9ee
> > --- /dev/null
> > +++ b/drivers/iio/potentiometer/mcp41010.c
> > @@ -0,0 +1,216 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Industrial I/O driver for Microchip digital potentiometers
> > + *
> > + * Copyright (c) 2018 Chris Coffey <cmc@babblebit.net>
> > + * Based on: Slawomir Stepien's code from mcp4131.c
> > + *
> > + * Datasheet: http://ww1.microchip.com/downloads/en/devicedoc/11195c.pdf
> > + *
> > + * DEVID	#Wipers	#Positions	Resistance (kOhm)
> > + * mcp41010	1	256		10
> > + * mcp41050	1	256		50
> > + * mcp41100	1	256		100
> > + * mcp42010	2	256		10
> > + * mcp42050	2	256		50
> > + * mcp42100	2	256		100
> > + */
> > +
> > +#include <linux/cache.h>
> > +#include <linux/err.h>
> > +#include <linux/export.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/types.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/spi/spi.h>
> > +
> > +#define MCP41010_MAX_WIPERS	2
> > +#define MCP41010_WRITE		BIT(4)
> > +#define MCP41010_WIPER_MAX	255
> > +#define MCP41010_WIPER_CHANNEL	BIT(0)
> > +
> > +struct mcp41010_cfg {
> > +	int wipers;
> > +	int kohms;
> > +};
> > +
> > +enum mcp41010_type {
> > +	MCP41010,
> > +	MCP41050,
> > +	MCP41100,
> > +	MCP42010,
> > +	MCP42050,
> > +	MCP42100,
> > +};
> > +
> > +static const struct mcp41010_cfg mcp41010_cfg[] = {
> > +	[MCP41010] = { .wipers = 1, .kohms =  10, },
> > +	[MCP41050] = { .wipers = 1, .kohms =  50, },
> > +	[MCP41100] = { .wipers = 1, .kohms = 100, },
> > +	[MCP42010] = { .wipers = 2, .kohms =  10, },
> > +	[MCP42050] = { .wipers = 2, .kohms =  50, },
> > +	[MCP42100] = { .wipers = 2, .kohms = 100, },
> > +};
> > +
> > +struct mcp41010_data {
> > +	struct spi_device *spi;
> > +	const struct mcp41010_cfg *cfg;
> > +	struct mutex lock; /* Protect write sequences */
> > +	unsigned int value[MCP41010_MAX_WIPERS]; /* Cache wiper values */
> > +	u8 buf[2] ____cacheline_aligned;
> > +};
> > +
> > +#define MCP41010_CHANNEL(ch) {					\
> > +	.type = IIO_RESISTANCE,					\
> > +	.indexed = 1,						\
> > +	.output = 1,						\
> > +	.channel = (ch),					\
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> > +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> > +}
> > +
> > +static const struct iio_chan_spec mcp41010_channels[] = {
> > +	MCP41010_CHANNEL(0),
> > +	MCP41010_CHANNEL(1),
> > +};
> > +
> > +static int mcp41010_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int *val, int *val2, long mask)
> > +{
> > +	struct mcp41010_data *data = iio_priv(indio_dev);
> > +	int channel = chan->channel;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		*val = data->value[channel];
> > +		return IIO_VAL_INT;
> > +
> > +	case IIO_CHAN_INFO_SCALE:
> > +		*val = 1000 * data->cfg->kohms;
> > +		*val2 = MCP41010_WIPER_MAX;
> > +		return IIO_VAL_FRACTIONAL;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static int mcp41010_write_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan,
> > +			     int val, int val2, long mask)
> > +{
> > +	int err;
> > +	struct mcp41010_data *data = iio_priv(indio_dev);
> > +	int channel = chan->channel;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		if (val > MCP41010_WIPER_MAX || val < 0)
> > +			return -EINVAL;
> > +		break;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}

This is an unusual code structure.  Given any additions to the
above switch will presumably involve changes to the below, I think
we should either have all the below in the switch case, or
we should just use an if statement to check if it's not
IIO_CHAN_INFO_RAW.

> > +
> > +	mutex_lock(&data->lock);
> > +
> > +	data->buf[0] = MCP41010_WIPER_CHANNEL << channel;
> > +	data->buf[0] |= MCP41010_WRITE;
> > +	data->buf[1] = val & 0xff;
> > +
> > +	err = spi_write(data->spi, data->buf, 2);
> > +	if (!err)
> > +		data->value[channel] = val;
> > +
> > +	mutex_unlock(&data->lock);
> > +
> > +	return err;
> > +}
> > +
> > +static const struct iio_info mcp41010_info = {
> > +	.read_raw = mcp41010_read_raw,
> > +	.write_raw = mcp41010_write_raw,
> > +};
> > +
> > +static int mcp41010_probe(struct spi_device *spi)
> > +{
> > +	int err;
> > +	struct device *dev = &spi->dev;
> > +	unsigned long devid = spi_get_device_id(spi)->driver_data;  
> 
> I guess the calculation of devid value can now be done only when
> of_device_get_match_data() did not return config.
> 
> > +	struct mcp41010_data *data;
> > +	struct iio_dev *indio_dev;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	data = iio_priv(indio_dev);
> > +	spi_set_drvdata(spi, indio_dev);
> > +	data->spi = spi;
> > +	data->cfg = of_device_get_match_data(&spi->dev);
> > +	if (!data->cfg)
> > +		data->cfg = &mcp41010_cfg[devid];
> > +
> > +	mutex_init(&data->lock);
> > +
> > +	indio_dev->dev.parent = dev;
> > +	indio_dev->info = &mcp41010_info;
> > +	indio_dev->channels = mcp41010_channels;
> > +	indio_dev->num_channels = data->cfg->wipers;
> > +	indio_dev->name = spi_get_device_id(spi)->name;

It is a bit odd to use the of match for the data, but
then get the name always from the spi_device_id table.
We probably need a separate source for the names such
as in the config structure.


> > +
> > +	err = devm_iio_device_register(dev, indio_dev);
> > +	if (err) {
> > +		dev_info(&spi->dev, "Unable to register %s\n", indio_dev->name);
> > +		return err;
> > +	}
> > +
> > +	return 0;

Drop the return out of the bracket and return err here. It's a trivial
improvement, but as one of the static checkers tends to point this out,
we'll only end up with a patch changing it shortly if we don't do it
now.

	err = devm_iio_device_register(dev, indio_dev);
	if (err)
		dev_info(&spi->dev, "Unable to register %s\n", indio_dev->name);

	return err;
	
> > +}
> > +
> > +static const struct of_device_id mcp41010_match[] = {
> > +	{ .compatible = "microchip,mcp41010",
> > +		.data = &mcp41010_cfg[MCP41010] },
> > +	{ .compatible = "microchip,mcp41050",
> > +		.data = &mcp41010_cfg[MCP41050] },
> > +	{ .compatible = "microchip,mcp41100",
> > +		.data = &mcp41010_cfg[MCP41100] },
> > +	{ .compatible = "microchip,mcp42010",
> > +		.data = &mcp41010_cfg[MCP42010] },
> > +	{ .compatible = "microchip,mcp42050",
> > +		.data = &mcp41010_cfg[MCP42050] },
> > +	{ .compatible = "microchip,mcp42100",
> > +		.data = &mcp41010_cfg[MCP42100] },  
> 
> It looks that you can fit these into 80 chars column.
> 
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, mcp41010_match);
> > +
> > +static const struct spi_device_id mcp41010_id[] = {
> > +	{ "mcp41010", MCP41010 },
> > +	{ "mcp41050", MCP41050 },
> > +	{ "mcp41100", MCP41100 },
> > +	{ "mcp42010", MCP42010 },
> > +	{ "mcp42050", MCP42050 },
> > +	{ "mcp42100", MCP42100 },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(spi, mcp41010_id);
> > +
> > +static struct spi_driver mcp41010_driver = {
> > +	.driver = {
> > +		.name	= "mcp41010",
> > +		.of_match_table = mcp41010_match,
> > +	},
> > +	.probe		= mcp41010_probe,
> > +	.id_table	= mcp41010_id,
> > +};
> > +
> > +module_spi_driver(mcp41010_driver);
> > +
> > +MODULE_AUTHOR("Chris Coffey <cmc@babblebit.net>");
> > +MODULE_DESCRIPTION("MCP41010 digital potentiometer");
> > +MODULE_LICENSE("GPL v2");  
> 
