Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56989 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755106AbcCTLYt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Mar 2016 07:24:49 -0400
Subject: Re: [PATCH-vs-togreg v2 1/2] iio: ina2xx-adc: update the CALIB.
 register when RShunt changes
To: Marc Titinger <mtitinger@baylibre.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net
References: <1457950844-7261-1-git-send-email-marc.titinger@baylibre.com>
Cc: afd@ti.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56EE887F.7030508@kernel.org>
Date: Sun, 20 Mar 2016 11:24:47 +0000
MIME-Version: 1.0
In-Reply-To: <1457950844-7261-1-git-send-email-marc.titinger@baylibre.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/03/16 10:20, Marc Titinger wrote:
> The user (or an init script) may setup RShunt via sysfs after the
> driver was initialized, for instance based on the EEPROM contents
> of a modular probe. The calibration register must be set accordingly.
> 
> Signed-off-by: Marc Titinger <marc.titinger@baylibre.com>
> ---
>  v2 of http://www.spinics.net/lists/linux-iio/msg23402.html:
> 
> 	- remove unnecessary line insertions
> 	- cleanup leftover unused variable (build warning)
> 	- patch 2/2 is unchanged (see v1)
Err, can't find it for some reason.

Anyhow, applied this one to the togreg branch of iio.git - pushed
out as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/ina2xx-adc.c | 39 ++++++++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index 65909d5..4e56fe3 100644
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
> @@ -602,24 +624,11 @@ static const struct iio_info ina2xx_info = {
>  /* Initialize the configuration and calibration registers. */
>  static int ina2xx_init(struct ina2xx_chip_info *chip, unsigned int config)
>  {
> -	u16 regval;
> -	int ret;
> -
> -	ret = regmap_write(chip->regmap, INA2XX_CONFIG, config);
> +	int ret = regmap_write(chip->regmap, INA2XX_CONFIG, config);
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

