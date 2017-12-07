Return-Path: <SRS0=RB/+=DD=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: =?iso-8859-1?Q?Br=FCns=2C_Stefan?= <Stefan.Bruens@rwth-aachen.de>
To: Maciej Purski <m.purski@samsung.com>
CC: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>, Hartmut Knaack <knaack.h@gmx.de>, "Jean
 Delvare" <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz
	<b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2] iio: adc: ina2xx: Make calibration register value
 fixed
Date: Thu, 7 Dec 2017 16:10:40 +0000
Message-ID: <3656355.n9BamPbOAV@sbruens-linux>
References: <CGME20171207120340eucas1p24b145ba9b41768c1708ad574307c00c0@eucas1p2.samsung.com>
 <1512648167-11482-1-git-send-email-m.purski@samsung.com>
In-Reply-To: <1512648167-11482-1-git-send-email-m.purski@samsung.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Donnerstag, 7. Dezember 2017 13:02:47 CET Maciej Purski wrote:=0A=
> Calibration register is used for calculating current register in=0A=
> hardware according to datasheet:=0A=
> current =3D shunt_volt * calib_register / 2048 (ina 226)=0A=
> current =3D shunt_volt * calib_register / 4096 (ina 219)=0A=
> =0A=
> Fix calib_register value to 2048 for ina226 and 4096 for ina 219 in=0A=
> order to avoid truncation error and provide best precision allowed=0A=
> by shunt_voltage measurement. Make current scale value follow changes=0A=
> of shunt_resistor from sysfs as calib_register value is now fixed.=0A=
> =0A=
> Power_lsb value should also follow shunt_resistor changes as stated in=0A=
> datasheet:=0A=
> power_lsb =3D 25 * current_lsb (ina 226)=0A=
> power_lsb =3D 20 * current_lsb (ina 219)=0A=
> =0A=
> This is a part of the patchset: https://lkml.org/lkml/2017/11/22/394=0A=
> =0A=
> Signed-off-by: Maciej Purski <m.purski@samsung.com>=0A=
> =0A=
> ---=0A=
> Changes in v2:=0A=
> - rebase on top of the latest next=0A=
> - remove a redundant variable - power_lsb_uW=0A=
> - fix comments=0A=
> ---=0A=
>  drivers/iio/adc/ina2xx-adc.c | 58=0A=
> +++++++++++++++++++++++--------------------- 1 file changed, 31=0A=
> insertions(+), 27 deletions(-)=0A=
> =0A=
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c=
=0A=
> index ddf8781..3e4972f 100644=0A=
> --- a/drivers/iio/adc/ina2xx-adc.c=0A=
> +++ b/drivers/iio/adc/ina2xx-adc.c=0A=
> @@ -124,11 +124,11 @@ enum ina2xx_ids { ina219, ina226 };=0A=
> =0A=
>  struct ina2xx_config {=0A=
>  	u16 config_default;=0A=
> -	int calibration_factor;=0A=
> +	int calibration_value;=0A=
>  	int shunt_voltage_lsb;	/* nV */=0A=
>  	int bus_voltage_shift;	/* position of lsb */=0A=
>  	int bus_voltage_lsb;	/* uV */=0A=
> -	int power_lsb;		/* uW */=0A=
> +	int power_lsb_factor;=0A=
>  	enum ina2xx_ids chip_id;=0A=
>  };=0A=
> =0A=
> @@ -138,6 +138,7 @@ struct ina2xx_chip_info {=0A=
>  	const struct ina2xx_config *config;=0A=
>  	struct mutex state_lock;=0A=
>  	unsigned int shunt_resistor_uohm;=0A=
> +	unsigned int current_lsb_uA;=0A=
=0A=
I don't think you need current_lsb_uA, see below ...=0A=
=0A=
>  	int avg;=0A=
>  	int int_time_vbus; /* Bus voltage integration time uS */=0A=
>  	int int_time_vshunt; /* Shunt voltage integration time uS */=0A=
> @@ -149,20 +150,20 @@ struct ina2xx_chip_info {=0A=
>  static const struct ina2xx_config ina2xx_config[] =3D {=0A=
>  	[ina219] =3D {=0A=
>  		.config_default =3D INA219_CONFIG_DEFAULT,=0A=
> -		.calibration_factor =3D 40960000,=0A=
> +		.calibration_value =3D 4096,=0A=
>  		.shunt_voltage_lsb =3D 10000,=0A=
>  		.bus_voltage_shift =3D INA219_BUS_VOLTAGE_SHIFT,=0A=
>  		.bus_voltage_lsb =3D 4000,=0A=
> -		.power_lsb =3D 20000,=0A=
> +		.power_lsb_factor =3D 20,=0A=
>  		.chip_id =3D ina219,=0A=
>  	},=0A=
>  	[ina226] =3D {=0A=
>  		.config_default =3D INA226_CONFIG_DEFAULT,=0A=
> -		.calibration_factor =3D 5120000,=0A=
> +		.calibration_value =3D 2048,=0A=
>  		.shunt_voltage_lsb =3D 2500,=0A=
>  		.bus_voltage_shift =3D 0,=0A=
>  		.bus_voltage_lsb =3D 1250,=0A=
> -		.power_lsb =3D 25000,=0A=
> +		.power_lsb_factor =3D 25,=0A=
>  		.chip_id =3D ina226,=0A=
>  	},=0A=
>  };=0A=
> @@ -229,14 +230,16 @@ static int ina2xx_read_raw(struct iio_dev *indio_de=
v,=0A=
> =0A=
>  		case INA2XX_POWER:=0A=
>  			/* processed (mW) =3D raw*lsb (uW) / 1000 */=0A=
> -			*val =3D chip->config->power_lsb;=0A=
> +			*val =3D chip->config->power_lsb_factor *=0A=
> +			       chip->current_lsb_uA;=0A=
>  			*val2 =3D 1000;=0A=
>  			return IIO_VAL_FRACTIONAL;=0A=
> =0A=
>  		case INA2XX_CURRENT:=0A=
> -			/* processed (mA) =3D raw (mA) */=0A=
> -			*val =3D 1;=0A=
> -			return IIO_VAL_INT;=0A=
> +			/* processed (mA) =3D raw*lsb (uA) / 1000 */=0A=
> +			*val =3D chip->current_lsb_uA;=0A=
> +			*val2 =3D 1000;=0A=
=0A=
... this is the only place where current_lsb_uA is used ...=0A=
=0A=
> +			return IIO_VAL_FRACTIONAL;=0A=
>  		}=0A=
> =0A=
>  	case IIO_CHAN_INFO_HARDWAREGAIN:=0A=
> @@ -541,28 +544,34 @@ static ssize_t ina2xx_allow_async_readout_store(str=
uct=0A=
> device *dev, }=0A=
> =0A=
>  /*=0A=
> - * Set current LSB to 1mA, shunt is in uOhms=0A=
> - * (equation 13 in datasheet). We hardcode a Current_LSB=0A=
> - * of 1.0 x10-3. The only remaining parameter is RShunt.=0A=
> - * There is no need to expose the CALIBRATION register=0A=
> - * to the user for now. But we need to reset this register=0A=
> - * if the user updates RShunt after driver init, e.g upon=0A=
> - * reading an EEPROM/Probe-type value.=0A=
> + * Calibration register is set to the best value, which eliminates=0A=
> + * truncation errors on calculating current register in hardware.=0A=
> + * According to datasheet (INA 226: eq. 3, INA219: eq. 4) the best value=
s=0A=
> + * are 2048 for ina226 and 4096 for ina219. They are hardcoded as=0A=
> + * calibration_value.=0A=
>   */=0A=
>  static int ina2xx_set_calibration(struct ina2xx_chip_info *chip)=0A=
>  {=0A=
> -	u16 regval =3D DIV_ROUND_CLOSEST(chip->config->calibration_factor,=0A=
> -				   chip->shunt_resistor_uohm);=0A=
> -=0A=
> -	return regmap_write(chip->regmap, INA2XX_CALIBRATION, regval);=0A=
> +	return regmap_write(chip->regmap, INA2XX_CALIBRATION,=0A=
> +			    chip->config->calibration_value);=0A=
>  }=0A=
> =0A=
> +/*=0A=
> + * In order to keep calibration register value fixed, the product=0A=
> + * of current_lsb and shunt_resistor should also be fixed and equal=0A=
> + * to shunt_voltage_lsb =3D 1 / shunt_div multiplied by 10^9 in order=0A=
> + * to keep the scale.=0A=
> + */=0A=
>  static int set_shunt_resistor(struct ina2xx_chip_info *chip, unsigned in=
t=0A=
> val) {=0A=
> -	if (val <=3D 0 || val > chip->config->calibration_factor)=0A=
> +	unsigned int dividend =3D DIV_ROUND_CLOSEST(1000000000,=0A=
> +						  chip->config->shunt_div);=0A=
> +=0A=
> +	if (val <=3D 0 || val > dividend)=0A=
>  		return -EINVAL;=0A=
> =0A=
>  	chip->shunt_resistor_uohm =3D val;=0A=
> +	chip->current_lsb_uA =3D DIV_ROUND_CLOSEST(dividend, val);=0A=
=0A=
1st: shunt_div no longer exists, but shunt_voltage_lsb[nV], so this code do=
es =0A=
not even compile ...=0A=
=0A=
This function does two things - range check and calculation of the =0A=
curren_lsb_uA auxiliary variable.=0A=
=0A=
Lets start with the second part:=0A=
=0A=
read_raw returns the IIO_VAL_FRACTIONAL=0A=
val / val2     =3D current_lsb_uA / 1000             (1)=0A=
=0A=
=0A=
from set_shunt_resistor(...):=0A=
=0A=
dividend       =3D 1e9 / shunt_div	                  (2)=0A=
current_lsb_uA =3D dividend / shunt_resistor_uohm    (3)=0A=
=0A=
shunt_div no longer exists, but can be substituted:=0A=
shunt_div      =3D 1e6 / shunt_voltage_lsb           (4)=0A=
=0A=
substituting (2), (3) and (4) in (1), we end up with=0A=
=0A=
val / val2     =3D 1e9 / (shunt_div * shunt_resistor_uohm * 1000)=0A=
=0A=
=3D> val / val2  =3D 1e6 / ((1e6 / shunt_voltage_lsb) * shunt_resistor_uohm=
)=0A=
=3D> val / val2  =3D shunt_voltage_lsb / shunt_resistor_uohm=0A=
=3D>  [mA]       =3D     [nV]          /     [uOhm]=0A=
=0A=
The auxiliary variable is gone, as are the two DIV_ROUND_CLOSEST calls.=0A=
=0A=
=0A=
Part 2, range check:=0A=
=0A=
lower bound is obviously 1 uOhm. The upper bound is only limited by=0A=
typeof(val2) and typeof(shunt_resistor_uohm), both are ints.=0A=
=0A=
so the range check can be simplified to=0A=
=0A=
if (val =3D=3D 0 || val > INT_MAX)=0A=
	return -EINVAL=0A=
=0A=
Kind regards,=0A=
=0A=
Stefan=0A=
 =0A=
