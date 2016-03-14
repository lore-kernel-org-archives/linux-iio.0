Return-Path: <tiberiu.a.breana@intel.com>
From: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: "Baluta, Daniel" <daniel.baluta@intel.com>
Subject: RE: [PATCH 1/2] iio: temperature: Add support for MAX31722/MAX31723
 temperature sensors
Date: Mon, 14 Mar 2016 13:45:29 +0000
Message-ID: <4586F61A4A291F4DA44D32824E7C0F4023568C26@IRSMSX109.ger.corp.intel.com>
References: <1457530252-4984-1-git-send-email-tiberiu.a.breana@intel.com>
 <1457530252-4984-2-git-send-email-tiberiu.a.breana@intel.com>
 <56E3E807.8040408@kernel.org>
In-Reply-To: <56E3E807.8040408@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: Saturday, March 12, 2016 11:57 AM
> To: Breana, Tiberiu A <tiberiu.a.breana@intel.com>; linux-
> iio@vger.kernel.org
> Subject: Re: [PATCH 1/2] iio: temperature: Add support for
> MAX31722/MAX31723 temperature sensors
>=20
> On 09/03/16 13:30, Tiberiu Breana wrote:
> > Add basic support for the Maxim Integrated MAX31722/MAX31723 SPI
> > temperature sensors / thermostats.
> >
> > Includes:
> > 	- ACPI support;
> > 	- raw temperature readings;
> > 	- ability to set measurement resolution;
> > 	- power management
> >
> > Datasheet:
> > https://datasheets.maximintegrated.com/en/ds/MAX31722-
> MAX31723.pdf
> >
> > Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
> I thought I'd give this a quick review, putting aside the question of whe=
ther it
> should be in IIO at all.

What are the criteria for a temperature driver to be in IIO vs hwmon? I see=
 there's another temperature sensor in IIO - TSYS01 (http://www.meas-spec.c=
om/product/temperature/TSYS01.aspx) which is used for "Industrial Control, =
Replacement of Thermistors and NTCs, Heating / Cooling Systems, HVAC".

>=20
> A few really trivial suggestions, but otherwise a nice clean driver.
>=20
> Jonathan
> > ---
> >  drivers/iio/temperature/Kconfig    |  12 ++
> >  drivers/iio/temperature/Makefile   |   1 +
> >  drivers/iio/temperature/max31722.c | 374
> > +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 387 insertions(+)
> >  create mode 100644 drivers/iio/temperature/max31722.c
> >
> > diff --git a/drivers/iio/temperature/Kconfig
> > b/drivers/iio/temperature/Kconfig index c4664e5..7587887 100644
> > --- a/drivers/iio/temperature/Kconfig
> > +++ b/drivers/iio/temperature/Kconfig
> > @@ -3,6 +3,18 @@
> >  #
> >  menu "Temperature sensors"
> >
> > +config MAX31722
> > +	tristate "MAX31722 temperature sensor"
> > +	depends on SPI
> > +	select REGMAP_SPI
> > +	help
> > +	  If you say yes here you get support for the Maxim Integrated
> > +	  MAX31722/MAX31723 digital thermometers / thermostats
> operating
> > +	  over an SPI interface.
> > +
> > +	  This driver can also be built as a module. If so, the module will
> > +	  be called max31722.
> > +
> >  config MLX90614
> >  	tristate "MLX90614 contact-less infrared sensor"
> >  	depends on I2C
> > diff --git a/drivers/iio/temperature/Makefile
> > b/drivers/iio/temperature/Makefile
> > index 02bc79d..a9484d6 100644
> > --- a/drivers/iio/temperature/Makefile
> > +++ b/drivers/iio/temperature/Makefile
> > @@ -2,6 +2,7 @@
> >  # Makefile for industrial I/O temperature drivers  #
> >
> > +obj-$(CONFIG_MAX31722) +=3D max31722.o
> >  obj-$(CONFIG_MLX90614) +=3D mlx90614.o
> >  obj-$(CONFIG_TMP006) +=3D tmp006.o
> >  obj-$(CONFIG_TSYS01) +=3D tsys01.o
> > diff --git a/drivers/iio/temperature/max31722.c
> > b/drivers/iio/temperature/max31722.c
> > new file mode 100644
> > index 0000000..fa833b6
> > --- /dev/null
> > +++ b/drivers/iio/temperature/max31722.c
> > @@ -0,0 +1,374 @@
> > +/**
> > + * MAX31722/MAX31723 digital thermometer and thermostat SPI driver
> > + *
> > + * Copyright (c) 2016, Intel Corporation.
> > + *
> > + * This file is subject to the terms and conditions of version 2 of
> > + * the GNU General Public License. See the file COPYING in the main
> > + * directory of this archive for more details.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/acpi.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +
> > +#define MAX31722_REG_CFG				0x00
> > +#define MAX31722_REG_TEMP_LSB			0x01
> > +#define MAX31722_REG_TEMP_MSB			0x02
> > +#define MAX31722_MAX_REG				0x86
> > +
> > +#define MAX31722_MODE_CONTINUOUS		0x00
> > +#define MAX31722_MODE_STANDBY			0x01
> > +
> > +#define MAX31722_REGMAP_NAME
> 	"max31722_regmap"
> > +
> > +#define MAX31722_SCALE_AVAILABLE		"0.5 0.25 0.125
> 0.0625"
> > +
> > +#define MAX31722_REGFIELD(name)
> 		 \
> > +	do {								 \
> > +		data->reg_##name =3D					 \
> > +			devm_regmap_field_alloc(&spi->dev, regmap,	 \
> > +				max31722_reg_field_##name);
> 	 \
> > +		if (IS_ERR(data->reg_##name)) {
> 	 \
> > +			dev_err(&spi->dev, "reg field alloc failed.\n"); \
> > +			return PTR_ERR(data->reg_##name);		 \
> > +		}							 \
> > +	} while (0)
> > +
> > +static const struct reg_field max31722_reg_field_state =3D
> > +				REG_FIELD(MAX31722_REG_CFG, 0, 0); static
> const struct reg_field
> > +max31722_reg_field_resolution =3D
> > +				REG_FIELD(MAX31722_REG_CFG, 1, 2);
> > +
> > +struct max31722_data {
> > +	struct spi_device *spi_device;
> > +	struct mutex lock;
> > +	struct regmap *regmap;
> > +	struct regmap_field *reg_state;
> > +	struct regmap_field *reg_resolution; };
> > +
> > +/*
> > + * This table can double as a negative exponent value lookup table
> > + * (as micro units) for calculating LSB temperature values.
> > + */
> > +static const int max31722_scale_table[4] =3D {
> > +	500000, 250000, 125000, 62500
> > +};
> > +
> > +static IIO_CONST_ATTR(in_temp_scale_available,
> > +MAX31722_SCALE_AVAILABLE);
> > +
> > +static struct attribute *max31722_attributes[] =3D {
> > +	&iio_const_attr_in_temp_scale_available.dev_attr.attr,
> > +	NULL
> > +};
> > +
> > +static const struct attribute_group max31722_attribute_group =3D {
> > +	.attrs =3D max31722_attributes
> > +};
> > +
> > +static const struct iio_chan_spec max31722_channels[] =3D {
> > +	{
> > +		.type =3D IIO_TEMP,
> > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE),
> > +	},
> > +};
> > +
> > +static bool max31722_is_volatile_reg(struct device *dev, unsigned int
> > +reg) {
> > +	switch (reg) {
> > +	case MAX31722_REG_TEMP_LSB:
> > +	case MAX31722_REG_TEMP_MSB:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> > +static bool max31722_is_writeable_reg(struct device *dev, unsigned
> > +int reg) {
> > +	switch (reg) {
> > +	case MAX31722_REG_TEMP_LSB:
> > +	case MAX31722_REG_TEMP_MSB:
> > +		return false;
> > +	default:
> > +		return true;
> > +	}
> > +}
> > +
> > +static struct regmap_config max31722_regmap_config =3D {
> > +	.name =3D MAX31722_REGMAP_NAME,
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 8,
> > +
> > +	.max_register =3D MAX31722_MAX_REG,
> > +	.cache_type =3D REGCACHE_RBTREE,
> > +
> > +	.volatile_reg =3D max31722_is_volatile_reg,
> > +	.writeable_reg =3D max31722_is_writeable_reg,
> > +
> > +	.read_flag_mask =3D 0x00,
> > +	.write_flag_mask =3D 0x80,
> > +};
> > +
> > +/*
> > + * Convert a temperature register value to a floating point value.
> > + * Data is represented in 9-12 bits, two's complement.
> > + * The MSB contains the integer part of the temperature value
> > + * (signed), while the LSB contains the fractional part as
> > + * negative powers of 2, e.g.: bit 0 is 2^-1, bit 1 is 2^-2, etc.
> > + */
> > +static void max31722_reg_to_float(u16 reg_val, int *val, int *val2) {
> > +	int i;
> > +	u8 msb;
> > +	u8 lsb;
> > +
> > +	msb =3D reg_val >> 8;
> > +	lsb =3D (reg_val << 8) >> 8;
> > +
> > +	/* Calculate the integer part. */
> > +	if (msb & 0x80) {
> > +		/* Negative value. Reverse bits and add 1. */
> > +		u16 orig =3D reg_val;
> > +		u16 rev =3D 0;
> > +		int num_bits =3D sizeof(rev) * 8;
> > +
> > +		for (i =3D 0 ; i < num_bits ; i++) {
> > +			rev |=3D !(orig & 0x01) << i;
> > +			orig >>=3D 1;
> > +		}
> > +		rev +=3D 1;
> > +		msb =3D rev >> 8;
> > +		lsb =3D (rev << 8) >> 8;
> > +		*val =3D (-1) * msb;
> > +	} else { /* Positive value. */
> > +		*val =3D msb;
> > +	}
> > +
> > +	/*
> > +	 * Calculate the fractional part.
> > +	 * Only the first four LSB bits contain data.
> > +	 */
> > +	lsb >>=3D 4;
> > +	i =3D 0;
> > +	*val2 =3D 0;
> > +	while (i < 4) {
> > +		if ((lsb >> (4 - i - 1)) & 0x01)
> > +			*val2 +=3D max31722_scale_table[i];
> > +		lsb <<=3D 1;
> > +		lsb >>=3D 1;
> > +		i++;
> > +	}
> > +}
> > +
> > +static int max31722_read_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan,
> > +			     int *val, int *val2, long mask) {
> > +	int ret;
> > +	int index;
> > +	u16 buf;
> > +	struct max31722_data *data =3D iio_priv(indio_dev);
> > +	struct spi_device *spi =3D data->spi_device;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		mutex_lock(&data->lock);
> > +		ret =3D regmap_bulk_read(data->regmap,
> > +				       MAX31722_REG_TEMP_LSB, &buf, 2);
> > +		if (ret < 0) {
> > +			dev_err(&spi->dev, "failed to read temperature
> register\n");
> > +			mutex_unlock(&data->lock);
> > +			return ret;
> > +		}
> > +		max31722_reg_to_float(buf, val, val2);
> > +		mutex_unlock(&data->lock);
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		mutex_lock(&data->lock);
> > +		ret =3D regmap_field_read(data->reg_resolution, &index);
> > +		if (ret < 0) {
> > +			dev_err(&spi->dev, "failed to read configuration
> register\n");
> > +			mutex_unlock(&data->lock);
> > +			return ret;
> > +		}
> > +		mutex_unlock(&data->lock);
> > +		*val =3D 0;
> > +		*val2 =3D max31722_scale_table[index];
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static int max31722_write_raw(struct iio_dev *indio_dev,
> > +			      struct iio_chan_spec const *chan,
> > +			      int val, int val2, long mask) {
> > +	int i;
> > +	int ret;
> > +	int index =3D -1;
> > +	struct max31722_data *data =3D iio_priv(indio_dev);
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SCALE:
> > +		for (i =3D 0; i < ARRAY_SIZE(max31722_scale_table); i++) {
> > +			if (val =3D=3D 0 && val2 =3D=3D max31722_scale_table[i]) {
> > +				index =3D i;
> > +				break;
> > +			}
> > +		}
> > +		if (index < 0)
> > +			return -EINVAL;
> > +
> > +		mutex_lock(&data->lock);
> > +		ret =3D regmap_field_write(data->reg_resolution, index);
> > +		mutex_unlock(&data->lock);
> > +
> > +		return ret;
> > +	}
> > +	return -EINVAL;
> > +}
> > +
> > +static const struct iio_info max31722_info =3D {
> > +	.driver_module		=3D THIS_MODULE,
> > +	.read_raw		=3D max31722_read_raw,
> > +	.write_raw		=3D max31722_write_raw,
> > +	.attrs			=3D &max31722_attribute_group,
> > +};
> > +
> > +static int max31722_init(struct max31722_data *data) {
> > +	int ret =3D 0;
> > +	struct spi_device *spi =3D data->spi_device;
> > +	struct regmap *regmap;
> > +
> > +	/* Initialize the regmap */
> > +	regmap =3D devm_regmap_init_spi(spi, &max31722_regmap_config);
> > +	if (IS_ERR(regmap)) {
> > +		dev_err(&spi->dev, "regmap initialization failed.\n");
> > +		return PTR_ERR(regmap);
> > +	}
> > +	data->regmap =3D regmap;
> > +
> > +	MAX31722_REGFIELD(state);
> > +	MAX31722_REGFIELD(resolution);
> > +
> > +	/* Set SD bit to 0 so we can have continuous measurements. */
> > +	ret =3D regmap_field_write(data->reg_state,
> MAX31722_MODE_CONTINUOUS);
> > +	if (ret < 0)
> > +		dev_err(&spi->dev, "failed to configure sensor.\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static int max31722_probe(struct spi_device *spi) {
> > +	int ret;
> > +	struct iio_dev *indio_dev;
> > +	struct max31722_data *data;
> > +
> > +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*data));
> > +	if (!indio_dev) {
> > +		dev_err(&spi->dev, "iio allocation failed!\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	data =3D iio_priv(indio_dev);
> > +	data->spi_device =3D spi;
> > +	spi_set_drvdata(spi, indio_dev);
> > +	mutex_init(&data->lock);
> > +
> > +	indio_dev->dev.parent =3D &spi->dev;
> > +	indio_dev->info =3D &max31722_info;
> > +	indio_dev->name =3D spi_get_device_id(spi)->name;
> > +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +	indio_dev->channels =3D max31722_channels;
> > +	indio_dev->num_channels =3D ARRAY_SIZE(max31722_channels);
> > +
> > +	ret =3D max31722_init(data);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret =3D iio_device_register(indio_dev);
> > +	if (ret < 0) {
> > +		dev_err(&spi->dev, "iio_device_register failed\n");
> Given this statement is effectively unwinding max31722_init, would have a
> max31722_exit function as well with this in.  That makes for 'obviously
> correct' code which is always good for reviewers!
>=20
> Alternative would be to pull the mode setting out of the init function an=
d
> have it inline in this function making the pairing obvious as well.
>=20
> > +		regmap_field_write(data->reg_state,
> MAX31722_MODE_STANDBY);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int max31722_remove(struct spi_device *spi) {
> > +	struct max31722_data *data;
> > +	struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
> > +
> > +	iio_device_unregister(indio_dev);
> > +	data =3D iio_priv(indio_dev);
>=20
> I would have put this inline with the declaration of data above.
> It is pretty much the same level of lookup as spi_get_drvdata.
>=20
> > +
> > +	return regmap_field_write(data->reg_state,
> MAX31722_MODE_STANDBY); }
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static int max31722_suspend(struct device *dev) {
> > +	struct max31722_data *data;
> > +
> > +	data =3D iio_priv(spi_get_drvdata(to_spi_device(dev)));
> > +
> > +	return regmap_field_write(data->reg_state,
> MAX31722_MODE_STANDBY); }
> > +
> > +static int max31722_resume(struct device *dev) {
> > +	struct max31722_data *data;
> > +
> > +	data =3D iio_priv(spi_get_drvdata(to_spi_device(dev)));
> > +
> > +	return regmap_field_write(data->reg_state,
> > +MAX31722_MODE_CONTINUOUS); }
> > +
> > +static SIMPLE_DEV_PM_OPS(max31722_pm_ops, max31722_suspend,
> > +max31722_resume);
> > +
> > +#define MAX31722_PM_OPS (&max31722_pm_ops) #else #define
> > +MAX31722_PM_OPS NULL #endif
> > +
> > +static const struct spi_device_id max31722_spi_id[] =3D {
> > +	{"max31722", 0},
> > +	{"max31723", 0},
> > +	{}
> > +};
> > +
> > +static const struct acpi_device_id max31722_acpi_id[] =3D {
> > +	{"MAX31722", 0},
> > +	{"MAX31723", 0},
> > +	{}
> > +};
> > +
> > +MODULE_DEVICE_TABLE(spi, max31722_spi_id);
> > +
> > +static struct spi_driver max31722_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "max31722",
> > +		.pm =3D MAX31722_PM_OPS,
> > +		.acpi_match_table =3D ACPI_PTR(max31722_acpi_id),
> > +	},
> > +	.probe =3D            max31722_probe,
> > +	.remove =3D           max31722_remove,
> > +	.id_table =3D         max31722_spi_id,
> > +};
> > +
> > +module_spi_driver(max31722_driver);
> > +
> > +MODULE_AUTHOR("Tiberiu Breana <tiberiu.a.breana@intel.com>");
> > +MODULE_DESCRIPTION("MAX31722 digital thermometer and thermostat
> SPI
> > +driver"); MODULE_LICENSE("GPL v2");
> >
