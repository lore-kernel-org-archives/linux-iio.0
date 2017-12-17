Return-Path: <SRS0=GYUY=DN=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
To: Maciej Purski <m.purski@samsung.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>, "Peter
 Meerwald-Stadler" <pmeerw@pmeerw.net>, Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>, Jean Delvare <jdelvare@suse.com>, "Guenter
 Roeck" <linux@roeck-us.net>, Marek Szyprowski <m.szyprowski@samsung.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v3] iio: adc: ina2xx: Make calibration register value fixed
Date: Sun, 17 Dec 2017 17:28:21 +0100
Message-ID: <5911204.mtbGo95WBk@pebbles>
In-Reply-To: <1513324763-21541-1-git-send-email-m.purski@samsung.com>
References: <CGME20171215075934eucas1p17dd876ffdc654ee4714bbd20a9c3abdb@eucas1p1.samsung.com> <1513324763-21541-1-git-send-email-m.purski@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2835239.0NMQKTozls";
	micalg=pgp-sha1; protocol="application/pgp-signature"
List-ID: <linux-iio@vger.kernel.org>

--nextPart2835239.0NMQKTozls
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, December 15, 2017 8:59:23 AM CET Maciej Purski wrote:
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
> This is a part of the patchset: https://lkml.org/lkml/2017/11/22/394
>=20
> Signed-off-by: Maciej Purski <m.purski@samsung.com>

The code itself looks fine now, although I have some nitpicks regarding the=
=20
comments, see below.

Regards,

Stefan

> ---
> Changes in v3:
> - remove variable current_lsb and calculate it on each read of current
>   and power scale value
> - update comments
>=20
> Changes in v2:
> - rebase on top of the latest next
> - remove a redundant variable - power_lsb_uW
> - fix comments
> ---
>  drivers/iio/adc/ina2xx-adc.c | 56
> +++++++++++++++++++++----------------------- 1 file changed, 27
> insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index ddf8781..3488100 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -124,11 +124,11 @@ enum ina2xx_ids { ina219, ina226 };
>=20
>  struct ina2xx_config {
>  	u16 config_default;
> -	int calibration_factor;
> +	int calibration_value;
>  	int shunt_voltage_lsb;	/* nV */
>  	int bus_voltage_shift;	/* position of lsb */
>  	int bus_voltage_lsb;	/* uV */
> -	int power_lsb;		/* uW */
> +	int power_lsb_factor;

A comment for the power_lsb_factor would be nice, something like
/* fixed relation between current and power lsb, uW/uA */

>  	enum ina2xx_ids chip_id;
>  };
>=20
> @@ -149,20 +149,20 @@ struct ina2xx_chip_info {
>  static const struct ina2xx_config ina2xx_config[] =3D {
>  	[ina219] =3D {
>  		.config_default =3D INA219_CONFIG_DEFAULT,
> -		.calibration_factor =3D 40960000,
> +		.calibration_value =3D 4096,
>  		.shunt_voltage_lsb =3D 10000,
>  		.bus_voltage_shift =3D INA219_BUS_VOLTAGE_SHIFT,
>  		.bus_voltage_lsb =3D 4000,
> -		.power_lsb =3D 20000,
> +		.power_lsb_factor =3D 20,
>  		.chip_id =3D ina219,
>  	},
>  	[ina226] =3D {
>  		.config_default =3D INA226_CONFIG_DEFAULT,
> -		.calibration_factor =3D 5120000,
> +		.calibration_value =3D 2048,
>  		.shunt_voltage_lsb =3D 2500,
>  		.bus_voltage_shift =3D 0,
>  		.bus_voltage_lsb =3D 1250,
> -		.power_lsb =3D 25000,
> +		.power_lsb_factor =3D 25,
>  		.chip_id =3D ina226,
>  	},
>  };
> @@ -228,15 +228,17 @@ static int ina2xx_read_raw(struct iio_dev *indio_de=
v,
>  			return IIO_VAL_FRACTIONAL;
>=20
>  		case INA2XX_POWER:
> -			/* processed (mW) =3D raw*lsb (uW) / 1000 */
> -			*val =3D chip->config->power_lsb;
> -			*val2 =3D 1000;
> +			/* processed (mW) =3D raw * factor * current_lsb (mW)*/
> +			*val =3D chip->config->power_lsb_factor *
> +			       chip->config->shunt_voltage_lsb;
> +			*val2 =3D chip->shunt_resistor_uohm;
>  			return IIO_VAL_FRACTIONAL;
>=20
>  		case INA2XX_CURRENT:
> -			/* processed (mA) =3D raw (mA) */
> -			*val =3D 1;
> -			return IIO_VAL_INT;
> +			/* processed (mA) =3D raw * lsb ([nV] / [uOhm] =3D [mA]) */
> +			*val =3D chip->config->shunt_voltage_lsb;
> +			*val2 =3D chip->shunt_resistor_uohm;
> +			return IIO_VAL_FRACTIONAL;
>  		}

It think this may be somewhat easier to follow if you place the CURRENT cas=
e=20
above the POWER case, and then extend the comments for both cases, e.g.:

/*
 * processed (mA) =3D raw * current_lsb (mA)
 * current_lsb (mA) =3D shunt_voltage_lsb (nV) / shunt_resistor (uOhm)
 */

and
/*
 * processed (mW) =3D raw * power_lsb (mW)
 * power_lsb (mW) =3D power_lsb_factor (mW/mA) * current_lsb (mA)
 */

>  	case IIO_CHAN_INFO_HARDWAREGAIN:
> @@ -541,25 +543,26 @@ static ssize_t ina2xx_allow_async_readout_store(str=
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
> + * According to datasheet (INA 226: eq. 3, INA219: eq. 4) the best values
> + * are 2048 for ina226 and 4096 for ina219. They are hardcoded as
> + * calibration_value.
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
> + * As the calibration register is fixed, the product of current_lsb
> + * and shunt_resistor should also be fixed and equal
> + * to shunt_voltage_lsb. Current_lsb will be calculated in read_raw()
> + */

I think this comment is misplaced here. Neither current_lsb nor=20
shunt_voltage_lsb are used in the remaining code, the resistor value is jus=
t=20
stored.

>  static int set_shunt_resistor(struct ina2xx_chip_info *chip, unsigned int
> val) {
> -	if (val <=3D 0 || val > chip->config->calibration_factor)
> +	if (val =3D=3D 0 || val > INT_MAX)
>  		return -EINVAL;
>=20
>  	chip->shunt_resistor_uohm =3D val;
> @@ -592,11 +595,6 @@ static ssize_t ina2xx_shunt_resistor_store(struct
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
--nextPart2835239.0NMQKTozls
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSwWRWIpJbl0W4DemNvf0o9jP6qUwUCWjabJQAKCRBvf0o9jP6q
U+ysAKCkCkaDdl6QShrP1iCrSNt1zsOOcwCfbLg5xKqJYbql+3wJzOlP136d0oY=
=ytKi
-----END PGP SIGNATURE-----

--nextPart2835239.0NMQKTozls--
