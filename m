Return-Path: <peda@axentia.se>
From: Peter Rosin <peda@axentia.se>
To: Cristina Moraru <cristina.moraru09@gmail.com>, "jic23@kernel.org"
	<jic23@kernel.org>, "knaack.h@gmx.de" <knaack.h@gmx.de>, "lars@metafoo.de"
	<lars@metafoo.de>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"daniel.baluta@intel.com" <daniel.baluta@intel.com>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>
Subject: RE: [PATCH] iio: max5487: Add support for Maxim digital
 potentiometers
Date: Thu, 24 Mar 2016 21:46:43 +0000
Message-ID: <9dc210ed21cc467699ec0a33a62507f9@EMAIL.axentia.se>
References: <1458818485-2770-1-git-send-email-cristina.moraru09@gmail.com>
In-Reply-To: <1458818485-2770-1-git-send-email-cristina.moraru09@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Cristina,

Some comments inline...

Cheers,
Peter

Cristina Moraru wrote:
> Add implementation for Maxim MAX5487, MAX5488, MAX5489
> digital potentiometers.
>=20
> Signed-off-by: Cristina Moraru <cristina.moraru09@gmail.com>
> CC: Daniel Baluta <daniel.baluta@intel.com>
> ---
>  drivers/iio/potentiometer/Kconfig   |  11 +++
>  drivers/iio/potentiometer/Makefile  |   1 +
>  drivers/iio/potentiometer/max5487.c | 185 ++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 197 insertions(+)
>  create mode 100644 drivers/iio/potentiometer/max5487.c
>=20
> diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiomete=
r/Kconfig
> index ffc735c..3046c79 100644
> --- a/drivers/iio/potentiometer/Kconfig
> +++ b/drivers/iio/potentiometer/Kconfig
> @@ -5,6 +5,17 @@
> =20
>  menu "Digital potentiometers"
> =20
> +config MAX5487
> +        tristate "Maxim MAX5487/MAX5488/MAX5489  Digital Potentiometer d=
river"
> +        depends on SPI
> +        help
> +          Say yes here to build support for the Maxim
> +          MAX5487, MAX5488, MAX5489 digital potentiomenter
> +	  chips.

The whitespace on this line is different.

> +
> +          To compile this driver as a module, choose M here: the
> +          module will be called max5487.
> +
>  config MCP4531
>  	tristate "Microchip MCP45xx/MCP46xx Digital Potentiometer driver"
>  	depends on I2C
> diff --git a/drivers/iio/potentiometer/Makefile b/drivers/iio/potentiomet=
er/Makefile
> index b563b49..dcc791a 100644
> --- a/drivers/iio/potentiometer/Makefile
> +++ b/drivers/iio/potentiometer/Makefile
> @@ -3,5 +3,6 @@
>  #
> =20
>  # When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_MAX5487) +=3D max5487.o
>  obj-$(CONFIG_MCP4531) +=3D mcp4531.o
>  obj-$(CONFIG_TPL0102) +=3D tpl0102.o
> diff --git a/drivers/iio/potentiometer/max5487.c b/drivers/iio/potentiome=
ter/max5487.c
> new file mode 100644
> index 0000000..69db979
> --- /dev/null
> +++ b/drivers/iio/potentiometer/max5487.c
> @@ -0,0 +1,185 @@
> +/*
> + * max5487.c - Support for MAX5487, MAX5488, MAX5489 digital potentiomet=
ers
> + *
> + * Copyright (C) Cristina-Gabriela Moraru <cristina.moraru09@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/acpi.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/iio.h>
> +
> +#define MAX5487_DRV_NAME "max5487"
> +
> +#define MAX5487_WRITE_WIPER_A	0x01
> +#define MAX5487_WRITE_WIPER_B	0x02
> +
> +/* copy both wiper regs to NV regs */
> +#define MAX5487_COPY_AB_TO_NV	0x23
> +/* copy both NV regs to wiper regs */
> +#define MAX5487_COPY_NV_TO_AB	0x33
> +
> +enum {
> +	MAX5487,
> +	MAX5488,
> +	MAX5489,
> +};
> +
> +struct max5487_cfg {
> +	int wipers;
> +	int max_pos;
> +	int kohms;
> +};
> +
> +static const struct max5487_cfg max5487_cfg[] =3D {
> +	[MAX5487] =3D { .wipers =3D 2, .max_pos =3D 256, .kohms =3D  10,},
> +	[MAX5488] =3D { .wipers =3D 2, .max_pos =3D 256, .kohms =3D  50,},
> +	[MAX5489] =3D { .wipers =3D 2, .max_pos =3D 256, .kohms =3D  100,}
> +};

.wipers and .max_pos need not be in max5487_cfg, they are common.
.wipers isn't even used. Which means that if you like, you can
use the ohms reading as the driver_data directly instead of going
via the MAX548x enumeration, see below. Or is there some reason
not doing so?

> +
> +struct max5487_data {
> +	struct regmap *regmap;
> +	int chip_id;

I.e., change chip_id to kohms.

> +};
> +
> +#define MAX5487_CHANNEL(ch, addr) {				\
> +	.type =3D IIO_RESISTANCE,					\
> +	.indexed =3D 1,						\
> +	.output =3D 1,						\
> +	.channel =3D ch,						\
> +	.address =3D addr,					\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),	\
> +}
> +
> +static const struct iio_chan_spec max5487_channels[] =3D {
> +	MAX5487_CHANNEL(0, MAX5487_WRITE_WIPER_A),
> +	MAX5487_CHANNEL(1, MAX5487_WRITE_WIPER_B),
> +};
> +
> +static int max5487_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct max5487_data *data =3D iio_priv(indio_dev);
> +
> +	if (mask !=3D IIO_CHAN_INFO_SCALE)
> +		return -EINVAL;
> +
> +	*val =3D 1000 * max5487_cfg[data->chip_id].kohms;

Use data->kohms here.

> +	*val2 =3D max5487_cfg[data->chip_id].max_pos;

Hardcode this to 256 (using a define).

> +	return IIO_VAL_FRACTIONAL;
> +}
> +
> +static int max5487_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct max5487_data *data =3D iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (val < 0 || val >=3D max5487_cfg[data->chip_id].max_pos)

Hardcode to 256.

> +			return -EINVAL;
> +		return regmap_write(data->regmap, chan->address, val);
> +	default:
> +		return -EINVAL;
> +	}
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info max5487_info =3D {
> +	.read_raw =3D &max5487_read_raw,
> +	.write_raw =3D &max5487_write_raw,
> +	.driver_module =3D THIS_MODULE,
> +};
> +
> +static const struct regmap_config max5487_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +
> +	.max_register =3D MAX5487_COPY_NV_TO_AB,
> +};
> +
> +static int max5487_spi_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct max5487_data *data;
> +	const struct spi_device_id *id =3D spi_get_device_id(spi);
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&spi->dev, indio_dev);
> +	data =3D iio_priv(indio_dev);
> +
> +	data->regmap =3D devm_regmap_init_spi(spi, &max5487_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return PTR_ERR(data->regmap);
> +
> +	data->chip_id =3D id->driver_data;

Use data->kohms =3D id->driver_data

> +
> +	indio_dev->info =3D &max5487_info;
> +	indio_dev->name =3D id->name;
> +	indio_dev->dev.parent =3D &spi->dev;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->channels =3D max5487_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(max5487_channels);
> +
> +	/* restore both wiper regs from NV regs */
> +	ret =3D regmap_write(data->regmap, MAX5487_COPY_NV_TO_AB, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static int max5487_spi_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(&spi->dev);
> +	struct max5487_data *data =3D iio_priv(indio_dev);
> +
> +	/* save both wiper regs to NV regs */
> +	return regmap_write(data->regmap, MAX5487_COPY_AB_TO_NV, 0);
> +}
> +
> +static const struct spi_device_id max5487_id[] =3D {
> +	{ "MAX5487", MAX5487 },
> +	{ "MAX5488", MAX5488 },
> +	{ "MAX5489", MAX5489 },

Use 10, 50, and 100 instead of the MAX548x enums.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, max5487_id);
> +
> +static const struct acpi_device_id max5487_acpi_match[] =3D {
> +	{ "MAX5487", MAX5487 },
> +	{ "MAX5488", MAX5488 },
> +	{ "MAX5489", MAX5489 },

Dito.

> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, max5487_acpi_match);
> +
> +static struct spi_driver max5487_driver =3D {
> +	.driver =3D {
> +		.name =3D MAX5487_DRV_NAME,
> +		.owner =3D THIS_MODULE,
> +		.acpi_match_table =3D ACPI_PTR(max5487_acpi_match),
> +	},
> +	.id_table =3D max5487_id,
> +	.probe =3D max5487_spi_probe,
> +	.remove =3D max5487_spi_remove
> +};
> +module_spi_driver(max5487_driver);
> +
> +MODULE_AUTHOR("Cristina-Gabriela Moraru <cristina.moraru09@gmail.com>");
> +MODULE_DESCRIPTION("max5487 SPI driver");
> +MODULE_LICENSE("GPL v2");
> --=20
> 2.5.0
>=20
>
