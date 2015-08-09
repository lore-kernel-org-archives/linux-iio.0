Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:49171 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933158AbbHIUNX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 9 Aug 2015 16:13:23 -0400
Message-ID: <55C7B45B.6040005@gmx.de>
Date: Sun, 09 Aug 2015 22:13:15 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
	lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	William.Markezana@meas-spec.com, Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH V2 3/6] iio: Add tsys02d meas-spec driver support
References: <1438248345-25820-1-git-send-email-ludovic.tancerel@maplehightech.com> <1438248345-25820-4-git-send-email-ludovic.tancerel@maplehightech.com> <55C63917.1030905@kernel.org> <55C74888.7060001@roeck-us.net>
In-Reply-To: <55C74888.7060001@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Guenter Roeck schrieb am 09.08.2015 um 14:33:
> On 08/08/2015 10:15 AM, Jonathan Cameron wrote:
>> On 30/07/15 10:25, Ludovic Tancerel wrote:
>> The battery low indicator is certainly 'unusual' and undocumented on the
>> datasheet mentioned here.
>>
>> Ah well.  Same owner point as with the previous driver. Otherwise
>> seems fine to me.  Have cc'd the hwmon guys in case they have comments.
>>
>> Guenter / Jean, I would be more doubtful about having what is basically
>> a straight forward (if accurate) temperature IC in IIO except that
>> this is part of a series of parts including humidity and pressure sensors
>> in combined forms which are more common IIO fodder.
> 
> Agreed; I would really not like to have common code between iio and hwmon.
> 
> Does the series include support for htu21d ? If so, we should probably drop
> that driver from hwmon after it is available in iio.

Yes, it does.

http://www.spinics.net/lists/linux-iio/msg19918.html

> 
> Thanks,
> Guenter
> 
>>
>> Jonathan
>>> Signed-off-by: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
>>> ---
>>>   Documentation/ABI/testing/sysfs-bus-iio-meas-spec |   7 +
>>>   drivers/iio/temperature/Kconfig                   |  11 ++
>>>   drivers/iio/temperature/Makefile                  |   1 +
>>>   drivers/iio/temperature/tsys02d.c                 | 193 ++++++++++++++++++++++
>>>   4 files changed, 212 insertions(+)
>>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-meas-spec
>>>   create mode 100644 drivers/iio/temperature/tsys02d.c
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-meas-spec b/Documentation/ABI/testing/sysfs-bus-iio-meas-spec
>>> new file mode 100644
>>> index 0000000..6d47e54
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-meas-spec
>>> @@ -0,0 +1,7 @@
>>> +What:           /sys/bus/iio/devices/iio:deviceX/battery_low
>>> +KernelVersion:  4.1.0
>>> +Contact:        linux-iio@vger.kernel.org
>>> +Description:
>>> +                Reading returns either '1' or '0'. '1' means that the
>>> +                battery level supplied to sensor is below 2.25V.
>>> +                This ABI is available for tsys02d, htu21, ms8607
>>
>> Hmm. This one is odd to find in IIO.  Also I can't actually find
>> reference to it on the datasheet.
>>
>> You are quite correct in thinking this is device specific abi and
>> documenting it as you have.
>>
>> Not sure we can do much else...
>>> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
>>> index 35712032..c4664e5 100644
>>> --- a/drivers/iio/temperature/Kconfig
>>> +++ b/drivers/iio/temperature/Kconfig
>>> @@ -34,4 +34,15 @@ config TSYS01
>>>   	  This driver can also be built as a module. If so, the module will
>>>   	  be called tsys01.
>>>
>>> +config TSYS02D
>>> +	tristate "Measurement Specialties TSYS02D temperature sensor"
>>> +	depends on I2C
>>> +	select IIO_MS_SENSORS_I2C
>>> +	help
>>> +	  If you say yes here you get support for the Measurement Specialties
>>> +	  TSYS02D temperature sensor.
>>> +
>>> +	  This driver can also be built as a module. If so, the module will
>>> +	  be called tsys02d.
>>> +
>>>   endmenu
>>> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
>>> index 368a2a2..02bc79d 100644
>>> --- a/drivers/iio/temperature/Makefile
>>> +++ b/drivers/iio/temperature/Makefile
>>> @@ -5,3 +5,4 @@
>>>   obj-$(CONFIG_MLX90614) += mlx90614.o
>>>   obj-$(CONFIG_TMP006) += tmp006.o
>>>   obj-$(CONFIG_TSYS01) += tsys01.o
>>> +obj-$(CONFIG_TSYS02D) += tsys02d.o
>>> diff --git a/drivers/iio/temperature/tsys02d.c b/drivers/iio/temperature/tsys02d.c
>>> new file mode 100644
>>> index 0000000..6971dab
>>> --- /dev/null
>>> +++ b/drivers/iio/temperature/tsys02d.c
>>> @@ -0,0 +1,193 @@
>>> +/*
>>> + * tsys02d.c - Support for Measurement-Specialties tsys02d temperature sensor
>>> + *
>>> + * Copyright (c) 2015 Measurement-Specialties
>>> + *
>>> + * Licensed under the GPL-2.
>>> + *
>>> + * (7-bit I2C slave address 0x40)
>>> + *
>>> + * Datasheet:
>>> + *  http://www.meas-spec.com/downloads/Digital_Sensor_TSYS02D.pdf
>>> + *
>>> + */
>>> +
>>> +#include <linux/init.h>
>>> +#include <linux/device.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/stat.h>
>>> +#include <linux/module.h>
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/iio/sysfs.h>
>>> +
>>> +#include "../common/ms_sensors/ms_sensors_i2c.h"
>>> +
>>> +#define TSYS02D_RESET				0xFE
>>> +
>>> +static const int tsys02d_samp_freq[4] = { 20, 40, 70, 140 };
>>> +/* String copy of the above const for readability purpose */
>>> +static const char tsys02d_show_samp_freq[] = "20 40 70 140";
>>> +
>>> +static int tsys02d_read_raw(struct iio_dev *indio_dev,
>>> +			    struct iio_chan_spec const *channel, int *val,
>>> +			    int *val2, long mask)
>>> +{
>>> +	int ret;
>>> +	s32 temperature;
>>> +	struct ms_ht_dev *dev_data = iio_priv(indio_dev);
>>> +
>>> +	switch (mask) {
>>> +	case IIO_CHAN_INFO_PROCESSED:
>>> +		switch (channel->type) {
>>> +		case IIO_TEMP:	/* in milli °C */
>>> +			ret = ms_sensors_i2c_ht_read_temperature(dev_data,
>>> +								 &temperature);
>>> +			if (ret)
>>> +				return ret;
>>> +			*val = temperature;
>>> +
>>> +			return IIO_VAL_INT;
>>> +		default:
>>> +			return -EINVAL;
>>> +		}
>>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>>> +		*val = tsys02d_samp_freq[dev_data->res_index];
>>> +
>>> +		return IIO_VAL_INT;
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +}
>>> +
>>> +static int tsys02d_write_raw(struct iio_dev *indio_dev,
>>> +			     struct iio_chan_spec const *chan,
>>> +			     int val, int val2, long mask)
>>> +{
>>> +	struct ms_ht_dev *dev_data = iio_priv(indio_dev);
>>> +	int i, ret;
>>> +
>>> +	switch (mask) {
>>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>>> +		i = ARRAY_SIZE(tsys02d_samp_freq);
>>> +		while (i-- > 0)
>>> +			if (val == tsys02d_samp_freq[i])
>>> +				break;
>>> +		if (i < 0)
>>> +			return -EINVAL;
>>> +		mutex_lock(&dev_data->lock);
>>> +		dev_data->res_index = i;
>>> +		ret = ms_sensors_i2c_write_resolution(dev_data, i);
>>> +		mutex_unlock(&dev_data->lock);
>>> +
>>> +		return ret;
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +}
>>> +
>>> +static const struct iio_chan_spec tsys02d_channels[] = {
>>> +	{
>>> +		.type = IIO_TEMP,
>>> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_PROCESSED),
>>> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>>> +	}
>>> +};
>>> +
>>> +static ssize_t tsys02_read_battery_low(struct device *dev,
>>> +				       struct device_attribute *attr,
>>> +				       char *buf)
>>> +{
>>> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>> +	struct ms_ht_dev *dev_data = iio_priv(indio_dev);
>>> +
>>> +	return ms_sensors_i2c_show_battery_low(dev_data, buf);
>>> +}
>>> +
>>> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(tsys02d_show_samp_freq);
>>> +static IIO_DEVICE_ATTR(battery_low, S_IRUGO,
>>> +		       tsys02_read_battery_low, NULL, 0);
>>> +
>>> +static struct attribute *tsys02d_attributes[] = {
>>> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
>>> +	&iio_dev_attr_battery_low.dev_attr.attr,
>>> +	NULL,
>>> +};
>>> +
>>> +static const struct attribute_group tsys02d_attribute_group = {
>>> +	.attrs = tsys02d_attributes,
>>> +};
>>> +
>>> +static const struct iio_info tsys02d_info = {
>>> +	.read_raw = tsys02d_read_raw,
>>> +	.write_raw = tsys02d_write_raw,
>>> +	.attrs = &tsys02d_attribute_group,
>>> +	.driver_module = THIS_MODULE,
>>> +};
>>> +
>>> +int tsys02d_probe(struct i2c_client *client,
>>> +		  const struct i2c_device_id *id)
>>> +{
>>> +	struct ms_ht_dev *dev_data;
>>> +	struct iio_dev *indio_dev;
>>> +	int ret;
>>> +	u64 serial_number;
>>> +
>>> +	if (!i2c_check_functionality(client->adapter,
>>> +				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
>>> +				     I2C_FUNC_SMBUS_WRITE_BYTE |
>>> +				     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
>>> +		dev_err(&client->dev,
>>> +			"Adapter does not support some i2c transaction\n");
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*dev_data));
>>> +	if (!indio_dev)
>>> +		return -ENOMEM;
>>> +
>>> +	dev_data = iio_priv(indio_dev);
>>> +	dev_data->client = client;
>>> +	dev_data->res_index = 0;
>>> +	mutex_init(&dev_data->lock);
>>> +
>>> +	indio_dev->info = &tsys02d_info;
>>> +	indio_dev->name = id->name;
>>> +	indio_dev->dev.parent = &client->dev;
>>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>>> +	indio_dev->channels = tsys02d_channels;
>>> +	indio_dev->num_channels = ARRAY_SIZE(tsys02d_channels);
>>> +
>>> +	i2c_set_clientdata(client, indio_dev);
>>> +
>>> +	ret = ms_sensors_i2c_reset(client, TSYS02D_RESET, 15000);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = ms_sensors_i2c_read_serial(client, &serial_number);
>>> +	if (ret)
>>> +		return ret;
>>> +	dev_info(&client->dev, "Serial number : %llx", serial_number);
>>> +
>>> +	return devm_iio_device_register(&client->dev, indio_dev);
>>> +}
>>> +
>>> +static const struct i2c_device_id tsys02d_id[] = {
>>> +	{"tsys02d", 0},
>>> +	{}
>>> +};
>>> +
>>> +static struct i2c_driver tsys02d_driver = {
>>> +	.probe = tsys02d_probe,
>>> +	.id_table = tsys02d_id,
>>> +	.driver = {
>>> +		   .name = "tsys02d",
>>> +		   .owner = THIS_MODULE,
>> Again, don't set owner (I'll only get a patch removing it a few days after
>> taking this one otherwise!)
>>> +		   },
>>> +};
>>> +
>>> +module_i2c_driver(tsys02d_driver);
>>> +
>>> +MODULE_DESCRIPTION("Measurement-Specialties tsys02d temperature driver");
>>> +MODULE_AUTHOR("William Markezana <william.markezana@meas-spec.com>");
>>> +MODULE_AUTHOR("Ludovic Tancerel <ludovic.tancerel@maplehightech.com>");
>>> +MODULE_LICENSE("GPL v2");
>>>
>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

