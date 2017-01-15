Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56848 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbdAONMn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Jan 2017 08:12:43 -0500
Subject: Re: [PATCH v2 2/2] iio: distance: srf08: add IIO driver for us ranger
To: Andreas Klinger <ak@it-klinger.de>
References: <20170110184815.GA15532@andreas>
 <4099feac-959c-2b5b-a21a-3b111098af39@kernel.org>
 <20170114174856.GA2351@andreas>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ktsai@capellamicro.com, wsa@the-dreams.de, robh+dt@kernel.org,
        pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        trivial@kernel.org, mranostay@gmail.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d05cce62-4362-b249-f49f-58eed2316ddb@kernel.org>
Date: Sun, 15 Jan 2017 13:12:40 +0000
MIME-Version: 1.0
In-Reply-To: <20170114174856.GA2351@andreas>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/01/17 17:48, Andreas Klinger wrote:
> Hi Jonathan,
> 
> see comments below.
> 
> Andreas
> 
> 
> Jonathan Cameron <jic23@kernel.org> schrieb am Sat, 14. Jan 12:17:
>> On 10/01/17 18:48, Andreas Klinger wrote:
>>> This is the IIO driver for devantech srf08 ultrasonic ranger which can be
>>> used to measure the distances to an object.
>>>
>>> The sensor supports I2C with some registers.
>>>
>>> Supported Features include:
>>> - read the distance in ranging mode in centimeters
>>> - output of the driver is directly the read value
>>> - together with the scale the driver delivers the distance in meters
>>> - only the first echo of the nearest object is delivered
>>> - set max gain register; userspace enters analogue value
>>> - set range registers; userspace enters range in millimeters in 43 mm steps
>>>
>>> Features not supported by this driver:
>>> - ranging mode in inches or in microseconds
>>> - ANN mode
>>> - change I2C address through this driver
>>> - light sensor
>>>
>>> The driver was added in the directory "proximity" of the iio subsystem
>>> in absence of another directory named "distance".
>>> There is also a new submenu "distance"
>> Hi Andreas,
>>
>> Sorry it took me a while to get to this!
>>
>> I'd not bother with the new submenu.  Perhaps we should rename the
>> proximity menu to proximity/distance.
>>
>> We already the lightening detector in there which is definitely not
>> measuring proximity in the convetional sense!
>>
>> Anyhow, the actual code is fine, but we need to think about how the
>> userspace ABI fits within the wider IIO ABI.  Naming and approaches
>> that make sense in a single class of drivers can end up meaining
>> very different things for other drivers.  Various suggestions inline.
>>
>> Jonathan
>>>
>>> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
>>> ---
>>>  drivers/iio/proximity/Kconfig  |  15 ++
>>>  drivers/iio/proximity/Makefile |   1 +
>>>  drivers/iio/proximity/srf08.c  | 362 +++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 378 insertions(+)
>>>  create mode 100644 drivers/iio/proximity/srf08.c
>>>
>>> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
>>> index ef4c73db5b53..7b10a137702b 100644
>>> --- a/drivers/iio/proximity/Kconfig
>>> +++ b/drivers/iio/proximity/Kconfig
>>> @@ -46,3 +46,18 @@ config SX9500
>>>  	  module will be called sx9500.
>>>  
>>>  endmenu
>>> +
>>> +menu "Distance sensors"
>>> +
>>> +config SRF08
>>> +	tristate "Devantech SRF08 ultrasonic ranger sensor"
>>> +	depends on I2C
>>> +	help
>>> +	  Say Y here to build a driver for Devantech SRF08 ultrasonic
>>> +	  ranger sensor. This driver can be used to measure the distance
>>> +	  of objects.
>>> +
>>> +	  To compile this driver as a module, choose M here: the
>>> +	  module will be called srf08.
>>> +
>>> +endmenu
>>> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
>>> index 9aadd9a8ee99..e914c2a5dd49 100644
>>> --- a/drivers/iio/proximity/Makefile
>>> +++ b/drivers/iio/proximity/Makefile
>>> @@ -5,4 +5,5 @@
>>>  # When adding new entries keep the list in alphabetical order
>>>  obj-$(CONFIG_AS3935)		+= as3935.o
>>>  obj-$(CONFIG_LIDAR_LITE_V2)	+= pulsedlight-lidar-lite-v2.o
>>> +obj-$(CONFIG_SRF08)		+= srf08.o
>>>  obj-$(CONFIG_SX9500)		+= sx9500.o
>>> diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
>>> new file mode 100644
>>> index 000000000000..f38c74ed0933
>>> --- /dev/null
>>> +++ b/drivers/iio/proximity/srf08.c
>>> @@ -0,0 +1,362 @@
>>> +/*
>>> + * srf08.c - Support for Devantech SRF08 ultrasonic ranger
>>> + *
>>> + * Copyright (c) 2016 Andreas Klinger <ak@it-klinger.de>
>>> + *
>>> + * This file is subject to the terms and conditions of version 2 of
>>> + * the GNU General Public License.  See the file COPYING in the main
>>> + * directory of this archive for more details.
>>> + *
>>> + * For details about the device see:
>>> + * http://www.robot-electronics.co.uk/htm/srf08tech.html
>>> + */
>>> +
>>> +#include <linux/err.h>
>>> +#include <linux/i2c.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/module.h>
>>> +#include <linux/bitops.h>
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/iio/sysfs.h>
>>> +
>>> +/* registers of SRF08 device */
>>> +#define SRF08_WRITE_COMMAND	0x00	/* Command Register */
>>> +#define SRF08_WRITE_MAX_GAIN	0x01	/* Max Gain Register: 0 .. 31 */
>>> +#define SRF08_WRITE_RANGE	0x02	/* Range Register: 0 .. 255 */
>>> +#define SRF08_READ_SW_REVISION	0x00	/* Software Revision */
>>> +#define SRF08_READ_LIGHT	0x01	/* Light Sensor during last echo */
>>> +#define SRF08_READ_ECHO_1_HIGH	0x02	/* Range of first echo received */
>>> +#define SRF08_READ_ECHO_1_LOW	0x03	/* Range of first echo received */
>>> +
>>> +#define SRF08_CMD_RANGING_CM	0x51	/* Ranging Mode - Result in cm */
>>> +
>>> +#define SRF08_DEFAULT_GAIN	1025	/* max. analogue value of Gain */
>>> +#define SRF08_DEFAULT_RANGE	11008	/* max. value of Range in mm */
>>> +
>>> +struct srf08_data {
>>> +	struct i2c_client	*client;
>>> +	int			gain;			/* Max Gain */
>>> +	int			range_mm;		/* Range in mm */
>>> +	struct mutex		lock;
>>> +};
>>> +
>>> +static const int srf08_gain[] = {
>>> +	 94,  97, 100, 103, 107, 110, 114, 118,
>>> +	123, 128, 133, 139, 145, 152, 159, 168,
>>> +	177, 187, 199, 212, 227, 245, 265, 288,
>>> +	317, 352, 395, 450, 524, 626, 777, 1025 };
>>> +
>>> +static int srf08_read_ranging(struct srf08_data *data)
>>> +{
>>> +	struct i2c_client *client = data->client;
>>> +	int ret, i;
>>> +
>>> +	mutex_lock(&data->lock);
>>> +
>>> +	ret = i2c_smbus_write_byte_data(data->client,
>>> +			SRF08_WRITE_COMMAND, SRF08_CMD_RANGING_CM);
>>> +	if (ret < 0) {
>>> +		dev_err(&client->dev, "write command - err: %d\n", ret);
>>> +		mutex_unlock(&data->lock);
>>> +		return ret;
>>> +	}
>>> +
>>> +	/*
>>> +	 * normally after 65 ms the device should have the read value
>>> +	 * we round it up to 100 ms
>> I'd suggest this should be adapted so that it takes advantage of knowing
>> roughly how long it is going to take as the 'range' maximum is changed.
>> So perhaps in the basic case, sleep for 65 msecs, then poll at 5msec
>> intervals.  If we know it's going to be a lot faster, then poll it from
>> an earlier time.
>>> +	 *
>>> +	 * we read here until a correct version number shows up as
>>> +	 * suggested by the documentation
>>> +	 */
>>> +	for (i = 0; i < 5; i++) {
>>> +		ret = i2c_smbus_read_byte_data(data->client,
>>> +						SRF08_READ_SW_REVISION);
>>> +
>>> +		/* check if a valid version number is read */
>>> +		if (ret < 255 && ret > 0)
>>> +			break;
>>> +		msleep(20);
>>> +	}
>>> +
>>> +	if (ret >= 255 || ret <= 0) {
>>> +		dev_err(&client->dev, "device not ready\n");
>>> +		mutex_unlock(&data->lock);
>>> +		return -EIO;
>>> +	}
>>> +
>>> +	ret = i2c_smbus_read_word_swapped(data->client,
>>> +						SRF08_READ_ECHO_1_HIGH);
>>> +	if (ret < 0) {
>>> +		dev_err(&client->dev, "cannot read distance: ret=%d\n", ret);
>>> +		mutex_unlock(&data->lock);
>>> +		return ret;
>>> +	}
>>> +
>>> +	mutex_unlock(&data->lock);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int srf08_read_raw(struct iio_dev *indio_dev,
>>> +			    struct iio_chan_spec const *channel, int *val,
>>> +			    int *val2, long mask)
>>> +{
>>> +	struct srf08_data *data = iio_priv(indio_dev);
>>> +	int ret;
>>> +
>>> +	if (channel->type != IIO_DISTANCE)
>>> +		return -EINVAL;
>>> +
>>> +	switch (mask) {
>>> +	case IIO_CHAN_INFO_RAW:
>>> +		ret = srf08_read_ranging(data);
>>> +		if (ret < 0)
>>> +			return ret;
>>> +		*val = ret;
>>> +		return IIO_VAL_INT;
>>> +	case IIO_CHAN_INFO_SCALE:
>>> +		/* 1 LSB is 1 cm */
>>> +		*val = 0;
>>> +		*val2 = 10000;
>>> +		return IIO_VAL_INT_PLUS_MICRO;
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +}
>>> +
>>> +static ssize_t srf08_show_range_mm_available(struct device *dev,
>>> +				struct device_attribute *attr, char *buf)
>>> +{
>>> +	int i, len = 0;
>>> +
>>> +	for (i = 0; i < 256; i++)
>>> +		len += scnprintf(buf + len, PAGE_SIZE - len,
>>> +							"%d ", (i + 1) * 43);
>>> +
>>> +	buf[len - 1] = '\n';
>>> +
>>> +	return len;
>>> +}
>>> +
>>> +static IIO_DEVICE_ATTR(range_mm_available, S_IRUGO,
>>> +				srf08_show_range_mm_available, NULL, 0);
>>> +
>>> +static ssize_t srf08_show_range_mm(struct device *dev,
>>> +				struct device_attribute *attr, char *buf)
>>> +{
>>> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>> +	struct srf08_data *data = iio_priv(indio_dev);
>>> +
>>> +	return sprintf(buf, "%d\n", data->range_mm);
>>> +}
>>> +
>>> +/*
>>> + * set the range of the sensor to an even multiple of 43 mm
>>> + * which corresponds to 1 LSB in the register
>>> + *
>>> + * register value    corresponding range
>>> + *         0x00             43 mm
>>> + *         0x01             86 mm
>>> + *         0x02            129 mm
>>> + *         ...
>>> + *         0xFF          11008 mm
>>> + */
>>> +static ssize_t srf08_write_range_mm(struct device *dev,
>>> +					struct device_attribute *attr,
>>> +					const char *buf, size_t len)
>>> +{
>>> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>> +	struct srf08_data *data = iio_priv(indio_dev);
>>> +	struct i2c_client *client = data->client;
>>> +	int ret;
>>> +	unsigned int val, mod;
>>> +	u8 regval;
>>> +
>>> +	ret = kstrtouint(buf, 10, &val);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = val / 43 - 1;
>>> +	mod = val % 43;
>>> +
>>> +	if (mod || (ret < 0) || (ret > 255))
>>> +		return -EINVAL;
>>> +
>>> +	regval = ret;
>>> +
>>> +	mutex_lock(&data->lock);
>>> +
>>> +	ret = i2c_smbus_write_byte_data(data->client,
>>> +						SRF08_WRITE_RANGE, regval);
>>> +	if (ret < 0) {
>>> +		dev_err(&client->dev, "write_range - err: %d\n", ret);
>>> +		mutex_unlock(&data->lock);
>>> +		return ret;
>>> +	}
>>> +
>>> +	data->range_mm = val;
>>> +
>>> +	mutex_unlock(&data->lock);
>>> +
>>> +	return len;
>>> +}
>>> +
>>> +static IIO_DEVICE_ATTR(range_mm, S_IRUGO | S_IWUSR,
>>> +			srf08_show_range_mm, srf08_write_range_mm, 0);
>>> +
>>> +static ssize_t srf08_show_gain_available(struct device *dev,
>>> +				struct device_attribute *attr, char *buf)
>>> +{
>>> +	int i, len = 0;
>>> +
>>> +	for (i = 0; i < ARRAY_SIZE(srf08_gain); i++)
>>> +		len += sprintf(buf + len, "%d ", srf08_gain[i]);
>>> +
>>> +	len += sprintf(buf + len, "\n");
>>> +
>>> +	return len;
>>> +}
>>> +
>>> +static IIO_DEVICE_ATTR(gain_available, S_IRUGO,
>>> +				srf08_show_gain_available, NULL, 0);
>>> +
>>> +static ssize_t srf08_show_gain(struct device *dev,
>>> +				struct device_attribute *attr, char *buf)
>>> +{
>>> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>> +	struct srf08_data *data = iio_priv(indio_dev);
>>> +	int len;
>>> +
>>> +	len = sprintf(buf, "%d\n", data->gain);
>>> +
>>> +	return len;
>>> +}
>>> +
>>> +static ssize_t srf08_write_gain(struct device *dev,
>>> +						struct device_attribute *attr,
>>> +						const char *buf, size_t len)
>>> +{
>>> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>> +	struct srf08_data *data = iio_priv(indio_dev);
>>> +	struct i2c_client *client = data->client;
>>> +	int ret, i;
>>> +	unsigned int val;
>>> +	u8 regval;
>>> +
>>> +	ret = kstrtouint(buf, 10, &val);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	for (i = 0; i < ARRAY_SIZE(srf08_gain); i++)
>>> +		if (val == srf08_gain[i]) {
>>> +			regval = i;
>>> +			break;
>>> +		}
>>> +
>>> +	if (i >= ARRAY_SIZE(srf08_gain))
>>> +		return -EINVAL;
>>> +
>>> +	mutex_lock(&data->lock);
>>> +
>>> +	ret = i2c_smbus_write_byte_data(data->client,
>>> +						SRF08_WRITE_MAX_GAIN, regval);
>>> +	if (ret < 0) {
>>> +		dev_err(&client->dev, "write_gain - err: %d\n", ret);
>>> +		mutex_unlock(&data->lock);
>>> +		return ret;
>>> +	}
>>> +
>>> +	data->gain = val;
>>> +
>>> +	mutex_unlock(&data->lock);
>>> +
>>> +	return len;
>>> +}
>>> +
>>> +static IIO_DEVICE_ATTR(gain, S_IRUGO | S_IWUSR,
>>> +					srf08_show_gain, srf08_write_gain, 0);
>>> +
>>> +static struct attribute *srf08_attributes[] = {
>>> +	&iio_dev_attr_range_mm.dev_attr.attr,
>>> +	&iio_dev_attr_range_mm_available.dev_attr.attr,
>>> +	&iio_dev_attr_gain.dev_attr.attr,
>>> +	&iio_dev_attr_gain_available.dev_attr.attr,
>> Hmm. Custom attributes always give us issues. The primary point of IIO
>> is to enforce (more or less) standard interfaces.
>>
>> If you do need to add something new then that is fine (and I do think
>> you need to here!).
>>
>> They need to be formally proposed as an addition to the ABI with
>> docs in /Documentation/ABI/testing/sysfs-bus-iio*
>>
>> Once we take one driver using it it becomes part of our ABI that
>> userspace will need to handle, hence we consider these very
>> carefully.
>>
>> My gut feeling would be that gain needs to be more specific as it's
>> a term that can mean very different things.. Here we are talking
>> about an amplifier on a signal that we are then looking at the timing
>> of.   It might otherwise be interpretted as another term for what
>> we term 'scale' in IIO.
>>
>> So what to call it... Perhaps afegain for Analog front end gain?
>> We might want to add this to the core supported attrs, but lets
>> not do so until we see if we have this on a number of devices.
>>
> 
> In /Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935 there is also a
> gain used in a similar situation and it's called there "sensor_sensitivity"
> 
> What it we also use this name here?
It's not ideal as it's not linked to a particular channel or anything,
but lets go with that as at least we will be consistent between drivers.
> 
>> The description would need to make it explicit that this gain is
>> for cases where we aren't measuring the magnitude of what is
>> being amplified.
>>
>> For the range, it's an interesting one.  Again the term range could
>> mean too many things within the wider ABI. We need to make it more
>> specific.
>>
>> Actually reading the datasheet, I think this is fundamentally about the
>> maximum sampling frequency rather than directly about the range.
>> The only reason you'd reduce the range is to speed that up. It doesn't
>> improve the resolution, the device simply answers quicker.
>>
>> So I'd support this as sampling_frequency.  You could then use
>> the the iio_info_mask_*_available and relevant callback to provide
>> info on what it then restricts the possible output values to
>> (rather than controlling it directly).
>>
> 
> By changing the range one cannot influence the sampling frequency directly. I
> have seen on the oszilloscope that the telegrams arrive almost at the same time
> with different settings of range and the same gain.
> 
> Only if the gain is also adjusted the sensor works faster and a higher frequency
> can be used. But the gain is also used to adjust the sensitivity of the sensor. 
That's rather weird and not what the datasheet suggests. Ah well.
> 
> What about calling it "sensor_domain" or "sensor_max_range"?
hmm. Not sure - propose that with appropriate Docs and we can think more on it.
> 
> 
>>> +	NULL,
>>> +};
>>> +
>>> +static const struct attribute_group srf08_attribute_group = {
>>> +	.attrs = srf08_attributes,
>>> +};
>>> +
>>> +static const struct iio_chan_spec srf08_channels[] = {
>>> +	{
>>> +		.type = IIO_DISTANCE,
>>> +		.info_mask_separate =
>>> +				BIT(IIO_CHAN_INFO_RAW) |
>>> +				BIT(IIO_CHAN_INFO_SCALE),
>>> +	},
>>> +};
>>> +
>>> +static const struct iio_info srf08_info = {
>>> +	.read_raw = srf08_read_raw,
>>> +	.attrs = &srf08_attribute_group,
>>> +	.driver_module = THIS_MODULE,
>>> +};
>>> +
>>> +static int srf08_probe(struct i2c_client *client,
>>> +					 const struct i2c_device_id *id)
>>> +{
>>> +	struct iio_dev *indio_dev;
>>> +	struct srf08_data *data;
>>> +
>>> +	if (!i2c_check_functionality(client->adapter,
>>> +					I2C_FUNC_SMBUS_READ_BYTE_DATA |
>>> +					I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
>>> +					I2C_FUNC_SMBUS_READ_WORD_DATA))
>>> +		return -ENODEV;
>>> +
>>> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>>> +	if (!indio_dev)
>>> +		return -ENOMEM;
>>> +
>>> +	data = iio_priv(indio_dev);
>>> +	i2c_set_clientdata(client, indio_dev);
>>> +	data->client = client;
>>> +
>>> +	/*
>>> +	 * set default values of device here
>>> +	 * these values are already set on the hardware after power on
>>> +	 */
>>> +	data->gain = SRF08_DEFAULT_GAIN;
>>> +	data->range_mm = SRF08_DEFAULT_RANGE;
>> We should be a little careful with assumptions about the device having
>> just been powered on.  The driver might simply have been removed and
>> reprobed.  So I'd sugest rewriting them whatever to be sure we have
>> what we expect.  Either that or if they can be read back, then just
>> always retrieve them from the device.
> 
> You are right. 
> Then i'll set the default value at the sensor, because it cannot be read.
> 
>>> +
>>> +	indio_dev->name = dev_name(&client->dev);
>>> +	indio_dev->dev.parent = &client->dev;
>>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>>> +	indio_dev->info = &srf08_info;
>>> +	indio_dev->channels = srf08_channels;
>>> +	indio_dev->num_channels = ARRAY_SIZE(srf08_channels);
>>> +
>>> +	mutex_init(&data->lock);
>>> +
>>> +	return devm_iio_device_register(&client->dev, indio_dev);
>>> +}
>>> +
>>> +static const struct i2c_device_id srf08_id[] = {
>>> +	{ "srf08", 0 },
>>> +	{ }
>>> +};
>>> +MODULE_DEVICE_TABLE(i2c, srf08_id);
>>> +
>>> +static struct i2c_driver srf08_driver = {
>>> +	.driver = {
>>> +		.name	= "srf08",
>>> +	},
>>> +	.probe = srf08_probe,
>>> +	.id_table = srf08_id,
>>> +};
>>> +module_i2c_driver(srf08_driver);
>>> +
>>> +MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
>>> +MODULE_DESCRIPTION("Devantech SRF08 ultrasonic ranger driver");
>>> +MODULE_LICENSE("GPL");
>>>
>>
> 

