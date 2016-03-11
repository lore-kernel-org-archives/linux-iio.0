Return-Path: <afd@ti.com>
Subject: Re: [PATCH-vs-togreg 1/2] iio: ina2xx-adc: update the CALIB. register
 when RShunt changes
To: Marc Titinger <mtitinger@baylibre.com>, <jic23@kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>
References: <1457707950-17593-1-git-send-email-marc.titinger@baylibre.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <56E2DE7E.5090905@ti.com>
Date: Fri, 11 Mar 2016 09:04:30 -0600
MIME-Version: 1.0
In-Reply-To: <1457707950-17593-1-git-send-email-marc.titinger@baylibre.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

On 03/11/2016 08:52 AM, Marc Titinger wrote:
> The user (or an init script) may setup RShunt via sysfs after the
> driver was initialized, for instance based on the EEPROM contents
> of a modular probe. The calibration register must be set accordingly.
> 
> Signed-off-by: Marc Titinger <marc.titinger@baylibre.com>
> ---
> tested with BeagleBone-black and BayLibre-acme.
> ---
>  drivers/iio/adc/ina2xx-adc.c | 36 +++++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index 65909d5..e5ac120 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -350,6 +350,23 @@ static ssize_t ina2xx_allow_async_readout_store(struct device *dev,
>  	return len;
>  }
>  
> +/*
> + * Set current LSB to 1mA, shunt is in uOhms
> + * (equation 13 in datasheet). We hardcode a Current_LSB
> + * of 1.0 x10-6. The only remaining parameter is RShunt.
> + * There is no need to expose the CALIBRATION register
> + * to the user for now. But we need to reset this register
> + * if the user updates RShunt after driver init, e.g upon
> + * reading an EEPROM/Probe-type value.
> + */
> +static int ina2xx_set_calibration(struct ina2xx_chip_info *chip)
> +{
> +	u16 regval = DIV_ROUND_CLOSEST(chip->config->calibration_factor,
> +				   chip->shunt_resistor);
> +
> +	return regmap_write(chip->regmap, INA2XX_CALIBRATION, regval);
> +}
> +
>  static int set_shunt_resistor(struct ina2xx_chip_info *chip, unsigned int val)
>  {
>  	if (val <= 0 || val > chip->config->calibration_factor)
> @@ -385,6 +402,11 @@ static ssize_t ina2xx_shunt_resistor_store(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> +	/* Update the Calibration register */
> +	ret = ina2xx_set_calibration(chip);
> +	if (ret)
> +		return ret;
> +
>  	return len;
>  }
>  
> @@ -599,6 +621,8 @@ static const struct iio_info ina2xx_info = {
>  	.debugfs_reg_access = ina2xx_debug_reg,
>  };
>  
> +
> +

?

>  /* Initialize the configuration and calibration registers. */
>  static int ina2xx_init(struct ina2xx_chip_info *chip, unsigned int config)
>  {
> @@ -609,17 +633,7 @@ static int ina2xx_init(struct ina2xx_chip_info *chip, unsigned int config)
>  	if (ret)
>  		return ret;
>  
> -	/*
> -	 * Set current LSB to 1mA, shunt is in uOhms
> -	 * (equation 13 in datasheet). We hardcode a Current_LSB
> -	 * of 1.0 x10-6. The only remaining parameter is RShunt.
> -	 * There is no need to expose the CALIBRATION register
> -	 * to the user for now.
> -	 */
> -	regval = DIV_ROUND_CLOSEST(chip->config->calibration_factor,
> -				   chip->shunt_resistor);
> -
> -	return regmap_write(chip->regmap, INA2XX_CALIBRATION, regval);
> +	return ina2xx_set_calibration(chip);
>  }
>  
>  static int ina2xx_probe(struct i2c_client *client,
> 
