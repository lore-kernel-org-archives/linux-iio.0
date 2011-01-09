Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:53859 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab1AIWag (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 9 Jan 2011 17:30:36 -0500
Message-ID: <4D2A373B.6060901@cam.ac.uk>
Date: Sun, 09 Jan 2011 22:31:23 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Roland Stigge <stigge@antcom.de>
CC: Greg KH <greg@kroah.com>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: Linux driver for MAX517/518/519
References: <4D21A2AA.6080006@antcom.de> <20110103222834.GA11277@kroah.com> <4D29C64E.4040806@antcom.de>
In-Reply-To: <4D29C64E.4040806@antcom.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/09/11 14:29, Roland Stigge wrote:
> Hi,
> 
> On 03/01/11 23:28, Greg KH wrote:
>>> I've written a driver for the Maxim MAX517/MAX518/MAX519 1/2-channel
>>> DAC. See also the branch "max51x" of repository linux-2.6 at
>>> git.antcom.de (alternatively the patch at
>>> http://www.rolandstigge.de/dp/download/patches/max51x.patch).
>>>
>>> It's currently located in drivers/misc/max51x.c, implemented similarly
>>> to the other drivers like e.g. ti_dac7512.c. The hwmon maintainer
>>> pointed me to drivers/staging/iio/.
>>>
>>> Is it advisible now to port the driver to drivers/staging/iio or keep it
>>> in drivers/misc? Where should I forward the code/patch for Linux
>>> integration?
>>
>> It's best to convert to the iio subsystem, as that is the way to go in
>> the future.
>>
>> As for where to send patches for it, send them here, and cc: the iio
>> developers and me and we will be glad to comment on them and apply them
>> to the kernel tree for submission to Linus's tree.
> 
> OK, done. Attaching the patch. (Also available at the above mentioned
> git repository for merging.)
> 
> Thanks in advance,
> 
> Roland
Hi Roland,

What the heck, nothing on iplayer so I'll do a review now.

Firstly, I find reviewing easier in reverse so some comments
may only make sense that way around!

Pretty clean and nice driver so it was an easy review and should
be trivial to fix up for a merge.

Main points of review are:

1) You are on an out of date tree, please use Greg's staging-next
tree for base of IIO patches (see below for addresses). This means
you haven't seen or matched interfaces of the DAC drivers now
in the tree.

2) Interfaces need to match those in standard.  We need to support
a wide range of devices, so things like 'value' don't give enough
information. Note, if possible, can we also have output_scale
defined so userspace knows how to convert to the device units.
(obviously this point is really a result of point 1!)

3) One new interface needed (I think?) See below. Have cc'd Michael
as he is much more familiar with this area than I am and I'd like
his input on this if possible.

One or two other quirks inline.

Thanks,

Jonathan
> 
> 
> BTW: Maybe we should also call it "Analog to digital converters" instead
> of "Analog to digital convertors", see drivers/staging/iio/adc/Kconfig

> Added max51x iio driver
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> 
> diff --git a/drivers/staging/iio/Documentation/dac/max51x b/drivers/staging/iio/Documentation/dac/max51x
> new file mode 100644
> index 0000000..cf61a25
> --- /dev/null
> +++ b/drivers/staging/iio/Documentation/dac/max51x
> @@ -0,0 +1,38 @@
> +Kernel driver max51x
> +====================
> +
> +Supported chips:
> +  * Maxim MAX517, MAX518, MAX519
> +    Prefix: 'max51x'
> +    Datasheet: Publicly available at the Maxim website
> +               http://www.maxim-ic.com/
> +
> +Author:
> +        Roland Stigge <stigge@antcom.de>
> +
> +Description
> +-----------
> +
> +The Maxim MAX51x is an 8-bit DAC on the I2C bus. The following table shows the
> +different feature sets of the variants MAX517, MAX518 and MAX519:
> +
> +Feature                              MAX517 MAX518 MAX519
> +--------------------------------------------------------------------------
> +One output channel                   X
> +Two output channels                         X      X
> +Simultaneous output updates                 X      X
> +Supply voltage as reference                 X
> +Separate reference input             X
> +Reference input for each DAC                       X
> +
> +Via the iio sysfs interface, there are three attributes available: value_1,
> +value_2 and value_both. With value_1 and value_2, the current output values of
> +the DACs can be read back from the driver and written to the device. value_both
> +can be used to set both output channel values simultaneously.
> +
> +With MAX517, only value_1 is available.
> +
> +When the operating system goes to a power down state, the Power Down function
> +of the chip is activated, reducing the supply current to 4uA.
> +
> +On power-up, the device is in 0V-output state.
> diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
> index ed48815..6fc35ad 100644
> --- a/drivers/staging/iio/Kconfig
> +++ b/drivers/staging/iio/Kconfig
> @@ -42,6 +42,7 @@ config IIO_TRIGGER
>  
>  source "drivers/staging/iio/accel/Kconfig"
>  source "drivers/staging/iio/adc/Kconfig"
> +source "drivers/staging/iio/dac/Kconfig"
>  source "drivers/staging/iio/gyro/Kconfig"
>  source "drivers/staging/iio/imu/Kconfig"
>  source "drivers/staging/iio/light/Kconfig"
> diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
> index e909674..8766e07 100644
> --- a/drivers/staging/iio/Makefile
> +++ b/drivers/staging/iio/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_IIO_SW_RING) += ring_sw.o
>  
>  obj-y += accel/
>  obj-y += adc/
> +obj-y += dac/
Ah, looks like you have an old tree. All work on IIO drivers
needs to be done against the staging-next branch of
Greg's tree at:

http://git.kernel.org/?p=linux/kernel/git/gregkh/staging-2.6.git;a=shortlog;h=refs/heads/staging-next

git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging-2.6.git staging-next

There are a couple of DAC's in there now to copy interfaces
from.

>  obj-y += gyro/
>  obj-y += imu/
>  obj-y += light/
> diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kconfig
> new file mode 100644
> index 0000000..f2c9c84
> --- /dev/null
> +++ b/drivers/staging/iio/dac/Kconfig
> @@ -0,0 +1,14 @@
> +#
> +# DAC drivers
> +#
> +comment "Digital to analog converters"
> +
> +config MAX51X

Please don't use a wild card in a driver name. For starters,
the MAX510 is another DAC not supported by this driver.

Pick one of the devices supported and use that as the name.
We may well find Maxim release more devices with the same
interface (more or less) that have radically different
numbers. For example, see the set we have ended up with in
adc/max1363!

> +	tristate "Maxim MAX51X DAC driver"
> +	depends on I2C && EXPERIMENTAL
> +	help
> +	  If you say yes here you get support for the Maxim chips MAX517,
> +	  MAX518 and MAX519 (I2C 8-Bit DACs with rail-to-rail outputs).
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called max51x.
> diff --git a/drivers/staging/iio/dac/Makefile b/drivers/staging/iio/dac/Makefile
> new file mode 100644
> index 0000000..3caa871
> --- /dev/null
> +++ b/drivers/staging/iio/dac/Makefile
> @@ -0,0 +1,5 @@
> +#
> +# Makefile for industrial I/O DAC drivers
> +#
> +
> +obj-$(CONFIG_MAX51X) += max51x.o
> diff --git a/drivers/staging/iio/dac/max51x.c b/drivers/staging/iio/dac/max51x.c
> new file mode 100644
> index 0000000..6d05428
> --- /dev/null
> +++ b/drivers/staging/iio/dac/max51x.c
> @@ -0,0 +1,258 @@
> +/*
> + *  max51x.c - Support for Maxim MAX517, MAX518 and MAX519
> + *
> + *  Copyright (C) 2010 Roland Stigge <stigge@antcom.de>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/jiffies.h>
> +#include <linux/i2c.h>
> +#include <linux/err.h>
> +
> +#include "../iio.h"
> +
> +#define MAX51X_DRV_NAME	"max51x"
> +
> +/* Commands */
> +#define COMMAND_CHANNEL0	0x00
> +#define COMMAND_CHANNEL1	0x01 /* for MAX518 and MAX519 */
> +#define COMMAND_PD		0x08 /* Power Down */
> +
> +struct max51x_data {
> +	u8			values[2];
> +	struct iio_dev		*indio_dev;
> +};
> +
> +/*
> + * channel: bit 0: channel 1
> + *          bit 1: channel 2
> + * (this way, it's possible to set both channels at once)
> + */
> +static ssize_t max51x_set_value(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count, int channel)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct max51x_data *data = i2c_get_clientdata(client);
> +	u8 outbuf[4]; /* 1x or 2x command + value */
> +	int outbuf_size = 0;
> +	int res;
> +	long val;
> +
> +	res = strict_strtol(buf, 10, &val);
> +
> +	if (res)
> +		return res;
> +
> +	if (val < 0 || val > 255)
> +		return -EINVAL;
> +
> +	if (channel & 1) {
> +		data->values[0] = val;
> +		outbuf[outbuf_size++] = COMMAND_CHANNEL0;
> +		outbuf[outbuf_size++] = val;
> +	}
> +	if (channel & 2) {
> +		data->values[1] = val;
> +		outbuf[outbuf_size++] = COMMAND_CHANNEL1;
> +		outbuf[outbuf_size++] = val;
> +	}
> +
> +	/*
> +	 * at this point, there are always 1 or 2 two-byte commands in
> +	 * outbuf
Perhaps expand this comment to explain how the double version is
being blugeoned into an smbus transfer... It's a little unusual!
Does doing this actually conform to the smbus spec? It would be fine
with generic i2c, but then you wouldn't have to manipulate the form
quite like this...
> +	 */
> +	i2c_smbus_xfer(client->adapter, client->addr, client->flags,
> +			I2C_SMBUS_WRITE, outbuf[0], outbuf_size - 1,
> +			(union i2c_smbus_data *) &outbuf[1]);
I'd like to see some handling of any errors from this function.


> +	return count;
> +}
> +
> +static ssize_t max51x_set_value_1(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count)
> +{
> +	return max51x_set_value(dev, attr, buf, count, 1);
> +}
> +
> +static ssize_t max51x_set_value_2(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count)
> +{
> +	return max51x_set_value(dev, attr, buf, count, 2);
> +}
> +
> +static ssize_t max51x_set_value_both(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count)
> +{
> +	return max51x_set_value(dev, attr, buf, count, 3);
> +}
> +
> +static ssize_t max51x_get_value(struct device *dev, struct device_attribute *da,
> +				char *buf, int channel)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct max51x_data *data = i2c_get_clientdata(client);
> +	u8 val;
> +
> +	if (channel == 1) {
> +		val = data->values[0];
> +	} else { /* channel == 2 */
> +		val = data->values[1];
> +	}
> +
> +	return sprintf(buf, "%d\n", val);
return sprintf(buf, "%d\n", data->values[channel - 1]); ?
> +}
> +
> +static ssize_t max51x_get_value_1(struct device *dev,
> +				  struct device_attribute *da, char *buf)
> +{
> +	return max51x_get_value(dev, da, buf, 1);
> +}
> +
> +static ssize_t max51x_get_value_2(struct device *dev,
> +				  struct device_attribute *da, char *buf)
> +{
> +	return max51x_get_value(dev, da, buf, 2);
> +}
> +
> +static IIO_DEVICE_ATTR(value_1, S_IWUSR | S_IRUGO,
> +		max51x_get_value_1, max51x_set_value_1, 0);

If you see Greg's staging tree, we've recently pinned
down the interface for DAC devices as part of merging
various Analog Devices drivers.

There is a convenient macro in staging/iio/dac/dac.h

http://git.kernel.org/?p=linux/kernel/git/gregkh/staging-2.6.git;a=blob;f=drivers/staging/iio/dac/dac.h;h=1d82f353241c2ea5d3dacc240d8f56821aa0f4a8;hb=refs/heads/staging-next

Ooops, it seems the docs didn't get updated. Michael, do you
want to do the docs for this?

Basically, voltage dacs have

outputX_raw

I don't think we have previously had a device that
allows setting multiple inputs together.
Two options come to mind that will generalize more
than your _both.

output1&2_raw

output_raw (suppress the index hence indicating that it sets both).

What do you think is the clearest approach?
Which ever we pick it will also need proper documentation.  Whilst we
are here, please can you explain your use case?  From a datasheet
read I think the first channel is latched after the value byte is passed
then the second only after it's value has been passed over?
I appreciate there are plenty of cases where a true simultaneous latch
would make sense, but would like an example of when the behaviour seen
here makes sense. (I have no problem with this support, just would
like an example for documentation purposes as it isn't immediately
obvious to me.) 

> +static IIO_DEVICE_ATTR(value_2, S_IWUSR | S_IRUGO,
> +		max51x_get_value_2, max51x_set_value_2, 1);
> +static IIO_DEVICE_ATTR(value_both, S_IWUSR, NULL, max51x_set_value_both, -1);
> +
> +static struct attribute *max51x_attributes[] = {
> +	&iio_dev_attr_value_1.dev_attr.attr,
> +	&iio_dev_attr_value_2.dev_attr.attr,
> +	&iio_dev_attr_value_both.dev_attr.attr,
> +	NULL
> +};
> +
> +static struct attribute *max517_attributes[] = {
> +	&iio_dev_attr_value_1.dev_attr.attr,
> +	NULL
> +};
> +
> +static struct attribute_group max51x_attribute_group = {
> +	.attrs = max51x_attributes,
> +};
> +
> +static int max51x_suspend(struct i2c_client *client, pm_message_t mesg)
> +{
> +	return i2c_smbus_write_byte(client, COMMAND_PD);
> +}
> +
> +static int max51x_resume(struct i2c_client *client)
> +{
> +	return i2c_smbus_write_byte(client, 0);
> +}
> +
> +static int max51x_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct max51x_data *data;
> +	int err;
> +
> +	data = kzalloc(sizeof(struct max51x_data), GFP_KERNEL);
> +	if (!data) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	i2c_set_clientdata(client, data);
> +
> +	/* reduced attribute set for max517 */
> +	if (!strcmp(id->name, "max517"))
Use the other parameter in the table to do this. Typically create
a suitable enum overing the variants, then set the second column
in the table equal to the relevant enum values.  These are then
available in id->driver_id.  Clearly cheaper to use that than to
do a strcmp.

> +		max51x_attribute_group.attrs = max517_attributes;
I'd also prefer to see two groups rather than switching the
attributes in one of them.  Then you can just set
data->indio_dev->dev_data equal to the relevant one.  The
form used here requires looking back to see what the value
of group.attrs otherwise would be and hence makes the code
marginally harder to read.
> +
> +	data->indio_dev = iio_allocate_device();
> +	if (data->indio_dev == NULL) {
> +		err = -ENOMEM;
> +		goto exit_free_data;
> +	}
> +
> +	/* establish that the iio_dev is a child of the i2c device */
> +	data->indio_dev->dev.parent = &client->dev;
> +	data->indio_dev->attrs = &max51x_attribute_group;
> +	data->indio_dev->dev_data = (void *)(data);
> +	data->indio_dev->driver_module = THIS_MODULE;
> +	data->indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	err = iio_device_register(data->indio_dev);
> +	if (err)
> +		goto exit_free_device;
> +
> +	dev_info(&client->dev, "DAC registered\n");
> +
> +	return 0;
> +
> +exit_free_device:
> +	iio_free_device(data->indio_dev);
> +exit_free_data:
> +	kfree(data);
> +exit:
> +	return err;
> +}
> +
> +static int max51x_remove(struct i2c_client *client)
> +{
> +	struct max51x_data *data = i2c_get_clientdata(client);
> +
Memory leak as in this path I can't see a call to iio_free_device
> +	kfree(data);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id max51x_id[] = {
> +	{ "max517", 0 },
> +	{ "max518", 0 },
> +	{ "max519", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max51x_id);
> +
> +static struct i2c_driver max51x_driver = {
> +	.driver = {
> +		.name	= MAX51X_DRV_NAME,
> +	},
> +	.probe		= max51x_probe,
Check this builds with suspend support not built in... I think
the protective ifdef's are still needed.
> +	.remove		= max51x_remove,
> +	.suspend	= max51x_suspend,
> +	.resume		= max51x_resume,
> +	.id_table	= max51x_id,
> +};
> +
> +static int __init max51x_init(void)
> +{
> +	return i2c_add_driver(&max51x_driver);
> +}
> +
> +static void __exit max51x_exit(void)
> +{
> +	i2c_del_driver(&max51x_driver);
> +}
> +
> +MODULE_AUTHOR("Roland Stigge <stigge@antcom.de>");
> +MODULE_DESCRIPTION("MAX51X 8-bit DAC");
> +MODULE_LICENSE("GPL");
> +
> +module_init(max51x_init);
> +module_exit(max51x_exit);


