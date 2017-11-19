Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751132AbdKSQtY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Nov 2017 11:49:24 -0500
Date: Sun, 19 Nov 2017 16:13:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc: <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v2 1/3] iio: adc: ina2xx: Shift bus voltage register to
 mask flag bits
Message-ID: <20171119161339.14fb9685@archlinux>
In-Reply-To: <875c664a-9000-4121-acf5-e3ab254cf061@rwthex-w2-a.rwth-ad.de>
References: <20171028211249.24148-1-stefan.bruens@rwth-aachen.de>
 <875c664a-9000-4121-acf5-e3ab254cf061@rwthex-w2-a.rwth-ad.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 28 Oct 2017 23:12:46 +0200
Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:

> Lower bits of the INA219/220 bus voltage register are conversion
> status flags, properly shift the value.
> 
> When reading via IIO buffer, the value is passed on unaltered,
> shifting is the responsibility of the user.
> 
> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
> 
I thought about sending this as a fix, but as you haven't marked
it as such and the effect is very minor I haven't done so.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,
Jonathan
> ---
> 
> Changes in v2:
> - Apply to the shunt voltage, not bus voltage register
> - Shift instead of masking the LSBs
> 
>  drivers/iio/adc/ina2xx-adc.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index 3aff9556678f..84094235ff7e 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -44,7 +44,6 @@
>  
>  #define INA226_MASK_ENABLE		0x06
>  #define INA226_CVRF			BIT(3)
> -#define INA219_CNVR			BIT(1)
>  
>  #define INA2XX_MAX_REGISTERS            8
>  
> @@ -79,6 +78,11 @@
>  #define INA226_ITS_MASK		GENMASK(5, 3)
>  #define INA226_SHIFT_ITS(val)	((val) << 3)
>  
> +/* INA219 Bus voltage register, low bits are flags */
> +#define INA219_OVF		BIT(0)
> +#define INA219_CNVR		BIT(1)
> +#define INA219_BUS_VOLTAGE_SHIFT	3
> +
>  /* Cosmetic macro giving the sampling period for a full P=UxI cycle */
>  #define SAMPLING_PERIOD(c)	((c->int_time_vbus + c->int_time_vshunt) \
>  				 * c->avg)
> @@ -112,7 +116,7 @@ struct ina2xx_config {
>  	u16 config_default;
>  	int calibration_factor;
>  	int shunt_div;
> -	int bus_voltage_shift;
> +	int bus_voltage_shift;	/* position of lsb */
>  	int bus_voltage_lsb;	/* uV */
>  	int power_lsb;		/* uW */
>  	enum ina2xx_ids chip_id;
> @@ -135,7 +139,7 @@ static const struct ina2xx_config ina2xx_config[] = {
>  		.config_default = INA219_CONFIG_DEFAULT,
>  		.calibration_factor = 40960000,
>  		.shunt_div = 100,
> -		.bus_voltage_shift = 3,
> +		.bus_voltage_shift = INA219_BUS_VOLTAGE_SHIFT,
>  		.bus_voltage_lsb = 4000,
>  		.power_lsb = 20000,
>  		.chip_id = ina219,
> @@ -170,6 +174,9 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
>  		else
>  			*val  = regval;
>  
> +		if (chan->address == INA2XX_BUS_VOLTAGE)
> +			*val >>= chip->config->bus_voltage_shift;
> +
>  		return IIO_VAL_INT;
>  
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> @@ -203,9 +210,9 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
>  			return IIO_VAL_FRACTIONAL;
>  
>  		case INA2XX_BUS_VOLTAGE:
> -			/* processed (mV) = raw*lsb (uV) / (1000 << shift) */
> +			/* processed (mV) = raw * lsb (uV) / 1000 */
>  			*val = chip->config->bus_voltage_lsb;
> -			*val2 = 1000 << chip->config->bus_voltage_shift;
> +			*val2 = 1000;
>  			return IIO_VAL_FRACTIONAL;
>  
>  		case INA2XX_POWER:
> @@ -532,7 +539,7 @@ static ssize_t ina2xx_shunt_resistor_store(struct device *dev,
>   * Sampling Freq is a consequence of the integration times of
>   * the Voltage channels.
>   */
> -#define INA219_CHAN_VOLTAGE(_index, _address) { \
> +#define INA219_CHAN_VOLTAGE(_index, _address, _shift) { \
>  	.type = IIO_VOLTAGE, \
>  	.address = (_address), \
>  	.indexed = 1, \
> @@ -544,7 +551,8 @@ static ssize_t ina2xx_shunt_resistor_store(struct device *dev,
>  	.scan_index = (_index), \
>  	.scan_type = { \
>  		.sign = 'u', \
> -		.realbits = 16, \
> +		.shift = _shift, \
> +		.realbits = 16 - _shift, \
>  		.storagebits = 16, \
>  		.endianness = IIO_LE, \
>  	} \
> @@ -579,8 +587,8 @@ static const struct iio_chan_spec ina226_channels[] = {
>  };
>  
>  static const struct iio_chan_spec ina219_channels[] = {
> -	INA219_CHAN_VOLTAGE(0, INA2XX_SHUNT_VOLTAGE),
> -	INA219_CHAN_VOLTAGE(1, INA2XX_BUS_VOLTAGE),
> +	INA219_CHAN_VOLTAGE(0, INA2XX_SHUNT_VOLTAGE, 0),
> +	INA219_CHAN_VOLTAGE(1, INA2XX_BUS_VOLTAGE, INA219_BUS_VOLTAGE_SHIFT),
>  	INA219_CHAN(IIO_POWER, 2, INA2XX_POWER),
>  	INA219_CHAN(IIO_CURRENT, 3, INA2XX_CURRENT),
>  	IIO_CHAN_SOFT_TIMESTAMP(4),

