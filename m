Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43932 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbbFUNgG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 09:36:06 -0400
Message-ID: <5586BDC3.6000100@kernel.org>
Date: Sun, 21 Jun 2015 14:36:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "ludovic.tancerel@maplehightech.com"
	<ludovic.tancerel@maplehightech.com>,
	Tomasz Duszynski <tduszyns@gmail.com>
CC: knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	"Markezana, William" <William.Markezana@meas-spec.com>
Subject: Re: [PATCH] iio: ms5637: Add Measurement Specialties MS5637 support
References: <1434458009-20817-1-git-send-email-ludovic.tancerel@maplehightech.com> <20150616204255.GA32429@Arch.lan> <82DB780D-024B-402A-8AD9-C7A67966E957@maplehightech.com>
In-Reply-To: <82DB780D-024B-402A-8AD9-C7A67966E957@maplehightech.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/06/15 08:08, ludovic.tancerel@maplehightech.com wrote:
> Hello Tomasz,
> 
> Thank you for notifying me and your feedback, there is a wish from
> Measurement Specialties to have a separate driver for MS5637 and
> MS5611. There are a few differences in HW, moreover the driver you
> pushed does not support resolution change.
Hmm.  If I get a proposal from someone to actually do the work
to unify the resulting drivers without any loss of functionality, I
will be in favour.

If there is any chance of pushing back on this if there is a strong
case for a more unified driver then please do what you can.  I
appreciate the constraints that can get applied from above!
> 
> Note additional drivers from Measurement Specialties will be added
> soon.
If the parts are also similar in function and could be covered by
a single driver I might well start pushing back harder.  In the long
run, lots of duplicated code is bad for maintenance so I get grumpy
fairly quickly and very happy when I get big patches that unify
lots of drivers (as long as they aren't too complex!)

Jonathan
> 
> I will include your comments in corrections.
> Thank you,
> Ludovic
> 
> 
> Le 16 juin 2015 à 22:42, Tomasz Duszynski <tduszyns@gmail.com> a écrit :
> 
>> On Tue, Jun 16, 2015 at 02:33:29PM +0200, Ludovic wrote:
>>> MS5637 spec : http://www.meas-spec.com/product/pressure/MS5637-02BA03.aspx
>>>
>>> This patch has already been submitted some time ago by William Markezana, it was originally developped by me.
>>> Thank you for all the comments done. Hopefully, everything is ok now.
>>>
>>> Thank you in advance for reviewing again.
>>>
>> Hi Ludovic,
>>
>> Not so long ago I added support for ms5611. Comparing both chips datasheets
>> didn't reveal much difference, so maybe two patches can somehow be combined to
>> avoid code duplication.
>>
>> A few additional comments below.
>>> Regards,
>>> Ludovic
>>>
>>> Signed-off-by: Ludovic <ludovic.tancerel@maplehightech.com>
>>> ---
>>> drivers/iio/pressure/Kconfig  |  10 +
>>> drivers/iio/pressure/Makefile |   1 +
>>> drivers/iio/pressure/ms5637.c | 475 ++++++++++++++++++++++++++++++++++++++++++
>>> 3 files changed, 486 insertions(+)
>>> create mode 100644 drivers/iio/pressure/ms5637.c
>>>
>>> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
>>> index a3be537..6c7faa1 100644
>>> --- a/drivers/iio/pressure/Kconfig
>>> +++ b/drivers/iio/pressure/Kconfig
>>> @@ -52,6 +52,16 @@ config MPL3115
>>>           To compile this driver as a module, choose M here: the module
>>>           will be called mpl3115.
>>>
>>> +config MS5637
>>> +        tristate "MS5637 pressure & temperature sensor"
>>> +        depends on I2C
>>> +        help
>>> +          If you say yes here you get support for the Measurement Specialties
>>> +          MS5637 pressure and temperature sensor.
>>> +
>>> +          This driver can also be built as a module. If so, the module will
>>> +          be called ms5637.
>>> +
>>> config IIO_ST_PRESS
>>> 	tristate "STMicroelectronics pressure sensor Driver"
>>> 	depends on (I2C || SPI_MASTER) && SYSFS
>>> diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
>>> index 88011f2..2455f8e 100644
>>> --- a/drivers/iio/pressure/Makefile
>>> +++ b/drivers/iio/pressure/Makefile
>>> @@ -7,6 +7,7 @@ obj-$(CONFIG_BMP280) += bmp280.o
>>> obj-$(CONFIG_HID_SENSOR_PRESS)   += hid-sensor-press.o
>>> obj-$(CONFIG_MPL115) += mpl115.o
>>> obj-$(CONFIG_MPL3115) += mpl3115.o
>>> +obj-$(CONFIG_MS5637) += ms5637.o
>>> obj-$(CONFIG_IIO_ST_PRESS) += st_pressure.o
>>> st_pressure-y := st_pressure_core.o
>>> st_pressure-$(CONFIG_IIO_BUFFER) += st_pressure_buffer.o
>>> diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
>>> new file mode 100644
>>> index 0000000..9c647d7
>>> --- /dev/null
>>> +++ b/drivers/iio/pressure/ms5637.c
>>> @@ -0,0 +1,475 @@
>>> +/*
>>> + * ms5637.c - Support for Measurement-Specialties ms5637
>>> + *            pressure & temperature sensor
>>> + *
>>> + * Copyright (c) 2014 Measurement-Specialties
>>> + *
>>> + * Licensed under the GPL-2.
>>> + *
>>> + * (7-bit I2C slave address 0x76)
>>> + *
>>> + */
>>> +#include <linux/init.h>
>>> +#include <linux/device.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/stat.h>
>>> +#include <linux/module.h>
>>> +#include <linux/i2c.h>
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/iio/sysfs.h>
>>> +#include <linux/jiffies.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/mutex.h>
>>> +
>>> +/* MS5637 Commands */
>>> +#define MS5637_RESET				0x1E
>>> +#define MS5637_TEMPERATURE_CONVERSION_START	0x50
>>> +#define MS5637_PRESSURE_CONVERSION_START	0x40
>>> +#define MS5637_ADC_READ				0x00
>>> +#define MS5637_PROM_READ			0xA0
>>> +#define MS5637_PROM_ELEMENTS_NB                 7
>>> +
>>> +static const u16 ms5637_conversion_time[] = { 1000, 2000, 3000,
>>> +					      5000, 9000, 17000 };
>>> +static const int ms5637_samp_freq[6][2] = { {1800, 0}, {900, 0},
>>> +					    {450, 0}, {225, 0},
>>> +					    {112, 500000}, {56, 250000},
>>> +					  };
>>> +
>>> +struct ms5637_dev {
>>> +	struct i2c_client *client;
>>> +	struct mutex lock; /* mutex protecting this data structure */
>>> +	u16 calibration_coeffs[MS5637_PROM_ELEMENTS_NB];
>>> +	bool got_calibration_words;
>>> +	unsigned long last_update;
>>> +	bool valid;
>>> +	int temperature;
>>> +	unsigned int pressure;
>>> +	u8 resolution_index;
>>> +};
>>> +
>>> +static int ms5637_get_calibration_coeffs(struct ms5637_dev *dev_data,
>>> +					 unsigned char index, u16 *word)
>>> +{
>>> +	int ret = 0;
>>> +
>>> +	ret = i2c_smbus_read_word_swapped(dev_data->client,
>>> +					  MS5637_PROM_READ + (index << 1));
>>> +	if (ret < 0)
>>> +		return ret;
>>> +	*word = (u16)ret & 0xFFFF;
>>> +	return 0;
>>> +}
>>> +
>>> +static bool ms5637_crc_check(u16 *n_prom, u8 crc)
>>> +{
>>> +	unsigned int cnt, n_bit;
>>> +	u16 n_rem, crc_read;
>>> +
>>> +	n_rem = 0x0000;
>>> +	crc_read = n_prom[0];
>>> +	n_prom[MS5637_PROM_ELEMENTS_NB] = 0;
>>> +	n_prom[0] &= 0x0FFF;	/* Clear the CRC byte */
>>> +
>>> +	for (cnt = 0; cnt < (MS5637_PROM_ELEMENTS_NB + 1) * 2; cnt++) {
>>> +		if (cnt % 2 == 1)
>>> +			n_rem ^= n_prom[cnt >> 1] & 0x00FF;
>>> +		else
>>> +			n_rem ^= n_prom[cnt >> 1] >> 8;
>>> +
>>> +		for (n_bit = 8; n_bit > 0; n_bit--) {
>>> +			if (n_rem & 0x8000)
>>> +				n_rem = (n_rem << 1) ^ 0x3000;
>>> +			else
>>> +				n_rem <<= 1;
>>> +		}
>>> +	}
>>> +	n_rem >>= 12;
>>> +	n_prom[0] = crc_read;
>>> +	return (n_rem == crc);
>>> +}
>>> +
>>> +static int ms5637_fill_calibration_coeffs(struct ms5637_dev *dev_data)
>>> +{
>>> +	int i, ret = 0;
>>> +
>>> +	for (i = 0; i < MS5637_PROM_ELEMENTS_NB; i++) {
>>> +		ret = ms5637_get_calibration_coeffs(
>>> +					dev_data, i,
>>> +					&dev_data->calibration_coeffs[i]);
>>> +
>>> +		if (ret < 0) {
>>> +			dev_err(&dev_data->client->dev,
>>> +				"Unable to get calibration coefficients at address %d\n",
>>> +				i + 1);
>>> +			return ret;
>>> +		}
>>> +
>>> +		dev_dbg(&dev_data->client->dev, "Coeff %d : %d", i,
>>> +			dev_data->calibration_coeffs[i]);
>>> +	}
>>> +
>>> +	ret = ms5637_crc_check(
>>> +			dev_data->calibration_coeffs,
>>> +			(dev_data->calibration_coeffs[0] & 0xF000) >> 12);
>>> +	if (ret == 0)
>>> +		dev_err(&dev_data->client->dev,
>>> +			"Calibration coefficients crc check error\n");
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int ms5637_read_adc_value(struct ms5637_dev *dev_data, u32 *adc_value)
>>> +{
>>> +	int ret;
>>> +	u8 buf[3];
>>> +
>>> +	ret =
>>> +	    i2c_smbus_read_i2c_block_data(dev_data->client, MS5637_ADC_READ, 3,
>>> +					  buf);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +	dev_dbg(&dev_data->client->dev, "ADC raw value : %x %x %x\n", buf[0],
>>> +		buf[1], buf[2]);
>>> +	*adc_value = (buf[0] << 16) + (buf[1] << 8) + buf[2];
>>> +	return 0;
>>> +}
>>> +
>>> +static int ms5637_conversion_and_read_adc(struct ms5637_dev *dev_data,
>>> +					  u32 *t_adc, u32 *p_adc)
>>> +{
>>> +	int ret;
>>> +
>>> +	dev_dbg(&dev_data->client->dev, "ms5637_conversion_and_read_adc");
>>> +	/* Trigger Temperature conversion */
>>> +	ret = i2c_smbus_write_byte(dev_data->client,
>>> +				   MS5637_TEMPERATURE_CONVERSION_START
>>> +				   + dev_data->resolution_index * 2);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +	usleep_range(ms5637_conversion_time[dev_data->resolution_index],
>>> +		     ms5637_conversion_time[dev_data->resolution_index] + 3000);
>>> +	/* Retrieve ADC value */
>>> +	ret = ms5637_read_adc_value(dev_data, t_adc);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	/* Trigger Pressure conversion */
>>> +	ret = i2c_smbus_write_byte(dev_data->client,
>>> +				   MS5637_PRESSURE_CONVERSION_START
>>> +				   + dev_data->resolution_index * 2);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +	usleep_range(ms5637_conversion_time[dev_data->resolution_index],
>>> +		     ms5637_conversion_time[dev_data->resolution_index] + 3000);
>>> +	/* Retrieve ADC value */
>>> +	ret = ms5637_read_adc_value(dev_data, p_adc);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int ms5637_read_temperature_and_pressure(struct ms5637_dev *dev_data)
>>> +{
>>> +	int ret = 0;
>>> +	u32 t_adc, p_adc;
>>> +	s32 dt, temp;
>>> +	s64 off, sens, t2, off2, sens2;
>>> +
>>> +	mutex_lock(&dev_data->lock);
>>> +
>>> +	if (time_after(jiffies, dev_data->last_update + HZ / 2) ||
>>> +	    !dev_data->valid) {
>>> +		if (!dev_data->got_calibration_words) {
>>> +			ret = ms5637_fill_calibration_coeffs(dev_data);
>>> +			if (ret != 0)
>>> +				goto out;
>>> +
>>> +			dev_data->got_calibration_words = true;
>>> +		}
>>> +
>>> +		ret = ms5637_conversion_and_read_adc(dev_data, &t_adc, &p_adc);
>>> +		if (ret < 0) {
>>> +			dev_data->got_calibration_words = false;
>>> +			dev_err(&dev_data->client->dev,
>>> +				"Unable to make sensor adc conversion\n");
>>> +			goto out;
>>> +		}
>>> +
>>> +		dt = (s32)t_adc - (dev_data->calibration_coeffs[5] << 8);
>>> +
>>> +		/* Actual temperature = 2000 + dT * TEMPSENS */
>>> +		temp =
>>> +		    2000 + (((s64)dt * dev_data->calibration_coeffs[6]) >> 23);
>>> +
>>> +		/* Second order temperature compensation */
>>> +		if (temp < 2000) {
>>> +			s64 tmp = (s64)temp - 2000;
>>> +
>>> +			t2 = (3 * ((s64)dt * (s64)dt)) >> 33;
>>> +			off2 = (61 * tmp * tmp) >> 4;
>>> +			sens2 = (29 * tmp * tmp) >> 4;
>>> +
>>> +			if (temp < -1500) {
>>> +				s64 tmp = (s64)temp + 1500;
>>> +
>>> +				off2 += 17 * tmp * tmp;
>>> +				sens2 += 9 * tmp * tmp;
>>> +			}
>>> +		} else {
>>> +			t2 = (5 * ((s64)dt * (s64)dt)) >> 38;
>>> +			off2 = 0;
>>> +			sens2 = 0;
>>> +		}
>>> +
>>> +		/* OFF = OFF_T1 + TCO * dT */
>>> +		off = (((s64)dev_data->calibration_coeffs[2]) << 17) +
>>> +		    ((((s64)dev_data->calibration_coeffs[4]) * (s64)dt) >> 6);
>>> +		off -= off2;
>>> +
>>> +		/* Sensitivity at actual temperature = SENS_T1 + TCS * dT */
>>> +		sens = (((s64)dev_data->calibration_coeffs[1]) << 16)
>>> +		    + (((s64)dev_data->calibration_coeffs[3] * dt) >> 7);
>>> +		sens -= sens2;
>>> +
>>> +		/* Temperature compensated pressure = D1 * SENS - OFF */
>>> +		dev_data->temperature = (temp - t2) * 10;
>>> +		dev_data->pressure = (u32)(((((s64)p_adc * sens) >> 21)
>>> +					     - off) >> 15);
>>> +
>>> +		dev_data->last_update = jiffies;
>>> +		dev_data->valid = true;
>>> +	}
>>> + out:
>>> +	mutex_unlock(&dev_data->lock);
>>> +
>>> +	return ret >= 0 ? 0 : ret;
>>> +}
>>> +
>>> +static int ms5637_get_int_plus_micros_index(const int (*vals)[2], int n,
>>> +					    int val, int val2)
>>> +{
>>> +	while (n-- > 0)
>>> +		if (val == vals[n][0] && val2 == vals[n][1])
>>> +			return n;
>>> +	return -EINVAL;
>>> +}
>>> +
>>> +static int ms5637_get_samp_freq_index(struct ms5637_dev *dev_data,
>>> +				      int val, int val2)
>>> +{
>>> +	return ms5637_get_int_plus_micros_index(ms5637_samp_freq,
>>> +				ARRAY_SIZE(ms5637_samp_freq), val, val2);
>>> +}
>>> +
>>> +static ssize_t ms5637_show_int_plus_micros(char *buf,
>>> +					   const int (*vals)[2], int n)
>>> +{
>>> +	size_t len = 0;
>>> +
>>> +	while (n-- > 0)
>>> +		len += scnprintf(buf + len, PAGE_SIZE - len,
>>> +			"%d.%06d ", vals[n][0], vals[n][1]);
>>> +
>>> +	/* replace trailing space by newline */
>>> +	buf[len - 1] = '\n';
>>> +
>>> +	return len;
>>> +}
>>> +
>>> +static ssize_t ms5637_show_samp_freq_avail(struct device *dev,
>>> +					   struct device_attribute *attr,
>>> +					   char *buf)
>>> +{
>>> +	return ms5637_show_int_plus_micros(buf, ms5637_samp_freq,
>>> +					   ARRAY_SIZE(ms5637_samp_freq));
>>> +}
>>> +
>>> +static int ms5637_read_raw(struct iio_dev *indio_dev,
>>> +			   struct iio_chan_spec const *channel, int *val,
>>> +			   int *val2, long mask)
>>> +{
>>> +	int ret;
>>> +	struct ms5637_dev *dev_data = iio_priv(indio_dev);
>>> +
>>> +	switch (mask) {
>>> +	case IIO_CHAN_INFO_PROCESSED:
>>> +		ret = ms5637_read_temperature_and_pressure(dev_data);
>>> +		if (ret)
>>> +			goto err;
>>> +		switch (channel->type) {
>>> +		case IIO_TEMP:	/* in °C */
>> probably iio wants milli C
>>> +			*val = dev_data->temperature / 1000;
>>> +			*val2 = (dev_data->temperature -
>>> +					(dev_data->temperature / 1000) * 1000
>>> +				) * 1000;
>> (dev->data->temperature % 1000) * 1000 has same effect but is much shorter
>>> +			break;
>>> +		case IIO_PRESSURE:	/* in kPa */
>>> +			*val = dev_data->pressure / 1000;
>>> +			*val2 = (dev_data->pressure -
>>> +				 (dev_data->pressure / 1000) * 1000) * 1000;
>>> +			break;
>>> +		default:
>>> +			return -EINVAL;
>>> +		}
>>> +		break;
>>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>>> +		*val = ms5637_samp_freq[dev_data->resolution_index][0];
>>> +		*val2 = ms5637_samp_freq[dev_data->resolution_index][1];
>>> +		break;
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	return IIO_VAL_INT_PLUS_MICRO;
>>> + err:
>>> +	dev_err(&indio_dev->dev, "Device read error\n");
>>> +	return ret;
>>> +}
>>> +
>>> +static int ms5637_write_raw(struct iio_dev *indio_dev,
>>> +			    struct iio_chan_spec const *chan,
>>> +			    int val, int val2, long mask)
>>> +{
>>> +	struct ms5637_dev *dev_data = iio_priv(indio_dev);
>>> +	int i;
>>> +
>>> +	switch (mask) {
>>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>>> +		i = ms5637_get_samp_freq_index(dev_data, val, val2);
>>> +		if (i < 0)
>>> +			return -EINVAL;
>>> +
>>> +		dev_data->resolution_index = i;
>>> +		break;
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct iio_chan_spec ms5637_channels[] = {
>>> +	{
>>> +	 .type = IIO_TEMP,
>>> +	 .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>>> +	 .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>>> +	 },
>>> +	{
>>> +	 .type = IIO_PRESSURE,
>>> +	 .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>>> +	 .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>>> +	 }
>>> +};
>>> +
>>> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(ms5637_show_samp_freq_avail);
>>> +
>>> +static struct attribute *ms5637_attributes[] = {
>>> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>>> +	NULL,
>>> +};
>>> +
>>> +static const struct attribute_group ms5637_attribute_group = {
>>> +	.attrs = ms5637_attributes,
>>> +};
>>> +
>>> +static const struct iio_info ms5637_info = {
>>> +	.read_raw = ms5637_read_raw,
>>> +	.write_raw = ms5637_write_raw,
>>> +	.attrs = &ms5637_attribute_group,
>>> +	.driver_module = THIS_MODULE,
>>> +};
>>> +
>>> +static int ms5637_probe(struct i2c_client *client,
>>> +			const struct i2c_device_id *id)
>>> +{
>>> +	struct ms5637_dev *dev_data;
>>> +	struct iio_dev *indio_dev;
>>> +	int ret;
>>> +
>>> +	if (!i2c_check_functionality(client->adapter,
>>> +				     I2C_FUNC_SMBUS_READ_WORD_DATA)) {
>>> +		dev_err(&client->dev,
>>> +			"Adapter does not support SMBus read word transactions\n");
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	if (!i2c_check_functionality(client->adapter,
>>> +				     I2C_FUNC_SMBUS_WRITE_BYTE)) {
>>> +		dev_err(&client->dev,
>>> +			"Adapter does not support SMBus write byte transactions\n");
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	if (!i2c_check_functionality(client->adapter,
>>> +				     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
>>> +		dev_err(&client->dev,
>>> +			"Adapter does not support SMBus read block transactions\n");
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*dev_data));
>>> +	if (!indio_dev)
>>> +		return -ENOMEM;
>>> +
>>> +	dev_data = iio_priv(indio_dev);
>>> +	dev_data->client = client;
>>> +	mutex_init(&dev_data->lock);
>>> +
>>> +	indio_dev->info = &ms5637_info;
>>> +	indio_dev->name = id->name;
>>> +	indio_dev->dev.parent = &client->dev;
>>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>>> +	indio_dev->channels = ms5637_channels;
>>> +	indio_dev->num_channels = ARRAY_SIZE(ms5637_channels);
>>> +
>>> +	i2c_set_clientdata(client, indio_dev);
>>> +	ret = i2c_smbus_write_byte(client, MS5637_RESET);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +	usleep_range(3000, 6000);
>>> +
>>> +	ret = ms5637_fill_calibration_coeffs(dev_data);
>>> +	if (ret == 0)
>>> +		dev_data->got_calibration_words = true;
>>> +	else
>>> +		return ret;
>>> +
>>> +	ret = iio_device_register(indio_dev);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	dev_dbg(&client->dev, "Driver initialization done");
>>> +	return 0;
>>> +}
>>> +
>>> +static int ms5637_remove(struct i2c_client *client)
>>> +{
>>> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>>> +
>>> +	devm_iio_device_unregister(&client->dev, indio_dev);
>>> +
>>> +	return 0;
>>> +}
>> seems that nothing special happens on removal, so maybe use
>> devm_iio_device_register and drop *_remove().
>>> +
>>> +static const struct i2c_device_id ms5637_id[] = {
>>> +	{"ms5637", 0},
>>> +	{}
>>> +};
>>> +
>>> +static struct i2c_driver ms5637_driver = {
>>> +	.probe = ms5637_probe,
>>> +	.remove = ms5637_remove,
>>> +	.id_table = ms5637_id,
>>> +	.driver = {
>>> +		   .name = "ms5637",
>>> +		   .owner = THIS_MODULE,
>>> +		   },
>>> +};
>>> +
>>> +module_i2c_driver(ms5637_driver);
>>> +
>>> +MODULE_LICENSE("GPL");
>>> +MODULE_DESCRIPTION("Measurement-Specialties ms5637 temperature driver");
>>> +MODULE_AUTHOR("William Markezana <william.markezana@meas-spec.com>");
>>> +MODULE_AUTHOR("Ludovic Tancerel <ludovic.tancerel@maplehightech.com>");
>>> --
>>> 2.3.7
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
