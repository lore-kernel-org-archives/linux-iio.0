Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750932AbeETKXR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 May 2018 06:23:17 -0400
Date: Sun, 20 May 2018 11:23:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Silvan Murer <silvan.murer@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3] iio: dac: Add support for external reference voltage
 through the regulator framework.
Message-ID: <20180520112312.668e0213@archlinux>
In-Reply-To: <1526775557.32235.33.camel@gmail.com>
References: <1526775557.32235.33.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 20 May 2018 02:19:17 +0200
Silvan Murer <silvan.murer@gmail.com> wrote:

> Add support for external reference voltage through the regulator framewor=
k.
>=20
> Signed-off-by: Silvan Murer <silvan.murer@gmail.com>
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

Content looks fine, but I'm having the same issue with subtle issues with
patch formatting.  Please check and see if you can figure out what is
causing this.

Anyhow, I'd like this to sit on the lists a little longer to give
time for Devicetree binding feedback.

Thanks,

Jonathan

> ---
> Changes in v3:
> 	- remove extra spaces and tab
> Changes in v2:
> 	- Add 'optional properties' documentation
> 	- Return an error when a regulator is specified
> 	- Use internal reference when no regulator is specified
> 	- Use iio_device_register instead of devm_iio_device_register
>=20
> =C2=A0.../devicetree/bindings/iio/dac/ltc2632.txt=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0| 14 +++++
> =C2=A0drivers/iio/dac/ltc2632.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 70 +++++++++++++++++++---
> =C2=A02 files changed, 75 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt b/Docu=
mentation/devicetree/bindings/iio/dac/ltc2632.txt
> index eb911e5..e0d5fea 100644
> --- a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> +++ b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> @@ -12,12 +12,26 @@ Required properties:
> =C2=A0Property rules described in Documentation/devicetree/bindings/spi/s=
pi-bus.txt
> =C2=A0apply. In particular, "reg" and "spi-max-frequency" properties must=
 be given.
> =C2=A0
> +Optional properties:
> +	- vref-supply: Phandle to the external reference voltage supply. This s=
hould
> +	=C2=A0=C2=A0only be set if there is an external reference voltage conne=
cted to the VREF
> +	=C2=A0=C2=A0pin. If the property is not set the internal reference is u=
sed.
> +
> =C2=A0Example:
> =C2=A0
> +	vref: regulator-vref {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vref-ltc2632";
> +		regulator-min-microvolt =3D <1250000>;
> +		regulator-max-microvolt =3D <1250000>;
> +		regulator-always-on;
> +	};
> +
> =C2=A0	spi_master {
> =C2=A0		dac: ltc2632@0 {
> =C2=A0			compatible =3D "lltc,ltc2632-l12";
> =C2=A0			reg =3D <0>; /* CS0 */
> =C2=A0			spi-max-frequency =3D <1000000>;
> +			vref-supply =3D <&vref>; /* optional */
> =C2=A0		};
> =C2=A0	};
> diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
> index d322b78..9551156 100644
> --- a/drivers/iio/dac/ltc2632.c
> +++ b/drivers/iio/dac/ltc2632.c
> @@ -2,6 +2,7 @@
> =C2=A0 * LTC2632 Digital to analog convertors spi driver
> =C2=A0 *
> =C2=A0 * Copyright 2017 Maxime Roussin-B=C3=A9langer
> + * expanded by Silvan Murer <silvan.murer@gmail.com>
> =C2=A0 *
> =C2=A0 * Licensed under the GPL-2.
> =C2=A0 */
> @@ -10,6 +11,7 @@
> =C2=A0#include <linux/spi/spi.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/iio/iio.h>
> +#include <linux/regulator/consumer.h>
> =C2=A0
> =C2=A0#define LTC2632_DAC_CHANNELS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A02
> =C2=A0
> @@ -28,7 +30,7 @@
> =C2=A0/**
> =C2=A0 * struct ltc2632_chip_info - chip specific information
> =C2=A0 * @channels:		channel spec for the DAC
> - * @vref_mv:		reference voltage
> + * @vref_mv:		internal reference voltage
> =C2=A0 */
> =C2=A0struct ltc2632_chip_info {
> =C2=A0	const struct iio_chan_spec *channels;
> @@ -39,10 +41,14 @@ struct ltc2632_chip_info {
> =C2=A0 * struct ltc2632_state - driver instance specific data
> =C2=A0 * @spi_dev:			pointer to the spi_device struct
> =C2=A0 * @powerdown_cache_mask	used to show current channel powerdown sta=
te
> + * @vref_mv			used reference voltage (internal or external)
> + * @vref_reg		regulator for the reference voltage
> =C2=A0 */
> =C2=A0struct ltc2632_state {
> =C2=A0	struct spi_device *spi_dev;
> =C2=A0	unsigned int powerdown_cache_mask;
> +	int vref_mv;
> +	struct regulator *vref_reg;
> =C2=A0};
> =C2=A0
> =C2=A0enum ltc2632_supported_device_ids {
> @@ -90,7 +96,7 @@ static int ltc2632_read_raw(struct iio_dev *indio_dev,
> =C2=A0
> =C2=A0	switch (m) {
> =C2=A0	case IIO_CHAN_INFO_SCALE:
> -		*val =3D chip_info->vref_mv;
> +		*val =3D st->vref_mv;
> =C2=A0		*val2 =3D chan->scan_type.realbits;
> =C2=A0		return IIO_VAL_FRACTIONAL_LOG2;
> =C2=A0	}
> @@ -247,6 +253,45 @@ static int ltc2632_probe(struct spi_device *spi)
> =C2=A0	chip_info =3D (struct ltc2632_chip_info *)
> =C2=A0			spi_get_device_id(spi)->driver_data;
> =C2=A0
> +	st->vref_reg =3D devm_regulator_get_optional(&spi->dev, "vref");
> +	if (PTR_ERR(st->vref_reg) =3D=3D -ENODEV) {
> +		/* use internal reference voltage */
> +		st->vref_reg =3D NULL;
> +		st->vref_mv =3D chip_info->vref_mv;
> +
> +		ret =3D ltc2632_spi_write(spi, LTC2632_CMD_INTERNAL_REFER,
> +				0, 0, 0);
> +		if (ret) {
> +			dev_err(&spi->dev,
> +				"Set internal reference command failed, %d\n",
> +				ret);
> +			return ret;
> +		}
> +	} else if (IS_ERR(st->vref_reg)) {
> +		dev_err(&spi->dev,
> +				"Error getting voltage reference regulator\n");
> +		return PTR_ERR(st->vref_reg);
> +	} else {
> +		/* use external reference voltage */
> +		ret =3D regulator_enable(st->vref_reg);
> +		if (ret) {
> +			dev_err(&spi->dev,
> +				"enable reference regulator failed, %d\n",
> +				ret);
> +			return ret;
> +		}
> +		st->vref_mv =3D regulator_get_voltage(st->vref_reg) / 1000;
> +
> +		ret =3D ltc2632_spi_write(spi, LTC2632_CMD_EXTERNAL_REFER,
> +				0, 0, 0);
> +		if (ret) {
> +			dev_err(&spi->dev,
> +				"Set external reference command failed, %d\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
> =C2=A0	indio_dev->dev.parent =3D &spi->dev;
> =C2=A0	indio_dev->name =3D dev_of_node(&spi->dev) ? dev_of_node(&spi->dev=
)->name
> =C2=A0						=C2=A0: spi_get_device_id(spi)->name;
> @@ -255,14 +300,20 @@ static int ltc2632_probe(struct spi_device *spi)
> =C2=A0	indio_dev->channels =3D chip_info->channels;
> =C2=A0	indio_dev->num_channels =3D LTC2632_DAC_CHANNELS;
> =C2=A0
> -	ret =3D ltc2632_spi_write(spi, LTC2632_CMD_INTERNAL_REFER, 0, 0, 0);
> -	if (ret) {
> -		dev_err(&spi->dev,
> -			"Set internal reference command failed, %d\n", ret);
> -		return ret;
> -	}
> +	return iio_device_register(indio_dev);
> +}
> +
> +static int ltc2632_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
> +	struct ltc2632_state *st =3D iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	if (st->vref_reg)
> +		regulator_disable(st->vref_reg);
> =C2=A0
> -	return devm_iio_device_register(&spi->dev, indio_dev);
> +	return 0;
> =C2=A0}
> =C2=A0
> =C2=A0static const struct spi_device_id ltc2632_id[] =3D {
> @@ -306,6 +357,7 @@ static struct spi_driver ltc2632_driver =3D {
> =C2=A0		.of_match_table =3D of_match_ptr(ltc2632_of_match),
> =C2=A0	},
> =C2=A0	.probe		=3D ltc2632_probe,
> +	.remove		=3D ltc2632_remove,
> =C2=A0	.id_table	=3D ltc2632_id,
> =C2=A0};
> =C2=A0module_spi_driver(ltc2632_driver);
> --=C2=A0
> 2.7.4

