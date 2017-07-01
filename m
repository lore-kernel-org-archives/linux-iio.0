Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751563AbdGAJ6e (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Jul 2017 05:58:34 -0400
Date: Sat, 1 Jul 2017 10:58:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Mike Looijmans <mike.looijmans@topic.nl>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, jdelvare@suse.com
Subject: Re: [PATCH] hwmon: Add LTC2471/LTC2473 driver
Message-ID: <20170701105829.1597d426@kernel.org>
In-Reply-To: <d85cd7a1-a9c2-63c1-1038-f032299c66c9@roeck-us.net>
References: <1498733135-4729-1-git-send-email-mike.looijmans@topic.nl>
        <d85cd7a1-a9c2-63c1-1038-f032299c66c9@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 29 Jun 2017 06:34:22 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 06/29/2017 03:45 AM, Mike Looijmans wrote:
> > The LTC2741 and LTC2473 are single voltage monitoring chips. The LTC2473
> > is similar to the LTC2471 but outputs a signed differential value.
> > 
> > Datasheet:
> >    http://cds.linear.com/docs/en/datasheet/24713fb.pdf
> > 
> > Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>  
> 
> Hi Mike,
> 
> that looks like a perfect candidate for an iio driver, since its use is
> not limited to hardware monitoring, it has a high sample rate, and it
> doesn't have limit registers or actions.
> 
> Jonathan, what do you think ?
Late response given I just applied the IIO driver ;)
Yes, fine for IIO.  Whilst they list hwmon as one of the possible
uses they list a whole load of others as well so IIO probably
makes more sense for this one.

Thanks,

Jonathan
> 
> Thanks,
> Guenter
> 
> > ---
> >   drivers/hwmon/Kconfig   |  10 ++++
> >   drivers/hwmon/Makefile  |   1 +
> >   drivers/hwmon/ltc2471.c | 127 ++++++++++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 138 insertions(+)
> >   create mode 100644 drivers/hwmon/ltc2471.c
> > 
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index fbde226..c9a2a87 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -673,6 +673,16 @@ config SENSORS_LINEAGE
> >   	  This driver can also be built as a module.  If so, the module
> >   	  will be called lineage-pem.
> >   
> > +config SENSORS_LTC2471
> > +	tristate "Linear Technology LTC2471 and LTC2473"
> > +	depends on I2C
> > +	help
> > +	  If you say yes here you get support for Linear Technology LTC2471
> > +	  and LTC2473 voltage monitors.
> > +
> > +	  This driver can also be built as a module. If so, the module will
> > +	  be called ltc2471.
> > +
> >   config SENSORS_LTC2945
> >   	tristate "Linear Technology LTC2945"
> >   	depends on I2C
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index 58cc3ac..6f60fe7 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -99,6 +99,7 @@ obj-$(CONFIG_SENSORS_LM93)	+= lm93.o
> >   obj-$(CONFIG_SENSORS_LM95234)	+= lm95234.o
> >   obj-$(CONFIG_SENSORS_LM95241)	+= lm95241.o
> >   obj-$(CONFIG_SENSORS_LM95245)	+= lm95245.o
> > +obj-$(CONFIG_SENSORS_LTC2471)	+= ltc2471.o
> >   obj-$(CONFIG_SENSORS_LTC2945)	+= ltc2945.o
> >   obj-$(CONFIG_SENSORS_LTC2990)	+= ltc2990.o
> >   obj-$(CONFIG_SENSORS_LTC4151)	+= ltc4151.o
> > diff --git a/drivers/hwmon/ltc2471.c b/drivers/hwmon/ltc2471.c
> > new file mode 100644
> > index 0000000..17eaad8
> > --- /dev/null
> > +++ b/drivers/hwmon/ltc2471.c
> > @@ -0,0 +1,127 @@
> > +/*
> > + * Driver for Linear Technology LTC2471 and LTC2473 voltage monitors
> > + * The LTC2473 is identical to the 2471, but reports a differential signal.
> > + *
> > + * Copyright (C) 2017 Topic Embedded Products
> > + * Author: Mike Looijmans <mike.looijmans@topic.nl>
> > + *
> > + * License: GPLv2
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/hwmon-sysfs.h>
> > +#include <linux/i2c.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +
> > +enum chips {
> > +	ltc2471,
> > +	ltc2473
> > +};
> > +
> > +struct ltc2471_data {
> > +	struct i2c_client *i2c;
> > +	bool differential;
> > +};
> > +
> > +/* Reference voltage is 1.25V */
> > +#define LTC2471_VREF 1250
> > +
> > +/* Read two bytes from the I2C bus to obtain the ADC result */
> > +static int ltc2471_get_value(struct i2c_client *i2c)
> > +{
> > +	int ret;
> > +	__be16 buf;
> > +
> > +	ret = i2c_master_recv(i2c, (char *)&buf, 2);
> > +	if (ret < 0)
> > +		return ret;
> > +	if (ret != 2)
> > +		return -EIO;
> > +
> > +	/* MSB first */
> > +	return be16_to_cpu(buf);
> > +}
> > +
> > +static ssize_t ltc2471_show_value(struct device *dev,
> > +				  struct device_attribute *da, char *buf)
> > +{
> > +	struct ltc2471_data *data = dev_get_drvdata(dev);
> > +	int value;
> > +
> > +	value = ltc2471_get_value(data->i2c);
> > +	if (unlikely(value < 0))
> > +		return value;
> > +
> > +	if (data->differential)
> > +		/* Ranges from -VREF to +VREF with "0" at 0x8000 */
> > +		value = ((s32)LTC2471_VREF * (s32)(value - 0x8000)) >> 15;
> > +	else
> > +		/* Ranges from 0 to +VREF */
> > +		value = ((u32)LTC2471_VREF * (u32)value) >> 16;
> > +
> > +	return snprintf(buf, PAGE_SIZE, "%d\n", value);
> > +}
> > +
> > +static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, ltc2471_show_value, NULL, 0);
> > +
> > +static struct attribute *ltc2471_attrs[] = {
> > +	&sensor_dev_attr_in0_input.dev_attr.attr,
> > +	NULL
> > +};
> > +
> > +ATTRIBUTE_GROUPS(ltc2471);
> > +
> > +static int ltc2471_i2c_probe(struct i2c_client *i2c,
> > +			     const struct i2c_device_id *id)
> > +{
> > +	int ret;
> > +	struct device *hwmon_dev;
> > +	struct ltc2471_data *data;
> > +
> > +	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C))
> > +		return -ENODEV;
> > +
> > +	data = devm_kzalloc(&i2c->dev, sizeof(struct ltc2471_data), GFP_KERNEL);
> > +	if (unlikely(!data))
> > +		return -ENOMEM;
> > +
> > +	data->i2c = i2c;
> > +	data->differential = (id->driver_data == ltc2473);
> > +
> > +	/* Trigger once to start conversion and check if chip is there */
> > +	ret = ltc2471_get_value(i2c);
> > +	if (ret < 0) {
> > +		dev_err(&i2c->dev, "Cannot read from device.\n");
> > +		return ret;
> > +	}
> > +
> > +	hwmon_dev = devm_hwmon_device_register_with_groups(&i2c->dev,
> > +							   i2c->name,
> > +							   data,
> > +							   ltc2471_groups);
> > +
> > +	return PTR_ERR_OR_ZERO(hwmon_dev);
> > +}
> > +
> > +static const struct i2c_device_id ltc2471_i2c_id[] = {
> > +	{ "ltc2471", ltc2471 },
> > +	{ "ltc2473", ltc2473 },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(i2c, ltc2471_i2c_id);
> > +
> > +static struct i2c_driver ltc2471_i2c_driver = {
> > +	.driver = {
> > +		.name = "ltc2471",
> > +	},
> > +	.probe    = ltc2471_i2c_probe,
> > +	.id_table = ltc2471_i2c_id,
> > +};
> > +
> > +module_i2c_driver(ltc2471_i2c_driver);
> > +
> > +MODULE_DESCRIPTION("LTC2471/LTC2473 Sensor Driver");
> > +MODULE_AUTHOR("Topic Embedded Products");
> > +MODULE_LICENSE("GPL v2");
> >   
> 

