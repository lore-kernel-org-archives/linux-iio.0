Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out-1.itc.rwth-aachen.de ([134.130.5.46]:21363 "EHLO
        mail-out-1.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751395AbdKYW17 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Nov 2017 17:27:59 -0500
From: Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
To: Maciej Purski <m.purski@samsung.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        "Javier Martinez Canillas" <javier@osg.samsung.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/2] iio: adc: ina2xx: Make calibration register value fixed
Date: Sat, 25 Nov 2017 23:27:46 +0100
Message-ID: <20431291.ZXVLBfod4B@pebbles>
In-Reply-To: <1511364735-16818-2-git-send-email-m.purski@samsung.com>
References: <1511364735-16818-1-git-send-email-m.purski@samsung.com> <CGME20171122153246eucas1p20832152c270805d20343e40287402e0d@eucas1p2.samsung.com> <1511364735-16818-2-git-send-email-m.purski@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3782726.uvLYaKe6hD";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--nextPart3782726.uvLYaKe6hD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday, November 22, 2017 4:32:14 PM CET Maciej Purski wrote:
> Calibration register is used for calculating current register in
> hardware according to datasheet:
> current =3D shunt_volt * calib_register / 2048 (ina 226)
> current =3D shunt_volt * calib_register / 4096 (ina 219)
>=20
> Fix calib_register value to 2048 for ina226 and 4096 for ina 219 in
> order to avoid truncation error and provide best precision allowed
> by shunt_voltage measurement. Make current scale value follow changes
> of shunt_resistor from sysfs as calib_register value is now fixed.
>=20
> Power_lsb value should also follow shunt_resistor changes as stated in
> datasheet:
> power_lsb =3D 25 * current_lsb (ina 226)
> power_lsb =3D 20 * current_lsb (ina 219)
>=20
> Signed-off-by: Maciej Purski <m.purski@samsung.com>

Looks fine in general, but will need rebasing on top of Jonathans git tree.=
=20
Some comments inline ...

Kind regards,

Stefan

> ---
>  drivers/iio/adc/ina2xx-adc.c | 59
> ++++++++++++++++++++++++-------------------- 1 file changed, 32
> insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index 84a4387..0f25087 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -110,11 +110,11 @@ enum ina2xx_ids { ina219, ina226 };
>=20
>  struct ina2xx_config {
>  	u16 config_default;
> -	int calibration_factor;
> +	int calibration_value;
>  	int shunt_div;
>  	int bus_voltage_shift;
>  	int bus_voltage_lsb;	/* uV */
> -	int power_lsb;		/* uW */
> +	int power_lsb_factor;
>  	enum ina2xx_ids chip_id;
>  };
>=20
> @@ -124,6 +124,8 @@ struct ina2xx_chip_info {
>  	const struct ina2xx_config *config;
>  	struct mutex state_lock;
>  	unsigned int shunt_resistor_uohm;
> +	unsigned int current_lsb_uA;
> +	unsigned int power_lsb_uW;

I think power_lsb_uW is unneeded, see below.

>  	int avg;
>  	int int_time_vbus; /* Bus voltage integration time uS */
>  	int int_time_vshunt; /* Shunt voltage integration time uS */
> @@ -133,20 +135,20 @@ struct ina2xx_chip_info {
>  static const struct ina2xx_config ina2xx_config[] =3D {
>  	[ina219] =3D {
>  		.config_default =3D INA219_CONFIG_DEFAULT,
> -		.calibration_factor =3D 40960000,
> +		.calibration_value =3D 4096,
>  		.shunt_div =3D 100,
>  		.bus_voltage_shift =3D 3,
>  		.bus_voltage_lsb =3D 4000,
> -		.power_lsb =3D 20000,
> +		.power_lsb_factor =3D 20,
>  		.chip_id =3D ina219,
>  	},
>  	[ina226] =3D {
>  		.config_default =3D INA226_CONFIG_DEFAULT,
> -		.calibration_factor =3D 5120000,
> +		.calibration_value =3D 2048,
>  		.shunt_div =3D 400,
>  		.bus_voltage_shift =3D 0,
>  		.bus_voltage_lsb =3D 1250,
> -		.power_lsb =3D 25000,
> +		.power_lsb_factor =3D 25,
>  		.chip_id =3D ina226,
>  	},
>  };
> @@ -210,14 +212,15 @@ static int ina2xx_read_raw(struct iio_dev *indio_de=
v,
>=20
>  		case INA2XX_POWER:
>  			/* processed (mW) =3D raw*lsb (uW) / 1000 */
> -			*val =3D chip->config->power_lsb;
> +			*val =3D chip->power_lsb_uW;
>  			*val2 =3D 1000;
>  			return IIO_VAL_FRACTIONAL;
>=20
>  		case INA2XX_CURRENT:
> -			/* processed (mA) =3D raw (mA) */
> -			*val =3D 1;
> -			return IIO_VAL_INT;
> +			/* processed (mA) =3D raw*lsb (uA) / 1000 */
> +			*val =3D chip->current_lsb_uA;
> +			*val2 =3D 1000;
> +			return IIO_VAL_FRACTIONAL;
>  		}
>  	}
>=20
> @@ -434,28 +437,35 @@ static ssize_t ina2xx_allow_async_readout_store(str=
uct
> device *dev, }
>=20
>  /*
> - * Set current LSB to 1mA, shunt is in uOhms
> - * (equation 13 in datasheet). We hardcode a Current_LSB
> - * of 1.0 x10-3. The only remaining parameter is RShunt.
> - * There is no need to expose the CALIBRATION register
> - * to the user for now. But we need to reset this register
> - * if the user updates RShunt after driver init, e.g upon
> - * reading an EEPROM/Probe-type value.
> + * Calibration register is set to the best value, which eliminates
> + * truncation errors on calculating current register in hardware.
> + * According to datasheet (eq. 3) the best values are 2048 for

Nitpick - eq. 3 is only correct for INA226, IIRC, so maybe:
(INA226: Eq. 3, INA219: Eq. ?)

> + * ina226 and 4096 for ina219. They are hardcoded as calibration_value.
>   */
>  static int ina2xx_set_calibration(struct ina2xx_chip_info *chip)
>  {
> -	u16 regval =3D DIV_ROUND_CLOSEST(chip->config->calibration_factor,
> -				   chip->shunt_resistor_uohm);
> -
> -	return regmap_write(chip->regmap, INA2XX_CALIBRATION, regval);
> +	return regmap_write(chip->regmap, INA2XX_CALIBRATION,
> +			    chip->config->calibration_value);
>  }
>=20
> +/*
> + * In order to keep calibration register value fixed, the product
> + * of current_lsb and shunt_resistor should also be fixed and equal
> + * to shunt_voltage_lsb =3D 1 / shunt_div multiplied by 10^9 in order
> + * to keep the scale.
> + */
>  static int set_shunt_resistor(struct ina2xx_chip_info *chip, unsigned int
> val) {
> -	if (val <=3D 0 || val > chip->config->calibration_factor)
> +	unsigned int dividend =3D DIV_ROUND_CLOSEST(1000000000,
> +						  chip->config->shunt_div);
> +
> +	if (val <=3D 0 || val > dividend)
>  		return -EINVAL;
>=20
>  	chip->shunt_resistor_uohm =3D val;
> +	chip->current_lsb_uA =3D DIV_ROUND_CLOSEST(dividend, val);
> +	chip->power_lsb_uW =3D chip->config->power_lsb_factor *
> +			     chip->current_lsb_uA;

As the calculation is trivial an only used in ina2xx_read_raw, I think you=
=20
should remove the extra struct member and do the calculation in=20
ina2xx_read_raw.

=20
>  	return 0;
>  }
> @@ -485,11 +495,6 @@ static ssize_t ina2xx_shunt_resistor_store(struct
> device *dev, if (ret)
>  		return ret;
>=20
> -	/* Update the Calibration register */
> -	ret =3D ina2xx_set_calibration(chip);
> -	if (ret)
> -		return ret;
> -
>  	return len;
>  }


=2D-=20
Stefan Br=FCns  /  Bergstra=DFe 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
--nextPart3782726.uvLYaKe6hD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSwWRWIpJbl0W4DemNvf0o9jP6qUwUCWhnuYgAKCRBvf0o9jP6q
U7vkAJ4tdijxdv05H7vzoOCiUN3Z12LNNgCbBGK2qZZwjrOOVPrwUQrh8t720Mw=
=Cs4v
-----END PGP SIGNATURE-----

--nextPart3782726.uvLYaKe6hD--
