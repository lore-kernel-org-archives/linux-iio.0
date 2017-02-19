Return-Path: <SRS0=PbGF=2A=gmail.com=tduszyns@kernel.org>
Date: Sun, 19 Feb 2017 18:29:40 +0100
From: Tomasz Duszynski <tduszyns@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Tomasz Duszynski <tduszyns@gmail.com>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, Jean Delvare <khali@linux-fr.org>,
	linux-hwmon@vger.kernel.org, "Peter A. Bigot" <pab@pabigot.com>,
	David Frey <david.frey@sensirion.com>,
	Pascal Sachs <pascal.sachs@sensirion.com>
Subject: Re: [PATCH 1/3] iio: humidity: add sht21 relative humidity and
 temperature sensor driver
Message-ID: <20170219172938.GA25989@Arch.lan>
References: <20170219145827.22644-1-tduszyns@gmail.com>
 <32c2d99f-e861-c3f3-a63a-4c47f050c159@kernel.org>
 <d63b8ca9-cead-2485-6f28-f5dcf37fed08@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d63b8ca9-cead-2485-6f28-f5dcf37fed08@roeck-us.net>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Feb 19, 2017 at 08:10:54AM -0800, Guenter Roeck wrote:
> On 02/19/2017 07:04 AM, Jonathan Cameron wrote:
> > On 19/02/17 14:58, Tomasz Duszynski wrote:
> > > Add sht21 relative humidity and temperature sensor driver. There already
> > > exists an in-kernel driver under hwmon but with limited functionality
> > > like humidity and temperature always measured together at predefined
> > > resolutions, etc.
> > >
> > > New iio driver comes without limitations of predecessor, uses non-blocking i2c
> > > communication mode and adds triggered buffer support thus is suited for more
> > > use cases.
> > >
> > > Device datasheet can be found under:
> > >
> > > https://www.sensirion.com/fileadmin/user_upload/customers/sensirion/ \
> > > Dokumente/2_Humidity_Sensors/Sensirion_Humidity_Sensors_SHT21_Datasheet_V4.pdf
> > >
> > > Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> > Hi Tomasz,
> >
> > I haven't looked at this yet, but one thing we have to do whenever suggesting
> > replacement of an hwmon driver is to convince the hwmon guys that it is a
> > good idea.
> >
> > As such I've cc'd Guenter, Jean and the list.
> >
>
> I don't really have a strong opinion. The chip does not have limits,
> so no core functionality is lost. Hope replacing a 200 LOC driver with
> a 500 LOC driver is worth it. Point of concern may be that other Sensirion
> drivers are in hwmon, so moving only this one over is not really optimal.
> And newer chips (sht3x) _do_ have limits and alarms.
Ah, I have somehow missed sht3x support in hwmon, for which I was
preparing iio driver, my bad. This makes your concern even more valid as
indeed moving single driver generates just noise. sht21 simplistic driver
has been around for a couple of years now so maybe it means that nobody
would really benefit from the functionality in new iio driver besides
me.

Guess I need some more thought on that.
>
> Please make sure to keep me in the loop, and please also add the functionality
> currently being added to the hwmon driver (Electronic Identification Code
> retrieval), as available in linux-next. I would also suggest to keep Sensirion
> in the loop.
>
> At some point we may want to more seriously discuss a hwmon->iio bridge.
> Maybe it is just me, but it still seems to me that might make more sense
> than rewriting drivers from scratch.
That iio bridge would be definitely a beneficial thing.
>
> Guenter
>
> > Jonathan
> >
> > p.s Probably won't get to this today as running out of time.  Depending on
> > how mad the week is it might be next weekend before I get a chance.
> > > ---
> > >  drivers/iio/humidity/Kconfig  |  10 +
> > >  drivers/iio/humidity/Makefile |   1 +
> > >  drivers/iio/humidity/sht21.c  | 519 ++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 530 insertions(+)
> > >  create mode 100644 drivers/iio/humidity/sht21.c
> > >
> > > diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
> > > index 866dda133336..93247ecc9324 100644
> > > --- a/drivers/iio/humidity/Kconfig
> > > +++ b/drivers/iio/humidity/Kconfig
> > > @@ -35,6 +35,16 @@ config HTU21
> > >  	  This driver can also be built as a module. If so, the module will
> > >  	  be called htu21.
> > >
> > > +config SHT21
> > > +	tristate "Sensirion SHT21 relative humidity and temperature sensor"
> > > +	depends on I2C
> > > +	help
> > > +	  Say yes here to build support for the  Sensirion SHT21 relative
> > > +	  humidity and temperature sensor.
> > > +
> > > +	  To compile this driver as a module, choose M here: the module
> > > +	  will be called sht21.
> > > +
> > >  config SI7005
> > >  	tristate "SI7005 relative humidity and temperature sensor"
> > >  	depends on I2C
> > > diff --git a/drivers/iio/humidity/Makefile b/drivers/iio/humidity/Makefile
> > > index c9f089a9a6b8..f2472fd2cc44 100644
> > > --- a/drivers/iio/humidity/Makefile
> > > +++ b/drivers/iio/humidity/Makefile
> > > @@ -5,5 +5,6 @@
> > >  obj-$(CONFIG_DHT11) += dht11.o
> > >  obj-$(CONFIG_HDC100X) += hdc100x.o
> > >  obj-$(CONFIG_HTU21) += htu21.o
> > > +obj-$(CONFIG_SHT21) += sht21.o
> > >  obj-$(CONFIG_SI7005) += si7005.o
> > >  obj-$(CONFIG_SI7020) += si7020.o
> > > diff --git a/drivers/iio/humidity/sht21.c b/drivers/iio/humidity/sht21.c
> > > new file mode 100644
> > > index 000000000000..199933b87297
> > > --- /dev/null
> > > +++ b/drivers/iio/humidity/sht21.c
> > > @@ -0,0 +1,519 @@
> > > +/*
> > > + * Sensirion SHT21 relative humidity and temperature sensor driver
> > > + *
> > > + * Copyright (C) 2017 Tomasz Duszynski <tduszyns@gmail.com>
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify
> > > + * it under the terms of the GNU General Public License as published by
> > > + * the Free Software Foundation; either version 2 of the License, or
> > > + * (at your option) any later version.
> > > + *
> > > + * This program is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > > + * GNU General Public License for more details.
> > > + *
> > > + * 7-bit I2C slave address: 0x40
> > > + */
> > > +
> > > +#include <linux/bitops.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/iio/buffer.h>
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/iio/sysfs.h>
> > > +#include <linux/iio/trigger_consumer.h>
> > > +#include <linux/iio/triggered_buffer.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/of.h>
> > > +
> > > +#define SHT21_DRV_NAME "sht21"
> > > +
> > > +#define SHT21_TRIGGER_T_MEASUREMENT 0xF3
> > > +#define SHT21_TRIGGER_RH_MEASUREMENT 0xF5
> > > +
> > > +#define SHT21_WRITE_USER_REG 0xE6
> > > +#define SHT21_READ_USER_REG 0xE7
> > > +#define SHT21_SOFT_RESET 0xFE
> > > +
> > > +#define SHT21_USER_REG_RES_8_12 BIT(0)
> > > +#define SHT21_USER_REG_RES_10_13 BIT(7)
> > > +#define SHT21_USER_REG_RES_11_11 (BIT(7) | BIT(0))
> > > +
> > > +#define SHT21_USER_REG_ENABLE_HEATER BIT(2)
> > > +
> > > +enum {
> > > +	RES_12_14,
> > > +	RES_8_12,
> > > +	RES_10_13,
> > > +	RES_11_11,
> > > +};
> > > +
> > > +/*
> > > + * Combined sampling frequency i.e measuring RH and T together, which seems
> > > + * to be common case for pressure/humidity sensors, was chosen so that sensor
> > > + * is active for only 10% of time thus avoiding self-heating effect.
> > > + *
> > > + * Note that sampling frequencies are higher when measuring RH or T separately.
> > > + *
> > > + * Following table shows how available resolutions, combined sampling frequency
> > > + * and frequencies for RH and T when measured separately are related.
> > > + *
> > > + * +-------------------+-------------+---------+--------+
> > > + * | RH / T resolution | RH + T [Hz] | RH [Hz] | T [Hz] |
> > > + * +-------------------+-------------+---------+--------+
> > > + * | 12 / 14           | 0.88        | 3.45    | 1.18   |
> > > + * +-------------------+-------------+---------+--------+
> > > + * | 8 / 12            | 3.85        | 25      | 4.55   |
> > > + * +-------------------+-------------+---------+--------+
> > > + * | 10 / 13           | 1.93        | 11.11   | 2.33   |
> > > + * +-------------------+-------------+---------+--------+
> > > + * | 11 / 11           | 2.28        | 6.67    | 9.09   |
> > > + * +-------------------+-------------+---------+--------+
> > > + */
> > > +static const struct {
> > > +	int freq;
> > > +	int freq2;
> > > +
> > > +	int rh_meas_time;
> > > +	int t_meas_time;
> > > +} sht21_freq_meas_time_tbl[] = {
> > > +	[RES_12_14] = { 0, 880000, 29000, 85000 },
> > > +	[RES_8_12] = { 3, 850000, 4000, 22000 },
> > > +	[RES_10_13] = { 1, 930000, 9000, 43000 },
> > > +	[RES_11_11] = { 2, 280000, 15000, 11000 }
> > > +};
> > > +
> > > +struct sht21_state {
> > > +	struct i2c_client *client;
> > > +	struct mutex lock;
> > > +	int res;
> > > +};
> > > +
> > > +static int sht21_verify_crc(const u8 *data, int len)
> > > +{
> > > +	int i, j;
> > > +	u8 crc = 0;
> > > +
> > > +	for (i = 0; i < len; i++) {
> > > +		crc ^= data[i];
> > > +
> > > +		for (j = 0; j < 8; j++) {
> > > +			if (crc & 0x80)
> > > +				crc = (crc << 1) ^ 0x31;
> > > +			else
> > > +				crc = crc << 1;
> > > +		}
> > > +	}
> > > +
> > > +	return crc == 0;
> > > +}
> > > +
> > > +/* every chunk of data read from sensor has crc byte appended */
> > > +static int sht21_read_data(struct sht21_state *state, int cmd, int *data)
> > > +{
> > > +	int delay, ret = 0;
> > > +	__be32 tmp = 0;
> > > +
> > > +	switch (cmd) {
> > > +	case SHT21_READ_USER_REG:
> > > +		ret = i2c_smbus_read_i2c_block_data(state->client, cmd,
> > > +						    2, (u8 *)&tmp);
> > > +		break;
> > > +	case SHT21_TRIGGER_RH_MEASUREMENT:
> > > +	case SHT21_TRIGGER_T_MEASUREMENT:
> > > +		ret = i2c_smbus_write_byte(state->client, cmd);
> > > +		if (ret)
> > > +			break;
> > > +
> > > +		delay = cmd == SHT21_TRIGGER_RH_MEASUREMENT ?
> > > +			sht21_freq_meas_time_tbl[state->res].rh_meas_time :
> > > +			sht21_freq_meas_time_tbl[state->res].t_meas_time;
> > > +
> > > +		usleep_range(delay, delay + 1000);
> > > +
> > > +		ret = i2c_master_recv(state->client, (u8 *)&tmp, 3);
> > > +		if (ret < 0)
> > > +			break;
> > > +
> > > +		/*
> > > +		 * Sensor should not be active more that 10% of time
> > > +		 * otherwise it heats up and returns biased measurements.
> > > +		 */
> > > +		delay *= 9;
> > > +		usleep_range(delay, delay + 1000);
> > > +
> > > +		break;
> > > +	}
> > > +
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	if (!sht21_verify_crc((u8 *)&tmp, ret)) {
> > > +		dev_err(&state->client->dev, "Data integrity check failed\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	/* crc byte no longer needed so drop it here */
> > > +	*data = be32_to_cpu(tmp) >> ((sizeof(tmp) - ret + 1) * 8);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int sht21_write_data(struct sht21_state *state, int cmd, int *data)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (!data)
> > > +		ret = i2c_smbus_write_byte(state->client, cmd);
> > > +	else
> > > +		ret = i2c_smbus_write_byte_data(state->client, cmd, *data);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int sht21_trigger_measurement(struct sht21_state *state, int cmd, int *data)
> > > +{
> > > +	int ret;
> > > +
> > > +	mutex_lock(&state->lock);
> > > +	ret = sht21_read_data(state, cmd, data);
> > > +	if (ret) {
> > > +		mutex_unlock(&state->lock);
> > > +		return ret;
> > > +	}
> > > +	mutex_unlock(&state->lock);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int sht21_trigger_rh_measurement(struct sht21_state *state, int *data)
> > > +{
> > > +	int ret = sht21_trigger_measurement(state, SHT21_TRIGGER_RH_MEASUREMENT, data);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	*data >>= 2;
> > > +	*data = (((s64)*data * 125000) >> 14) - 6000;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int sht21_trigger_t_measurement(struct sht21_state *state, int *data)
> > > +{
> > > +	int ret = sht21_trigger_measurement(state, SHT21_TRIGGER_T_MEASUREMENT, data);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	*data >>= 2;
> > > +	*data = (((s64)*data * 175720) >> 14) - 46850;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int sht21_set_resolution(struct sht21_state *state, int res)
> > > +{
> > > +	int ret, data;
> > > +
> > > +	ret = sht21_read_data(state, SHT21_READ_USER_REG, &data);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	data &= ~SHT21_USER_REG_RES_11_11;
> > > +
> > > +	switch (res) {
> > > +	case RES_12_14:
> > > +		break;
> > > +	case RES_8_12:
> > > +		data |= SHT21_USER_REG_RES_8_12;
> > > +		break;
> > > +	case RES_10_13:
> > > +		data |= SHT21_USER_REG_RES_10_13;
> > > +		break;
> > > +	case RES_11_11:
> > > +		data |= SHT21_USER_REG_RES_11_11;
> > > +		break;
> > > +	}
> > > +
> > > +	ret = sht21_write_data(state, SHT21_WRITE_USER_REG, &data);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	state->res = res;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int sht21_soft_reset(struct sht21_state *state)
> > > +{
> > > +	int ret = sht21_write_data(state, SHT21_SOFT_RESET, NULL);
> > > +	if (ret) {
> > > +		dev_err(&state->client->dev, "Failed to reset device\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	msleep(15);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static irqreturn_t sht21_trigger_handler(int irq, void *p)
> > > +{
> > > +	struct iio_poll_func *pf = p;
> > > +	struct iio_dev *indio_dev = pf->indio_dev;
> > > +	struct sht21_state *state = iio_priv(indio_dev);
> > > +	int buf[4], ret, i, j = 0;
> > > +
> > > +	for_each_set_bit(i, indio_dev->active_scan_mask, indio_dev->masklength) {
> > > +		ret = i == 0 ? sht21_trigger_rh_measurement(state, &buf[j++]) :
> > > +			       sht21_trigger_t_measurement(state, &buf[j++]);
> > > +		if (ret)
> > > +			goto out;
> > > +	}
> > > +
> > > +	iio_push_to_buffers_with_timestamp(indio_dev, buf,
> > > +					   iio_get_time_ns(indio_dev));
> > > +out:
> > > +	iio_trigger_notify_done(indio_dev->trig);
> > > +
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static int sht21_read_raw(struct iio_dev *indio_dev,
> > > +			  struct iio_chan_spec const *channel, int *val,
> > > +			  int *val2, long mask)
> > > +{
> > > +	struct sht21_state *state = iio_priv(indio_dev);
> > > +	int ret;
> > > +
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_PROCESSED:
> > > +		if (iio_buffer_enabled(indio_dev))
> > > +			return -EBUSY;
> > > +
> > > +		switch (channel->type) {
> > > +		case IIO_HUMIDITYRELATIVE:
> > > +			ret = sht21_trigger_rh_measurement(state, val);
> > > +			if (ret)
> > > +				return ret;
> > > +
> > > +			return IIO_VAL_INT;
> > > +		case IIO_TEMP:
> > > +			ret = sht21_trigger_t_measurement(state, val);
> > > +			if (ret)
> > > +				return ret;
> > > +
> > > +			return IIO_VAL_INT;
> > > +		default:
> > > +			return -EINVAL;
> > > +		}
> > > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > > +		*val = sht21_freq_meas_time_tbl[state->res].freq;
> > > +		*val2 = sht21_freq_meas_time_tbl[state->res].freq2;
> > > +
> > > +		return IIO_VAL_INT_PLUS_MICRO;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> > > +static int sht21_write_raw(struct iio_dev *indio_dev,
> > > +			   struct iio_chan_spec const *chan,
> > > +			   int val, int val2, long mask)
> > > +{
> > > +	struct sht21_state *state = iio_priv(indio_dev);
> > > +	int i, ret;
> > > +
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > > +		for (i = 0; i < ARRAY_SIZE(sht21_freq_meas_time_tbl); i++)
> > > +			if (val == sht21_freq_meas_time_tbl[i].freq &&
> > > +			    val2 == sht21_freq_meas_time_tbl[i].freq2)
> > > +				break;
> > > +
> > > +		if (i == ARRAY_SIZE(sht21_freq_meas_time_tbl))
> > > +			return -EINVAL;
> > > +
> > > +		ret = iio_device_claim_direct_mode(indio_dev);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		mutex_lock(&state->lock);
> > > +		ret = sht21_set_resolution(state, i);
> > > +		mutex_unlock(&state->lock);
> > > +
> > > +		iio_device_release_direct_mode(indio_dev);
> > > +
> > > +		return ret;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> > > +static ssize_t sht21_show_heater(struct device *dev,
> > > +				 struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > > +	struct sht21_state *state = iio_priv(indio_dev);
> > > +	int data, ret;
> > > +
> > > +	ret = sht21_read_data(state, SHT21_READ_USER_REG, &data);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return sprintf(buf, "%d\n", !!(data & SHT21_USER_REG_ENABLE_HEATER));
> > > +}
> > > +
> > > +static ssize_t sht21_write_heater(struct device *dev,
> > > +				  struct device_attribute *attr,
> > > +				  const char *buf, size_t len)
> > > +{
> > > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > > +	struct sht21_state *state = iio_priv(indio_dev);
> > > +	int val, data, ret;
> > > +
> > > +	ret = kstrtoint(buf, 10, &val);
> > > +	if (ret)
> > > +		return ret;
> > > +	if (val != 0 && val != 1)
> > > +		return -EINVAL;
> > > +
> > > +	mutex_lock(&state->lock);
> > > +	ret = sht21_read_data(state, SHT21_READ_USER_REG, &data);
> > > +	if (ret) {
> > > +		mutex_unlock(&state->lock);
> > > +		return ret;
> > > +	}
> > > +
> > > +	if (val)
> > > +		data |= SHT21_USER_REG_ENABLE_HEATER;
> > > +	else
> > > +		data &= ~SHT21_USER_REG_ENABLE_HEATER;
> > > +
> > > +	ret = sht21_write_data(state, SHT21_WRITE_USER_REG, &data);
> > > +	mutex_unlock(&state->lock);
> > > +
> > > +	return ret ? ret : len;
> > > +}
> > > +
> > > +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("0.88 1.93 2.28 3.85");
> > > +static IIO_DEVICE_ATTR(heater_enable, S_IRUGO | S_IWUSR,
> > > +		       sht21_show_heater, sht21_write_heater, 0);
> > > +
> > > +static struct attribute *sht21_attributes[] = {
> > > +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> > > +	&iio_dev_attr_heater_enable.dev_attr.attr,
> > > +	NULL
> > > +};
> > > +
> > > +static const struct attribute_group sht21_attribute_group = {
> > > +	.attrs = sht21_attributes,
> > > +};
> > > +
> > > +static const struct iio_info sht21_info = {
> > > +	.driver_module = THIS_MODULE,
> > > +	.read_raw = sht21_read_raw,
> > > +	.write_raw = sht21_write_raw,
> > > +	.attrs = &sht21_attribute_group,
> > > +};
> > > +
> > > +#define SHT21_CHANNEL(_type, _index) { \
> > > +	.type = _type, \
> > > +	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED), \
> > > +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> > > +	.scan_index = _index, \
> > > +	.scan_type = { \
> > > +		.sign = 's', \
> > > +		.realbits = 32, \
> > > +		.storagebits = 32, \
> > > +		.endianness = IIO_CPU, \
> > > +	}, \
> > > +}
> > > +
> > > +static const struct iio_chan_spec sht21_channels[] = {
> > > +	SHT21_CHANNEL(IIO_HUMIDITYRELATIVE, 0),
> > > +	SHT21_CHANNEL(IIO_TEMP, 1),
> > > +	IIO_CHAN_SOFT_TIMESTAMP(2),
> > > +};
> > > +
> > > +static int sht21_probe(struct i2c_client *client, const struct i2c_device_id *id)
> > > +{
> > > +	struct iio_dev *indio_dev;
> > > +	struct sht21_state *data;
> > > +	int ret;
> > > +
> > > +	if (!i2c_check_functionality(client->adapter,
> > > +				     I2C_FUNC_SMBUS_WRITE_BYTE |
> > > +				     I2C_FUNC_SMBUS_BYTE_DATA |
> > > +				     I2C_FUNC_SMBUS_READ_I2C_BLOCK))
> > > +		return -ENODEV;
> > > +
> > > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > > +	if (!indio_dev)
> > > +		return -ENOMEM;
> > > +
> > > +	data = iio_priv(indio_dev);
> > > +	i2c_set_clientdata(client, indio_dev);
> > > +	data->client = client;
> > > +	mutex_init(&data->lock);
> > > +
> > > +	indio_dev->dev.parent = &client->dev;
> > > +	indio_dev->name = id->name;
> > > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > > +	indio_dev->info = &sht21_info;
> > > +	indio_dev->channels = sht21_channels;
> > > +	indio_dev->num_channels = ARRAY_SIZE(sht21_channels);
> > > +
> > > +	ret = sht21_soft_reset(data);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> > > +					 sht21_trigger_handler, NULL);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = iio_device_register(indio_dev);
> > > +	if (ret)
> > > +		iio_triggered_buffer_cleanup(indio_dev);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int sht21_remove(struct i2c_client *client)
> > > +{
> > > +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > > +
> > > +	iio_device_unregister(indio_dev);
> > > +	iio_triggered_buffer_cleanup(indio_dev);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct i2c_device_id sht21_id[] = {
> > > +	{ "sht21", 0 },
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(i2c, sht21_id);
> > > +
> > > +static const struct of_device_id sht21_of_match[] = {
> > > +	{ .compatible = "sensirion,sht21" },
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, sht21_of_match);
> > > +
> > > +static struct i2c_driver sht21_driver = {
> > > +	.driver = {
> > > +		.name = SHT21_DRV_NAME,
> > > +		.of_match_table = of_match_ptr(sht21_of_match),
> > > +	},
> > > +	.id_table = sht21_id,
> > > +	.probe = sht21_probe,
> > > +	.remove = sht21_remove,
> > > +};
> > > +module_i2c_driver(sht21_driver);
> > > +
> > > +MODULE_DESCRIPTION("Sensirion SHT21 relative humidity and temperature sensor driver");
> > > +MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
> > > +MODULE_LICENSE("GPL v2");
> > > --
> > > 2.11.1
> > >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-hwmon" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>

--
-----BEGIN CERTIFICATE-----
MIIDfTCCAuagAwIBAgIDErvmMA0GCSqGSIb3DQEBBQUAME4xCzAJBgNVBAYTAlVT
MRAwDgYDVQQKEwdFcXVpZmF4MS0wKwYDVQQLEyRFcXVpZmF4IFNlY3VyZSBDZXJ0
aWZpY2F0ZSBBdXRob3JpdHkwHhcNMDIwNTIxMDQwMDAwWhcNMTgwODIxMDQwMDAw
WjBCMQswCQYDVQQGEwJVUzEWMBQGA1UEChMNR2VvVHJ1c3QgSW5jLjEbMBkGA1UE
AxMSR2VvVHJ1c3QgR2xvYmFsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEA2swYYzD99BcjGlZ+W988bDjkcbd4kdS8odhM+KhDtgPpTSEHCIjaWC9m
OSm9BXiLnTjoBbdqfnGk5sRgprDvgOSJKA+eJdbtg/OtppHHmMlCGDUUna2YRpIu
T8rxh0PBFpVXLVDviS2Aelet8u5fa9IAjbkU+BQVNdnARqN7csiRv8lVK83Qlz6c
JmTM386DGXHKTubU1XupGc1V3sjs0l44U+VcT4wt/lAjNvxm5suOpDkZALeVAjmR
Cw7+OC7RHQWa9k0+bw8HHa8sHo9gOeL6NlMTOdReJivbPagUvTLrGAMoUgRx5asz
PeE4uwc2hGKceeoWMPRfwCvocWvk+QIDAQABo4HwMIHtMB8GA1UdIwQYMBaAFEjm
aPkr0rKV10fYIyAQTzOYkJ/UMB0GA1UdDgQWBBTAephojYn7qwVkDBF9qn1luMrM
TjAPBgNVHRMBAf8EBTADAQH/MA4GA1UdDwEB/wQEAwIBBjA6BgNVHR8EMzAxMC+g
LaArhilodHRwOi8vY3JsLmdlb3RydXN0LmNvbS9jcmxzL3NlY3VyZWNhLmNybDBO
BgNVHSAERzBFMEMGBFUdIAAwOzA5BggrBgEFBQcCARYtaHR0cHM6Ly93d3cuZ2Vv
dHJ1c3QuY29tL3Jlc291cmNlcy9yZXBvc2l0b3J5MA0GCSqGSIb3DQEBBQUAA4GB
AHbhEm5OSxYShjAGsoEIz/AIx8dxfmbuwu3UOx//8PDITtZDOLC5MH0Y0FWDomrL
NhGc6Ehmo21/uBPUR/6LWlxz/K7ZGzIZOKuXNBSqltLroxwUCEm2u+WR74M26x1W
b8ravHNjkOR/ez4iyz0H7V84dJzjA1BOoa+Y7mHyhD8S
-----END CERTIFICATE-----
