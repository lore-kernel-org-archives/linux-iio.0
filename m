Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751107AbdL2RcM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 Dec 2017 12:32:12 -0500
Date: Fri, 29 Dec 2017 17:32:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc: Maciej Purski <m.purski@samsung.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jean Delvare <jdelvare@suse.com>,
        "Guenter Roeck" <linux@roeck-us.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v4] iio: adc: ina2xx: Make calibration register value
 fixed
Message-ID: <20171229173207.32cfbc76@archlinux>
In-Reply-To: <5526600.j0ivttN8ph@bacchus.fritz.box>
References: <CGME20171218084408eucas1p16889c413d8d983e70b43732347f22e01@eucas1p1.samsung.com>
        <1513586638-6036-1-git-send-email-m.purski@samsung.com>
        <5526600.j0ivttN8ph@bacchus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 18 Dec 2017 10:02:44 +0100
Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:

> On Monday, December 18, 2017 9:43:58 AM CET Maciej Purski wrote:
> > Calibration register is used for calculating current register in
> > hardware according to datasheet:
> > current = shunt_volt * calib_register / 2048 (ina 226)
> > current = shunt_volt * calib_register / 4096 (ina 219)
> > 
> > Fix calib_register value to 2048 for ina226 and 4096 for ina 219 in
> > order to avoid truncation error and provide best precision allowed
> > by shunt_voltage measurement. Make current scale value follow changes
> > of shunt_resistor from sysfs as calib_register value is now fixed.
> > 
> > Power_lsb value should also follow shunt_resistor changes as stated in
> > datasheet:
> > power_lsb = 25 * current_lsb (ina 226)
> > power_lsb = 20 * current_lsb (ina 219)
> > 
> > This is a part of the patchset: https://lkml.org/lkml/2017/11/22/394
> > 
> > Signed-off-by: Maciej Purski <m.purski@samsung.com>  
> 
> Reviewed-by:  Stefan Brüns <stefan.bruens@rwth-aachen.de>
Applied to the togreg branch of iio.git and pushed out ass testing
for the autobuilders to play with it.

Thanks,

Jonathan
> 
> > ---
> > Changes in v4:
> > - fix comments
> > 
> > Changes in v3:
> > - remove variable current_lsb and calculate it on each read of current
> >   and power scale value
> > - update comments
> > 
> > Changes in v2:
> > - rebase on top of the latest next
> > - remove a redundant variable - power_lsb_uW
> > - fix comments
> > ---
> >  drivers/iio/adc/ina2xx-adc.c | 64
> > +++++++++++++++++++++++--------------------- 1 file changed, 33
> > insertions(+), 31 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> > index ddf8781..9e8ca12 100644
> > --- a/drivers/iio/adc/ina2xx-adc.c
> > +++ b/drivers/iio/adc/ina2xx-adc.c
> > @@ -124,11 +124,12 @@ enum ina2xx_ids { ina219, ina226 };
> > 
> >  struct ina2xx_config {
> >  	u16 config_default;
> > -	int calibration_factor;
> > +	int calibration_value;
> >  	int shunt_voltage_lsb;	/* nV */
> >  	int bus_voltage_shift;	/* position of lsb */
> >  	int bus_voltage_lsb;	/* uV */
> > -	int power_lsb;		/* uW */
> > +	/* fixed relation between current and power lsb, uW/uA */
> > +	int power_lsb_factor;
> >  	enum ina2xx_ids chip_id;
> >  };
> > 
> > @@ -149,20 +150,20 @@ struct ina2xx_chip_info {
> >  static const struct ina2xx_config ina2xx_config[] = {
> >  	[ina219] = {
> >  		.config_default = INA219_CONFIG_DEFAULT,
> > -		.calibration_factor = 40960000,
> > +		.calibration_value = 4096,
> >  		.shunt_voltage_lsb = 10000,
> >  		.bus_voltage_shift = INA219_BUS_VOLTAGE_SHIFT,
> >  		.bus_voltage_lsb = 4000,
> > -		.power_lsb = 20000,
> > +		.power_lsb_factor = 20,
> >  		.chip_id = ina219,
> >  	},
> >  	[ina226] = {
> >  		.config_default = INA226_CONFIG_DEFAULT,
> > -		.calibration_factor = 5120000,
> > +		.calibration_value = 2048,
> >  		.shunt_voltage_lsb = 2500,
> >  		.bus_voltage_shift = 0,
> >  		.bus_voltage_lsb = 1250,
> > -		.power_lsb = 25000,
> > +		.power_lsb_factor = 25,
> >  		.chip_id = ina226,
> >  	},
> >  };
> > @@ -227,16 +228,26 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
> >  			*val2 = 1000;
> >  			return IIO_VAL_FRACTIONAL;
> > 
> > -		case INA2XX_POWER:
> > -			/* processed (mW) = raw*lsb (uW) / 1000 */
> > -			*val = chip->config->power_lsb;
> > -			*val2 = 1000;
> > +		case INA2XX_CURRENT:
> > +			/*
> > +			 * processed (mA) = raw * current_lsb (mA)
> > +			 * current_lsb (mA) = shunt_voltage_lsb (nV) /
> > +			 *                    shunt_resistor (uOhm)
> > +			 */
> > +			*val = chip->config->shunt_voltage_lsb;
> > +			*val2 = chip->shunt_resistor_uohm;
> >  			return IIO_VAL_FRACTIONAL;
> > 
> > -		case INA2XX_CURRENT:
> > -			/* processed (mA) = raw (mA) */
> > -			*val = 1;
> > -			return IIO_VAL_INT;
> > +		case INA2XX_POWER:
> > +			/*
> > +			 * processed (mW) = raw * power_lsb (mW)
> > +			 * power_lsb (mW) = power_lsb_factor (mW/mA) *
> > +			 *                  current_lsb (mA)
> > +			 */
> > +			*val = chip->config->power_lsb_factor *
> > +			       chip->config->shunt_voltage_lsb;
> > +			*val2 = chip->shunt_resistor_uohm;
> > +			return IIO_VAL_FRACTIONAL;
> >  		}
> > 
> >  	case IIO_CHAN_INFO_HARDWAREGAIN:
> > @@ -541,25 +552,21 @@ static ssize_t ina2xx_allow_async_readout_store(struct
> > device *dev, }
> > 
> >  /*
> > - * Set current LSB to 1mA, shunt is in uOhms
> > - * (equation 13 in datasheet). We hardcode a Current_LSB
> > - * of 1.0 x10-3. The only remaining parameter is RShunt.
> > - * There is no need to expose the CALIBRATION register
> > - * to the user for now. But we need to reset this register
> > - * if the user updates RShunt after driver init, e.g upon
> > - * reading an EEPROM/Probe-type value.
> > + * Calibration register is set to the best value, which eliminates
> > + * truncation errors on calculating current register in hardware.
> > + * According to datasheet (INA 226: eq. 3, INA219: eq. 4) the best values
> > + * are 2048 for ina226 and 4096 for ina219. They are hardcoded as
> > + * calibration_value.
> >   */
> >  static int ina2xx_set_calibration(struct ina2xx_chip_info *chip)
> >  {
> > -	u16 regval = DIV_ROUND_CLOSEST(chip->config->calibration_factor,
> > -				   chip->shunt_resistor_uohm);
> > -
> > -	return regmap_write(chip->regmap, INA2XX_CALIBRATION, regval);
> > +	return regmap_write(chip->regmap, INA2XX_CALIBRATION,
> > +			    chip->config->calibration_value);
> >  }
> > 
> >  static int set_shunt_resistor(struct ina2xx_chip_info *chip, unsigned int
> > val) {
> > -	if (val <= 0 || val > chip->config->calibration_factor)
> > +	if (val == 0 || val > INT_MAX)
> >  		return -EINVAL;
> > 
> >  	chip->shunt_resistor_uohm = val;
> > @@ -592,11 +599,6 @@ static ssize_t ina2xx_shunt_resistor_store(struct
> > device *dev, if (ret)
> >  		return ret;
> > 
> > -	/* Update the Calibration register */
> > -	ret = ina2xx_set_calibration(chip);
> > -	if (ret)
> > -		return ret;
> > -
> >  	return len;
> >  }  
> 
> 

