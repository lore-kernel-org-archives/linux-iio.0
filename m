Return-Path: <ludovic.tancerel@maplehightech.com>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] iio: ms5637: Add Measurement Specialties MS5637 support
From: "ludovic.tancerel@maplehightech.com" <ludovic.tancerel@maplehightech.com>
In-Reply-To: <20150616204255.GA32429@Arch.lan>
Date: Wed, 17 Jun 2015 09:08:58 +0200
Cc: jic23@kernel.org,
 knaack.h@gmx.de,
 pmeerw@pmeerw.net,
 linux-iio@vger.kernel.org,
 "Markezana, William" <William.Markezana@meas-spec.com>
Message-Id: <82DB780D-024B-402A-8AD9-C7A67966E957@maplehightech.com>
References: <1434458009-20817-1-git-send-email-ludovic.tancerel@maplehightech.com> <20150616204255.GA32429@Arch.lan>
To: Tomasz Duszynski <tduszyns@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Hello Tomasz,

Thank you for notifying me and  your feedback, there is a wish from =
Measurement Specialties to have a separate driver for MS5637 and MS5611.
There are a few differences in HW, moreover the driver you pushed does =
not support resolution change.

Note additional drivers from Measurement Specialties will be added soon.

I will include your comments in corrections.

Thank you,
Ludovic


Le 16 juin 2015 =E0 22:42, Tomasz Duszynski <tduszyns@gmail.com> a =E9crit=
 :

> On Tue, Jun 16, 2015 at 02:33:29PM +0200, Ludovic wrote:
>> MS5637 spec : =
http://www.meas-spec.com/product/pressure/MS5637-02BA03.aspx
>>=20
>> This patch has already been submitted some time ago by William =
Markezana, it was originally developped by me.
>> Thank you for all the comments done. Hopefully, everything is ok now.
>>=20
>> Thank you in advance for reviewing again.
>>=20
> Hi Ludovic,
>=20
> Not so long ago I added support for ms5611. Comparing both chips =
datasheets
> didn't reveal much difference, so maybe two patches can somehow be =
combined to
> avoid code duplication.
>=20
> A few additional comments below.
>> Regards,
>> Ludovic
>>=20
>> Signed-off-by: Ludovic <ludovic.tancerel@maplehightech.com>
>> ---
>> drivers/iio/pressure/Kconfig  |  10 +
>> drivers/iio/pressure/Makefile |   1 +
>> drivers/iio/pressure/ms5637.c | 475 =
++++++++++++++++++++++++++++++++++++++++++
>> 3 files changed, 486 insertions(+)
>> create mode 100644 drivers/iio/pressure/ms5637.c
>>=20
>> diff --git a/drivers/iio/pressure/Kconfig =
b/drivers/iio/pressure/Kconfig
>> index a3be537..6c7faa1 100644
>> --- a/drivers/iio/pressure/Kconfig
>> +++ b/drivers/iio/pressure/Kconfig
>> @@ -52,6 +52,16 @@ config MPL3115
>>           To compile this driver as a module, choose M here: the =
module
>>           will be called mpl3115.
>>=20
>> +config MS5637
>> +        tristate "MS5637 pressure & temperature sensor"
>> +        depends on I2C
>> +        help
>> +          If you say yes here you get support for the Measurement =
Specialties
>> +          MS5637 pressure and temperature sensor.
>> +
>> +          This driver can also be built as a module. If so, the =
module will
>> +          be called ms5637.
>> +
>> config IIO_ST_PRESS
>> 	tristate "STMicroelectronics pressure sensor Driver"
>> 	depends on (I2C || SPI_MASTER) && SYSFS
>> diff --git a/drivers/iio/pressure/Makefile =
b/drivers/iio/pressure/Makefile
>> index 88011f2..2455f8e 100644
>> --- a/drivers/iio/pressure/Makefile
>> +++ b/drivers/iio/pressure/Makefile
>> @@ -7,6 +7,7 @@ obj-$(CONFIG_BMP280) +=3D bmp280.o
>> obj-$(CONFIG_HID_SENSOR_PRESS)   +=3D hid-sensor-press.o
>> obj-$(CONFIG_MPL115) +=3D mpl115.o
>> obj-$(CONFIG_MPL3115) +=3D mpl3115.o
>> +obj-$(CONFIG_MS5637) +=3D ms5637.o
>> obj-$(CONFIG_IIO_ST_PRESS) +=3D st_pressure.o
>> st_pressure-y :=3D st_pressure_core.o
>> st_pressure-$(CONFIG_IIO_BUFFER) +=3D st_pressure_buffer.o
>> diff --git a/drivers/iio/pressure/ms5637.c =
b/drivers/iio/pressure/ms5637.c
>> new file mode 100644
>> index 0000000..9c647d7
>> --- /dev/null
>> +++ b/drivers/iio/pressure/ms5637.c
>> @@ -0,0 +1,475 @@
>> +/*
>> + * ms5637.c - Support for Measurement-Specialties ms5637
>> + *            pressure & temperature sensor
>> + *
>> + * Copyright (c) 2014 Measurement-Specialties
>> + *
>> + * Licensed under the GPL-2.
>> + *
>> + * (7-bit I2C slave address 0x76)
>> + *
>> + */
>> +#include <linux/init.h>
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/stat.h>
>> +#include <linux/module.h>
>> +#include <linux/i2c.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/delay.h>
>> +#include <linux/mutex.h>
>> +
>> +/* MS5637 Commands */
>> +#define MS5637_RESET				0x1E
>> +#define MS5637_TEMPERATURE_CONVERSION_START	0x50
>> +#define MS5637_PRESSURE_CONVERSION_START	0x40
>> +#define MS5637_ADC_READ				0x00
>> +#define MS5637_PROM_READ			0xA0
>> +#define MS5637_PROM_ELEMENTS_NB                 7
>> +
>> +static const u16 ms5637_conversion_time[] =3D { 1000, 2000, 3000,
>> +					      5000, 9000, 17000 };
>> +static const int ms5637_samp_freq[6][2] =3D { {1800, 0}, {900, 0},
>> +					    {450, 0}, {225, 0},
>> +					    {112, 500000}, {56, 250000},
>> +					  };
>> +
>> +struct ms5637_dev {
>> +	struct i2c_client *client;
>> +	struct mutex lock; /* mutex protecting this data structure */
>> +	u16 calibration_coeffs[MS5637_PROM_ELEMENTS_NB];
>> +	bool got_calibration_words;
>> +	unsigned long last_update;
>> +	bool valid;
>> +	int temperature;
>> +	unsigned int pressure;
>> +	u8 resolution_index;
>> +};
>> +
>> +static int ms5637_get_calibration_coeffs(struct ms5637_dev =
*dev_data,
>> +					 unsigned char index, u16 *word)
>> +{
>> +	int ret =3D 0;
>> +
>> +	ret =3D i2c_smbus_read_word_swapped(dev_data->client,
>> +					  MS5637_PROM_READ + (index << =
1));
>> +	if (ret < 0)
>> +		return ret;
>> +	*word =3D (u16)ret & 0xFFFF;
>> +	return 0;
>> +}
>> +
>> +static bool ms5637_crc_check(u16 *n_prom, u8 crc)
>> +{
>> +	unsigned int cnt, n_bit;
>> +	u16 n_rem, crc_read;
>> +
>> +	n_rem =3D 0x0000;
>> +	crc_read =3D n_prom[0];
>> +	n_prom[MS5637_PROM_ELEMENTS_NB] =3D 0;
>> +	n_prom[0] &=3D 0x0FFF;	/* Clear the CRC byte */
>> +
>> +	for (cnt =3D 0; cnt < (MS5637_PROM_ELEMENTS_NB + 1) * 2; cnt++) =
{
>> +		if (cnt % 2 =3D=3D 1)
>> +			n_rem ^=3D n_prom[cnt >> 1] & 0x00FF;
>> +		else
>> +			n_rem ^=3D n_prom[cnt >> 1] >> 8;
>> +
>> +		for (n_bit =3D 8; n_bit > 0; n_bit--) {
>> +			if (n_rem & 0x8000)
>> +				n_rem =3D (n_rem << 1) ^ 0x3000;
>> +			else
>> +				n_rem <<=3D 1;
>> +		}
>> +	}
>> +	n_rem >>=3D 12;
>> +	n_prom[0] =3D crc_read;
>> +	return (n_rem =3D=3D crc);
>> +}
>> +
>> +static int ms5637_fill_calibration_coeffs(struct ms5637_dev =
*dev_data)
>> +{
>> +	int i, ret =3D 0;
>> +
>> +	for (i =3D 0; i < MS5637_PROM_ELEMENTS_NB; i++) {
>> +		ret =3D ms5637_get_calibration_coeffs(
>> +					dev_data, i,
>> +					=
&dev_data->calibration_coeffs[i]);
>> +
>> +		if (ret < 0) {
>> +			dev_err(&dev_data->client->dev,
>> +				"Unable to get calibration coefficients =
at address %d\n",
>> +				i + 1);
>> +			return ret;
>> +		}
>> +
>> +		dev_dbg(&dev_data->client->dev, "Coeff %d : %d", i,
>> +			dev_data->calibration_coeffs[i]);
>> +	}
>> +
>> +	ret =3D ms5637_crc_check(
>> +			dev_data->calibration_coeffs,
>> +			(dev_data->calibration_coeffs[0] & 0xF000) >> =
12);
>> +	if (ret =3D=3D 0)
>> +		dev_err(&dev_data->client->dev,
>> +			"Calibration coefficients crc check error\n");
>> +
>> +	return 0;
>> +}
>> +
>> +static int ms5637_read_adc_value(struct ms5637_dev *dev_data, u32 =
*adc_value)
>> +{
>> +	int ret;
>> +	u8 buf[3];
>> +
>> +	ret =3D
>> +	    i2c_smbus_read_i2c_block_data(dev_data->client, =
MS5637_ADC_READ, 3,
>> +					  buf);
>> +	if (ret < 0)
>> +		return ret;
>> +	dev_dbg(&dev_data->client->dev, "ADC raw value : %x %x %x\n", =
buf[0],
>> +		buf[1], buf[2]);
>> +	*adc_value =3D (buf[0] << 16) + (buf[1] << 8) + buf[2];
>> +	return 0;
>> +}
>> +
>> +static int ms5637_conversion_and_read_adc(struct ms5637_dev =
*dev_data,
>> +					  u32 *t_adc, u32 *p_adc)
>> +{
>> +	int ret;
>> +
>> +	dev_dbg(&dev_data->client->dev, =
"ms5637_conversion_and_read_adc");
>> +	/* Trigger Temperature conversion */
>> +	ret =3D i2c_smbus_write_byte(dev_data->client,
>> +				   MS5637_TEMPERATURE_CONVERSION_START
>> +				   + dev_data->resolution_index * 2);
>> +	if (ret < 0)
>> +		return ret;
>> +	usleep_range(ms5637_conversion_time[dev_data->resolution_index],
>> +		     ms5637_conversion_time[dev_data->resolution_index] =
+ 3000);
>> +	/* Retrieve ADC value */
>> +	ret =3D ms5637_read_adc_value(dev_data, t_adc);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* Trigger Pressure conversion */
>> +	ret =3D i2c_smbus_write_byte(dev_data->client,
>> +				   MS5637_PRESSURE_CONVERSION_START
>> +				   + dev_data->resolution_index * 2);
>> +	if (ret < 0)
>> +		return ret;
>> +	usleep_range(ms5637_conversion_time[dev_data->resolution_index],
>> +		     ms5637_conversion_time[dev_data->resolution_index] =
+ 3000);
>> +	/* Retrieve ADC value */
>> +	ret =3D ms5637_read_adc_value(dev_data, p_adc);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ms5637_read_temperature_and_pressure(struct ms5637_dev =
*dev_data)
>> +{
>> +	int ret =3D 0;
>> +	u32 t_adc, p_adc;
>> +	s32 dt, temp;
>> +	s64 off, sens, t2, off2, sens2;
>> +
>> +	mutex_lock(&dev_data->lock);
>> +
>> +	if (time_after(jiffies, dev_data->last_update + HZ / 2) ||
>> +	    !dev_data->valid) {
>> +		if (!dev_data->got_calibration_words) {
>> +			ret =3D =
ms5637_fill_calibration_coeffs(dev_data);
>> +			if (ret !=3D 0)
>> +				goto out;
>> +
>> +			dev_data->got_calibration_words =3D true;
>> +		}
>> +
>> +		ret =3D ms5637_conversion_and_read_adc(dev_data, &t_adc, =
&p_adc);
>> +		if (ret < 0) {
>> +			dev_data->got_calibration_words =3D false;
>> +			dev_err(&dev_data->client->dev,
>> +				"Unable to make sensor adc =
conversion\n");
>> +			goto out;
>> +		}
>> +
>> +		dt =3D (s32)t_adc - (dev_data->calibration_coeffs[5] << =
8);
>> +
>> +		/* Actual temperature =3D 2000 + dT * TEMPSENS */
>> +		temp =3D
>> +		    2000 + (((s64)dt * dev_data->calibration_coeffs[6]) =
>> 23);
>> +
>> +		/* Second order temperature compensation */
>> +		if (temp < 2000) {
>> +			s64 tmp =3D (s64)temp - 2000;
>> +
>> +			t2 =3D (3 * ((s64)dt * (s64)dt)) >> 33;
>> +			off2 =3D (61 * tmp * tmp) >> 4;
>> +			sens2 =3D (29 * tmp * tmp) >> 4;
>> +
>> +			if (temp < -1500) {
>> +				s64 tmp =3D (s64)temp + 1500;
>> +
>> +				off2 +=3D 17 * tmp * tmp;
>> +				sens2 +=3D 9 * tmp * tmp;
>> +			}
>> +		} else {
>> +			t2 =3D (5 * ((s64)dt * (s64)dt)) >> 38;
>> +			off2 =3D 0;
>> +			sens2 =3D 0;
>> +		}
>> +
>> +		/* OFF =3D OFF_T1 + TCO * dT */
>> +		off =3D (((s64)dev_data->calibration_coeffs[2]) << 17) +
>> +		    ((((s64)dev_data->calibration_coeffs[4]) * (s64)dt) =
>> 6);
>> +		off -=3D off2;
>> +
>> +		/* Sensitivity at actual temperature =3D SENS_T1 + TCS * =
dT */
>> +		sens =3D (((s64)dev_data->calibration_coeffs[1]) << 16)
>> +		    + (((s64)dev_data->calibration_coeffs[3] * dt) >> =
7);
>> +		sens -=3D sens2;
>> +
>> +		/* Temperature compensated pressure =3D D1 * SENS - OFF =
*/
>> +		dev_data->temperature =3D (temp - t2) * 10;
>> +		dev_data->pressure =3D (u32)(((((s64)p_adc * sens) >> =
21)
>> +					     - off) >> 15);
>> +
>> +		dev_data->last_update =3D jiffies;
>> +		dev_data->valid =3D true;
>> +	}
>> + out:
>> +	mutex_unlock(&dev_data->lock);
>> +
>> +	return ret >=3D 0 ? 0 : ret;
>> +}
>> +
>> +static int ms5637_get_int_plus_micros_index(const int (*vals)[2], =
int n,
>> +					    int val, int val2)
>> +{
>> +	while (n-- > 0)
>> +		if (val =3D=3D vals[n][0] && val2 =3D=3D vals[n][1])
>> +			return n;
>> +	return -EINVAL;
>> +}
>> +
>> +static int ms5637_get_samp_freq_index(struct ms5637_dev *dev_data,
>> +				      int val, int val2)
>> +{
>> +	return ms5637_get_int_plus_micros_index(ms5637_samp_freq,
>> +				ARRAY_SIZE(ms5637_samp_freq), val, =
val2);
>> +}
>> +
>> +static ssize_t ms5637_show_int_plus_micros(char *buf,
>> +					   const int (*vals)[2], int n)
>> +{
>> +	size_t len =3D 0;
>> +
>> +	while (n-- > 0)
>> +		len +=3D scnprintf(buf + len, PAGE_SIZE - len,
>> +			"%d.%06d ", vals[n][0], vals[n][1]);
>> +
>> +	/* replace trailing space by newline */
>> +	buf[len - 1] =3D '\n';
>> +
>> +	return len;
>> +}
>> +
>> +static ssize_t ms5637_show_samp_freq_avail(struct device *dev,
>> +					   struct device_attribute =
*attr,
>> +					   char *buf)
>> +{
>> +	return ms5637_show_int_plus_micros(buf, ms5637_samp_freq,
>> +					   =
ARRAY_SIZE(ms5637_samp_freq));
>> +}
>> +
>> +static int ms5637_read_raw(struct iio_dev *indio_dev,
>> +			   struct iio_chan_spec const *channel, int =
*val,
>> +			   int *val2, long mask)
>> +{
>> +	int ret;
>> +	struct ms5637_dev *dev_data =3D iio_priv(indio_dev);
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_PROCESSED:
>> +		ret =3D ms5637_read_temperature_and_pressure(dev_data);
>> +		if (ret)
>> +			goto err;
>> +		switch (channel->type) {
>> +		case IIO_TEMP:	/* in =B0C */
> probably iio wants milli C
>> +			*val =3D dev_data->temperature / 1000;
>> +			*val2 =3D (dev_data->temperature -
>> +					(dev_data->temperature / 1000) * =
1000
>> +				) * 1000;
> (dev->data->temperature % 1000) * 1000 has same effect but is much =
shorter
>> +			break;
>> +		case IIO_PRESSURE:	/* in kPa */
>> +			*val =3D dev_data->pressure / 1000;
>> +			*val2 =3D (dev_data->pressure -
>> +				 (dev_data->pressure / 1000) * 1000) * =
1000;
>> +			break;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +		break;
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		*val =3D =
ms5637_samp_freq[dev_data->resolution_index][0];
>> +		*val2 =3D =
ms5637_samp_freq[dev_data->resolution_index][1];
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return IIO_VAL_INT_PLUS_MICRO;
>> + err:
>> +	dev_err(&indio_dev->dev, "Device read error\n");
>> +	return ret;
>> +}
>> +
>> +static int ms5637_write_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan,
>> +			    int val, int val2, long mask)
>> +{
>> +	struct ms5637_dev *dev_data =3D iio_priv(indio_dev);
>> +	int i;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		i =3D ms5637_get_samp_freq_index(dev_data, val, val2);
>> +		if (i < 0)
>> +			return -EINVAL;
>> +
>> +		dev_data->resolution_index =3D i;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static const struct iio_chan_spec ms5637_channels[] =3D {
>> +	{
>> +	 .type =3D IIO_TEMP,
>> +	 .info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
>> +	 .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +	 },
>> +	{
>> +	 .type =3D IIO_PRESSURE,
>> +	 .info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
>> +	 .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +	 }
>> +};
>> +
>> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(ms5637_show_samp_freq_avail);
>> +
>> +static struct attribute *ms5637_attributes[] =3D {
>> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group ms5637_attribute_group =3D {
>> +	.attrs =3D ms5637_attributes,
>> +};
>> +
>> +static const struct iio_info ms5637_info =3D {
>> +	.read_raw =3D ms5637_read_raw,
>> +	.write_raw =3D ms5637_write_raw,
>> +	.attrs =3D &ms5637_attribute_group,
>> +	.driver_module =3D THIS_MODULE,
>> +};
>> +
>> +static int ms5637_probe(struct i2c_client *client,
>> +			const struct i2c_device_id *id)
>> +{
>> +	struct ms5637_dev *dev_data;
>> +	struct iio_dev *indio_dev;
>> +	int ret;
>> +
>> +	if (!i2c_check_functionality(client->adapter,
>> +				     I2C_FUNC_SMBUS_READ_WORD_DATA)) {
>> +		dev_err(&client->dev,
>> +			"Adapter does not support SMBus read word =
transactions\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (!i2c_check_functionality(client->adapter,
>> +				     I2C_FUNC_SMBUS_WRITE_BYTE)) {
>> +		dev_err(&client->dev,
>> +			"Adapter does not support SMBus write byte =
transactions\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (!i2c_check_functionality(client->adapter,
>> +				     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
>> +		dev_err(&client->dev,
>> +			"Adapter does not support SMBus read block =
transactions\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	indio_dev =3D devm_iio_device_alloc(&client->dev, =
sizeof(*dev_data));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	dev_data =3D iio_priv(indio_dev);
>> +	dev_data->client =3D client;
>> +	mutex_init(&dev_data->lock);
>> +
>> +	indio_dev->info =3D &ms5637_info;
>> +	indio_dev->name =3D id->name;
>> +	indio_dev->dev.parent =3D &client->dev;
>> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
>> +	indio_dev->channels =3D ms5637_channels;
>> +	indio_dev->num_channels =3D ARRAY_SIZE(ms5637_channels);
>> +
>> +	i2c_set_clientdata(client, indio_dev);
>> +	ret =3D i2c_smbus_write_byte(client, MS5637_RESET);
>> +	if (ret < 0)
>> +		return ret;
>> +	usleep_range(3000, 6000);
>> +
>> +	ret =3D ms5637_fill_calibration_coeffs(dev_data);
>> +	if (ret =3D=3D 0)
>> +		dev_data->got_calibration_words =3D true;
>> +	else
>> +		return ret;
>> +
>> +	ret =3D iio_device_register(indio_dev);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	dev_dbg(&client->dev, "Driver initialization done");
>> +	return 0;
>> +}
>> +
>> +static int ms5637_remove(struct i2c_client *client)
>> +{
>> +	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
>> +
>> +	devm_iio_device_unregister(&client->dev, indio_dev);
>> +
>> +	return 0;
>> +}
> seems that nothing special happens on removal, so maybe use
> devm_iio_device_register and drop *_remove().
>> +
>> +static const struct i2c_device_id ms5637_id[] =3D {
>> +	{"ms5637", 0},
>> +	{}
>> +};
>> +
>> +static struct i2c_driver ms5637_driver =3D {
>> +	.probe =3D ms5637_probe,
>> +	.remove =3D ms5637_remove,
>> +	.id_table =3D ms5637_id,
>> +	.driver =3D {
>> +		   .name =3D "ms5637",
>> +		   .owner =3D THIS_MODULE,
>> +		   },
>> +};
>> +
>> +module_i2c_driver(ms5637_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Measurement-Specialties ms5637 temperature =
driver");
>> +MODULE_AUTHOR("William Markezana =
<william.markezana@meas-spec.com>");
>> +MODULE_AUTHOR("Ludovic Tancerel =
<ludovic.tancerel@maplehightech.com>");
>> --
>> 2.3.7
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
