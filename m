Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50837 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbbJDOEx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Oct 2015 10:04:53 -0400
Subject: Re: [PATCH v4 3/7] Add tsys02d meas-spec driver support
To: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, William.Markezana@meas-spec.com
References: <1443708822-8580-1-git-send-email-ludovic.tancerel@maplehightech.com>
 <1443708822-8580-4-git-send-email-ludovic.tancerel@maplehightech.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56113204.7060006@kernel.org>
Date: Sun, 4 Oct 2015 15:04:52 +0100
MIME-Version: 1.0
In-Reply-To: <1443708822-8580-4-git-send-email-ludovic.tancerel@maplehightech.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/10/15 15:13, Ludovic Tancerel wrote:
> Support for TSYS02D temperature sensor
> 
> Signed-off-by: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
Applied.
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-meas-spec |   7 +
>  drivers/iio/temperature/Kconfig                   |  11 ++
>  drivers/iio/temperature/Makefile                  |   1 +
>  drivers/iio/temperature/tsys02d.c                 | 191 ++++++++++++++++++++++
>  4 files changed, 210 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-meas-spec
>  create mode 100644 drivers/iio/temperature/tsys02d.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-meas-spec b/Documentation/ABI/testing/sysfs-bus-iio-meas-spec
> new file mode 100644
> index 0000000..6d47e54
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-meas-spec
> @@ -0,0 +1,7 @@
> +What:           /sys/bus/iio/devices/iio:deviceX/battery_low
> +KernelVersion:  4.1.0
> +Contact:        linux-iio@vger.kernel.org
> +Description:
> +                Reading returns either '1' or '0'. '1' means that the
> +                battery level supplied to sensor is below 2.25V.
> +                This ABI is available for tsys02d, htu21, ms8607
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> index 35712032..c4664e5 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -34,4 +34,15 @@ config TSYS01
>  	  This driver can also be built as a module. If so, the module will
>  	  be called tsys01.
>  
> +config TSYS02D
> +	tristate "Measurement Specialties TSYS02D temperature sensor"
> +	depends on I2C
> +	select IIO_MS_SENSORS_I2C
> +	help
> +	  If you say yes here you get support for the Measurement Specialties
> +	  TSYS02D temperature sensor.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called tsys02d.
> +
>  endmenu
> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
> index 368a2a2..02bc79d 100644
> --- a/drivers/iio/temperature/Makefile
> +++ b/drivers/iio/temperature/Makefile
> @@ -5,3 +5,4 @@
>  obj-$(CONFIG_MLX90614) += mlx90614.o
>  obj-$(CONFIG_TMP006) += tmp006.o
>  obj-$(CONFIG_TSYS01) += tsys01.o
> +obj-$(CONFIG_TSYS02D) += tsys02d.o
> diff --git a/drivers/iio/temperature/tsys02d.c b/drivers/iio/temperature/tsys02d.c
> new file mode 100644
> index 0000000..2618d42
> --- /dev/null
> +++ b/drivers/iio/temperature/tsys02d.c
> @@ -0,0 +1,191 @@
> +/*
> + * tsys02d.c - Support for Measurement-Specialties tsys02d temperature sensor
> + *
> + * Copyright (c) 2015 Measurement-Specialties
> + *
> + * Licensed under the GPL-2.
> + *
> + * (7-bit I2C slave address 0x40)
> + *
> + * Datasheet:
> + *  http://www.meas-spec.com/downloads/Digital_Sensor_TSYS02D.pdf
> + */
> +
> +#include <linux/init.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/stat.h>
> +#include <linux/module.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#include "../common/ms_sensors/ms_sensors_i2c.h"
> +
> +#define TSYS02D_RESET				0xFE
> +
> +static const int tsys02d_samp_freq[4] = { 20, 40, 70, 140 };
> +/* String copy of the above const for readability purpose */
> +static const char tsys02d_show_samp_freq[] = "20 40 70 140";
> +
> +static int tsys02d_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *channel, int *val,
> +			    int *val2, long mask)
> +{
> +	int ret;
> +	s32 temperature;
> +	struct ms_ht_dev *dev_data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		switch (channel->type) {
> +		case IIO_TEMP:	/* in milli °C */
> +			ret = ms_sensors_ht_read_temperature(dev_data,
> +							     &temperature);
> +			if (ret)
> +				return ret;
> +			*val = temperature;
> +
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = tsys02d_samp_freq[dev_data->res_index];
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int tsys02d_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct ms_ht_dev *dev_data = iio_priv(indio_dev);
> +	int i, ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		i = ARRAY_SIZE(tsys02d_samp_freq);
> +		while (i-- > 0)
> +			if (val == tsys02d_samp_freq[i])
> +				break;
> +		if (i < 0)
> +			return -EINVAL;
> +		mutex_lock(&dev_data->lock);
> +		dev_data->res_index = i;
> +		ret = ms_sensors_write_resolution(dev_data, i);
> +		mutex_unlock(&dev_data->lock);
> +
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_chan_spec tsys02d_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_PROCESSED),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	}
> +};
> +
> +static ssize_t tsys02_read_battery_low(struct device *dev,
> +				       struct device_attribute *attr,
> +				       char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct ms_ht_dev *dev_data = iio_priv(indio_dev);
> +
> +	return ms_sensors_show_battery_low(dev_data, buf);
> +}
> +
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(tsys02d_show_samp_freq);
> +static IIO_DEVICE_ATTR(battery_low, S_IRUGO,
> +		       tsys02_read_battery_low, NULL, 0);
> +
> +static struct attribute *tsys02d_attributes[] = {
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	&iio_dev_attr_battery_low.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group tsys02d_attribute_group = {
> +	.attrs = tsys02d_attributes,
> +};
> +
> +static const struct iio_info tsys02d_info = {
> +	.read_raw = tsys02d_read_raw,
> +	.write_raw = tsys02d_write_raw,
> +	.attrs = &tsys02d_attribute_group,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +int tsys02d_probe(struct i2c_client *client,
> +		  const struct i2c_device_id *id)
> +{
> +	struct ms_ht_dev *dev_data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +	u64 serial_number;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> +				     I2C_FUNC_SMBUS_WRITE_BYTE |
> +				     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
> +		dev_err(&client->dev,
> +			"Adapter does not support some i2c transaction\n");
> +		return -ENODEV;
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*dev_data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	dev_data = iio_priv(indio_dev);
> +	dev_data->client = client;
> +	dev_data->res_index = 0;
> +	mutex_init(&dev_data->lock);
> +
> +	indio_dev->info = &tsys02d_info;
> +	indio_dev->name = id->name;
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = tsys02d_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(tsys02d_channels);
> +
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	ret = ms_sensors_reset(client, TSYS02D_RESET, 15000);
> +	if (ret)
> +		return ret;
> +
> +	ret = ms_sensors_read_serial(client, &serial_number);
> +	if (ret)
> +		return ret;
> +	dev_info(&client->dev, "Serial number : %llx", serial_number);
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id tsys02d_id[] = {
> +	{"tsys02d", 0},
> +	{}
> +};
> +
> +static struct i2c_driver tsys02d_driver = {
> +	.probe = tsys02d_probe,
> +	.id_table = tsys02d_id,
> +	.driver = {
> +		   .name = "tsys02d",
> +		   },
> +};
> +
> +module_i2c_driver(tsys02d_driver);
> +
> +MODULE_DESCRIPTION("Measurement-Specialties tsys02d temperature driver");
> +MODULE_AUTHOR("William Markezana <william.markezana@meas-spec.com>");
> +MODULE_AUTHOR("Ludovic Tancerel <ludovic.tancerel@maplehightech.com>");
> +MODULE_LICENSE("GPL v2");
> 

