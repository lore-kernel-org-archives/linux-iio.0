Return-Path: <ludovic.tancerel@maplehightech.com>
Content-Type: multipart/alternative; boundary="Apple-Mail=_53C9CBE8-D2ED-4969-AD5E-C456FC55A5B8"
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v2] iio: ms5637: Add Measurement Specialties MS5637 support
From: "ludovic.tancerel@maplehightech.com" <ludovic.tancerel@maplehightech.com>
In-Reply-To: <5586D3F3.9040509@kernel.org>
Date: Wed, 24 Jun 2015 18:27:29 +0200
Cc: knaack.h@gmx.de,
 pmeerw@pmeerw.net,
 William.Markezana@meas-spec.com,
 linux-iio@vger.kernel.org
Message-Id: <8EED1162-3DDF-4DAF-B208-D84A9F262E1C@maplehightech.com>
References: <1434644885-9037-1-git-send-email-ludovic.tancerel@maplehightech.com> <5586D3F3.9040509@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>


--Apple-Mail=_53C9CBE8-D2ED-4969-AD5E-C456FC55A5B8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Hello again,
answer to this feedback will be simpler. Thank you for reviewing

For comments I did not reply, that also means I took it into account.

Regards,
Ludovic


Le 21 juin 2015 =E0 17:10, Jonathan Cameron <jic23@kernel.org> a =E9crit =
:

> On 18/06/15 17:28, Ludovic wrote:
>> This a patch re-submission taking into account feebdack from Peter =
and Tomasz.
>> Thank you for your feedback
>>=20
>> Ludovic
>>=20
>> Signed-off-by: Ludovic <ludovic.tancerel@maplehightech.com>
> Hi Ludovic,
>=20
> Firstly would you mind signing off with your whole name prior to the =
email
> address (convention in the kernel - if you have two or more names =
anyway ;)
I will not fill all my names, but will add the last name=85
I never noticed that my config did not include it, even for our internal =
dev.

>=20
> Looking pretty good, just a few bits and bobs inline. Mostly along the
> lines of ways of slightly cleaning up the code rather than anything
> fundamental.
>=20
> The one non trivial question is why the throttle on reading rate?

The throttle is not strong req from me,
as long as I recall, I got this from other driver I looked into, and =
found this usefull providing that temperature / pressure do not change =
often.
I will remove this.

>=20
> Jonathan
>> ---
>> drivers/iio/pressure/Kconfig  |   9 +
>> drivers/iio/pressure/Makefile |   1 +
>> drivers/iio/pressure/ms5637.c | 457 =
++++++++++++++++++++++++++++++++++++++++++
>> 3 files changed, 467 insertions(+)
>> create mode 100644 drivers/iio/pressure/ms5637.c
>>=20
>> diff --git a/drivers/iio/pressure/Kconfig =
b/drivers/iio/pressure/Kconfig
>> index fa62950..69675ef2 100644
>> --- a/drivers/iio/pressure/Kconfig
>> +++ b/drivers/iio/pressure/Kconfig
>> @@ -78,6 +78,15 @@ config MS5611_SPI
>>=20
>> 	  To compile this driver as a module, choose M here: the module =
will
>> 	  be called ms5611_spi.
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
>>=20
>> config IIO_ST_PRESS
>> 	tristate "STMicroelectronics pressure sensor Driver"
>> diff --git a/drivers/iio/pressure/Makefile =
b/drivers/iio/pressure/Makefile
>> index a4f98f8..46571c96 100644
>> --- a/drivers/iio/pressure/Makefile
>> +++ b/drivers/iio/pressure/Makefile
>> @@ -10,6 +10,7 @@ obj-$(CONFIG_MPL3115) +=3D mpl3115.o
>> obj-$(CONFIG_MS5611) +=3D ms5611_core.o
>> obj-$(CONFIG_MS5611_I2C) +=3D ms5611_i2c.o
>> obj-$(CONFIG_MS5611_SPI) +=3D ms5611_spi.o
>> +obj-$(CONFIG_MS5637) +=3D ms5637.o
>> obj-$(CONFIG_IIO_ST_PRESS) +=3D st_pressure.o
>> st_pressure-y :=3D st_pressure_core.o
>> st_pressure-$(CONFIG_IIO_BUFFER) +=3D st_pressure_buffer.o
>> diff --git a/drivers/iio/pressure/ms5637.c =
b/drivers/iio/pressure/ms5637.c
>> new file mode 100644
>> index 0000000..bda7206
>> --- /dev/null
>> +++ b/drivers/iio/pressure/ms5637.c
>> @@ -0,0 +1,457 @@
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
>> +#define MS5637_CONVERSION_SLEEP(index)		\
>> +		usleep_range(ms5637_conversion_time[index],\
>> +		ms5637_conversion_time[index] + 3000)
> I'd be tempted to make this one a function rather than a macro then
> let the compiler inline it if it feels like it..
>> +
>> +static const u16 ms5637_conversion_time[6] =3D { 1000, 2000,
>> +					       3000, 5000,
>> +					       9000, 17000 };
>> +
>> +static const int ms5637_samp_freq[6][2]    =3D { {1800, 0}, {900, =
0},
>> +					       {450, 0}, {225, 0},
>> +					       {112, 500000}, {56, =
250000}
>> +					     };
> Although it is clearly duplicating data, I'd be tempted to have
> the available list as a const char * here (where it can be easily =
checked).
> Then you can drop a couple of functions and use the const attribute
> defintion.
The way understand it, I will drop you something looking to this.
This is unusual to me, but if you like it, I am not opposed to it :
******
static const int ms5637_samp_freq[6][2]    =3D { {1800, 0}, {900, 0},
					       {450, 0}, {225, 0},
					       {112, 500000}, {56, =
250000}
					     };
/* String copy of the above const for readability purpose */
static const char ms5637_show_samp_freq[]  =3D
				"1800.0 900.0 450.0 225.0 112.50 56.25";
******

>=20
>> +
>> +struct ms5637_dev {
>> +	struct i2c_client *client;
>> +	struct mutex lock; /* Mutex protecting this data structure */
>> +	/* Added element for CRC computation */
>> +	u16 calibration_coeffs[MS5637_PROM_ELEMENTS_NB + 1];
>> +	unsigned long last_update;
>> +	int temperature;
>> +	unsigned int pressure;
>> +	u8 resolution_index;
>> +};
>> +
>> +static int ms5637_get_calibration_coeffs(struct ms5637_dev =
*dev_data,
>> +					 u8 index, u16 *word)
>> +{
>> +	int ret;
>> +
>> +	ret =3D i2c_smbus_read_word_swapped(dev_data->client,
>> +					  MS5637_PROM_READ + (index << =
1));
>> +	if (ret < 0)
>> +		return ret;
>> +	*word =3D ret;
> Blank line here.
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
>> +	n_prom[0] &=3D 0x0FFF;      /* Clear the CRC computation part */
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
> blank line here.
>> +	return n_rem =3D=3D crc;
>> +}
>> +
>> +static int ms5637_fill_calibration_coeffs(struct ms5637_dev =
*dev_data)
>> +{
>> +	int i, ret;
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
>> +	if ( ms5637_crc_check(
>> +		dev_data->calibration_coeffs,
>> +		(dev_data->calibration_coeffs[0] & 0xF000) >> 12) =3D=3D =
false) {
>> +		dev_err(&dev_data->client->dev,
>> +			"Calibration coefficients crc check error\n");
>> +		return -ENODEV;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int ms5637_read_adc_value(struct ms5637_dev *dev_data, u32 =
*adc_value)
>> +{
>> +	int ret
> This is a fairly standard beast.  I'd use a u32 and just set it to =
zero
> before reading into the relevant address and using an endian =
conversion
> to sort out the ordering if needed.  That way if no endian conversion
> is needed it is all free ;)
>> +	u8 buf[3];
>> +
>> +	ret =3D
>> +	    i2c_smbus_read_i2c_block_data(dev_data->client, =
MS5637_ADC_READ, 3,
>> +					  buf);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	dev_dbg(&dev_data->client->dev, "ADC raw value : %x %x %x\n", =
buf[0],
>> +		buf[1], buf[2]);
>> +
>> +	*adc_value =3D (buf[0] << 16) + (buf[1] << 8) + buf[2];
>> +
>> +	return 0;
>> +}
>> +
>> +static int ms5637_conversion_and_read_adc(struct ms5637_dev =
*dev_data,
>> +					  u32 *t_adc, u32 *p_adc)
>> +{
>> +	int ret;
>> +
>> +	/* Trigger Temperature conversion */
>> +	ret =3D i2c_smbus_write_byte(dev_data->client,
>> +				   MS5637_TEMPERATURE_CONVERSION_START
>> +				   + dev_data->resolution_index * 2);
>> +	if (ret < 0)
>> +		return ret;
>> +	MS5637_CONVERSION_SLEEP(dev_data->resolution_index);
>> +
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
>> +	MS5637_CONVERSION_SLEEP(dev_data->resolution_index);
>> +
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
> Why this throttle on frequency of reading?  If there is a reason
> add a comment saying why.
>> +	if (time_after(jiffies, dev_data->last_update + HZ / 2)) {
>> +		ret =3D ms5637_conversion_and_read_adc(dev_data, &t_adc, =
&p_adc);
>> +		if (ret < 0) {
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
>> +	}
>> + out:
>> +	mutex_unlock(&dev_data->lock);
>> +
>> +	return ret >=3D 0 ? 0 : ret;
> I'd just make sure that ret is firmly defined to only be an error if
> negative then just return it directly.  (convention in the kernel is
> for only negative errors).
>> +}
>> +
> Again, this isn't complex enough or used enough to demand a utility =
function.
>=20
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
> Only used in one place. Roll this inline.  It's not complex enough
> that this little utilty function is needed.
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
>> +			*val =3D dev_data->temperature / 1000;
>> +			*val2 =3D (dev_data->temperature % 1000) * 1000;
>> +			break;
>> +		case IIO_PRESSURE:	/* in kPa */
>> +			*val =3D dev_data->pressure / 1000;
>> +			*val2 =3D (dev_data->pressure % 1000) * 1000;
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
> I'd return directly from the various case statements.
>> + err:
>> +	dev_err(&indio_dev->dev, "Device read error\n");
> You only get here from one place.  Do this inline.
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
> Nitpick of the day.  A blank line here would be perfect ;)
>> +		return 0;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static const struct iio_chan_spec ms5637_channels[] =3D {
>> +	{
> The indenting you are using here is somewhat unusual.  Give the
> entries another tab.
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
> The func parameter passed into i2c_check_functionality is a bitmap so
> do all these in one call.
> if (!i2c_check_functionality(client->adapter,
>                             I2C_FUNC_SMBUS_READ_WORD_DATA |
> 			     I2C_FUNC_SMBUS_WRITE_BYTE |
> 			     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
> etc.
>=20
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
>> +	dev_data->resolution_index =3D 5;
>> +	dev_data->last_update =3D jiffies - HZ / 2;
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
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret =3D devm_iio_device_register(&client->dev, indio_dev);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	dev_dbg(&client->dev, "Driver initialization done");
> There are a lot of ways fo telling it is finsihed ;)  I'd drop this
> particular debug output from a driver just before submitting it.
>=20
>> +	return 0;
>> +}
>> +
>> +static const struct i2c_device_id ms5637_id[] =3D {
>> +	{"ms5637", 0},
>> +	{}
>> +};
>> +
>> +static struct i2c_driver ms5637_driver =3D {
>> +	.probe =3D ms5637_probe,
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
>> +MODULE_DESCRIPTION("Measurement-Specialties ms5637 temperature & =
pressure driver");
>> +MODULE_AUTHOR("William Markezana =
<william.markezana@meas-spec.com>");
>> +MODULE_AUTHOR("Ludovic Tancerel =
<ludovic.tancerel@maplehightech.com>");
>>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" =
in


--Apple-Mail=_53C9CBE8-D2ED-4969-AD5E-C456FC55A5B8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dwindows-1252"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">Hello =
again,<div>answer to this feedback will be simpler. Thank you for =
reviewing</div><div><br></div><div>For comments I did not reply, that =
also means I took it into =
account.</div><div><br></div><div>Regards,</div><div>Ludovic<br><div =
apple-content-edited=3D"true"><br></div>
<br><div><div>Le 21 juin 2015 =E0 17:10, Jonathan Cameron &lt;<a =
href=3D"mailto:jic23@kernel.org">jic23@kernel.org</a>&gt; a =E9crit =
:</div><br class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite"><div style=3D"font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;">On 18/06/15 17:28, Ludovic =
wrote:<br><blockquote type=3D"cite">This a patch re-submission taking =
into account feebdack from Peter and Tomasz.<br>Thank you for your =
feedback<br><br>Ludovic<br><br>Signed-off-by: Ludovic &lt;<a =
href=3D"mailto:ludovic.tancerel@maplehightech.com">ludovic.tancerel@mapleh=
ightech.com</a>&gt;<br></blockquote>Hi Ludovic,<br><br>Firstly would you =
mind signing off with your whole name prior to the email<br>address =
(convention in the kernel - if you have two or more names anyway =
;)<br></div></blockquote>I will not fill all my names, but will add the =
last name=85</div><div>I never noticed that my config did not include =
it, even for our internal dev.</div><div><br></div><div><blockquote =
type=3D"cite"><div style=3D"font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;"><br>Looking pretty good, just a =
few bits and bobs inline. Mostly along the<br>lines of ways of slightly =
cleaning up the code rather than anything<br>fundamental.<br><br>The one =
non trivial question is why the throttle on reading =
rate?<br></div></blockquote><div><br></div>The throttle is not strong =
req from me,</div><div>as long as I recall, I got this from other driver =
I looked into, and found this usefull providing that temperature / =
pressure do not change often.</div><div>I will remove =
this.</div><div><br><blockquote type=3D"cite"><div style=3D"font-size: =
12px; font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; line-height: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;"><br>Jonathan<br><blockquote =
type=3D"cite">---<br>drivers/iio/pressure/Kconfig &nbsp;| &nbsp;&nbsp;9 =
+<br>drivers/iio/pressure/Makefile | &nbsp;&nbsp;1 =
+<br>drivers/iio/pressure/ms5637.c | 457 =
++++++++++++++++++++++++++++++++++++++++++<br>3 files changed, 467 =
insertions(+)<br>create mode 100644 =
drivers/iio/pressure/ms5637.c<br><br>diff --git =
a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig<br>index =
fa62950..69675ef2 100644<br>--- a/drivers/iio/pressure/Kconfig<br>+++ =
b/drivers/iio/pressure/Kconfig<br>@@ -78,6 +78,15 @@ config =
MS5611_SPI<br><br><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-converted-space">&nbsp;</span>&nbsp;To=
 compile this driver as a module, choose M here: the module =
will<br><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-converted-space">&nbsp;</span>&nbsp;be =
called ms5611_spi.<br>+config MS5637<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;tristate "MS5637 pressure =
&amp; temperature sensor"<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;depends on I2C<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;help<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If you say yes =
here you get support for the Measurement Specialties<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MS5637 pressure =
and temperature sensor.<br>+<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This driver can =
also be built as a module. If so, the module will<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;be called =
ms5637.<br><br>config IIO_ST_PRESS<br><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>tristate "STMicroelectronics =
pressure sensor Driver"<br>diff --git a/drivers/iio/pressure/Makefile =
b/drivers/iio/pressure/Makefile<br>index a4f98f8..46571c96 100644<br>--- =
a/drivers/iio/pressure/Makefile<br>+++ =
b/drivers/iio/pressure/Makefile<br>@@ -10,6 +10,7 @@ =
obj-$(CONFIG_MPL3115) +=3D mpl3115.o<br>obj-$(CONFIG_MS5611) +=3D =
ms5611_core.o<br>obj-$(CONFIG_MS5611_I2C) +=3D =
ms5611_i2c.o<br>obj-$(CONFIG_MS5611_SPI) +=3D =
ms5611_spi.o<br>+obj-$(CONFIG_MS5637) +=3D =
ms5637.o<br>obj-$(CONFIG_IIO_ST_PRESS) +=3D =
st_pressure.o<br>st_pressure-y :=3D =
st_pressure_core.o<br>st_pressure-$(CONFIG_IIO_BUFFER) +=3D =
st_pressure_buffer.o<br>diff --git a/drivers/iio/pressure/ms5637.c =
b/drivers/iio/pressure/ms5637.c<br>new file mode 100644<br>index =
0000000..bda7206<br>--- /dev/null<br>+++ =
b/drivers/iio/pressure/ms5637.c<br>@@ -0,0 +1,457 @@<br>+/*<br>+ * =
ms5637.c - Support for Measurement-Specialties ms5637<br>+ * =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pressure=
 &amp; temperature sensor<br>+ *<br>+ * Copyright (c) 2014 =
Measurement-Specialties<br>+ *<br>+ * Licensed under the GPL-2.<br>+ =
*<br>+ * (7-bit I2C slave address 0x76)<br>+ *<br>+ */<br>+#include =
&lt;linux/init.h&gt;<br>+#include &lt;linux/device.h&gt;<br>+#include =
&lt;linux/kernel.h&gt;<br>+#include &lt;linux/stat.h&gt;<br>+#include =
&lt;linux/module.h&gt;<br>+#include &lt;linux/i2c.h&gt;<br>+#include =
&lt;linux/iio/iio.h&gt;<br>+#include =
&lt;linux/iio/sysfs.h&gt;<br>+#include =
&lt;linux/jiffies.h&gt;<br>+#include &lt;linux/delay.h&gt;<br>+#include =
&lt;linux/mutex.h&gt;<br>+<br>+/* MS5637 Commands */<br>+#define =
MS5637_RESET<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x1E<br>+#define MS5637_TEMPERATURE_CONVERSION_START<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x50<br>+#define MS5637_PRESSURE_CONVERSION_START<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x40<br>+#define MS5637_ADC_READ<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x00<br>+#define =
MS5637_PROM_READ<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0xA0<br>+#define MS5637_PROM_ELEMENTS_NB =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;7<br>+<br>+#define =
MS5637_CONVERSION_SLEEP(index)<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>\<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>usleep_range(ms5637_conversion_time[index],\<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ms5637_conversion_time[index] + 3000)<br></blockquote>I'd be =
tempted to make this one a function rather than a macro then<br>let the =
compiler inline it if it feels like it..<br><blockquote =
type=3D"cite">+<br>+static const u16 ms5637_conversion_time[6] =3D { =
1000, 2000,<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;3000, 5000,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;9000, 17000 };<br>+<br>+static const int ms5637_samp_freq[6][2] =
&nbsp;&nbsp;&nbsp;=3D { {1800, 0}, {900, 0},<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;{450, 0}, {225, 0},<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;{112, 500000}, {56, 250000}<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;};<br=
></blockquote>Although it is clearly duplicating data, I'd be tempted to =
have<br>the available list as a const char * here (where it can be =
easily checked).<br>Then you can drop a couple of functions and use the =
const attribute<br>defintion.<br></div></blockquote>The way understand =
it, I will drop you something looking to this.</div><div>This is unusual =
to me, but if you like it, I am not opposed to it =
:</div><div>******</div><div><div>static const int =
ms5637_samp_freq[6][2] &nbsp; &nbsp;=3D { {1800, 0}, {900, =
0},</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
			</span> &nbsp; &nbsp; &nbsp; {450, 0}, {225, =
0},</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
			</span> &nbsp; &nbsp; &nbsp; {112, 500000}, {56, =
250000}</div><div><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">					</span> =
&nbsp; &nbsp; };</div><div>/* String copy of the above const for =
readability purpose */</div><div>static const char =
ms5637_show_samp_freq[] &nbsp;=3D</div><div><span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">				</span>"1800.0 =
900.0 450.0 225.0 112.50 =
56.25";</div><div>******</div><div><br></div><blockquote =
type=3D"cite"><div style=3D"font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;"><br><blockquote =
type=3D"cite">+<br>+struct ms5637_dev {<br>+<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>struct i2c_client =
*client;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>struct mutex lock; /* Mutex protecting this data structure =
*/<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>/* Added element for CRC computation */<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>u16 =
calibration_coeffs[MS5637_PROM_ELEMENTS_NB + 1];<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>unsigned =
long last_update;<br>+<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>int temperature;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>unsigned int pressure;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>u8 =
resolution_index;<br>+};<br>+<br>+static int =
ms5637_get_calibration_coeffs(struct ms5637_dev *dev_data,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>u8 index, u16 =
*word)<br>+{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>int ret;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ret =3D =
i2c_smbus_read_word_swapped(dev_data-&gt;client,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;MS5637_PROM_READ + =
(index &lt;&lt; 1));<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (ret &lt; 0)<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
ret;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>*word =3D ret;<br></blockquote>Blank line here.<br><blockquote =
type=3D"cite">+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>return 0;<br>+}<br>+<br>+static bool ms5637_crc_check(u16 =
*n_prom, u8 crc)<br>+{<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>unsigned int cnt, =
n_bit;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>u16 n_rem, crc_read;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>n_rem =3D 0x0000;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>crc_read =
=3D n_prom[0];<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>n_prom[MS5637_PROM_ELEMENTS_NB] =3D 0;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>n_prom[0] =
&amp;=3D 0x0FFF; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* Clear the CRC =
computation part */<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>for (cnt =3D 0; cnt &lt; =
(MS5637_PROM_ELEMENTS_NB + 1) * 2; cnt++) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (cnt % =
2 =3D=3D 1)<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>n_rem ^=3D n_prom[cnt &gt;&gt; 1] &amp; 0x00FF;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>else<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>n_rem ^=3D n_prom[cnt &gt;&gt; 1] &gt;&gt; =
8;<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>for (n_bit =3D 8; n_bit &gt; 0; n_bit--) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (n_rem =
&amp; 0x8000)<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>n_rem =3D (n_rem &lt;&lt; 1) ^ 0x3000;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>else<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>n_rem &lt;&lt;=3D 1;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>}<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>n_rem &gt;&gt;=3D 12;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>n_prom[0] =3D =
crc_read;<br></blockquote>blank line here.<br><blockquote =
type=3D"cite">+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>return n_rem =3D=3D crc;<br>+}<br>+<br>+static int =
ms5637_fill_calibration_coeffs(struct ms5637_dev =
*dev_data)<br>+{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>int i, ret;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>for (i =3D 0; i &lt; =
MS5637_PROM_ELEMENTS_NB; i++) {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ret =3D =
ms5637_get_calibration_coeffs(<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>dev_data, i,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>&amp;dev_data-&gt;calibration_coeffs[i]);<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (ret =
&lt; 0) {<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>dev_err(&amp;dev_data-&gt;client-&gt;dev,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>"Unable =
to get calibration coefficients at address %d\n",<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>i + =
1);<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>return ret;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>}<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>dev_dbg(&amp;dev_data-&gt;client-&gt;dev, "Coeff %d : %d", =
i,<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>dev_data-&gt;calibration_coeffs[i]);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>if ( ms5637_crc_check(<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>dev_data-&gt;calibration_coeffs,<br>+<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>(dev_data-&gt;calibration_coeffs[0] &amp; 0xF000) &gt;&gt; 12) =3D=3D=
 false) {<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>dev_err(&amp;dev_data-&gt;client-&gt;dev,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>"Calibration coefficients crc check error\n");<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
-ENODEV;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>return 0;<br>+}<br>+<br>+static int ms5637_read_adc_value(struct =
ms5637_dev *dev_data, u32 *adc_value)<br>+{<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>int =
ret<br></blockquote>This is a fairly standard beast. &nbsp;I'd use a u32 =
and just set it to zero<br>before reading into the relevant address and =
using an endian conversion<br>to sort out the ordering if needed. =
&nbsp;That way if no endian conversion<br>is needed it is all free =
;)<br><blockquote type=3D"cite">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>u8 buf[3];<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ret =
=3D<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;i2c_smbus_r=
ead_i2c_block_data(dev_data-&gt;client, MS5637_ADC_READ, 3,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;buf);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (ret =
&lt; 0)<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>return ret;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>dev_dbg(&amp;dev_data-&gt;client-&gt;dev, "ADC raw value : %x %x =
%x\n", buf[0],<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>buf[1], buf[2]);<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>*adc_value =3D (buf[0] &lt;&lt; =
16) + (buf[1] &lt;&lt; 8) + buf[2];<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
0;<br>+}<br>+<br>+static int ms5637_conversion_and_read_adc(struct =
ms5637_dev *dev_data,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;u32 *t_adc, u32 =
*p_adc)<br>+{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>int ret;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>/* Trigger Temperature conversion =
*/<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ret =3D i2c_smbus_write_byte(dev_data-&gt;client,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;MS5637_TEMPERATUR=
E_CONVERSION_START<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;+ =
dev_data-&gt;resolution_index * 2);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (ret &lt; 0)<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
ret;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>MS5637_CONVERSION_SLEEP(dev_data-&gt;resolution_index);<br>+<br>+<s=
pan class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>/* Retrieve ADC value */<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ret =3D =
ms5637_read_adc_value(dev_data, t_adc);<br>+<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>if (ret &lt; 0)<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
ret;<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>/* Trigger Pressure conversion */<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ret =3D =
i2c_smbus_write_byte(dev_data-&gt;client,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;MS5637_PRESSURE_C=
ONVERSION_START<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;+ =
dev_data-&gt;resolution_index * 2);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (ret &lt; 0)<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
ret;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>MS5637_CONVERSION_SLEEP(dev_data-&gt;resolution_index);<br>+<br>+<s=
pan class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>/* Retrieve ADC value */<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ret =3D =
ms5637_read_adc_value(dev_data, p_adc);<br>+<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>if (ret &lt; 0)<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
ret;<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>return 0;<br>+}<br>+<br>+static int =
ms5637_read_temperature_and_pressure(struct ms5637_dev =
*dev_data)<br>+{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>int ret =3D 0;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>u32 t_adc, p_adc;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>s32 dt, =
temp;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>s64 off, sens, t2, off2, sens2;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>mutex_lock(&amp;dev_data-&gt;lock);<br>+<br></blockquote>Why this =
throttle on frequency of reading? &nbsp;If there is a reason<br>add a =
comment saying why.<br><blockquote type=3D"cite">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if =
(time_after(jiffies, dev_data-&gt;last_update + HZ / 2)) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ret =3D =
ms5637_conversion_and_read_adc(dev_data, &amp;t_adc, =
&amp;p_adc);<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>if (ret &lt; 0) {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>dev_err(&amp;dev_data-&gt;client-&gt;dev,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>"Unable =
to make sensor adc conversion\n");<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>goto out;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>dt =3D (s32)t_adc - (dev_data-&gt;calibration_coeffs[5] =
&lt;&lt; 8);<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>/* Actual temperature =3D 2000 + dT * TEMPSENS =
*/<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>temp =3D<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;2000 + =
(((s64)dt * dev_data-&gt;calibration_coeffs[6]) &gt;&gt; =
23);<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>/* Second order temperature compensation */<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (temp =
&lt; 2000) {<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>s64 tmp =3D (s64)temp - 2000;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>t2 =3D (3 =
* ((s64)dt * (s64)dt)) &gt;&gt; 33;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>off2 =3D (61 * tmp * tmp) =
&gt;&gt; 4;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>sens2 =3D (29 * tmp * tmp) &gt;&gt; 4;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (temp =
&lt; -1500) {<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>s64 tmp =3D (s64)temp + 1500;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>off2 +=3D =
17 * tmp * tmp;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>sens2 +=3D 9 * tmp * tmp;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>} else {<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>t2 =3D (5 * ((s64)dt * (s64)dt)) &gt;&gt; 38;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>off2 =3D =
0;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>sens2 =3D 0;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>}<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>/* OFF =3D =
OFF_T1 + TCO * dT */<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>off =3D =
(((s64)dev_data-&gt;calibration_coeffs[2]) &lt;&lt; 17) +<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;((((s64)dev=
_data-&gt;calibration_coeffs[4]) * (s64)dt) &gt;&gt; 6);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>off -=3D =
off2;<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>/* Sensitivity at actual temperature =3D SENS_T1 + TCS * =
dT */<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>sens =3D (((s64)dev_data-&gt;calibration_coeffs[1]) &lt;&lt; =
16)<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;+ =
(((s64)dev_data-&gt;calibration_coeffs[3] * dt) &gt;&gt; 7);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>sens -=3D =
sens2;<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>/* Temperature compensated pressure =3D D1 * SENS - OFF =
*/<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>dev_data-&gt;temperature =3D (temp - t2) * 10;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>dev_data-&gt;pressure =3D (u32)(((((s64)p_adc * sens) &gt;&gt; =
21)<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;- =
off) &gt;&gt; 15);<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>dev_data-&gt;last_update =3D =
jiffies;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+ out:<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>mutex_unlock(&amp;dev_data-&gt;lock);<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
ret &gt;=3D 0 ? 0 : ret;<br></blockquote>I'd just make sure that ret is =
firmly defined to only be an error if<br>negative then just return it =
directly. &nbsp;(convention in the kernel is<br>for only negative =
errors).<br><blockquote type=3D"cite">+}<br>+<br></blockquote>Again, =
this isn't complex enough or used enough to demand a utility =
function.<br><br><blockquote type=3D"cite">+static int =
ms5637_get_int_plus_micros_index(const int (*vals)[2], int n,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;int val, =
int val2)<br>+{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>while (n-- &gt; 0)<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (val =3D=3D vals[n][0] =
&amp;&amp; val2 =3D=3D vals[n][1])<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return n;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
-EINVAL;<br>+}<br>+<br></blockquote>Only used in one place. Roll this =
inline. &nbsp;It's not complex enough<br>that this little utilty =
function is needed.<br><blockquote type=3D"cite">+static int =
ms5637_get_samp_freq_index(struct ms5637_dev *dev_data,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;int val, int val2)<br>+{<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return =
ms5637_get_int_plus_micros_index(ms5637_samp_freq,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ARRAY_SIZE(ms5637_samp_freq), val, val2);<br>+}<br>+<br>+static =
ssize_t ms5637_show_int_plus_micros(char *buf,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;const int =
(*vals)[2], int n)<br>+{<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>size_t len =3D 0;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>while =
(n-- &gt; 0)<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>len +=3D scnprintf(buf + len, PAGE_SIZE - len,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>"%d.%06d =
", vals[n][0], vals[n][1]);<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>/* replace trailing space by =
newline */<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>buf[len - 1] =3D '\n';<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
len;<br>+}<br>+<br>+static ssize_t ms5637_show_samp_freq_avail(struct =
device *dev,<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;struct =
device_attribute *attr,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;char =
*buf)<br>+{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>return ms5637_show_int_plus_micros(buf, =
ms5637_samp_freq,<br>+<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;ARRAY_SIZE(ms5637=
_samp_freq));<br>+}<br>+<br>+static int ms5637_read_raw(struct iio_dev =
*indio_dev,<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;struct =
iio_chan_spec const *channel, int *val,<br>+<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;int *val2, long =
mask)<br>+{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>int ret;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>struct ms5637_dev *dev_data =3D =
iio_priv(indio_dev);<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>switch (mask) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>case =
IIO_CHAN_INFO_PROCESSED:<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ret =3D =
ms5637_read_temperature_and_pressure(dev_data);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if =
(ret)<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>goto err;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>switch (channel-&gt;type) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>case =
IIO_TEMP:<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>/* in =B0C */<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>*val =3D dev_data-&gt;temperature =
/ 1000;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>*val2 =3D (dev_data-&gt;temperature % 1000) * 1000;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>break;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>case IIO_PRESSURE:<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>/* in kPa */<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>*val =3D =
dev_data-&gt;pressure / 1000;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>*val2 =3D (dev_data-&gt;pressure =
% 1000) * 1000;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>break;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>default:<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
-EINVAL;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>break;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>case IIO_CHAN_INFO_SAMP_FREQ:<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>*val =3D =
ms5637_samp_freq[dev_data-&gt;resolution_index][0];<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>*val2 =3D =
ms5637_samp_freq[dev_data-&gt;resolution_index][1];<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>break;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>default:<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return -EINVAL;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>return IIO_VAL_INT_PLUS_MICRO;<br></blockquote>I'd return =
directly from the various case statements.<br><blockquote type=3D"cite">+ =
err:<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>dev_err(&amp;indio_dev-&gt;dev, "Device read =
error\n");<br></blockquote>You only get here from one place. &nbsp;Do =
this inline.<br><blockquote type=3D"cite">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return ret;<br>+}<br>+<br>+static =
int ms5637_write_raw(struct iio_dev *indio_dev,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;struct =
iio_chan_spec const *chan,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;int val, =
int val2, long mask)<br>+{<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>struct ms5637_dev *dev_data =3D =
iio_priv(indio_dev);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>int i;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>switch =
(mask) {<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>case IIO_CHAN_INFO_SAMP_FREQ:<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>i =3D =
ms5637_get_samp_freq_index(dev_data, val, val2);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (i =
&lt; 0)<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>return -EINVAL;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>dev_data-&gt;resolution_index =3D =
i;<br></blockquote>Nitpick of the day. &nbsp;A blank line here would be =
perfect ;)<br><blockquote type=3D"cite">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return 0;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>default:<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>return -EINVAL;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>}<br>+}<br>+<br>+static const =
struct iio_chan_spec ms5637_channels[] =3D {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>{<br></blockquote>The indenting you are using here is somewhat =
unusual. &nbsp;Give the<br>entries another tab.<br><blockquote =
type=3D"cite">+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-converted-space">&nbsp;</span>.type =
=3D IIO_TEMP,<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>.info_mask_separate =3D =
BIT(IIO_CHAN_INFO_PROCESSED),<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>.info_mask_shared_by_type =3D=
 BIT(IIO_CHAN_INFO_SAMP_FREQ),<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>},<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-converted-space">&nbsp;</span>.type =3D =
IIO_PRESSURE,<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>.info_mask_separate =3D =
BIT(IIO_CHAN_INFO_PROCESSED),<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>.info_mask_shared_by_type =3D=
 BIT(IIO_CHAN_INFO_SAMP_FREQ),<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>}<br>+};<br>+<br>+static =
IIO_DEV_ATTR_SAMP_FREQ_AVAIL(ms5637_show_samp_freq_avail);<br>+<br>+static=
 struct attribute *ms5637_attributes[] =3D {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>&amp;iio_dev_attr_sampling_frequency_available.dev_attr.attr,<br>+<=
span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>NULL,<br>+};<br>+<br>+static const struct attribute_group =
ms5637_attribute_group =3D {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>.attrs =3D =
ms5637_attributes,<br>+};<br>+<br>+static const struct iio_info =
ms5637_info =3D {<br>+<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>.read_raw =3D ms5637_read_raw,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>.write_raw =3D ms5637_write_raw,<br>+<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>.attrs =3D =
&amp;ms5637_attribute_group,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>.driver_module =3D =
THIS_MODULE,<br>+};<br>+<br>+static int ms5637_probe(struct i2c_client =
*client,<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>const struct i2c_device_id *id)<br>+{<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>struct =
ms5637_dev *dev_data;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>struct iio_dev =
*indio_dev;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>int ret;<br>+<br></blockquote>The func parameter passed =
into i2c_check_functionality is a bitmap so<br>do all these in one =
call.<br>if =
(!i2c_check_functionality(client-&gt;adapter,<br>&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I2C_F=
UNC_SMBUS_READ_WORD_DATA |<br><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;I2C_F=
UNC_SMBUS_WRITE_BYTE |<br><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;I2C_F=
UNC_SMBUS_READ_I2C_BLOCK)) {<br>etc.<br><br><blockquote =
type=3D"cite">+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>if =
(!i2c_check_functionality(client-&gt;adapter,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;I2C_F=
UNC_SMBUS_READ_WORD_DATA)) {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>dev_err(&amp;client-&gt;dev,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>"Adapter does not support SMBus =
read word transactions\n");<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return -ENODEV;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>if =
(!i2c_check_functionality(client-&gt;adapter,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;I2C_F=
UNC_SMBUS_WRITE_BYTE)) {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>dev_err(&amp;client-&gt;dev,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>"Adapter does not support SMBus =
write byte transactions\n");<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return -ENODEV;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>if =
(!i2c_check_functionality(client-&gt;adapter,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;I2C_F=
UNC_SMBUS_READ_I2C_BLOCK)) {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>dev_err(&amp;client-&gt;dev,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>"Adapter does not support SMBus =
read block transactions\n");<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return -ENODEV;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>indio_dev =3D devm_iio_device_alloc(&amp;client-&gt;dev, =
sizeof(*dev_data));<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (!indio_dev)<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
-ENOMEM;<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>dev_data =3D iio_priv(indio_dev);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>dev_data-&gt;client =3D client;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>dev_data-&gt;resolution_index =3D =
5;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>dev_data-&gt;last_update =3D jiffies - HZ / 2;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>mutex_init(&amp;dev_data-&gt;lock);<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>indio_dev-&gt;info =3D &amp;ms5637_info;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>indio_dev-&gt;name =3D id-&gt;name;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>indio_dev-&gt;dev.parent =3D &amp;client-&gt;dev;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>indio_dev-&gt;modes =3D INDIO_DIRECT_MODE;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>indio_dev-&gt;channels =3D ms5637_channels;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>indio_dev-&gt;num_channels =3D =
ARRAY_SIZE(ms5637_channels);<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>i2c_set_clientdata(client, =
indio_dev);<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>ret =3D i2c_smbus_write_byte(client, =
MS5637_RESET);<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>if (ret &lt; 0)<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return ret;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>usleep_range(3000, 6000);<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ret =3D =
ms5637_fill_calibration_coeffs(dev_data);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (ret =
&lt; 0)<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>return ret;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ret =3D =
devm_iio_device_register(&amp;client-&gt;dev, indio_dev);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (ret =
&lt; 0)<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>return ret;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>dev_dbg(&amp;client-&gt;dev, =
"Driver initialization done");<br></blockquote>There are a lot of ways =
fo telling it is finsihed ;) &nbsp;I'd drop this<br>particular debug =
output from a driver just before submitting it.<br><br><blockquote =
type=3D"cite">+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>return 0;<br>+}<br>+<br>+static const struct =
i2c_device_id ms5637_id[] =3D {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>{"ms5637", 0},<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>{}<br>+};<br>+<br>+static struct i2c_driver ms5637_driver =3D =
{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>.probe =3D ms5637_probe,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>.id_table =3D =
ms5637_id,<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>.driver =3D {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;.name =3D =
"ms5637",<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;.owner =3D =
THIS_MODULE,<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;},<br>+};<br>+<br=
>+module_i2c_driver(ms5637_driver);<br>+<br>+MODULE_LICENSE("GPL");<br>+MO=
DULE_DESCRIPTION("Measurement-Specialties ms5637 temperature &amp; =
pressure driver");<br>+MODULE_AUTHOR("William Markezana &lt;<a =
href=3D"mailto:william.markezana@meas-spec.com">william.markezana@meas-spe=
c.com</a>&gt;");<br>+MODULE_AUTHOR("Ludovic Tancerel &lt;<a =
href=3D"mailto:ludovic.tancerel@maplehightech.com">ludovic.tancerel@mapleh=
ightech.com</a>&gt;");<br><br></blockquote><br>--<br>To unsubscribe from =
this list: send the line "unsubscribe linux-iio" =
in</div></blockquote></div><br></div></body></html>=

--Apple-Mail=_53C9CBE8-D2ED-4969-AD5E-C456FC55A5B8--
