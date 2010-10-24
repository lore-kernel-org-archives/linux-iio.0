Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:60023 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932301Ab0JXSOJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Oct 2010 14:14:09 -0400
Message-ID: <4CC478D1.2070604@cam.ac.uk>
Date: Sun, 24 Oct 2010 19:20:01 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Mike Frysinger <vapier@gentoo.org>
CC: linux-iio@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org,
	Sonic Zhang <sonic.zhang@analog.com>
Subject: Re: [PATCH] staging: iio: new ADT7316/7/8 and ADT7516/7/9 driver
References: <1287865409-32171-1-git-send-email-vapier@gentoo.org>
In-Reply-To: <1287865409-32171-1-git-send-email-vapier@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/23/10 21:23, Mike Frysinger wrote:
> From: Sonic Zhang <sonic.zhang@analog.com>
> 
> IIO driver for temperature sensor, ADC and DAC devices over SPI and I2C.

Given I'm low on time I've done this review without diving into the
datasheets, so I may have missed some stuff.

DAC interfaces need thorough discussion. That doesn't prevent merging
but note they will almost certainly change somewhat. I'm not all that
familiar with these devices so I'm happy to have others propose the
interface, but it needs to be proposed widely and discussed before we
commit to it.  Hence we won't have a stable userspace abi for now.

Few quirks that could do with cleaning up.
For starters I can't find any users of the multi_read and multi_write
functions, other than where they are used for the spi single read and
write equivalent.

Some of the sanity checks related to the exact chip can be removed
as I don't think it's possible for the functions to run such that
the checks can fail.

Some errors from the bus functions are eaten rather than passed on.

Not keen on the single channel / round robin control. It is utterly
non standard. If I understand what this is doing, it's just the same
as the scan modes handled in a consistent manner by a number of
other drivers (max1363 and other adc drivers).
I don't mind this merging as is, but it needs a TODO file to indicate
that this needs cleaning up.  The whole selecting channel stuff is
completely wrong under our abi. Sorry guys, but it just doesn't
generalize. You should have separate attributes such as:
in0_supply_raw
in1_raw
in2_raw
in3_raw
temp0_external_raw
temp1_raw

There are elements here that the abi covers that are incorrect here
as well. in_temp for example doesn't exist.

as appropriate. The temp0_external will need documenting as we haven't
had that one before. 

Locking needed to ensure consistency.  Always remember multiple reads
of sysfs attributes can occur at the same time.

Whilst clearer than many cases, there are magic numbers in the resolution
parameters.  Please just use the actual values.

Sorry, event codes have all changed and you'll need to update that stuff before
it will build against current staging-next.  Disadvantage of working on
big drivers out of mainline I'm afraid.  What we had for this was a mess
and only got cleaned up in this kernel cycle.  Lots of your events don't
look device specific anyway so should never have been using those codes.

The hex based interrupt mask definitely needs changing to be abi compliant.


This one is way off on the abi, but I guess if it builds we can merge it and
fix in tree as long as someone has the relevant part and is willing todo
testing.  Should definitely have an accompanying TODO covering the various
points in here if they haven't been fixed prior to merge.

It would be good to merge it as we still have relatively few drivers implementing
the event interfaces. What worries me is it may lead other driver writers
astray. 

Jonathan

> 
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
>  drivers/staging/iio/Kconfig             |    1 +
>  drivers/staging/iio/Makefile            |    1 +
(nothing to do with this driver - just idle musing ;)
I'm beginning to wonder whether it was such a good idea to break the
devices out into directories.  As this one shows the divisions aren't
always all that clear.  We can decide that at a later date though.  
>  drivers/staging/iio/addac/Kconfig       |   25 +
>  drivers/staging/iio/addac/Makefile      |    7 +
>  drivers/staging/iio/addac/adt7316-i2c.c |  169 +++
>  drivers/staging/iio/addac/adt7316-spi.c |  179 +++
>  drivers/staging/iio/addac/adt7316.c     | 2402 +++++++++++++++++++++++++++++++
>  drivers/staging/iio/addac/adt7316.h     |   33 +
>  8 files changed, 2817 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/staging/iio/addac/Kconfig
>  create mode 100644 drivers/staging/iio/addac/Makefile
>  create mode 100644 drivers/staging/iio/addac/adt7316-i2c.c
>  create mode 100644 drivers/staging/iio/addac/adt7316-spi.c
>  create mode 100644 drivers/staging/iio/addac/adt7316.c
>  create mode 100644 drivers/staging/iio/addac/adt7316.h
> 
> diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
> index ed48815..b8bb5f1 100644
> --- a/drivers/staging/iio/Kconfig
> +++ b/drivers/staging/iio/Kconfig
> @@ -42,6 +42,7 @@ config IIO_TRIGGER
>  
>  source "drivers/staging/iio/accel/Kconfig"
>  source "drivers/staging/iio/adc/Kconfig"
> +source "drivers/staging/iio/addac/Kconfig"
>  source "drivers/staging/iio/gyro/Kconfig"
>  source "drivers/staging/iio/imu/Kconfig"
>  source "drivers/staging/iio/light/Kconfig"
> diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
> index e909674..0111647 100644
> --- a/drivers/staging/iio/Makefile
> +++ b/drivers/staging/iio/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_IIO_SW_RING) += ring_sw.o
>  
>  obj-y += accel/
>  obj-y += adc/
> +obj-y += addac/
>  obj-y += gyro/
>  obj-y += imu/
>  obj-y += light/
> diff --git a/drivers/staging/iio/addac/Kconfig b/drivers/staging/iio/addac/Kconfig
> new file mode 100644
> index 0000000..9b4ee42
> --- /dev/null
> +++ b/drivers/staging/iio/addac/Kconfig
> @@ -0,0 +1,25 @@
> +#
> +# ADDAC drivers
> +#
> +comment "Analog digital bi-direction convertors"
> +
> +config ADT7316
> +	tristate "Analog Devices ADT7316/7/8 ADT7516/7/9 temperature sensor, ADC and DAC driver"
> +	help
(non critical) Please can we have the names in full in the help text.  It makes
for easier grepping.
> +	  Say yes here to build support for Analog Devices ADT7316/7/8
> +	  and ADT7516/7/9 temperature sensors, ADC and DAC.
> +
> +config ADT7316_SPI
> +	tristate "support SPI bus connection"
> +	depends on SPI && ADT7316
why default y ?  
> +	default y
> +	help
> +	  Say yes here to build SPI bus support for Analog Devices ADT7316/7/8
> +	  and ADT7516/7/9.
> +
> +config ADT7316_I2C
> +	tristate "support I2C bus connection"
> +	depends on I2C && ADT7316
> +	help
> +	  Say yes here to build I2C bus support for Analog Devices ADT7316/7/8
> +	  and ADT7516/7/9.
> diff --git a/drivers/staging/iio/addac/Makefile b/drivers/staging/iio/addac/Makefile
> new file mode 100644
> index 0000000..4c76861
> --- /dev/null
> +++ b/drivers/staging/iio/addac/Makefile
> @@ -0,0 +1,7 @@
> +#
> +# Makefile for industrial I/O ADDAC drivers
> +#
> +
> +obj-$(CONFIG_ADT7316) += adt7316.o
> +obj-$(CONFIG_ADT7316_SPI) += adt7316-spi.o
> +obj-$(CONFIG_ADT7316_I2C) += adt7316-i2c.o
> diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
> new file mode 100644
> index 0000000..744c82d
> --- /dev/null
> +++ b/drivers/staging/iio/addac/adt7316-i2c.c
> @@ -0,0 +1,169 @@
> +/*
> + * I2C bus driver for ADT7316/7/8 ADT7516/7/9 digital temperature
> + * sensor, ADC and DAC
> + *
> + * Copyright 2010 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2 or later.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/i2c.h>
> +
> +#include "adt7316.h"
> +
> +/*
> + * adt7316 register access by I2C
> + */
> +static int adt7316_i2c_read(void *client, u8 reg, u8 *data)
> +{
> +	struct i2c_client *cl = client;
> +	int ret = 0;
Don't bother initializing the value.
> +
> +	ret = i2c_smbus_write_byte(cl, reg);
> +	if (ret < 0) {
> +		dev_err(&cl->dev, "I2C fail to select reg\n");
> +		return ret;
> +	}
> +
> +	ret = i2c_smbus_read_byte(client);
> +	if (ret < 0) {
> +		dev_err(&cl->dev, "I2C read error\n");
> +		return ret;
> +	}
I think these two calls correspond to a single
i2c_smbus_read_byte_data call.
If there is a quirk that makes this inappropriate then there
should probably be a comment about it.

> +
> +	return 0;
> +}
> +
> +static int adt7316_i2c_write(void *client, u8 reg, u8 data)
> +{
> +	struct i2c_client *cl = client;
> +	int ret = 0;
No point in initializing the value.
> +
> +	ret = i2c_smbus_write_byte_data(cl, reg, data);
> +	if (ret < 0)
> +		dev_err(&cl->dev, "I2C write error\n");
> +
> +	return ret;
> +}
> +
> +static int adt7316_i2c_multi_read(void *client, u8 reg, u8 count, u8 *data)
> +{
> +	struct i2c_client *cl = client;
> +	int i, ret = 0;
> +
This is rather odd. Surely basic care will prevent this condition
occuring and if it does it probably implies a bug in the driver...
> +	if (count > ADT7316_REG_MAX_ADDR)
> +		count = ADT7316_REG_MAX_ADDR;
> +
> +	for (i = 0; i < count; i++) {
> +		ret = adt7316_i2c_read(cl, reg, &data[i]);
> +		if (ret < 0) {
> +			dev_err(&cl->dev, "I2C multi read error\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int adt7316_i2c_multi_write(void *client, u8 reg, u8 count, u8 *data)
> +{
> +	struct i2c_client *cl = client;
> +	int i, ret = 0;
> +
> +	if (count > ADT7316_REG_MAX_ADDR)
> +		count = ADT7316_REG_MAX_ADDR;
> +
> +	for (i = 0; i < count; i++) {
> +		ret = adt7316_i2c_write(cl, reg, data[i]);
> +		if (ret < 0) {
> +			dev_err(&cl->dev, "I2C multi write error\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * device probe and remove
> + */
> +
> +static int __devinit adt7316_i2c_probe(struct i2c_client *client,
> +		const struct i2c_device_id *id)
> +{

Isn't there an issue with this structure going out of scope.
Probably needs to be coppied in the adt7316_probe funciton.
> +	struct adt7316_bus bus = {
> +		.client = client,
> +		.irq = client->irq,
> +		.irq_flags = client->irq_flags,
> +		.read = adt7316_i2c_read,
> +		.write = adt7316_i2c_write,
> +		.multi_read = adt7316_i2c_multi_read,
> +		.multi_write = adt7316_i2c_multi_write,
> +	};
> +
> +	return adt7316_probe(&client->dev, &bus, id->name);
> +}
> +
> +static int __devexit adt7316_i2c_remove(struct i2c_client *client)
> +{
> +	return adt7316_remove(&client->dev);;
> +}
> +
> +static const struct i2c_device_id adt7316_i2c_id[] = {
> +	{ "adt7316", 0 },
> +	{ "adt7317", 0 },
> +	{ "adt7318", 0 },
> +	{ "adt7516", 0 },
> +	{ "adt7517", 0 },
> +	{ "adt7519", 0 },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, adt7316_i2c_id);
> +
> +#ifdef CONFIG_PM
> +static int adt7316_i2c_suspend(struct i2c_client *client, pm_message_t message)
> +{
> +	return adt7316_disable(&client->dev);
> +}
> +
> +static int adt7316_i2c_resume(struct i2c_client *client)
> +{
> +	return adt7316_enable(&client->dev);
> +}
> +#else
> +# define adt7316_i2c_suspend NULL
> +# define adt7316_i2c_resume  NULL
> +#endif
> +
> +static struct i2c_driver adt7316_driver = {
> +	.driver = {
> +		.name = "adt7316",
> +		.owner  = THIS_MODULE,
> +	},
> +	.probe = adt7316_i2c_probe,
> +	.remove = __devexit_p(adt7316_i2c_remove),
> +	.suspend = adt7316_i2c_suspend,
> +	.resume = adt7316_i2c_resume,
> +	.id_table = adt7316_i2c_id,
> +};
> +
> +static __init int adt7316_i2c_init(void)
> +{
> +	return i2c_add_driver(&adt7316_driver);
> +}
> +
> +static __exit void adt7316_i2c_exit(void)
> +{
> +	i2c_del_driver(&adt7316_driver);
> +}
> +
> +MODULE_AUTHOR("Sonic Zhang <sonic.zhang@analog.com>");
> +MODULE_DESCRIPTION("I2C bus driver for Analog Devices ADT7316/7/9 and"
> +			"ADT7516/7/8 digital temperature sensor, ADC and DAC");
> +MODULE_LICENSE("GPL v2");
> +
> +module_init(adt7316_i2c_init);
> +module_exit(adt7316_i2c_exit);
> diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
> new file mode 100644
> index 0000000..13c6cde
> --- /dev/null
> +++ b/drivers/staging/iio/addac/adt7316-spi.c
> @@ -0,0 +1,179 @@
> +/*
> + * API bus driver for ADT7316/7/8 ADT7516/7/9 digital temperature
> + * sensor, ADC and DAC
> + *
> + * Copyright 2010 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2 or later.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +
> +#include "adt7316.h"
> +
> +#define ADT7316_SPI_MAX_FREQ_HZ		5000000
> +#define ADT7316_SPI_CMD_READ		0x91
> +#define ADT7316_SPI_CMD_WRITE		0x90
> +
> +/*
> + * adt7316 register access by SPI
> + */
> +
> +static int adt7316_spi_multi_read(void *client, u8 reg, u8 count, u8 *data)
> +{
> +	struct spi_device *spi_dev = client;
> +	u8 cmd[2];
> +	int ret = 0;
Again, no need to initialize this.  Conversly
could initialize cmd
> +
> +	if (count > ADT7316_REG_MAX_ADDR)
> +		count = ADT7316_REG_MAX_ADDR;
> +
> +	cmd[0] = ADT7316_SPI_CMD_WRITE;
> +	cmd[1] = reg;
> +
> +	ret = spi_write(spi_dev, cmd, 2);
> +	if (ret < 0) {
> +		dev_err(&spi_dev->dev, "SPI fail to select reg\n");
> +		return ret;
> +	}
> +
> +	cmd[0] = ADT7316_SPI_CMD_READ;
> +
> +	ret = spi_write_then_read(spi_dev, cmd, 1, data, count);
> +	if (ret < 0) {
> +		dev_err(&spi_dev->dev, "SPI read data error\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int adt7316_spi_multi_write(void *client, u8 reg, u8 count, u8 *data)
> +{
> +	struct spi_device *spi_dev = client;
> +	u8 buf[ADT7316_REG_MAX_ADDR + 2];
> +	int i, ret = 0;
> +
> +	if (count > ADT7316_REG_MAX_ADDR)
> +		count = ADT7316_REG_MAX_ADDR;
> +
> +	buf[0] = ADT7316_SPI_CMD_WRITE;
> +	buf[1] = reg;
> +	for (i = 0; i < count; i++)
> +		buf[i + 2] = data[i];
> +
> +	ret = spi_write(spi_dev, buf, count + 2);
> +	if (ret < 0) {
> +		dev_err(&spi_dev->dev, "SPI write error\n");
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int adt7316_spi_read(void *client, u8 reg, u8 *data)
> +{
> +	return adt7316_spi_multi_read(client, reg, 1, data);
> +}
> +
> +static int adt7316_spi_write(void *client, u8 reg, u8 val)
> +{
> +	return adt7316_spi_multi_write(client, reg, 1, &val);
> +}
> +
> +/*
> + * device probe and remove
> + */
> +
> +static int __devinit adt7316_spi_probe(struct spi_device *spi_dev)
> +{
> +	struct adt7316_bus bus = {
> +		.client = spi_dev,
> +		.irq = spi_dev->irq,
> +		.irq_flags = spi_dev->irq_flags,
> +		.read = adt7316_spi_read,
> +		.write = adt7316_spi_write,
> +		.multi_read = adt7316_spi_multi_read,
> +		.multi_write = adt7316_spi_multi_write,
> +	};
> +
> +	/* don't exceed max specified SPI CLK frequency */
> +	if (spi_dev->max_speed_hz > ADT7316_SPI_MAX_FREQ_HZ) {
> +		dev_err(&spi_dev->dev, "SPI CLK %d Hz?\n",
> +			spi_dev->max_speed_hz);
> +		return -EINVAL;
> +	}
> +
> +	/* switch from default I2C protocol to SPI protocol */
> +	adt7316_spi_write(spi_dev, 0, 0);
> +	adt7316_spi_write(spi_dev, 0, 0);
> +	adt7316_spi_write(spi_dev, 0, 0);
> +
> +	return adt7316_probe(&spi_dev->dev, &bus, spi_dev->modalias);
> +}
> +
> +static int __devexit adt7316_spi_remove(struct spi_device *spi_dev)
> +{
> +	return adt7316_remove(&spi_dev->dev);
> +}
> +
> +static const struct spi_device_id adt7316_spi_id[] = {
> +	{ "adt7316", 0 },
> +	{ "adt7317", 0 },
> +	{ "adt7318", 0 },
> +	{ "adt7516", 0 },
> +	{ "adt7517", 0 },
> +	{ "adt7519", 0 },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(spi, adt7316_spi_id);
> +
> +#ifdef CONFIG_PM
> +static int adt7316_spi_suspend(struct spi_device *spi_dev, pm_message_t message)
> +{
> +	return adt7316_disable(&spi_dev->dev);
> +}
> +
> +static int adt7316_spi_resume(struct spi_device *spi_dev)
> +{
> +	return adt7316_enable(&spi_dev->dev);
> +}
> +#else
> +# define adt7316_spi_suspend NULL
> +# define adt7316_spi_resume  NULL
> +#endif
> +
> +static struct spi_driver adt7316_driver = {
> +	.driver = {
> +		.name = "adt7316",
> +		.bus = &spi_bus_type,
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = adt7316_spi_probe,
> +	.remove = __devexit_p(adt7316_spi_remove),
> +	.suspend = adt7316_spi_suspend,
> +	.resume = adt7316_spi_resume,
> +	.id_table = adt7316_spi_id,
> +};
> +
> +static __init int adt7316_spi_init(void)
> +{
> +	return spi_register_driver(&adt7316_driver);
> +}
> +
> +static __exit void adt7316_spi_exit(void)
> +{
> +	spi_unregister_driver(&adt7316_driver);
> +}
> +
> +MODULE_AUTHOR("Sonic Zhang <sonic.zhang@analog.com>");
> +MODULE_DESCRIPTION("SPI bus driver for Analog Devices ADT7316/7/8 and"
> +			"ADT7516/7/9 digital temperature sensor, ADC and DAC");
> +MODULE_LICENSE("GPL v2");
> +
> +module_init(adt7316_spi_init);
> +module_exit(adt7316_spi_exit);
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> new file mode 100644
> index 0000000..dfc153b
> --- /dev/null
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -0,0 +1,2402 @@
> +/*
> + * ADT7316 digital temperature sensor driver supporting ADT7316/7/8 ADT7516/7/9
> + *
> + *
> + * Copyright 2010 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2 or later.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/gpio.h>
> +#include <linux/workqueue.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/list.h>
> +#include <linux/i2c.h>

rtc.h?  Why?
> +#include <linux/rtc.h>
> +
> +#include "../iio.h"
> +#include "../sysfs.h"
> +#include "adt7316.h"
> +
> +/*
> + * ADT7316 registers definition
> + */
> +#define ADT7316_INT_STAT1		0x0
> +#define ADT7316_INT_STAT2		0x1
> +#define ADT7316_LSB_IN_TEMP_VDD		0x3
> +#define ADT7316_LSB_IN_TEMP_MASK	0x3
> +#define ADT7316_LSB_VDD_MASK		0xC
> +#define ADT7316_LSB_VDD_OFFSET		2
> +#define ADT7316_LSB_EX_TEMP_AIN		0x4
> +#define ADT7316_LSB_EX_TEMP_MASK	0x3
> +#define ADT7516_LSB_AIN_SHIFT		2
> +#define ADT7316_AD_MSB_DATA_BASE        0x6
> +#define ADT7316_AD_MSB_DATA_REGS        3
> +#define ADT7516_AD_MSB_DATA_REGS        6
> +#define ADT7316_MSB_VDD			0x6
> +#define ADT7316_MSB_IN_TEMP		0x7
> +#define ADT7316_MSB_EX_TEMP		0x8
> +#define ADT7516_MSB_AIN1		0x8
> +#define ADT7516_MSB_AIN2		0x9
> +#define ADT7516_MSB_AIN3		0xA
> +#define ADT7516_MSB_AIN4		0xB
> +#define ADT7316_DA_DATA_BASE		0x10
> +#define ADT7316_DA_MSB_DATA_REGS	4
> +#define ADT7316_LSB_DAC_A		0x10
> +#define ADT7316_MSB_DAC_A		0x11
> +#define ADT7316_LSB_DAC_B		0x12
> +#define ADT7316_MSB_DAC_B		0x13
> +#define ADT7316_LSB_DAC_C		0x14
> +#define ADT7316_MSB_DAC_C		0x15
> +#define ADT7316_LSB_DAC_D		0x16
> +#define ADT7316_MSB_DAC_D		0x17
> +#define ADT7316_CONFIG1			0x18
> +#define ADT7316_CONFIG2			0x19
> +#define ADT7316_CONFIG3			0x1A
> +#define ADT7316_LDAC_CONFIG		0x1B
> +#define ADT7316_DAC_CONFIG		0x1C
> +#define ADT7316_INT_MASK1		0x1D
> +#define ADT7316_INT_MASK2		0x1E
> +#define ADT7316_IN_TEMP_OFFSET		0x1F
> +#define ADT7316_EX_TEMP_OFFSET		0x20
> +#define ADT7316_IN_ANALOG_TEMP_OFFSET	0x21
> +#define ADT7316_EX_ANALOG_TEMP_OFFSET	0x22
> +#define ADT7316_VDD_HIGH		0x23
> +#define ADT7316_VDD_LOW			0x24
> +#define ADT7316_IN_TEMP_HIGH		0x25
> +#define ADT7316_IN_TEMP_LOW		0x26
> +#define ADT7316_EX_TEMP_HIGH		0x27
> +#define ADT7316_EX_TEMP_LOW		0x28
> +#define ADT7516_AIN2_HIGH		0x2B
> +#define ADT7516_AIN2_LOW		0x2C
> +#define ADT7516_AIN3_HIGH		0x2D
> +#define ADT7516_AIN3_LOW		0x2E
> +#define ADT7516_AIN4_HIGH		0x2F
> +#define ADT7516_AIN4_LOW		0x30
> +#define ADT7316_DEVICE_ID		0x4D
> +#define ADT7316_MANUFACTURE_ID		0x4E
> +#define ADT7316_DEVICE_REV		0x4F
> +#define ADT7316_SPI_LOCK_STAT		0x7F
> +
> +/*
> + * ADT7316 config1
> + */
> +#define ADT7316_EN			0x1
> +#define ADT7516_SEL_EX_TEMP		0x4
> +#define ADT7516_SEL_AIN1_2_EX_TEMP_MASK	0x6
> +#define ADT7516_SEL_AIN3		0x8
> +#define ADT7316_INT_EN			0x20
> +#define ADT7316_INT_POLARITY		0x40
> +#define ADT7316_PD			0x80
> +
> +/*
> + * ADT7316 config2
> + */
> +#define ADT7316_AD_SINGLE_CH_MASK	0x3
> +#define ADT7516_AD_SINGLE_CH_MASK	0x7
> +#define ADT7316_AD_SINGLE_CH_VDD	0
> +#define ADT7316_AD_SINGLE_CH_IN		1
> +#define ADT7316_AD_SINGLE_CH_EX		2
> +#define ADT7516_AD_SINGLE_CH_AIN1	2
> +#define ADT7516_AD_SINGLE_CH_AIN2	3
> +#define ADT7516_AD_SINGLE_CH_AIN3	4
> +#define ADT7516_AD_SINGLE_CH_AIN4	5
> +#define ADT7316_AD_SINGLE_CH_MODE	0x10
> +#define ADT7316_DISABLE_AVERAGING	0x20
> +#define ADT7316_EN_SMBUS_TIMEOUT	0x40
> +#define ADT7316_RESET			0x80
> +
> +/*
> + * ADT7316 config3
> + */
> +#define ADT7316_ADCLK_22_5		0x1
> +#define ADT7316_DA_HIGH_RESOLUTION	0x2
> +#define ADT7316_DA_EN_VIA_DAC_LDCA	0x4
> +#define ADT7516_AIN_IN_VREF		0x10
> +#define ADT7316_EN_IN_TEMP_PROP_DACA	0x20
> +#define ADT7316_EN_EX_TEMP_PROP_DACB	0x40
> +
> +/*
> + * ADT7316 DAC config
> + */
> +#define ADT7316_DA_2VREF_CH_MASK	0xF
> +#define ADT7316_DA_EN_MODE_MASK		0x30
> +#define ADT7316_DA_EN_MODE_SINGLE	0x00
> +#define ADT7316_DA_EN_MODE_AB_CD	0x10
> +#define ADT7316_DA_EN_MODE_ABCD		0x20
> +#define ADT7316_DA_EN_MODE_LDAC		0x30
> +#define ADT7316_VREF_BYPASS_DAC_AB	0x40
> +#define ADT7316_VREF_BYPASS_DAC_CD	0x80
> +
> +/*
> + * ADT7316 LDAC config
> + */
> +#define ADT7316_LDAC_EN_DA_MASK		0xF
> +#define ADT7316_DAC_IN_VREF		0x10
> +#define ADT7516_DAC_AB_IN_VREF		0x10
> +#define ADT7516_DAC_CD_IN_VREF		0x20
> +#define ADT7516_DAC_IN_VREF_OFFSET	4
> +#define ADT7516_DAC_IN_VREF_MASK	0x30
> +
> +/*
> + * ADT7316 INT_MASK2
> + */
> +#define ADT7316_INT_MASK2_VDD		0x10
> +
> +/*
> + * ADT7316 value masks
> + */
> +#define ADT7316_VALUE_MASK		0xfff
> +#define ADT7316_T_VALUE_SIGN		0x400
> +#define ADT7316_T_VALUE_FLOAT_OFFSET	2
> +#define ADT7316_T_VALUE_FLOAT_MASK	0x2
> +
> +/*
> + * Chip ID
> + */
> +#define ID_ADT7316		0x1
> +#define ID_ADT7317		0x2
> +#define ID_ADT7318		0x3
> +#define ID_ADT7516		0x11
> +#define ID_ADT7517		0x12
> +#define ID_ADT7519		0x14
> +
> +#define ID_FAMILY_MASK		0xF0
> +#define ID_ADT73XX		0x0
> +#define ID_ADT75XX		0x10
> +
> +/*
> + * struct adt7316_chip_info - chip specifc information
> + */

I'd like to see this structure more fully documented
(would make review simpler).
> +
> +struct adt7316_chip_info {
> +	const char		*name;
> +	struct iio_dev		*indio_dev;
> +	struct work_struct	thresh_work;
> +	s64			last_timestamp;
> +	struct adt7316_bus	bus;
> +	u16			ldac_pin;
> +	u16			int_mask;	/* 0x2f */
> +	u8			config1;
> +	u8			config2;
> +	u8			config3;
> +	u8			dac_config;	/* DAC config */
> +	u8			ldac_config;	/* LDAC config */
> +	u8			dac_bits;	/* 8, 10, 12 */
> +	u8			id;		/* chip id */
> +};
> +
> +/*
> + * Logic interrupt mask for user application to enable
> + * interrupts.
> + */
> +#define ADT7316_IN_TEMP_HIGH_INT_MASK	0x1
> +#define ADT7316_IN_TEMP_LOW_INT_MASK	0x2
> +#define ADT7316_EX_TEMP_HIGH_INT_MASK	0x4
> +#define ADT7316_EX_TEMP_LOW_INT_MASK	0x8
> +#define ADT7316_EX_TEMP_FAULT_INT_MASK	0x10
> +#define ADT7516_AIN1_INT_MASK		0x4
> +#define ADT7516_AIN2_INT_MASK		0x20
> +#define ADT7516_AIN3_INT_MASK		0x40
> +#define ADT7516_AIN4_INT_MASK		0x80
> +#define ADT7316_VDD_INT_MASK		0x100
> +#define ADT7316_TEMP_INT_MASK		0x1F
> +#define ADT7516_AIN_INT_MASK		0xE0
> +#define ADT7316_TEMP_AIN_INT_MASK	\
> +	(ADT7316_TEMP_INT_MASK | ADT7316_TEMP_INT_MASK)
> +
> +/*
> + * struct adt7316_chip_info - chip specifc information
> + */
Comment doesn't correspond to this structure.
> +
> +struct adt7316_limit_regs {
> +	u16	data_high;
> +	u16	data_low;
> +};
> +
> +static ssize_t adt7316_show_enabled(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return sprintf(buf, "%d\n", !!(chip->config1 & ADT7316_EN));
> +}
> +
> +static ssize_t _adt7316_store_enabled(struct adt7316_chip_info *chip,
> +		int enable)
> +{
> +	u8 config1;
> +	int ret;
> +
Don't think it matters that much, but probably want some locking
in here to ensure the cache matches the state.
> +	if (enable)
> +		config1 = chip->config1 | ADT7316_EN;
> +	else
> +		config1 = chip->config1 & ~ADT7316_EN;
> +
> +	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, config1);
Can this eat more informative errors coming up from the underlying bus
drivers?
> +	if (ret)
> +		return -EIO;
> +
> +	chip->config1 = config1;
> +
> +	return ret;
> +
> +}
> +
> +static ssize_t adt7316_store_enabled(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +	int enable;
> +
> +	if (!memcmp(buf, "1", 1))
> +		enable = 1;
> +	else
> +		enable = 0;
enable = !!memcmp(buf, "1", 1);
> +
> +	if (_adt7316_store_enabled(chip, enable) < 0)
Pass on the error that came from the function.
> +		return -EIO;
> +	else
> +		return len;
> +}
> +
> +static IIO_DEVICE_ATTR(enabled, S_IRUGO | S_IWUSR,
> +		adt7316_show_enabled,
> +		adt7316_store_enabled,
> +		0);
> +
> +static ssize_t adt7316_show_select_ex_temp(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	if ((chip->id & ID_FAMILY_MASK) != ID_ADT75XX)
How can this happen?
> +		return -EPERM;
> +
> +	return sprintf(buf, "%d\n", !!(chip->config1 & ADT7516_SEL_EX_TEMP));
> +}
> +
> +static ssize_t adt7316_store_select_ex_temp(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +	u8 config1;
> +	int ret;
> +
> +	if ((chip->id & ID_FAMILY_MASK) != ID_ADT75XX)
Same as above. I can't see how this can happen.
> +		return -EPERM;
> +
Ideally some locking here would prevent odd inconsistent results.
> +	config1 = chip->config1 & (~ADT7516_SEL_EX_TEMP);
> +	if (!memcmp(buf, "1", 1))
> +		config1 |= ADT7516_SEL_EX_TEMP;
> +
> +	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, config1);
> +	if (ret)
More error eating. Don't do it.
> +		return -EIO;
> +
> +	chip->config1 = config1;
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(select_ex_temp, S_IRUGO | S_IWUSR,
> +		adt7316_show_select_ex_temp,
> +		adt7316_store_select_ex_temp,
> +		0);
> +

This probably needs proper support as per the various ADC
drivers in mainline.  Userspace basically doesn't need to
know this.  The driver should setup which ever mode meets
the requirements of what userspace requests.

I guess we can let this go for now, but I will add a todo
file to the directory to point out this needs to change.
> +static ssize_t adt7316_show_mode(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	if (chip->config2 & ADT7316_AD_SINGLE_CH_MODE)
> +		return sprintf(buf, "single_channel\n");
> +	else
> +		return sprintf(buf, "round_robin\n");
> +}
> +
> +static ssize_t adt7316_store_mode(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +	u8 config2;
> +	int ret;
> +
> +	config2 = chip->config2 & (~ADT7316_AD_SINGLE_CH_MODE);
> +	if (!memcmp(buf, "single_channel", 14))
sysfs_strcmp is probably more appropriate.
> +		config2 |= ADT7316_AD_SINGLE_CH_MODE;
> +
> +	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG2, config2);
> +	if (ret)
Error eating.
> +		return -EIO;
> +
> +	chip->config2 = config2;
locking please.
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(mode, S_IRUGO | S_IWUSR,
> +		adt7316_show_mode,
> +		adt7316_store_mode,
> +		0);
> +
> +static ssize_t adt7316_show_all_modes(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	return sprintf(buf, "single_channel\nround_robin\n");
Space separated please.  Could use IIO_CONST_ATTR macro
to cover this.
> +}
> +
> +static IIO_DEVICE_ATTR(all_modes, S_IRUGO, adt7316_show_all_modes, NULL, 0);
> +
> +static ssize_t adt7316_show_ad_channel(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	if (!(chip->config2 & ADT7316_AD_SINGLE_CH_MODE))
Again, if this can happen you have a driver bug.
> +		return -EPERM;
> +
> +	switch (chip->config2 & ADT7516_AD_SINGLE_CH_MASK) {
> +	case ADT7316_AD_SINGLE_CH_VDD:
> +		return sprintf(buf, "0 - VDD\n");
> +	case ADT7316_AD_SINGLE_CH_IN:
> +		return sprintf(buf, "1 - Internal Temperature\n");
> +	case ADT7316_AD_SINGLE_CH_EX:
> +		if (((chip->id & ID_FAMILY_MASK) == ID_ADT75XX) &&
> +			(chip->config1 & ADT7516_SEL_AIN1_2_EX_TEMP_MASK) == 0)
> +			return sprintf(buf, "2 - AIN1\n");
> +		else
> +			return sprintf(buf, "2 - External Temperature\n");
> +	case ADT7516_AD_SINGLE_CH_AIN2:
> +		if ((chip->config1 & ADT7516_SEL_AIN1_2_EX_TEMP_MASK) == 0)
> +			return sprintf(buf, "3 - AIN2\n");
> +		else
> +			return sprintf(buf, "N/A\n");
> +	case ADT7516_AD_SINGLE_CH_AIN3:
> +		if (chip->config1 & ADT7516_SEL_AIN3)
> +			return sprintf(buf, "4 - AIN3\n");
> +		else
> +			return sprintf(buf, "N/A\n");
> +	case ADT7516_AD_SINGLE_CH_AIN4:
> +		return sprintf(buf, "5 - AIN4\n");
> +	default:
> +		return sprintf(buf, "N/A\n");
> +	};
> +}
> +
> +static ssize_t adt7316_store_ad_channel(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +	u8 config2;
> +	unsigned long data = 0;
> +	int ret;
> +
> +	if (!(chip->config2 & ADT7316_AD_SINGLE_CH_MODE))
> +		return -EPERM;
> +
> +	ret = strict_strtoul(buf, 10, &data);
> +	if (ret)
> +		return -EINVAL;
> +
> +	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX) {
> +		if (data > 5)
> +			return -EINVAL;
> +
> +		config2 = chip->config2 & (~ADT7516_AD_SINGLE_CH_MASK);
> +	} else {
> +		if (data > 2)
> +			return -EINVAL;
> +
> +		config2 = chip->config2 & (~ADT7316_AD_SINGLE_CH_MASK);
> +	}
> +
> +
> +	config2 |= data;
> +
> +	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG2, config2);
> +	if (ret)
> +		return -EIO;
> +
> +	chip->config2 = config2;
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(ad_channel, S_IRUGO | S_IWUSR,
> +		adt7316_show_ad_channel,
> +		adt7316_store_ad_channel,
> +		0);
> +
> +static ssize_t adt7316_show_all_ad_channels(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	if (!(chip->config2 & ADT7316_AD_SINGLE_CH_MODE))
> +		return -EPERM;
> +
> +	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
Space separated, also work on the strings, not numbers. It simplifies
this.  Though it will go anyway if abi compliant.
> +		return sprintf(buf, "0 - VDD\n1 - Internal Temperature\n"
> +				"2 - External Temperature or AIN2\n"
> +				"3 - AIN2\n4 - AIN3\n5 - AIN4\n");
> +	else
> +		return sprintf(buf, "0 - VDD\n1 - Internal Temperature\n"
> +				"2 - External Temperature\n");
> +}
> +
> +static IIO_DEVICE_ATTR(all_ad_channels, S_IRUGO,
> +		adt7316_show_all_ad_channels, NULL, 0);
> +
> +static ssize_t adt7316_show_disable_averaging(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return sprintf(buf, "%d\n",
> +		!!(chip->config2 & ADT7316_DISABLE_AVERAGING));
> +}
> +
> +static ssize_t adt7316_store_disable_averaging(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +	u8 config2;
> +	int ret;
> +
> +	config2 = chip->config2 & (~ADT7316_DISABLE_AVERAGING);
> +	if (!memcmp(buf, "1", 1))
> +		config2 |= ADT7316_DISABLE_AVERAGING;
> +
> +	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG2, config2);
> +	if (ret)
> +		return -EIO;
> +
> +	chip->config2 = config2;
> +
> +	return len;
> +}
> +
This one is new to us.  So we need to work out naming. For events
we have mean_period so something similar to that probably makes
sense.  If it applies to all channels we will need to figure out
how to indicate this.
> +static IIO_DEVICE_ATTR(disable_averaging, S_IRUGO | S_IWUSR,
> +		adt7316_show_disable_averaging,
> +		adt7316_store_disable_averaging,
> +		0);
> +
> +static ssize_t adt7316_show_enable_smbus_timeout(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return sprintf(buf, "%d\n",
> +		!!(chip->config2 & ADT7316_EN_SMBUS_TIMEOUT));
> +}
> +
> +static ssize_t adt7316_store_enable_smbus_timeout(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +	u8 config2;
> +	int ret;
> +
> +	config2 = chip->config2 & (~ADT7316_EN_SMBUS_TIMEOUT);
> +	if (!memcmp(buf, "1", 1))
> +		config2 |= ADT7316_EN_SMBUS_TIMEOUT;
> +
> +	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG2, config2);
> +	if (ret)
> +		return -EIO;
> +
> +	chip->config2 = config2;
> +
> +	return len;
> +}
> +
That's very device specific (not seen it before). Please add some
documentation for this one.
> +static IIO_DEVICE_ATTR(enable_smbus_timeout, S_IRUGO | S_IWUSR,
> +		adt7316_show_enable_smbus_timeout,
> +		adt7316_store_enable_smbus_timeout,
> +		0);
> +
> +
> +static ssize_t adt7316_store_reset(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +	u8 config2;
> +	int ret;
> +
> +	config2 = chip->config2 | ADT7316_RESET;
> +
> +	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG2, config2);
> +	if (ret)
> +		return -EIO;
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(reset, S_IWUSR,
> +		NULL,
> +		adt7316_store_reset,
> +		0);
> +

Idealy this functionality would be handled via runtime pm,
but that can occur in the future. For now it's fine with me.
> +static ssize_t adt7316_show_powerdown(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return sprintf(buf, "%d\n", !!(chip->config1 & ADT7316_PD));
> +}
> +
> +static ssize_t adt7316_store_powerdown(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +	u8 config1;
> +	int ret;
> +
> +	config1 = chip->config1 & (~ADT7316_PD);
> +	if (!memcmp(buf, "1", 1))
> +		config1 |= ADT7316_PD;
> +
> +	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, config1);
> +	if (ret)
> +		return -EIO;
> +
> +	chip->config1 = config1;
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(powerdown, S_IRUGO | S_IWUSR,
> +		adt7316_show_powerdown,
> +		adt7316_store_powerdown,
> +		0);
> +
> +static ssize_t adt7316_show_fast_ad_clock(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return sprintf(buf, "%d\n", !!(chip->config3 & ADT7316_ADCLK_22_5));
> +}
> +
> +static ssize_t adt7316_store_fast_ad_clock(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +	u8 config3;
> +	int ret;
> +
> +	config3 = chip->config3 & (~ADT7316_ADCLK_22_5);
> +	if (!memcmp(buf, "1", 1))
> +		config3 |= ADT7316_ADCLK_22_5;
> +
> +	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
> +	if (ret)
> +		return -EIO;
> +
> +	chip->config3 = config3;
> +
> +	return len;
> +}
> +
Guessing this corresponds indirectly to sampling_frequency?
> +static IIO_DEVICE_ATTR(fast_ad_clock, S_IRUGO | S_IWUSR,
> +		adt7316_show_fast_ad_clock,
> +		adt7316_store_fast_ad_clock,
> +		0);
> +
> +static ssize_t adt7316_show_da_high_resolution(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	if (chip->config3 & ADT7316_DA_HIGH_RESOLUTION) {
> +		if (chip->id == ID_ADT7316 || chip->id == ID_ADT7516)
> +			return sprintf(buf, "1 (12 bits)\n");
> +		else if (chip->id == ID_ADT7317 || chip->id == ID_ADT7517)
> +			return sprintf(buf, "1 (10 bits)\n");
> +	}
> +
> +	return sprintf(buf, "0 (8 bits)\n");
No. We have type attributes for this and never allow magic numbers.

> +}
> +
> +static ssize_t adt7316_store_da_high_resolution(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +	u8 config3;
> +	int ret;
> +
> +	chip->dac_bits = 8;
> +
> +	if (!memcmp(buf, "1", 1)) {
> +		config3 = chip->config3 | ADT7316_DA_HIGH_RESOLUTION;
> +		if (chip->id == ID_ADT7316 || chip->id == ID_ADT7516)
> +			chip->dac_bits = 12;
> +		else if (chip->id == ID_ADT7317 || chip->id == ID_ADT7517)
> +			chip->dac_bits = 10;
> +	} else
> +		config3 = chip->config3 & (~ADT7316_DA_HIGH_RESOLUTION);
> +
> +	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
> +	if (ret)
> +		return -EIO;
> +
> +	chip->config3 = config3;
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(da_high_resolution, S_IRUGO | S_IWUSR,
> +		adt7316_show_da_high_resolution,
> +		adt7316_store_da_high_resolution,
> +		0);
> +
> +static ssize_t adt7316_show_AIN_internal_Vref(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	if ((chip->id & ID_FAMILY_MASK) != ID_ADT75XX)
Again, can it happen?
> +		return -EPERM;
> +
> +	return sprintf(buf, "%d\n",
> +		!!(chip->config3 & ADT7516_AIN_IN_VREF));
> +}
> +
> +static ssize_t adt7316_store_AIN_internal_Vref(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +	u8 config3;
> +	int ret;
> +
> +	if ((chip->id & ID_FAMILY_MASK) != ID_ADT75XX)
> +		return -EPERM;
> +
> +	if (memcmp(buf, "1", 1))
> +		config3 = chip->config3 & (~ADT7516_AIN_IN_VREF);
> +	else
> +		config3 = chip->config3 | ADT7516_AIN_IN_VREF;
> +
> +	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
> +	if (ret)
error eating.
> +		return -EIO;
> +
> +	chip->config3 = config3;
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(AIN_internal_Vref, S_IRUGO | S_IWUSR,
> +		adt7316_show_AIN_internal_Vref,
> +		adt7316_store_AIN_internal_Vref,
> +		0);
> +
> +
> +static ssize_t adt7316_show_enable_prop_DACA(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return sprintf(buf, "%d\n",
> +		!!(chip->config3 & ADT7316_EN_IN_TEMP_PROP_DACA));
> +}
> +
> +static ssize_t adt7316_store_enable_prop_DACA(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +	u8 config3;
> +	int ret;
> +
> +	config3 = chip->config3 & (~ADT7316_EN_IN_TEMP_PROP_DACA);
> +	if (!memcmp(buf, "1", 1))
> +		config3 |= ADT7316_EN_IN_TEMP_PROP_DACA;
> +
> +	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
> +	if (ret)
> +		return -EIO;
> +
> +	chip->config3 = config3;
> +
> +	return len;
> +}
> +
I don't know what this is, so at very least it nees docs.  
> +static IIO_DEVICE_ATTR(enable_proportion_DACA, S_IRUGO | S_IWUSR,
> +		adt7316_show_enable_prop_DACA,
> +		adt7316_store_enable_prop_DACA,
> +		0);
> +
> +static ssize_t adt7316_show_enable_prop_DACB(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return sprintf(buf, "%d\n",
> +		!!(chip->config3 & ADT7316_EN_EX_TEMP_PROP_DACB));
> +}
> +
> +static ssize_t adt7316_store_enable_prop_DACB(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +	u8 config3;
> +	int ret;
> +
> +	config3 = chip->config3 & (~ADT7316_EN_EX_TEMP_PROP_DACB);
> +	if (!memcmp(buf, "1", 1))
> +		config3 |= ADT7316_EN_EX_TEMP_PROP_DACB;
> +
> +	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
> +	if (ret)
> +		return -EIO;
> +
> +	chip->config3 = config3;
> +
> +	return len;
> +}
> +
Also needs docs and I'm very anti acronyms unless they are very very
well known.
> +static IIO_DEVICE_ATTR(enable_proportion_DACB, S_IRUGO | S_IWUSR,
> +		adt7316_show_enable_prop_DACB,
> +		adt7316_store_enable_prop_DACB,
> +		0);
> +
> +static ssize_t adt7316_show_DAC_2Vref_ch_mask(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return sprintf(buf, "0x%x\n",
> +		chip->dac_config & ADT7316_DA_2VREF_CH_MASK);
> +}
> +
> +static ssize_t adt7316_store_DAC_2Vref_ch_mask(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +	u8 dac_config;
> +	unsigned long data = 0;
> +	int ret;
> +
> +	ret = strict_strtoul(buf, 16, &data);
> +	if (ret || data > ADT7316_DA_2VREF_CH_MASK)
> +		return -EINVAL;
> +
> +	dac_config = chip->dac_config & (~ADT7316_DA_2VREF_CH_MASK);
> +	dac_config |= data;
> +
> +	ret = chip->bus.write(chip->bus.client, ADT7316_DAC_CONFIG, dac_config);
> +	if (ret)
> +		return -EIO;
> +
> +	chip->dac_config = dac_config;
> +
> +	return len;
> +}
> +
This interface needs clean documentation so we can discuss it.

> +static IIO_DEVICE_ATTR(DAC_2Vref_channels_mask, S_IRUGO | S_IWUSR,
> +		adt7316_show_DAC_2Vref_ch_mask,
> +		adt7316_store_DAC_2Vref_ch_mask,
> +		0);
> +
> +static ssize_t adt7316_show_DAC_update_mode(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	if (!(chip->config3 & ADT7316_DA_EN_VIA_DAC_LDCA))
> +		return sprintf(buf, "manual\n");
> +	else {
> +		switch (chip->dac_config & ADT7316_DA_EN_MODE_MASK) {
> +		case ADT7316_DA_EN_MODE_SINGLE:
> +			return sprintf(buf, "0 - auto at any MSB DAC writing\n");
> +		case ADT7316_DA_EN_MODE_AB_CD:
> +			return sprintf(buf, "1 - auto at MSB DAC AB and CD writing\n");
> +		case ADT7316_DA_EN_MODE_ABCD:
> +			return sprintf(buf, "2 - auto at MSB DAC ABCD writing\n");
> +		default: /* ADT7316_DA_EN_MODE_LDAC */
> +			return sprintf(buf, "3 - manual\n");
The word 'ouch' comes to mind.  This interface needs detailed description and
general discussion.
> +		};
> +	}
> +}
> +
> +static ssize_t adt7316_store_DAC_update_mode(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +	u8 dac_config;
> +	unsigned long data;
> +	int ret;
> +
> +	if (!(chip->config3 & ADT7316_DA_EN_VIA_DAC_LDCA))
> +		return -EPERM;
> +
> +	ret = strict_strtoul(buf, 10, &data);
> +	if (ret || data > ADT7316_DA_EN_MODE_MASK)
> +		return -EINVAL;
> +
> +	dac_config = chip->dac_config & (~ADT7316_DA_EN_MODE_MASK);
> +	dac_config |= data;
> +
> +	ret = chip->bus.write(chip->bus.client, ADT7316_DAC_CONFIG, dac_config);
> +	if (ret)
error eating and locking again.
> +		return -EIO;
> +
> +	chip->dac_config = dac_config;
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(DAC_update_mode, S_IRUGO | S_IWUSR,
> +		adt7316_show_DAC_update_mode,
> +		adt7316_store_DAC_update_mode,
> +		0);
> +
> +static ssize_t adt7316_show_all_DAC_update_modes(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	if (chip->config3 & ADT7316_DA_EN_VIA_DAC_LDCA)
> +		return sprintf(buf, "0 - auto at any MSB DAC writing\n"
> +				"1 - auto at MSB DAC AB and CD writing\n"
> +				"2 - auto at MSB DAC ABCD writing\n"
> +				"3 - manual\n");
> +	else
> +		return sprintf(buf, "manual\n");
> +}
> +
> +static IIO_DEVICE_ATTR(all_DAC_update_modes, S_IRUGO,
> +		adt7316_show_all_DAC_update_modes, NULL, 0);
> +
> +
> +static ssize_t adt7316_store_update_DAC(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +	u8 ldac_config;
> +	unsigned long data;
> +	int ret;
> +
> +	if (chip->config3 & ADT7316_DA_EN_VIA_DAC_LDCA) {
> +		if ((chip->dac_config & ADT7316_DA_EN_MODE_MASK) !=
> +			ADT7316_DA_EN_MODE_LDAC)
> +			return -EPERM;
> +
> +		ret = strict_strtoul(buf, 16, &data);
> +		if (ret || data > ADT7316_LDAC_EN_DA_MASK)
> +			return -EINVAL;
> +
> +		ldac_config = chip->ldac_config & (~ADT7316_LDAC_EN_DA_MASK);
> +		ldac_config |= data;
> +
> +		ret = chip->bus.write(chip->bus.client, ADT7316_LDAC_CONFIG,
> +			ldac_config);
> +		if (ret)
> +			return -EIO;
> +	} else {
> +		gpio_set_value(chip->ldac_pin, 0);
> +		gpio_set_value(chip->ldac_pin, 1);
> +	}
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(update_DAC, S_IRUGO | S_IWUSR,
> +		NULL,
> +		adt7316_store_update_DAC,
> +		0);
> +
> +static ssize_t adt7316_show_DA_AB_Vref_bypass(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
> +		return -EPERM;
> +
> +	return sprintf(buf, "%d\n",
> +		!!(chip->dac_config & ADT7316_VREF_BYPASS_DAC_AB));
> +}
> +
> +static ssize_t adt7316_store_DA_AB_Vref_bypass(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +	u8 dac_config;
> +	int ret;
> +
> +	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
> +		return -EPERM;
> +
> +	dac_config = chip->dac_config & (~ADT7316_VREF_BYPASS_DAC_AB);
> +	if (!memcmp(buf, "1", 1))
> +		dac_config |= ADT7316_VREF_BYPASS_DAC_AB;
> +
> +	ret = chip->bus.write(chip->bus.client, ADT7316_DAC_CONFIG, dac_config);
> +	if (ret)
> +		return -EIO;
> +
> +	chip->dac_config = dac_config;
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(DA_AB_Vref_bypass, S_IRUGO | S_IWUSR,
> +		adt7316_show_DA_AB_Vref_bypass,
> +		adt7316_store_DA_AB_Vref_bypass,
> +		0);
> +
> +static ssize_t adt7316_show_DA_CD_Vref_bypass(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
> +		return -EPERM;
> +
> +	return sprintf(buf, "%d\n",
> +		!!(chip->dac_config & ADT7316_VREF_BYPASS_DAC_CD));
> +}
> +
> +static ssize_t adt7316_store_DA_CD_Vref_bypass(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +	u8 dac_config;
> +	int ret;
> +
> +	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
> +		return -EPERM;
> +
> +	dac_config = chip->dac_config & (~ADT7316_VREF_BYPASS_DAC_CD);
> +	if (!memcmp(buf, "1", 1))
> +		dac_config |= ADT7316_VREF_BYPASS_DAC_CD;
> +
> +	ret = chip->bus.write(chip->bus.client, ADT7316_DAC_CONFIG, dac_config);
> +	if (ret)
locking + error eating.
> +		return -EIO;
> +
> +	chip->dac_config = dac_config;
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(DA_CD_Vref_bypass, S_IRUGO | S_IWUSR,
> +		adt7316_show_DA_CD_Vref_bypass,
> +		adt7316_store_DA_CD_Vref_bypass,
> +		0);
> +
> +static ssize_t adt7316_show_DAC_internal_Vref(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
> +		return sprintf(buf, "0x%x\n",
> +			(chip->dac_config & ADT7516_DAC_IN_VREF_MASK) >>
> +			ADT7516_DAC_IN_VREF_OFFSET);
Why in hex?
> +	else
> +		return sprintf(buf, "%d\n",
> +			!!(chip->dac_config & ADT7316_DAC_IN_VREF));
> +}
> +
> +static ssize_t adt7316_store_DAC_internal_Vref(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +	u8 ldac_config;
> +	unsigned long data;
> +	int ret;
> +
> +	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX) {
> +		ret = strict_strtoul(buf, 16, &data);
> +		if (ret || data > 3)
> +			return -EINVAL;
> +
> +		ldac_config = chip->ldac_config & (~ADT7516_DAC_IN_VREF_MASK);
> +		if (data & 0x1)
> +			ldac_config |= ADT7516_DAC_AB_IN_VREF;
> +		else if (data & 0x2)
> +			ldac_config |= ADT7516_DAC_CD_IN_VREF;
> +	} else {
> +		ret = strict_strtoul(buf, 16, &data);
> +		if (ret)
error eating.. (at least I think in theory that function can be more specific).
> +			return -EINVAL;
> +
> +		ldac_config = chip->ldac_config & (~ADT7316_DAC_IN_VREF);
> +		if (data)
> +			ldac_config = chip->ldac_config | ADT7316_DAC_IN_VREF;
> +	}
> +
> +	ret = chip->bus.write(chip->bus.client, ADT7316_LDAC_CONFIG, ldac_config);
> +	if (ret)
> +		return -EIO;
> +
> +	chip->ldac_config = ldac_config;
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(DAC_internal_Vref, S_IRUGO | S_IWUSR,
> +		adt7316_show_DAC_internal_Vref,
> +		adt7316_store_DAC_internal_Vref,
> +		0);
> +
> +static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
> +		int channel, char *buf)
> +{
> +	u16 data;
> +	u8 msb, lsb;
> +	char sign = ' ';
> +	int ret;
> +
> +	if ((chip->config2 & ADT7316_AD_SINGLE_CH_MODE) &&
> +		channel != (chip->config2 & ADT7516_AD_SINGLE_CH_MASK))
> +		return -EPERM;
> +
> +	switch (channel) {
> +	case ADT7316_AD_SINGLE_CH_IN:
> +		ret = chip->bus.read(chip->bus.client,
> +			ADT7316_LSB_IN_TEMP_VDD, &lsb);
> +		if (ret)
> +			return -EIO;
> +
> +		ret = chip->bus.read(chip->bus.client,
> +			ADT7316_AD_MSB_DATA_BASE + channel, &msb);
> +		if (ret)
> +			return -EIO;
> +
> +		data = msb << ADT7316_T_VALUE_FLOAT_OFFSET;
> +		data |= lsb & ADT7316_LSB_IN_TEMP_MASK;
> +		break;
> +	case ADT7316_AD_SINGLE_CH_VDD:
> +		ret = chip->bus.read(chip->bus.client,
> +			ADT7316_LSB_IN_TEMP_VDD, &lsb);
> +		if (ret)
error eating
> +			return -EIO;
> +
> +		ret = chip->bus.read(chip->bus.client,
> +
> +			ADT7316_AD_MSB_DATA_BASE + channel, &msb);
> +		if (ret)
> +			return -EIO;
> +
> +		data = msb << ADT7316_T_VALUE_FLOAT_OFFSET;
> +		data |= (lsb & ADT7316_LSB_VDD_MASK) >> ADT7316_LSB_VDD_OFFSET;
> +		return sprintf(buf, "%d\n", data);
> +	default: /* ex_temp and ain */
> +		ret = chip->bus.read(chip->bus.client,
> +			ADT7316_LSB_EX_TEMP_AIN, &lsb);
> +		if (ret)
> +			return -EIO;
> +
> +		ret = chip->bus.read(chip->bus.client,
> +			ADT7316_AD_MSB_DATA_BASE + channel, &msb);
> +		if (ret)
> +			return -EIO;
> +
> +		data = msb << ADT7316_T_VALUE_FLOAT_OFFSET;
> +		data |= lsb & (ADT7316_LSB_EX_TEMP_MASK <<
> +			(ADT7516_LSB_AIN_SHIFT * (channel -
> +			(ADT7316_MSB_EX_TEMP - ADT7316_AD_MSB_DATA_BASE))));
> +
> +		if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
> +			return sprintf(buf, "%d\n", data);
> +		else
> +			break;
> +	};
> +
> +	if (data & ADT7316_T_VALUE_SIGN) {
> +		/* convert supplement to positive value */
> +		data = (ADT7316_T_VALUE_SIGN << 1) - data;
> +		sign = '-';
> +	}
> +
> +	return sprintf(buf, "%c%d.%.2d\n", sign,
> +		(data >> ADT7316_T_VALUE_FLOAT_OFFSET),
> +		(data & ADT7316_T_VALUE_FLOAT_MASK) * 25);
> +}
> +
> +static ssize_t adt7316_show_VDD(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return adt7316_show_ad(chip, ADT7316_AD_SINGLE_CH_VDD, buf);
> +}
> +static IIO_DEVICE_ATTR(VDD, S_IRUGO, adt7316_show_VDD, NULL, 0);
> +
> +static ssize_t adt7316_show_in_temp(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return adt7316_show_ad(chip, ADT7316_AD_SINGLE_CH_IN, buf);
> +}
> +
> +static IIO_DEVICE_ATTR(in_temp, S_IRUGO, adt7316_show_in_temp, NULL, 0);
temp_raw please - unless it really is just a general purpose adc then there
is probably no point in calling it temp at all.

> +
> +static ssize_t adt7316_show_ex_temp_AIN1(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return adt7316_show_ad(chip, ADT7316_AD_SINGLE_CH_EX, buf);
> +}
> +
> +static IIO_DEVICE_ATTR(ex_temp_AIN1, S_IRUGO, adt7316_show_ex_temp_AIN1, NULL, 0);
No way too that naming.  Please either switch to standard naming or explain why
that doesn't work.

> +static IIO_DEVICE_ATTR(ex_temp, S_IRUGO, adt7316_show_ex_temp_AIN1, NULL, 0);
> +
> +static ssize_t adt7316_show_AIN2(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return adt7316_show_ad(chip, ADT7516_AD_SINGLE_CH_AIN2, buf);
> +}
> +static IIO_DEVICE_ATTR(AIN2, S_IRUGO, adt7316_show_AIN2, NULL, 0);
Again we have standard names. Please use them.  in2_raw I would imagine
there are wrapper macros for these.
> +
> +static ssize_t adt7316_show_AIN3(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return adt7316_show_ad(chip, ADT7516_AD_SINGLE_CH_AIN3, buf);
> +}
> +static IIO_DEVICE_ATTR(AIN3, S_IRUGO, adt7316_show_AIN3, NULL, 0);
> +
> +static ssize_t adt7316_show_AIN4(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return adt7316_show_ad(chip, ADT7516_AD_SINGLE_CH_AIN4, buf);
> +}
> +static IIO_DEVICE_ATTR(AIN4, S_IRUGO, adt7316_show_AIN4, NULL, 0);
> +
> +static ssize_t adt7316_show_temp_offset(struct adt7316_chip_info *chip,
> +		int offset_addr, char *buf)
> +{
> +	int data;
> +	u8 val;
> +	int ret;
> +
> +	ret = chip->bus.read(chip->bus.client, offset_addr, &val);
> +	if (ret)
error eating.
> +		return -EIO;
> +
> +	data = (int)val;
> +	if (val & 0x80)
> +		data -= 256;
> +
> +	return sprintf(buf, "%d\n", data);
> +}
> +
> +static ssize_t adt7316_store_temp_offset(struct adt7316_chip_info *chip,
> +		int offset_addr, const char *buf, size_t len)
> +{
> +	long data;
> +	u8 val;
> +	int ret;
> +
> +	ret = strict_strtol(buf, 10, &data);
> +	if (ret || data > 127 || data < -128)
> +		return -EINVAL;
> +
> +	if (data < 0)
> +		data += 256;
> +
> +	val = (u8)data;
> +
> +	ret = chip->bus.write(chip->bus.client, offset_addr, val);
> +	if (ret)
error eating.
> +		return -EIO;
> +
> +	return len;
> +}
> +
> +static ssize_t adt7316_show_in_temp_offset(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return adt7316_show_temp_offset(chip, ADT7316_IN_TEMP_OFFSET, buf);
> +}
> +
> +static ssize_t adt7316_store_in_temp_offset(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return adt7316_store_temp_offset(chip, ADT7316_IN_TEMP_OFFSET, buf, len);
> +}
> +
> +static IIO_DEVICE_ATTR(in_temp_offset, S_IRUGO | S_IWUSR,
> +		adt7316_show_in_temp_offset,
> +		adt7316_store_in_temp_offset, 0);
temp_offset if it covers both types of temperature input, temp0_offset
if not.
> +
> +static ssize_t adt7316_show_ex_temp_offset(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return adt7316_show_temp_offset(chip, ADT7316_EX_TEMP_OFFSET, buf);
> +}
> +
> +static ssize_t adt7316_store_ex_temp_offset(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return adt7316_store_temp_offset(chip, ADT7316_EX_TEMP_OFFSET, buf, len);
> +}
> +
> +static IIO_DEVICE_ATTR(ex_temp_offset, S_IRUGO | S_IWUSR,
> +		adt7316_show_ex_temp_offset,
> +		adt7316_store_ex_temp_offset, 0);
> +
> +static ssize_t adt7316_show_in_analog_temp_offset(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return adt7316_show_temp_offset(chip,
> +			ADT7316_IN_ANALOG_TEMP_OFFSET, buf);
> +}
> +
> +static ssize_t adt7316_store_in_analog_temp_offset(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return adt7316_store_temp_offset(chip,
> +			ADT7316_IN_ANALOG_TEMP_OFFSET, buf, len);
> +}
> +
> +static IIO_DEVICE_ATTR(in_analog_temp_offset, S_IRUGO | S_IWUSR,
> +		adt7316_show_in_analog_temp_offset,
> +		adt7316_store_in_analog_temp_offset, 0);
> +
> +static ssize_t adt7316_show_ex_analog_temp_offset(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return adt7316_show_temp_offset(chip,
> +			ADT7316_EX_ANALOG_TEMP_OFFSET, buf);
> +}
> +
> +static ssize_t adt7316_store_ex_analog_temp_offset(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return adt7316_store_temp_offset(chip,
> +			ADT7316_EX_ANALOG_TEMP_OFFSET, buf, len);
> +}
> +
> +static IIO_DEVICE_ATTR(ex_analog_temp_offset, S_IRUGO | S_IWUSR,
> +		adt7316_show_ex_analog_temp_offset,
> +		adt7316_store_ex_analog_temp_offset, 0);
No way to that naming.

temp1_ex_raw maybe.
> +
> +static ssize_t adt7316_show_DAC(struct adt7316_chip_info *chip,
> +		int channel, char *buf)
> +{
> +	u16 data;
> +	u8 msb, lsb, offset;
> +	int ret;
> +
> +	if (channel >= ADT7316_DA_MSB_DATA_REGS ||
> +		(channel == 0 &&
> +		(chip->config3 & ADT7316_EN_IN_TEMP_PROP_DACA)) ||
> +		(channel == 1 &&
> +		(chip->config3 & ADT7316_EN_EX_TEMP_PROP_DACB)))
> +		return -EPERM;
> +
> +	offset = chip->dac_bits - 8;
> +
> +	if (chip->dac_bits > 8) {
> +		ret = chip->bus.read(chip->bus.client,
> +			ADT7316_DA_DATA_BASE + channel * 2, &lsb);
> +		if (ret)
> +			return -EIO;
> +	}
> +
> +	ret = chip->bus.read(chip->bus.client,
> +		ADT7316_DA_DATA_BASE + 1 + channel * 2, &msb);
> +	if (ret)
error eating.
> +		return -EIO;
> +
> +	data = (msb << offset) + (lsb & ((1 << offset) - 1));
> +
> +	return sprintf(buf, "%d\n", data);
> +}
> +
> +static ssize_t adt7316_store_DAC(struct adt7316_chip_info *chip,
> +		int channel, const char *buf, size_t len)
> +{
> +	u8 msb, lsb, offset;
> +	unsigned long data;
> +	int ret;
> +
> +	if (channel >= ADT7316_DA_MSB_DATA_REGS ||
> +		(channel == 0 &&
> +		(chip->config3 & ADT7316_EN_IN_TEMP_PROP_DACA)) ||
> +		(channel == 1 &&
> +		(chip->config3 & ADT7316_EN_EX_TEMP_PROP_DACB)))
> +		return -EPERM;
> +
> +	offset = chip->dac_bits - 8;
> +
> +	ret = strict_strtoul(buf, 10, &data);
> +	if (ret || data >= (1 << chip->dac_bits))
> +		return -EINVAL;
> +
> +	if (chip->dac_bits > 8) {
> +		lsb = data & (1 << offset);
> +		ret = chip->bus.write(chip->bus.client,
> +			ADT7316_DA_DATA_BASE + channel * 2, lsb);
> +		if (ret)
> +			return -EIO;
> +	}
> +
> +	msb = data >> offset;
> +	ret = chip->bus.write(chip->bus.client,
> +		ADT7316_DA_DATA_BASE + 1 + channel * 2, msb);
> +	if (ret)
error eating.
> +		return -EIO;
> +
> +	return len;
> +}
> +
> +static ssize_t adt7316_show_DAC_A(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return adt7316_show_DAC(chip, 0, buf);
> +}
> +
> +static ssize_t adt7316_store_DAC_A(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return adt7316_store_DAC(chip, 0, buf, len);
> +}
> +
Don't know what this is, but that name is nowhere near any of out abis
> +static IIO_DEVICE_ATTR(DAC_A, S_IRUGO | S_IWUSR, adt7316_show_DAC_A,
> +		adt7316_store_DAC_A, 0);
> +
> +static ssize_t adt7316_show_DAC_B(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return adt7316_show_DAC(chip, 1, buf);
> +}
> +
> +static ssize_t adt7316_store_DAC_B(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return adt7316_store_DAC(chip, 1, buf, len);
> +}
> +
> +static IIO_DEVICE_ATTR(DAC_B, S_IRUGO | S_IWUSR, adt7316_show_DAC_B,
> +		adt7316_store_DAC_B, 0);
> +
> +static ssize_t adt7316_show_DAC_C(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return adt7316_show_DAC(chip, 2, buf);
> +}
> +
> +static ssize_t adt7316_store_DAC_C(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return adt7316_store_DAC(chip, 2, buf, len);
> +}
> +
> +static IIO_DEVICE_ATTR(DAC_C, S_IRUGO | S_IWUSR, adt7316_show_DAC_C,
> +		adt7316_store_DAC_C, 0);
> +
> +static ssize_t adt7316_show_DAC_D(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return adt7316_show_DAC(chip, 3, buf);
> +}
> +
> +static ssize_t adt7316_store_DAC_D(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return adt7316_store_DAC(chip, 3, buf, len);
> +}
> +
If nothing else these need to be number based + I think we should keep
to lower case (though I may be convinced otherwise), so dac4_raw

> +static IIO_DEVICE_ATTR(DAC_D, S_IRUGO | S_IWUSR, adt7316_show_DAC_D,
> +		adt7316_store_DAC_D, 0);
> +
> +static ssize_t adt7316_show_device_id(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +	u8 id;
> +	int ret;
> +
> +	ret = chip->bus.read(chip->bus.client, ADT7316_DEVICE_ID, &id);
> +	if (ret)
> +		return -EIO;
> +
> +	return sprintf(buf, "%d\n", id);
> +}
> +
> +static IIO_DEVICE_ATTR(device_id, S_IRUGO, adt7316_show_device_id, NULL, 0);
> +
> +static ssize_t adt7316_show_manufactorer_id(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +	u8 id;
> +	int ret;
> +
> +	ret = chip->bus.read(chip->bus.client, ADT7316_MANUFACTURE_ID, &id);
> +	if (ret)
> +		return -EIO;
> +
> +	return sprintf(buf, "%d\n", id);
> +}
> +
> +static IIO_DEVICE_ATTR(manufactorer_id, S_IRUGO,
> +		adt7316_show_manufactorer_id, NULL, 0);
> +
> +static ssize_t adt7316_show_device_rev(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +	u8 rev;
> +	int ret;
> +
> +	ret = chip->bus.read(chip->bus.client, ADT7316_DEVICE_REV, &rev);
> +	if (ret)
> +		return -EIO;
> +
> +	return sprintf(buf, "%d\n", rev);
> +}
> +
> +static IIO_DEVICE_ATTR(device_rev, S_IRUGO, adt7316_show_device_rev, NULL, 0);
Is this of interest beyond for matching against the device that was registered?
Not sure why userspce would care...
> +
> +static ssize_t adt7316_show_bus_type(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +	u8 stat;
> +	int ret;
> +
> +	ret = chip->bus.read(chip->bus.client, ADT7316_SPI_LOCK_STAT, &stat);
> +	if (ret)
> +		return -EIO;
> +
> +	if (stat)
> +		return sprintf(buf, "spi\n");
> +	else
> +		return sprintf(buf, "i2c\n");
> +}
Don't see any point in this at all.
By all means try and convince me otherwise.

> +
> +static IIO_DEVICE_ATTR(bus_type, S_IRUGO, adt7316_show_bus_type, NULL, 0);
> +
> +static ssize_t adt7316_show_name(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return sprintf(buf, "%s\n", chip->name);
> +}
> +
> +static IIO_DEVICE_ATTR(name, S_IRUGO, adt7316_show_name, NULL, 0);
> +

Lets sumarize those I'm not happy with in here.
> +static struct attribute *adt7316_attributes[] = {
> +	&iio_dev_attr_all_modes.dev_attr.attr,
modes_available or fix to be abi compliant.
> +	&iio_dev_attr_mode.dev_attr.attr,
> +	&iio_dev_attr_reset.dev_attr.attr,
> +	&iio_dev_attr_enabled.dev_attr.attr,
difference between this and powerdown?
> +	&iio_dev_attr_ad_channel.dev_attr.attr,
Each channel should have separate access and driver should handle
switching to the required one.  If really not possible in_channel
> +	&iio_dev_attr_all_ad_channels.dev_attr.attr,
If it were here in_channel_available (though not abi compatible).
> +	&iio_dev_attr_disable_averaging.dev_attr.attr,
in_mean_period 0 for disable, whatever the period is (in seconds)
otherwise.
> +	&iio_dev_attr_enable_smbus_timeout.dev_attr.attr,
> +	&iio_dev_attr_powerdown.dev_attr.attr,
> +	&iio_dev_attr_fast_ad_clock.dev_attr.attr,
sampling_frequency
> +	&iio_dev_attr_da_high_resolution.dev_attr.attr,
in_type (or possibly type if it covers temp as well.
> +	&iio_dev_attr_enable_proportion_DACA.dev_attr.attr,
Don't know what this is.
> +	&iio_dev_attr_enable_proportion_DACB.dev_attr.attr,
> +	&iio_dev_attr_DAC_2Vref_channels_mask.dev_attr.attr,
not a clue.
> +	&iio_dev_attr_DAC_update_mode.dev_attr.attr,
> +	&iio_dev_attr_all_DAC_update_modes.dev_attr.attr,
DAC_update_mode_available is convention. (though not
happy with the base name either).

> +	&iio_dev_attr_update_DAC.dev_attr.attr,
> +	&iio_dev_attr_DA_AB_Vref_bypass.dev_attr.attr,
> +	&iio_dev_attr_DA_CD_Vref_bypass.dev_attr.attr,
> +	&iio_dev_attr_DAC_internal_Vref.dev_attr.attr,
> +	&iio_dev_attr_VDD.dev_attr.attr,
in0_supply_raw
> +	&iio_dev_attr_in_temp.dev_attr.attr,
temp0_raw
> +	&iio_dev_attr_ex_temp.dev_attr.attr,
temp1_external_raw
> +	&iio_dev_attr_in_temp_offset.dev_attr.attr,
temp0_offset
> +	&iio_dev_attr_ex_temp_offset.dev_attr.attr,
temp1_external_offset
> +	&iio_dev_attr_in_analog_temp_offset.dev_attr.attr,
> +	&iio_dev_attr_ex_analog_temp_offset.dev_attr.attr,
What are the differences between these and the non analog versions?
> +	&iio_dev_attr_DAC_A.dev_attr.attr,
> +	&iio_dev_attr_DAC_B.dev_attr.attr,
> +	&iio_dev_attr_DAC_C.dev_attr.attr,
> +	&iio_dev_attr_DAC_D.dev_attr.attr,
dac0_raw to dac3_raw (not in abi yet sho should be discussed.
> +	&iio_dev_attr_device_id.dev_attr.attr,
> +	&iio_dev_attr_manufactorer_id.dev_attr.attr,
> +	&iio_dev_attr_device_rev.dev_attr.attr,
> +	&iio_dev_attr_bus_type.dev_attr.attr,
pointless.  Can always find this out from sysfs anyway (look at parent
of the device).
> +	&iio_dev_attr_name.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group adt7316_attribute_group = {
> +	.attrs = adt7316_attributes,
> +};
> +
> +static struct attribute *adt7516_attributes[] = {
> +	&iio_dev_attr_all_modes.dev_attr.attr,
> +	&iio_dev_attr_mode.dev_attr.attr,
> +	&iio_dev_attr_select_ex_temp.dev_attr.attr,
> +	&iio_dev_attr_reset.dev_attr.attr,
> +	&iio_dev_attr_enabled.dev_attr.attr,
> +	&iio_dev_attr_ad_channel.dev_attr.attr,
> +	&iio_dev_attr_all_ad_channels.dev_attr.attr,
> +	&iio_dev_attr_disable_averaging.dev_attr.attr,
> +	&iio_dev_attr_enable_smbus_timeout.dev_attr.attr,
> +	&iio_dev_attr_powerdown.dev_attr.attr,
> +	&iio_dev_attr_fast_ad_clock.dev_attr.attr,
> +	&iio_dev_attr_AIN_internal_Vref.dev_attr.attr,
> +	&iio_dev_attr_da_high_resolution.dev_attr.attr,
> +	&iio_dev_attr_enable_proportion_DACA.dev_attr.attr,
> +	&iio_dev_attr_enable_proportion_DACB.dev_attr.attr,
> +	&iio_dev_attr_DAC_2Vref_channels_mask.dev_attr.attr,
> +	&iio_dev_attr_DAC_update_mode.dev_attr.attr,
> +	&iio_dev_attr_all_DAC_update_modes.dev_attr.attr,
> +	&iio_dev_attr_update_DAC.dev_attr.attr,
> +	&iio_dev_attr_DA_AB_Vref_bypass.dev_attr.attr,
> +	&iio_dev_attr_DA_CD_Vref_bypass.dev_attr.attr,
> +	&iio_dev_attr_DAC_internal_Vref.dev_attr.attr,
> +	&iio_dev_attr_VDD.dev_attr.attr,
> +	&iio_dev_attr_in_temp.dev_attr.attr,
> +	&iio_dev_attr_ex_temp_AIN1.dev_attr.attr,
> +	&iio_dev_attr_AIN2.dev_attr.attr,
> +	&iio_dev_attr_AIN3.dev_attr.attr,
> +	&iio_dev_attr_AIN4.dev_attr.attr,
> +	&iio_dev_attr_in_temp_offset.dev_attr.attr,
> +	&iio_dev_attr_ex_temp_offset.dev_attr.attr,
> +	&iio_dev_attr_in_analog_temp_offset.dev_attr.attr,
> +	&iio_dev_attr_ex_analog_temp_offset.dev_attr.attr,
> +	&iio_dev_attr_DAC_A.dev_attr.attr,
> +	&iio_dev_attr_DAC_B.dev_attr.attr,
> +	&iio_dev_attr_DAC_C.dev_attr.attr,
> +	&iio_dev_attr_DAC_D.dev_attr.attr,
> +	&iio_dev_attr_device_id.dev_attr.attr,
> +	&iio_dev_attr_manufactorer_id.dev_attr.attr,
> +	&iio_dev_attr_device_rev.dev_attr.attr,
> +	&iio_dev_attr_bus_type.dev_attr.attr,
> +	&iio_dev_attr_name.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group adt7516_attribute_group = {
> +	.attrs = adt7516_attributes,
> +};
> +
> +
> +/*
> + * temperature bound events
> + */
> +
> +#define IIO_EVENT_CODE_ADT7316_IN_TEMP_HIGH   (IIO_EVENT_CODE_DEVICE_SPECIFIC + 1)
> +#define IIO_EVENT_CODE_ADT7316_IN_TEMP_LOW    (IIO_EVENT_CODE_DEVICE_SPECIFIC + 2)
These aren't device specific.  We have perfectly good codes for them.  Also note
the event codes have all changed so you'll need to update.
> +#define IIO_EVENT_CODE_ADT7316_EX_TEMP_HIGH   (IIO_EVENT_CODE_DEVICE_SPECIFIC + 3)
> +#define IIO_EVENT_CODE_ADT7316_EX_TEMP_LOW    (IIO_EVENT_CODE_DEVICE_SPECIFIC + 4)
> +#define IIO_EVENT_CODE_ADT7316_EX_TEMP_FAULT  (IIO_EVENT_CODE_DEVICE_SPECIFIC + 5)
This is the only one not currently there.  Happy to add a type for that one. Please
propose something suitable under the new event code structure.

All perfectly well handled by standard events.
> +#define IIO_EVENT_CODE_ADT7516_AIN1           (IIO_EVENT_CODE_DEVICE_SPECIFIC + 3)
> +#define IIO_EVENT_CODE_ADT7516_AIN2           (IIO_EVENT_CODE_DEVICE_SPECIFIC + 6)
> +#define IIO_EVENT_CODE_ADT7516_AIN3           (IIO_EVENT_CODE_DEVICE_SPECIFIC + 7)
> +#define IIO_EVENT_CODE_ADT7516_AIN4           (IIO_EVENT_CODE_DEVICE_SPECIFIC + 8)
> +#define IIO_EVENT_CODE_ADT7316_VDD	      (IIO_EVENT_CODE_DEVICE_SPECIFIC + 9)
This will be an in0 based code.  Not sure what it does?  Is it out of range?
> +
> +static void adt7316_interrupt_bh(struct work_struct *work_s)
> +{
> +	struct adt7316_chip_info *chip =
> +		container_of(work_s, struct adt7316_chip_info, thresh_work);
> +	u8 stat1, stat2;
> +	int i, ret, count;
> +
> +	ret = chip->bus.read(chip->bus.client, ADT7316_INT_STAT1, &stat1);
> +	if (!ret) {
> +		if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
> +			count = 8;
> +		else
> +			count = 5;
> +
> +		for (i = 0; i < count; i++) {
> +			if (stat1 & (1 << i))
> +				iio_push_event(chip->indio_dev, 0,
> +					IIO_EVENT_CODE_ADT7316_IN_TEMP_HIGH + i,
> +					chip->last_timestamp);
> +		}
> +	}
> +
> +	ret = chip->bus.read(chip->bus.client, ADT7316_INT_STAT2, &stat2);
> +	if (!ret) {
> +		if (stat2 & ADT7316_INT_MASK2_VDD)
> +			iio_push_event(chip->indio_dev, 0,
> +				IIO_EVENT_CODE_ADT7316_VDD,
> +				chip->last_timestamp);
> +	}
> +
> +	enable_irq(chip->bus.irq);
> +}
> +
> +static int adt7316_interrupt(struct iio_dev *dev_info,
> +		int index,
> +		s64 timestamp,
> +		int no_test)
> +{
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	chip->last_timestamp = timestamp;
> +	schedule_work(&chip->thresh_work);
> +
> +	return 0;
> +}
> +
> +IIO_EVENT_SH(adt7316, &adt7316_interrupt);
> +
> +/*
> + * Show mask of enabled interrupts in Hex.
> + */
> +static ssize_t adt7316_show_int_mask(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return sprintf(buf, "0x%x\n", chip->int_mask);
> +}
No.  This is not abi compliant.  I'll let it as is as long
as someone promises to either work on it or offer testing
to someone else who does.
> +
> +/*
> + * Set 1 to the mask in Hex to enabled interrupts.
> + */
> +static ssize_t adt7316_set_int_mask(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +	unsigned long data;
> +	int ret;
> +	u8 mask;
> +
> +	ret = strict_strtoul(buf, 16, &data);
> +	if (ret || data >= ADT7316_VDD_INT_MASK + 1)
> +		return -EINVAL;
> +
> +	if (data & ADT7316_VDD_INT_MASK)
> +		mask = 0;			/* enable vdd int */
> +	else
> +		mask = ADT7316_INT_MASK2_VDD;	/* disable vdd int */
> +
> +	ret = chip->bus.write(chip->bus.client, ADT7316_INT_MASK2, mask);
> +	if (!ret) {
> +		chip->int_mask &= ~ADT7316_VDD_INT_MASK;
> +		chip->int_mask |= data & ADT7316_VDD_INT_MASK;
> +	}
> +
> +	if (data & ADT7316_TEMP_AIN_INT_MASK) {
> +		if ((chip->id & ID_FAMILY_MASK) == ID_ADT73XX)
> +			/* mask in reg is opposite, set 1 to disable */
> +			mask = (~data) & ADT7316_TEMP_INT_MASK;
> +		else
> +			/* mask in reg is opposite, set 1 to disable */
> +			mask = (~data) & ADT7316_TEMP_AIN_INT_MASK;
> +	}
> +	ret = chip->bus.write(chip->bus.client, ADT7316_INT_MASK1, mask);
> +
> +	chip->int_mask = mask;
> +
> +	return len;
> +}
> +static inline ssize_t adt7316_show_ad_bound(struct device *dev,
> +		struct device_attribute *attr,
> +		u8 bound_reg,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +	u8 val;
> +	int data;
> +	int ret;
> +
> +	if ((chip->id & ID_FAMILY_MASK) == ID_ADT73XX &&
> +		bound_reg > ADT7316_EX_TEMP_LOW)
> +		return -EPERM;
> +
> +	ret = chip->bus.read(chip->bus.client, bound_reg, &val);
> +	if (ret)
> +		return -EIO;
> +
> +	data = (int)val;
> +
> +	if (!((chip->id & ID_FAMILY_MASK) == ID_ADT75XX &&
> +		(chip->config1 & ADT7516_SEL_AIN1_2_EX_TEMP_MASK) == 0)) {
> +		if (data & 0x80)
> +			data -= 256;
> +	}
> +
> +	return sprintf(buf, "%d\n", data);
> +}
> +
> +static inline ssize_t adt7316_set_ad_bound(struct device *dev,
> +		struct device_attribute *attr,
> +		u8 bound_reg,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +	long data;
> +	u8 val;
> +	int ret;
> +
> +	if ((chip->id & ID_FAMILY_MASK) == ID_ADT73XX &&
> +		bound_reg > ADT7316_EX_TEMP_LOW)
> +		return -EPERM;
> +
> +	ret = strict_strtol(buf, 10, &data);
> +	if (ret)
> +		return -EINVAL;
> +
> +	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX &&
> +		(chip->config1 & ADT7516_SEL_AIN1_2_EX_TEMP_MASK) == 0) {
> +		if (data > 255 || data < 0)
> +			return -EINVAL;
> +	} else {
> +		if (data > 127 || data < -128)
> +			return -EINVAL;
> +
> +		if (data < 0)
> +			data += 256;
> +	}
> +
> +	val = (u8)data;
> +
> +	ret = chip->bus.write(chip->bus.client, bound_reg, val);
> +	if (ret)
> +		return -EIO;
> +
> +	return len;
> +}
> +
> +static ssize_t adt7316_show_in_temp_high(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	return adt7316_show_ad_bound(dev, attr,
> +			ADT7316_IN_TEMP_HIGH, buf);
> +}
> +
> +static inline ssize_t adt7316_set_in_temp_high(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	return adt7316_set_ad_bound(dev, attr,
> +			ADT7316_IN_TEMP_HIGH, buf, len);
> +}
> +
> +static ssize_t adt7316_show_in_temp_low(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	return adt7316_show_ad_bound(dev, attr,
> +			ADT7316_IN_TEMP_LOW, buf);
> +}
> +
> +static inline ssize_t adt7316_set_in_temp_low(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	return adt7316_set_ad_bound(dev, attr,
> +			ADT7316_IN_TEMP_LOW, buf, len);
> +}
> +
> +static ssize_t adt7316_show_ex_temp_ain1_high(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	return adt7316_show_ad_bound(dev, attr,
> +			ADT7316_EX_TEMP_HIGH, buf);
> +}
> +
> +static inline ssize_t adt7316_set_ex_temp_ain1_high(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	return adt7316_set_ad_bound(dev, attr,
> +			ADT7316_EX_TEMP_HIGH, buf, len);
> +}
> +
> +static ssize_t adt7316_show_ex_temp_ain1_low(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	return adt7316_show_ad_bound(dev, attr,
> +			ADT7316_EX_TEMP_LOW, buf);
> +}
> +
> +static inline ssize_t adt7316_set_ex_temp_ain1_low(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	return adt7316_set_ad_bound(dev, attr,
> +			ADT7316_EX_TEMP_LOW, buf, len);
> +}
> +
> +static ssize_t adt7316_show_ain2_high(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	return adt7316_show_ad_bound(dev, attr,
> +			ADT7516_AIN2_HIGH, buf);
> +}
> +
> +static inline ssize_t adt7316_set_ain2_high(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	return adt7316_set_ad_bound(dev, attr,
> +			ADT7516_AIN2_HIGH, buf, len);
> +}
> +
> +static ssize_t adt7316_show_ain2_low(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	return adt7316_show_ad_bound(dev, attr,
> +			ADT7516_AIN2_LOW, buf);
> +}
> +
> +static inline ssize_t adt7316_set_ain2_low(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	return adt7316_set_ad_bound(dev, attr,
> +			ADT7516_AIN2_LOW, buf, len);
> +}
> +
> +static ssize_t adt7316_show_ain3_high(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	return adt7316_show_ad_bound(dev, attr,
> +			ADT7516_AIN3_HIGH, buf);
> +}
> +
> +static inline ssize_t adt7316_set_ain3_high(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	return adt7316_set_ad_bound(dev, attr,
> +			ADT7516_AIN3_HIGH, buf, len);
> +}
> +
> +static ssize_t adt7316_show_ain3_low(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	return adt7316_show_ad_bound(dev, attr,
> +			ADT7516_AIN3_LOW, buf);
> +}
> +
> +static inline ssize_t adt7316_set_ain3_low(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	return adt7316_set_ad_bound(dev, attr,
> +			ADT7516_AIN3_LOW, buf, len);
> +}
> +
> +static ssize_t adt7316_show_ain4_high(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	return adt7316_show_ad_bound(dev, attr,
> +			ADT7516_AIN4_HIGH, buf);
> +}
> +
> +static inline ssize_t adt7316_set_ain4_high(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	return adt7316_set_ad_bound(dev, attr,
> +			ADT7516_AIN4_HIGH, buf, len);
> +}
> +
> +static ssize_t adt7316_show_ain4_low(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	return adt7316_show_ad_bound(dev, attr,
> +			ADT7516_AIN4_LOW, buf);
> +}
> +
> +static inline ssize_t adt7316_set_ain4_low(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	return adt7316_set_ad_bound(dev, attr,
> +			ADT7516_AIN4_LOW, buf, len);
> +}
> +
> +static ssize_t adt7316_show_int_enabled(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return sprintf(buf, "%d\n", !!(chip->config1 & ADT7316_INT_EN));
> +}
> +
> +static ssize_t adt7316_set_int_enabled(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +	u8 config1;
> +	int ret;
> +
> +	config1 = chip->config1 & (~ADT7316_INT_EN);
> +	if (!memcmp(buf, "1", 1))
> +		config1 |= ADT7316_INT_EN;
> +
> +	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, config1);
> +	if (ret)
> +		return -EIO;
> +
> +	chip->config1 = config1;
> +
> +	return len;
> +}
> +
> +
> +IIO_EVENT_ATTR_SH(int_mask, iio_event_adt7316,
> +		adt7316_show_int_mask, adt7316_set_int_mask, 0);
> +IIO_EVENT_ATTR_SH(in_temp_high, iio_event_adt7316,
> +		adt7316_show_in_temp_high, adt7316_set_in_temp_high, 0);
> +IIO_EVENT_ATTR_SH(in_temp_low, iio_event_adt7316,
> +		adt7316_show_in_temp_low, adt7316_set_in_temp_low, 0);
> +IIO_EVENT_ATTR_SH(ex_temp_high, iio_event_adt7316,
> +		adt7316_show_ex_temp_ain1_high,
> +		adt7316_set_ex_temp_ain1_high, 0);
> +IIO_EVENT_ATTR_SH(ex_temp_low, iio_event_adt7316,
> +		adt7316_show_ex_temp_ain1_low,
> +		adt7316_set_ex_temp_ain1_low, 0);
> +IIO_EVENT_ATTR_SH(ex_temp_ain1_high, iio_event_adt7316,
> +		adt7316_show_ex_temp_ain1_high,
> +		adt7316_set_ex_temp_ain1_high, 0);
> +IIO_EVENT_ATTR_SH(ex_temp_ain1_low, iio_event_adt7316,
> +		adt7316_show_ex_temp_ain1_low,
> +		adt7316_set_ex_temp_ain1_low, 0);
> +IIO_EVENT_ATTR_SH(ain2_high, iio_event_adt7316,
> +		adt7316_show_ain2_high, adt7316_set_ain2_high, 0);
> +IIO_EVENT_ATTR_SH(ain2_low, iio_event_adt7316,
> +		adt7316_show_ain2_low, adt7316_set_ain2_low, 0);
> +IIO_EVENT_ATTR_SH(ain3_high, iio_event_adt7316,
> +		adt7316_show_ain3_high, adt7316_set_ain3_high, 0);
> +IIO_EVENT_ATTR_SH(ain3_low, iio_event_adt7316,
> +		adt7316_show_ain3_low, adt7316_set_ain3_low, 0);
> +IIO_EVENT_ATTR_SH(ain4_high, iio_event_adt7316,
> +		adt7316_show_ain4_high, adt7316_set_ain4_high, 0);
> +IIO_EVENT_ATTR_SH(ain4_low, iio_event_adt7316,
> +		adt7316_show_ain4_low, adt7316_set_ain4_low, 0);
> +IIO_EVENT_ATTR_SH(int_enabled, iio_event_adt7316,
> +		adt7316_show_int_enabled, adt7316_set_int_enabled, 0);
These macros are meant to be for enabling disabling not the values.

See max1363 for example of use.
> +

> +static struct attribute *adt7316_event_attributes[] = {
> +	&iio_event_attr_int_mask.dev_attr.attr,
> +	&iio_event_attr_in_temp_high.dev_attr.attr,
> +	&iio_event_attr_in_temp_low.dev_attr.attr,
> +	&iio_event_attr_ex_temp_high.dev_attr.attr,
> +	&iio_event_attr_ex_temp_low.dev_attr.attr,
> +	&iio_event_attr_int_enabled.dev_attr.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group adt7316_event_attribute_group = {
> +	.attrs = adt7316_event_attributes,
> +};

Lets list what should be here (I think, I'm doing this from memory of the
abi as defined and extending where necessary)  Guessing these are edge
type interrupts, level equivalents exist though haven't been used much as
yet.

iio_event_attr_temp0_thresh_rising_en
iio_event_attr_temp0_thresh_falling_en
iio_event_attr_temp1_external_thresh_rising_en
iio_event_attr_temp1_external_thresh_falling_en
iio_event_attr_in0_thresh_rising_en
iio_event_attr_in0_thresh_falling_en
etc for all enabling /disabling attributes.
iio_device_attr_temp0_thresh_rising_value
iio_device_attr_temp0_thresh_falling_value
iio_device_attr_temp1_external_thresh_rising_value
iio_device_attr_temp1_external_thresh_falling_value
etc for all values.


> +
> +static struct attribute *adt7516_event_attributes[] = {
> +	&iio_event_attr_int_mask.dev_attr.attr,
> +	&iio_event_attr_in_temp_high.dev_attr.attr,
> +	&iio_event_attr_in_temp_low.dev_attr.attr,
> +	&iio_event_attr_ex_temp_ain1_high.dev_attr.attr,
> +	&iio_event_attr_ex_temp_ain1_low.dev_attr.attr,
> +	&iio_event_attr_ain2_high.dev_attr.attr,
> +	&iio_event_attr_ain2_low.dev_attr.attr,
> +	&iio_event_attr_ain3_high.dev_attr.attr,
> +	&iio_event_attr_ain3_low.dev_attr.attr,
> +	&iio_event_attr_ain4_high.dev_attr.attr,
> +	&iio_event_attr_ain4_low.dev_attr.attr,
> +	&iio_event_attr_int_enabled.dev_attr.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group adt7516_event_attribute_group = {
> +	.attrs = adt7516_event_attributes,
> +};
> +
> +#ifdef CONFIG_PM
> +int adt7316_disable(struct device *dev)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return _adt7316_store_enabled(chip, 0);
> +}
> +EXPORT_SYMBOL(adt7316_disable);
> +
> +int adt7316_enable(struct device *dev)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +
> +	return _adt7316_store_enabled(chip, 1);
> +}
> +EXPORT_SYMBOL(adt7316_enable);
> +#endif
> +
> +/*
> + * device probe and remove
> + */
> +int __devinit adt7316_probe(struct device *dev, struct adt7316_bus *bus,
> +		const char *name)
> +{
> +	struct adt7316_chip_info *chip;
> +	unsigned short *adt7316_platform_data = dev->platform_data;
> +	int ret = 0;
> +
> +	chip = kzalloc(sizeof(struct adt7316_chip_info), GFP_KERNEL);
> +
> +	if (chip == NULL)
> +		return -ENOMEM;
> +
> +	/* this is only used for device removal purposes */
> +	dev_set_drvdata(dev, chip);
> +
> +	chip->bus = *bus;
> +	chip->name = name;
> +
This is rather clunky. A simple table of names, or having the relevant id
tables pass on an enum value would be cleaner.
> +	if (name[4] == '3')
> +		chip->id = ID_ADT7316 + (name[6] - '6');
> +	else if (name[4] == '5')
> +		chip->id = ID_ADT7516 + (name[6] - '6');
> +	else
> +		return -ENODEV;
> +
> +	chip->ldac_pin = adt7316_platform_data[1];
> +	if (chip->ldac_pin) {
> +		chip->config3 |= ADT7316_DA_EN_VIA_DAC_LDCA;
> +		if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
> +			chip->config1 |= ADT7516_SEL_AIN3;
> +	}
> +	chip->int_mask = ADT7316_TEMP_INT_MASK | ADT7316_VDD_INT_MASK;
> +	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
> +		chip->int_mask |= ADT7516_AIN_INT_MASK;
> +
> +	chip->indio_dev = iio_allocate_device();
> +	if (chip->indio_dev == NULL) {
> +		ret = -ENOMEM;
> +		goto error_free_chip;
> +	}
> +
> +	chip->indio_dev->dev.parent = dev;
I think I'd rather see this stuff done with a chip_info struct covering each
set of parameters.  Tends to make for easier to read code and easy addition
of new parts.

> +	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX) {
> +		chip->indio_dev->attrs = &adt7516_attribute_group;
> +		chip->indio_dev->event_attrs = &adt7516_event_attribute_group;
> +	} else {
> +		chip->indio_dev->attrs = &adt7316_attribute_group;
> +		chip->indio_dev->event_attrs = &adt7316_event_attribute_group;
> +	}
> +	chip->indio_dev->dev_data = (void *)chip;
> +	chip->indio_dev->driver_module = THIS_MODULE;
> +	chip->indio_dev->num_interrupt_lines = 1;
> +	chip->indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = iio_device_register(chip->indio_dev);
> +	if (ret)
> +		goto error_free_dev;
> +
> +	if (chip->bus.irq > 0) {
> +		if (adt7316_platform_data[0])
> +			chip->bus.irq_flags = adt7316_platform_data[0];
> +
> +		ret = iio_register_interrupt_line(chip->bus.irq,
> +				chip->indio_dev,
> +				0,
> +				chip->bus.irq_flags,
> +				chip->name);
> +		if (ret)
> +			goto error_unreg_dev;
> +
> +		/*
> +		 * The event handler list element refer to iio_event_adt7316.
> +		 * All event attributes bind to the same event handler.
> +		 * So, only register event handler once.
> +		 */
> +		iio_add_event_to_list(&iio_event_adt7316,
> +				&chip->indio_dev->interrupts[0]->ev_list);
> +
> +		INIT_WORK(&chip->thresh_work, adt7316_interrupt_bh);
> +
> +		if (chip->bus.irq_flags & IRQF_TRIGGER_HIGH)
> +			chip->config1 |= ADT7316_INT_POLARITY;
> +	}
> +
> +	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, chip->config1);
> +	if (ret) {
> +		ret = -EIO;
> +		goto error_unreg_irq;
> +	}
> +
> +	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, chip->config3);
> +	if (ret) {
> +		ret = -EIO;
> +		goto error_unreg_irq;
> +	}
> +
> +	dev_info(dev, "%s temperature sensor, ADC and DAC registered.\n",
> +			chip->name);
> +
> +	return 0;
> +
> +error_unreg_irq:
> +	iio_unregister_interrupt_line(chip->indio_dev, 0);
> +error_unreg_dev:
> +	iio_device_unregister(chip->indio_dev);
> +error_free_dev:
> +	iio_free_device(chip->indio_dev);
> +error_free_chip:
> +	kfree(chip);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(adt7316_probe);
> +
> +int __devexit adt7316_remove(struct device *dev)
> +{
> +
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct adt7316_chip_info *chip = dev_info->dev_data;
> +	struct iio_dev *indio_dev = chip->indio_dev;
> +
> +	dev_set_drvdata(dev, NULL);
> +	if (chip->bus.irq)
> +		iio_unregister_interrupt_line(indio_dev, 0);
> +	iio_device_unregister(indio_dev);
> +	iio_free_device(chip->indio_dev);
> +	kfree(chip);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(adt7316_remove);
> +
> +MODULE_AUTHOR("Sonic Zhang <sonic.zhang@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADT7316/7/8 and ADT7516/7/9 digital"
> +			" temperature sensor, ADC and DAC driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/staging/iio/addac/adt7316.h b/drivers/staging/iio/addac/adt7316.h
> new file mode 100644
> index 0000000..d34bd67
> --- /dev/null
> +++ b/drivers/staging/iio/addac/adt7316.h
> @@ -0,0 +1,33 @@
> +/*
> + * ADT7316 digital temperature sensor driver supporting ADT7316/7/8 ADT7516/7/9
> + *
> + * Copyright 2010 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2 or later.
> + */
> +
> +#ifndef _ADT7316_H_
> +#define _ADT7316_H_
> +
> +#include <linux/types.h>
> +
> +#define ADT7316_REG_MAX_ADDR		0x3F
> +
> +struct adt7316_bus {
> +	void *client;
> +	int irq;
> +	int irq_flags;
> +	int (*read) (void *client, u8 reg, u8 *data);
> +	int (*write) (void *client, u8 reg, u8 val);

Why do these two exist?  Don't think they are directly used.
> +	int (*multi_read) (void *client, u8 first_reg, u8 count, u8 *data);
> +	int (*multi_write) (void *client, u8 first_reg, u8 count, u8 *data);
> +};
> +
> +#ifdef CONFIG_PM
> +int adt7316_disable(struct device *dev);
> +int adt7316_enable(struct device *dev);
> +#endif
> +int adt7316_probe(struct device *dev, struct adt7316_bus *bus, const char *name);
> +int adt7316_remove(struct device *dev);
> +
> +#endif

