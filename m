Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:57272 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354Ab2D3OkC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Apr 2012 10:40:02 -0400
Message-ID: <4F9EA43F.7000803@cam.ac.uk>
Date: Mon, 30 Apr 2012 15:39:59 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH] iio: add mcp4725 I2C DAC driver
References: <4F9E6909.6090409@cam.ac.uk> <1335794080-6398-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1335794080-6398-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 4/30/2012 2:54 PM, Peter Meerwald wrote:
> v2 (based on comments from Jonathan Cameron and Lars-Peter Clausen):
> * did NOT switch to chan_spec yet
I guess from this you are intending to? I guess whether we merge this as 
is depends
on what timescale you are thinking of to make that change?
> * rebase to staging-next tree, update iio header locations
> * dropped dac.h #include, not needed
> * strict_strtol() ->  kstrtol()
> * call iio_device_unregister() in remove()
> * everything in one patch
If you want to send it on to Greg KH now and Lars-Peter is happy, then 
that's fine by me.
> Signed-off-by: Peter Meerwald<pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/staging/iio/dac/Kconfig   |   11 ++
>   drivers/staging/iio/dac/Makefile  |    1 +
>   drivers/staging/iio/dac/mcp4725.c |  211 +++++++++++++++++++++++++++++++++++++
>   drivers/staging/iio/dac/mcp4725.h |   16 +++
>   4 files changed, 239 insertions(+)
>   create mode 100644 drivers/staging/iio/dac/mcp4725.c
>   create mode 100644 drivers/staging/iio/dac/mcp4725.h
>
> diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kconfig
> index a626f03..960ae06 100644
> --- a/drivers/staging/iio/dac/Kconfig
> +++ b/drivers/staging/iio/dac/Kconfig
> @@ -118,4 +118,15 @@ config MAX517
>   	  This driver can also be built as a module.  If so, the module
>   	  will be called max517.
>
> +config MCP4725
> +	tristate "MCP4725 DAC driver"
> +	depends on I2C
> +	---help---
> +	  Say Y here if you want to build a driver for the Microchip
> +	  MCP 4725 12-bit digital-to-analog convertor (DAC) with I2C
> +	  interface.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called mcp4725.
> +
>   endmenu
> diff --git a/drivers/staging/iio/dac/Makefile b/drivers/staging/iio/dac/Makefile
> index 8ab1d26..9ea3cee 100644
> --- a/drivers/staging/iio/dac/Makefile
> +++ b/drivers/staging/iio/dac/Makefile
> @@ -13,3 +13,4 @@ obj-$(CONFIG_AD5764) += ad5764.o
>   obj-$(CONFIG_AD5791) += ad5791.o
>   obj-$(CONFIG_AD5686) += ad5686.o
>   obj-$(CONFIG_MAX517) += max517.o
> +obj-$(CONFIG_MCP4725) += mcp4725.o
> diff --git a/drivers/staging/iio/dac/mcp4725.c b/drivers/staging/iio/dac/mcp4725.c
> new file mode 100644
> index 0000000..de2fc93
> --- /dev/null
> +++ b/drivers/staging/iio/dac/mcp4725.c
> @@ -0,0 +1,211 @@
> +/*
> + * mcp4725.c - Support for Microchip MCP4725
> + *
> + * Copyright (C) 2012 Peter Meerwald<pmeerw@pmeerw.net>
> + *
> + * Based on max517 by Roland Stigge<stigge@antcom.de>
> + *
> + * This file is subject to the terms and conditions of version 2 of
> + * the GNU General Public License.  See the file COPYING in the main
> + * directory of this archive for more details.
> + *
> + * driver for the Microchip I2C 12-bit digital-to-analog converter (DAC)
> + * (7-bit I2C slave address 0x60, the three LSBs can be configured in
> + * hardware)
> + *
> + * writing the DAC value to EEPROM is not supported
> + */
> +
> +#include<linux/module.h>
> +#include<linux/init.h>
> +#include<linux/i2c.h>
> +#include<linux/err.h>
> +
> +#include<linux/iio/iio.h>
> +#include<linux/iio/sysfs.h>
> +
> +#include "mcp4725.h"
> +
> +#define MCP4725_DRV_NAME	"mcp4725"
> +
> +struct mcp4725_data {
> +	struct iio_dev		*indio_dev;
> +	struct i2c_client	*client;
> +	unsigned short		vref_mv;
> +	unsigned short		dac_value;
> +};
> +
> +static ssize_t mcp4725_set_value(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct mcp4725_data *data = iio_priv(indio_dev);
> +	u8 outbuf[2];
> +	int res;
> +	long val;
> +
> +	res = kstrtol(buf, 10,&val);
> +	if (res)
> +		return res;
> +
> +	if (val<  0 || val>  0xfff)
> +		return -EINVAL;
> +
> +	outbuf[0] = (val>>  8)&  0xf;
> +	outbuf[1] = val&  0xff;
> +
> +	res = i2c_master_send(data->client, outbuf, 2);
> +	if (res<  0)
> +		return res;
> +
> +	data->dac_value = val;
> +
> +	return count;
> +}
> +
> +static IIO_DEVICE_ATTR(out_voltage_raw, S_IWUSR,
> +		       NULL, mcp4725_set_value, 0);
> +
> +static ssize_t mcp4725_show_scale(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct mcp4725_data *data = iio_priv(indio_dev);
> +
> +	unsigned int scale_uv = (data->vref_mv * 1000)>>  12;
> +
> +	return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv % 1000);
> +}
> +
> +static IIO_DEVICE_ATTR(out_voltage_scale, S_IRUGO,
> +		       mcp4725_show_scale, NULL, 0);
> +
> +static struct attribute *mcp4725_attributes[] = {
> +	&iio_dev_attr_out_voltage_raw.dev_attr.attr,
> +	&iio_dev_attr_out_voltage_scale.dev_attr.attr,
> +	NULL
> +};
> +
> +static struct attribute_group mcp4725_attribute_group = {
> +	.attrs = mcp4725_attributes,
> +};
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int mcp4725_suspend(struct device *dev)
> +{
> +	u8 outbuf[2];
> +
> +	outbuf[0] = 0x3<<  4; /* power-down bits, 500 kOhm resistor */
> +	outbuf[1] = 0;
> +
> +	return i2c_master_send(to_i2c_client(dev),&outbuf, 2);
> +}
> +
> +static int mcp4725_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct mcp4725_data *data = iio_priv(indio_dev);
> +	u8 outbuf[2];
> +
> +	/* restore previous DAC value */
> +	outbuf[0] = (data->dac_value>>  8)&  0xf;
> +	outbuf[1] = data->dac_value&  0xff;
> +
> +	return i2c_master_send(to_i2c_client(dev),&outbuf, 2);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(mcp4725_pm_ops, mcp4725_suspend, mcp4725_resume);
> +#define MCP4725_PM_OPS (&mcp4725_pm_ops)
> +#else
> +#define MCP4725_PM_OPS NULL
> +#endif
> +
> +static const struct iio_info mcp4725_info = {
> +	.attrs =&mcp4725_attribute_group,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static int mcp4725_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct mcp4725_data *data;
> +	struct iio_dev *indio_dev;
> +	struct mcp4725_platform_data *platform_data = client->dev.platform_data;
> +	u8 inbuf[3];
> +	int err;
> +
> +	if (!platform_data || !platform_data->vref_mv) {
> +		dev_err(&client->dev, "invalid platform data");
> +		err = -EINVAL;
> +		goto exit;
> +	}
> +
> +	indio_dev = iio_device_alloc(sizeof(*data));
> +	if (indio_dev == NULL) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	indio_dev->dev.parent =&client->dev;
> +	indio_dev->info =&mcp4725_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	data->vref_mv = platform_data->vref_mv;
> +
> +	/* read current DAC value */
> +	err = i2c_master_recv(client, inbuf, 3);
> +	if (err<  0) {
> +		dev_err(&client->dev, "failed to read DAC value");
> +		goto exit_free_device;
> +	}
> +	data->dac_value = (inbuf[1]<<  4) | (inbuf[2]>>  4);
> +
> +	err = iio_device_register(indio_dev);
> +	if (err)
> +		goto exit_free_device;
> +
> +	dev_info(&client->dev, "MCP4725 DAC registered\n");
> +
> +	return 0;
> +
> +exit_free_device:
> +	iio_device_free(indio_dev);
> +exit:
> +	return err;
> +}
> +
> +static int mcp4725_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +	iio_device_unregister(indio_dev);
> +	iio_device_free(indio_dev);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id mcp4725_id[] = {
> +	{ "mcp4725", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, mcp4725_id);
> +
> +static struct i2c_driver mcp4725_driver = {
> +	.driver = {
> +		.name	= MCP4725_DRV_NAME,
> +		.pm	= MCP4725_PM_OPS,
> +	},
> +	.probe		= mcp4725_probe,
> +	.remove		= mcp4725_remove,
> +	.id_table	= mcp4725_id,
> +};
> +module_i2c_driver(mcp4725_driver);
> +
> +MODULE_AUTHOR("Peter Meerwald<pmeerw@pmeerw.net>");
> +MODULE_DESCRIPTION("MCP4725 12-bit DAC");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/staging/iio/dac/mcp4725.h b/drivers/staging/iio/dac/mcp4725.h
> new file mode 100644
> index 0000000..91530e6
> --- /dev/null
> +++ b/drivers/staging/iio/dac/mcp4725.h
> @@ -0,0 +1,16 @@
> +/*
> + * MCP4725 DAC driver
> + *
> + * Copyright (C) 2012 Peter Meerwald<pmeerw@pmeerw.net>
> + *
> + * Licensed under the GPL-2 or later.
> + */
> +
> +#ifndef IIO_DAC_MCP4725_H_
> +#define IIO_DAC_MCP4725_H_
> +
> +struct mcp4725_platform_data {
> +	u16 vref_mv;
> +};
> +
> +#endif /* IIO_DAC_MCP4725_H_ */

