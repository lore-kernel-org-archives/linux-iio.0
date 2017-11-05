Return-Path: <SRS0=DR5M=CD=pmeerw.net=pmeerw@kernel.org>
Date: Sun, 5 Nov 2017 23:48:13 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: light: Add driver for IDT ZOPT2201 ambient light
 and UVB sensor
In-Reply-To: <20171014190644.653913bf@archlinux>
Message-ID: <alpine.DEB.2.20.1711041929430.23391@vps.pmeerw.net>
References: <20171010142959.4723-1-pmeerw@pmeerw.net> <20171014190644.653913bf@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hello Jonathan,

> Another very nice driver.  A couple of refactoring suggestions inline
> that I think would slightly (and it is slightly!) improve readability.
> I think we need some additional docs for the uv intensity channel as I can't
> find any documented units for that - so far they have been fairly randomly
> filtered and no docs have existed to map these to units.

UV intensity is already documented (around line 1288) as
/sys/.../iio:deviceX/in_intensityY_uv_raw
however
/sys/.../iio:deviceX/in_intensity_raw and 
/sys/.../iio:deviceX/in_intensity_uv_raw are missing, should these be 
added for completeness??

> As such I'm thinking w/m^2 would be a nicer base unit.  If I'm missing
> a prior example of this then let me know - I haven't really looked :)

intensity_uv is documented as unit-less currently;
not sure if we can suggest a unit after-the-fact; drivers may use _SCALE 
to set a gain, and not care about the unit

other chips such as the AS7262 are using micro W/cm2;
our channel modifiers (both, clear, uv, red, green blue) may not be 
sufficient for spectral sensors (6 visible channels at 450, 500, 550, 570, 
600, 650 -- AS7262; NIR channels at 610, 680, 730, 760, 810, 860 -- 
AS7263)

will post a v2 with your suggestions shortly, thanks for the review!
comments to your suggestions below...

regards, p.

> > ---
> >  drivers/iio/light/Kconfig    |  10 +
> >  drivers/iio/light/Makefile   |   1 +
> >  drivers/iio/light/zopt2201.c | 563 +++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 574 insertions(+)
> >  create mode 100644 drivers/iio/light/zopt2201.c
> > 
> > diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> > index 2356ed9285df..6a5835fab32e 100644
> > --- a/drivers/iio/light/Kconfig
> > +++ b/drivers/iio/light/Kconfig
> > @@ -425,4 +425,14 @@ config VL6180
> >  	 To compile this driver as a module, choose M here: the
> >  	 module will be called vl6180.
> >  
> > +config ZOPT2201
> > +	tristate "ZOPT2201 ALS and UV B sensor"
> > +	depends on I2C
> > +	help
> > +	 Say Y here if you want to build a driver for the IDT
> > +	 ZOPT2201 ambient light and UV B sensor.
> > +
> > +	 To compile this driver as a module, choose M here: the
> > +	 module will be called zopt2201.
> > +
> >  endmenu
> > diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> > index fa32fa459e2e..d99abdf6b746 100644
> > --- a/drivers/iio/light/Makefile
> > +++ b/drivers/iio/light/Makefile
> > @@ -40,3 +40,4 @@ obj-$(CONFIG_US5182D)		+= us5182d.o
> >  obj-$(CONFIG_VCNL4000)		+= vcnl4000.o
> >  obj-$(CONFIG_VEML6070)		+= veml6070.o
> >  obj-$(CONFIG_VL6180)		+= vl6180.o
> > +obj-$(CONFIG_ZOPT2201)		+= zopt2201.o
> > diff --git a/drivers/iio/light/zopt2201.c b/drivers/iio/light/zopt2201.c
> > new file mode 100644
> > index 000000000000..07b299642ac3
> > --- /dev/null
> > +++ b/drivers/iio/light/zopt2201.c
> > @@ -0,0 +1,563 @@
> > +/*
> > + * zopt2201.c - Support for IDT ZOPT2201 ambient light and UV B sensor
> > + *
> > + * Copyright 2017 Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> > + *
> > + * This file is subject to the terms and conditions of version 2 of
> > + * the GNU General Public License.  See the file COPYING in the main
> > + * directory of this archive for more details.
> > + *
> > + * Datasheet: https://www.idt.com/document/dst/zopt2201-datasheet
> > + * 7-bit I2C slave addresses 0x53 (default) or 0x52 (programmed)
> > + *
> > + * TODO: interrupt support, ALS/UVB raw mode
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/i2c.h>
> > +#include <linux/mutex.h>
> > +#include <linux/err.h>
> > +#include <linux/delay.h>
> > +
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +
> > +#define ZOPT2201_DRV_NAME "zopt2201"
> > +
> > +/* Registers */
> > +#define ZOPT2201_MAIN_CTRL		0x00
> > +#define ZOPT2201_LS_MEAS_RATE		0x04
> > +#define ZOPT2201_LS_GAIN		0x05
> > +#define ZOPT2201_PART_ID		0x06
> > +#define ZOPT2201_MAIN_STATUS		0x07
> > +#define ZOPT2201_ALS_DATA		0x0d /* LSB first, 13 to 20 bits */
> > +#define ZOPT2201_UVB_DATA		0x10 /* LSB first, 13 to 20 bits */
> > +#define ZOPT2201_UV_COMP_DATA		0x13 /* LSB first, 13 to 20 bits */
> > +#define ZOPT2201_COMP_DATA		0x16 /* LSB first, 13 to 20 bits */
> > +#define ZOPT2201_INT_CFG		0x19
> > +#define ZOPT2201_INT_PST		0x1a
> > +
> > +#define ZOPT2201_MAIN_CTRL_LS_MODE	BIT(3) /* 0 .. ALS, 1 .. UV B */
> > +#define ZOPT2201_MAIN_CTRL_LS_EN	BIT(1)
> > +
> > +/* Values for ZOPT2201_LS_MEAS_RATE resolution / bit width */
> > +#define ZOPT2201_MEAS_RES_20BIT		0 /* takes 400 ms */
> > +#define ZOPT2201_MEAS_RES_19BIT		1 /* takes 200 ms */
> > +#define ZOPT2201_MEAS_RES_18BIT		2 /* takes 100 ms, default */
> > +#define ZOPT2201_MEAS_RES_17BIT		3 /* takes 50 ms */
> > +#define ZOPT2201_MEAS_RES_16BIT		4 /* takes 25 ms */
> > +#define ZOPT2201_MEAS_RES_13BIT		5 /* takes 3.125 ms */
> > +#define ZOPT2201_MEAS_RES_SHIFT		4
> > +
> > +/* Values for ZOPT2201_LS_MEAS_RATE measurement rate */
> > +#define ZOPT2201_MEAS_FREQ_25MS		0
> > +#define ZOPT2201_MEAS_FREQ_50MS		1
> > +#define ZOPT2201_MEAS_FREQ_100MS	2 /* default */
> > +#define ZOPT2201_MEAS_FREQ_200MS	3
> > +#define ZOPT2201_MEAS_FREQ_500MS	4
> > +#define ZOPT2201_MEAS_FREQ_1000MS	5
> > +#define ZOPT2201_MEAS_FREQ_2000MS	6
> > +
> > +/* Values for ZOPT2201_LS_GAIN */
> > +#define ZOPT2201_LS_GAIN_1		0
> > +#define ZOPT2201_LS_GAIN_3		1
> > +#define ZOPT2201_LS_GAIN_6		2
> > +#define ZOPT2201_LS_GAIN_9		3
> > +#define ZOPT2201_LS_GAIN_18		4
> > +
> > +/* Values for ZOPT2201_MAIN_STATUS */
> > +#define ZOPT2201_MAIN_STATUS_POWERON	BIT(5)
> > +#define ZOPT2201_MAIN_STATUS_INT	BIT(4)
> > +#define ZOPT2201_MAIN_STATUS_DRDY	BIT(3)
> > +
> > +#define ZOPT2201_PART_NUMBER		0xb2
> > +
> > +struct zopt2201_data {
> > +	struct i2c_client *client;
> > +	struct mutex lock;
> > +	u8 gain;
> > +	u8 res;
> > +	u8 rate;
> > +};
> > +
> > +enum zopt2201_mode {
> > +	ZOPT2201_MODE_ALS,
> > +	ZOPT2201_MODE_UVB,
> > +};
> > +
> > +static const struct {
> > +	unsigned int gain; /* gain factor */
> > +	unsigned int scale; /* micro lux per count */
> > +} zopt2201_gain_als[] = {
> > +	{  1, 19200000 },
> > +	{  3,  6400000 },
> > +	{  6,  3200000 },
> > +	{  9,  2133333 },
> > +	{ 18,  1066666 },
> > +};
> > +
> > +static const struct {
> > +	unsigned int gain; /* gain factor */
> > +	unsigned int scale; /* micro W/cm2 per count */
> 
> I think docs need to be updated to cover having units for
> uv. Certainly good to assign units if we can to intensity
> channels.
> 
> Hmm. micro W / cm2 so 0.001W/((0.01*0.01)m^2)

micro W/cm2 so 0.000001W/cm2 so 0.01W/m^2 ?

> If we are going to define a unit I'd prefer we ended up with
> w/m^2 and hence SI unit.

I have changed the scale factor so that the driver now reports W/m^2;
the comment above ("micro W/cm2 per count") was incorrect, in fact the 
values related to pico W/cm2
 
> > +} zopt2201_gain_uvb[] = {
> > +	{  1, 46080000 },
> > +	{  3, 15360000 },
> > +	{  6,  7680000 },
> > +	{  9,  5120000 },
> > +	{ 18,  2560000 },
> > +};
> > +
> > +static const struct {
> > +	unsigned int bits; /* sensor resolution in bits */
> > +	unsigned long us; /* measurement time in micro seconds */
> > +} zopt2201_resolution[] = {
> > +	{ 20, 400000 },
> > +	{ 19, 200000 },
> > +	{ 18, 100000 },
> > +	{ 17,  50000 },
> > +	{ 16,  25000 },
> > +	{ 13,   3125 },
> > +};
> > +
> > +static const struct {
> > +	unsigned int scale, uscale; /* scale factor as integer + micro */
> > +	u8 gain; /* gain register value */
> > +	u8 res; /* resolution register value */
> > +} zopt2201_scale_als[] = {
> > +	{ 19, 200000, 0, 5 },
> > +	{  6, 400000, 1, 5 },
> > +	{  3, 200000, 2, 5 },
> > +	{  2, 400000, 0, 4 },
> > +	{  2, 133333, 3, 5 },
> > +	{  1, 200000, 0, 3 },
> > +	{  1,  66666, 4, 5 },
> > +	{  0, 800000, 1, 4 },
> > +	{  0, 600000, 0, 2 },
> > +	{  0, 400000, 2, 4 },
> > +	{  0, 300000, 0, 1 },
> > +	{  0, 266666, 3, 4 },
> > +	{  0, 200000, 2, 3 },
> > +	{  0, 150000, 0, 0 },
> > +	{  0, 133333, 4, 4 },
> > +	{  0, 100000, 2, 2 },
> > +	{  0,  66666, 4, 3 },
> > +	{  0,  50000, 2, 1 },
> > +	{  0,  33333, 4, 2 },
> > +	{  0,  25000, 2, 0 },
> > +	{  0,  16666, 4, 1 },
> > +	{  0,   8333, 4, 0 },
> > +};
> > +
> > +static const struct {
> > +	unsigned int scale, uscale; /* scale factor as integer + micro */
> > +	u8 gain; /* gain register value */
> > +	u8 res; /* resolution register value */
> > +} zopt2201_scale_uvb[] = {
> > +	{ 46,  80000, 0, 5 },
> > +	{ 15, 360000, 1, 5 },
> > +	{  7, 680000, 2, 5 },
> > +	{  5, 760000, 0, 4 },
> > +	{  5, 120000, 3, 5 },
> > +	{  2, 880000, 0, 3 },
> > +	{  2, 560000, 4, 5 },
> > +	{  1, 920000, 1, 4 },
> > +	{  1, 440000, 0, 2 },
> > +	{  0, 960000, 2, 4 },
> > +	{  0, 720000, 0, 1 },
> > +	{  0, 640000, 3, 4 },
> > +	{  0, 480000, 2, 3 },
> > +	{  0, 360000, 0, 0 },
> > +	{  0, 320000, 4, 4 },
> > +	{  0, 240000, 2, 2 },
> > +	{  0, 160000, 4, 3 },
> > +	{  0, 120000, 2, 1 },
> > +	{  0,  80000, 4, 2 },
> > +	{  0,  60000, 2, 0 },
> > +	{  0,  40000, 4, 1 },
> > +	{  0,  20000, 4, 0 },
> > +};
> > +
> > +static int zopt2201_enable_mode(struct zopt2201_data *data,
> > +				enum zopt2201_mode mode)
> > +{
> > +	u8 out = ZOPT2201_MAIN_CTRL_LS_EN;
> > +
> > +	if (mode == ZOPT2201_MODE_UVB)
> > +		out |= ZOPT2201_MAIN_CTRL_LS_MODE;
> > +
> > +	return i2c_smbus_write_byte_data(data->client, ZOPT2201_MAIN_CTRL, out);
> > +}
> > +
> > +static int zopt2201_read(struct zopt2201_data *data, enum zopt2201_mode mode)
> > +{
> > +	struct i2c_client *client = data->client;
> > +	int tries = 10;
> > +	u8 buf[3];
> > +	int ret;
> > +
> > +	mutex_lock(&data->lock);
> > +	ret = zopt2201_enable_mode(data, mode);
> > +	if (ret < 0)
> > +		goto fail;
> > +
> > +	while (tries--) {
> > +		unsigned long t = zopt2201_resolution[data->res].us;
> > +
> > +		if (t <= 20000)
> > +			usleep_range(t, t + 1000);
> > +		else
> > +			msleep(t / 1000);
> > +		ret = i2c_smbus_read_byte_data(client, ZOPT2201_MAIN_STATUS);
> > +		if (ret < 0)
> > +			goto fail;
> > +		if (ret & ZOPT2201_MAIN_STATUS_DRDY)
> > +			break;
> > +	}
> > +
> > +	if (tries < 0) {
> > +		ret = -ETIMEDOUT;
> > +		goto fail;
> > +	}
> > +
> > +	ret = i2c_smbus_read_i2c_block_data(client, mode == ZOPT2201_MODE_UVB ?
> > +		ZOPT2201_UVB_DATA : ZOPT2201_ALS_DATA, sizeof(buf), buf);
> Having a ternary buried in there is a little hard to read.  Please pull it
> out as a local variable assignment.

OK, actually I've dropped the mode enum and will use the corresponding 
register address directly (saves some lines)
 
> > +	if (ret < 0)
> > +		goto fail;
> > +
> > +	ret = i2c_smbus_write_byte_data(client, ZOPT2201_MAIN_CTRL, 0x00);
> > +	if (ret < 0)
> > +		goto fail;
> > +	mutex_unlock(&data->lock);
> > +
> > +	return (buf[2] << 16) | (buf[1] << 8) | buf[0];
> > +
> > +fail:
> > +	mutex_unlock(&data->lock);
> > +	return ret;
> > +}
> > +
> > +static const struct iio_chan_spec zopt2201_channels[] = {
> > +	{
> > +		.type = IIO_LIGHT,
> > +		.address = ZOPT2201_MODE_ALS,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE),
> > +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> > +	},
> > +	{
> > +		.type = IIO_INTENSITY,
> > +		.modified = 1,
> > +		.channel2 = IIO_MOD_LIGHT_UV,
> > +		.address = ZOPT2201_MODE_UVB,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE),
> > +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> > +	},
> > +	{
> > +		.type = IIO_UVINDEX,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> > +	},
> > +};
> > +
> > +static int zopt2201_read_raw(struct iio_dev *indio_dev,
> > +				struct iio_chan_spec const *chan,
> > +				int *val, int *val2, long mask)
> > +{
> > +	struct zopt2201_data *data = iio_priv(indio_dev);
> > +	u64 tmp;
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret = zopt2201_read(data, chan->address);
> > +		if (ret < 0)
> > +			return ret;
> > +		*val = ret;
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_PROCESSED:
> > +		ret = zopt2201_read(data, ZOPT2201_MODE_UVB);
> > +		if (ret < 0)
> > +			return ret;
> > +		*val = ret * 18 *
> > +			(1 << (20 - zopt2201_resolution[data->res].bits)) /
> > +			zopt2201_gain_uvb[data->gain].gain;
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		switch (chan->address) {
> > +		case ZOPT2201_MODE_ALS:
> > +			*val = zopt2201_gain_als[data->gain].scale;
> 
> This is documented above as micro lux, but illuminance ABI is in
> lux.

the scale factors above are given in micro lux

the code below the switch statement basically divides by 1000000 (I could 
have used IIO_VAL_FRACTIONAL, but that would use format string "%d.%09u" while 
everything else here uses "%d.%06u")

the resulting unit is Lux in fact

> > +			break;
> > +		case ZOPT2201_MODE_UVB:
> > +			*val = zopt2201_gain_uvb[data->gain].scale;
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +
> > +		*val2 = 1000000;
> > +		*val2 *= (1 << (zopt2201_resolution[data->res].bits - 13));
> > +		tmp = div_s64(*val * 1000000ULL, *val2);
> > +		*val = div_s64_rem(tmp, 1000000, val2);
> > +
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	case IIO_CHAN_INFO_INT_TIME:
> > +		*val = 0;
> > +		*val2 = zopt2201_resolution[data->res].us;
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int zopt2201_set_resolution(struct zopt2201_data *data, u8 res)
> > +{
> > +	int ret;
> > +
> > +	ret = i2c_smbus_write_byte_data(data->client, ZOPT2201_LS_MEAS_RATE,
> > +					(res << ZOPT2201_MEAS_RES_SHIFT) |
> > +					data->rate);
> > +	if (ret >= 0)
> > +		data->res = res;
> 
> Same as the case below - prefer the error case indented.  Just that
> tiny bit nicer to read and means that when a reviewer scan's past it
> they won't stop to check what is going on...

OK
 
> > +
> > +	return ret;
> > +}
> > +
> > +static int zopt2201_write_resolution(struct zopt2201_data *data,
> > +				     int val, int val2)
> > +{
> > +	int i, ret;
> > +
> > +	if (val != 0)
> > +		return -EINVAL;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(zopt2201_resolution); i++)
> > +		if (val2 == zopt2201_resolution[i].us) {
> > +			mutex_lock(&data->lock);
> > +			ret = zopt2201_set_resolution(data, i);
> > +			mutex_unlock(&data->lock);
> > +			return ret;
> > +		}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static int zopt2201_set_gain(struct zopt2201_data *data, u8 gain)
> > +{
> > +	int ret;
> > +
> > +	ret = i2c_smbus_write_byte_data(data->client, ZOPT2201_LS_GAIN, gain);
> > +	if (ret >= 0)
> > +		data->gain = gain;
> 
> I'm a fuss pot about this, but I always like the indented one to be the
> error path.  It adds a line of code, but it's easier to follow

fair enough
 
> 	if (ret < 0)
> 		return ret;
> 
> 	data->gain = gain;
> 
> 	return 0;
> > +
> > +	return ret;
> > +}
> > +
> > +static int zopt2201_write_scale_als(struct zopt2201_data *data,
> > +				     int val, int val2)
> > +{
> > +	int i, ret;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(zopt2201_scale_als); i++)
> > +		if (val == zopt2201_scale_als[i].scale &&
> > +		    val2 == zopt2201_scale_als[i].uscale) {
> > +
> This is very deeply indented and it hurting readability.
> Perhaps a little utility function to handle the actual
> configuring might help?

yes, code is a bit clearer
 
> static int zopt2201_write_scale_als_by_idx(struct zopt2201_data *data, int index)
> {
> 	int ret;
> 
> 	mutex_lock(&data->lock);
> 	ret = zopt2201_set_resolution(data, zopt2201_scale_als[i].res);
> 	if (ret < 0)
> 		goto unlock;
> 
> 	ret = zopt2201_set_gain(data, zopt2201_scale_als[i].gain);
> 
> unlock:
> 	mutex_unlock(&data->lock);
> 	return ret;	
> }
> 
> static int zopt2201_write_scale_als(struct zopt2201_data *data,
> 				     int val, int val2)
> {
> 	int i, ret;
> 
> 	for (i = 0; i < ARRAY_SIZE(zopt2201_scale_als); i++)
> 		if (val == zopt2201_scale_als[i].scale &&
> 		    val2 == zopt2201_scale_als[i].uscale) {
> 			return zopt2201_write_scale_als_by_idx(data, i);
> 	return -EINVAL;
> }
> 
> Plus equivalent for the next one below.
> 
> > +			mutex_lock(&data->lock);
> > +			ret = zopt2201_set_resolution(data,
> > +				zopt2201_scale_als[i].res);
> > +			if (ret < 0)
> > +				goto fail;
> > +			ret = zopt2201_set_gain(data,
> > +				zopt2201_scale_als[i].gain);
> > +
> > +fail:
> > +			mutex_unlock(&data->lock);
> > +			return ret;
> > +		}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static int zopt2201_write_scale_uvb(struct zopt2201_data *data,
> > +				     int val, int val2)
> > +{
> > +	int i, ret;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(zopt2201_scale_uvb); i++)
> > +		if (val == zopt2201_scale_uvb[i].scale &&
> > +		    val2 == zopt2201_scale_uvb[i].uscale) {
> > +			mutex_lock(&data->lock);
> > +			ret = zopt2201_set_resolution(data,
> > +				zopt2201_scale_uvb[i].res);
> > +			if (ret < 0)
> > +				goto fail;
> > +			ret = zopt2201_set_gain(data,
> > +				zopt2201_scale_uvb[i].gain);
> > +
> > +fail:
> > +			mutex_unlock(&data->lock);
> > +			return ret;
> > +		}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static int zopt2201_write_raw(struct iio_dev *indio_dev,
> > +			      struct iio_chan_spec const *chan,
> > +			      int val, int val2, long mask)
> > +{
> > +	struct zopt2201_data *data = iio_priv(indio_dev);
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_INT_TIME:
> > +		return zopt2201_write_resolution(data, val, val2);
> > +	case IIO_CHAN_INFO_SCALE:
> > +		switch (chan->address) {
> > +		case ZOPT2201_MODE_ALS:
> > +			return zopt2201_write_scale_als(data, val, val2);
> > +		case ZOPT2201_MODE_UVB:
> > +			return zopt2201_write_scale_uvb(data, val, val2);
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static ssize_t zopt2201_show_int_time_available(struct device *dev,
> > +						struct device_attribute *attr,
> > +						char *buf)
> > +{
> > +	size_t len = 0;
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(zopt2201_resolution); i++)
> > +		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%06lu ",
> > +				 zopt2201_resolution[i].us);
> > +	buf[len - 1] = '\n';
> > +
> > +	return len;
> > +}
> > +
> > +static IIO_DEV_ATTR_INT_TIME_AVAIL(zopt2201_show_int_time_available);
> > +
> 
> One blank line is enough...

Sure
 
> > +
> > +static ssize_t zopt2201_show_als_scale_avail(struct device *dev,
> > +					     struct device_attribute *attr,
> > +					     char *buf)
> > +{
> > +	ssize_t len = 0;
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(zopt2201_scale_als); i++)
> > +		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06u ",
> > +				 zopt2201_scale_als[i].scale,
> > +				 zopt2201_scale_als[i].uscale);
> > +	buf[len - 1] = '\n';
> > +
> > +	return len;
> > +}
> > +
> > +static ssize_t zopt2201_show_uvb_scale_avail(struct device *dev,
> > +					     struct device_attribute *attr,
> > +					     char *buf)
> > +{
> > +	ssize_t len = 0;
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(zopt2201_scale_uvb); i++)
> > +		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06u ",
> > +				 zopt2201_scale_uvb[i].scale,
> > +				 zopt2201_scale_uvb[i].uscale);
> > +	buf[len - 1] = '\n';
> > +
> > +	return len;
> > +}
> > +
> > +static IIO_DEVICE_ATTR(in_illuminance_scale_available, 0444,
> > +		       zopt2201_show_als_scale_avail, NULL, 0);
> > +static IIO_DEVICE_ATTR(in_intensity_uv_scale_available, 0444,
> > +		       zopt2201_show_uvb_scale_avail, NULL, 0);
> > +
> > +static struct attribute *zopt2201_attributes[] = {
> > +	&iio_dev_attr_integration_time_available.dev_attr.attr,
> > +	&iio_dev_attr_in_illuminance_scale_available.dev_attr.attr,
> > +	&iio_dev_attr_in_intensity_uv_scale_available.dev_attr.attr,
> > +	NULL
> > +};
> > +
> > +static const struct attribute_group zopt2201_attribute_group = {
> > +	.attrs = zopt2201_attributes,
> > +};
> > +
> 
> Only 1 blank line.

OK
 
> > +
> > +static const struct iio_info zopt2201_info = {
> > +	.read_raw = zopt2201_read_raw,
> > +	.write_raw = zopt2201_write_raw,
> > +	.attrs = &zopt2201_attribute_group,
> > +};
> > +
> > +static int zopt2201_probe(struct i2c_client *client,
> > +			  const struct i2c_device_id *id)
> > +{
> > +	struct zopt2201_data *data;
> > +	struct iio_dev *indio_dev;
> > +	int ret;
> > +
> > +	if (!i2c_check_functionality(client->adapter,
> > +				     I2C_FUNC_SMBUS_READ_I2C_BLOCK))
> > +		return -EOPNOTSUPP;
> > +
> > +	ret = i2c_smbus_read_byte_data(client, ZOPT2201_PART_ID);
> > +	if (ret < 0)
> > +		return ret;
> > +	if (ret != ZOPT2201_PART_NUMBER)
> > +		return -ENODEV;
> > +
> > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	data = iio_priv(indio_dev);
> > +	i2c_set_clientdata(client, indio_dev);
> > +	data->client = client;
> > +	mutex_init(&data->lock);
> > +
> > +	indio_dev->dev.parent = &client->dev;
> > +	indio_dev->info = &zopt2201_info;
> > +	indio_dev->channels = zopt2201_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(zopt2201_channels);
> > +	indio_dev->name = ZOPT2201_DRV_NAME;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +	data->rate = ZOPT2201_MEAS_FREQ_100MS;
> > +	ret = zopt2201_set_resolution(data, ZOPT2201_MEAS_RES_18BIT);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = zopt2201_set_gain(data, ZOPT2201_LS_GAIN_3);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return devm_iio_device_register(&client->dev, indio_dev);
> > +}
> > +
> > +static const struct i2c_device_id zopt2201_id[] = {
> > +	{ "zopt2201", 0 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, zopt2201_id);
> 
> Hmm. I wonder if we should be adding device tree bindings for
> pretty much all drivers now.  There is on going effort to
> drop the compatibility code that loads them based on the
> i2c device table.  Anyhow, can be a follow up patch so
> not a problem right now.

agree
 
> > +
> > +static struct i2c_driver zopt2201_driver = {
> > +	.driver = {
> > +		.name   = ZOPT2201_DRV_NAME,
> > +	},
> > +	.probe  = zopt2201_probe,
> > +	.id_table = zopt2201_id,
> > +};
> > +
> > +module_i2c_driver(zopt2201_driver);
> > +
> > +MODULE_AUTHOR("Peter Meerwald-Stadler <pmeerw@pmeerw.net>");
> > +MODULE_DESCRIPTION("IDT ZOPT2201 ambient light and UV B sensor driver");
> > +MODULE_LICENSE("GPL");
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
