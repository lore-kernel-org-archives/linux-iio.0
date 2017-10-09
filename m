Return-Path: <SRS0=hq1g=BI=samsung.com=m.purski@kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"; format="flowed"
Subject: Re: [2/3] iio: adc: ina2xx: Adhere to documented ABI, use Ohm
 instead of uOhm
To: =?UTF-8?Q?Stefan_Br=c3=bcns?= <stefan.bruens@rwth-aachen.de>,
	linux-iio@vger.kernel.org
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>, Javier
	Martinez Canillas <javier@osg.samsung.com>, Lars-Peter Clausen
	<lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack
	<knaack.h@gmx.de>
From: Maciej Purski <m.purski@samsung.com>
Message-id: <6144c719-5310-7358-bd57-f778ab481788@samsung.com>
Date: Mon, 09 Oct 2017 11:29:43 +0200
In-reply-to: <7ee955b2-a58f-45e0-985d-1f7508d41ae7@rwthex-w2-a.rwth-ad.de>
References: <7ee955b2-a58f-45e0-985d-1f7508d41ae7@rwthex-w2-a.rwth-ad.de>
	<CGME20171009092944eucas1p18b2e66a4a07db309551a7e945c2611ec@eucas1p1.samsung.com>
List-ID: <linux-iio@vger.kernel.org>



On 10/01/2017 09:48 PM, Stefan Brüns wrote:
> According to the ABI documentation, the shunt resistor value should be
> specificied in Ohm. As this is also used/documented for the MAX9611,
> use the same for the INA2xx driver.
> 
> This poses an ABI break for anyone actually altering the shunt value
> through the sysfs interface, it does not alter the default value nor
> a value set from the devicetree.
> 
> Minor change: Fix comment, 1mA is 10^-3A.
> 

I have just a minor issue. There could be an inconsistency with units as in my 
patch I make current_lsb adjustable and I need it to be in uA (it used to be 
hardcoded as 1 mA so to achieve better precision we need smaller units). So in 
order to keep calibration register properly scaled, I convert uOhms to mOhms on
each set_calibration(). So if both my changes and your changes were applied, on 
each shunt_resistore_store we would be performing multiplication by 10^6 and 
then in set_calibration() division by 10^3 which seems odd to me.

I guess we could keep it as shunt_resistor_ohms instead of shunt_resistor_uohm. 
We could avoid performing division on each shunt_resistor_show() and perform 
multiplication by 10^3 only once in set_calibration() on each 
shunt_resistore_store(). We could then change the default value and perform 
division only on probing, when reading the shunt_resistance from device tree.

There are many other options. It's not a major issue so maybe we could leave it
as it is or you could suggest some changes in my patch.

> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
> ---
> 
>   drivers/iio/adc/ina2xx-adc.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index 361fb4e459d5..1930f853e8c5 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -127,7 +127,7 @@ struct ina2xx_chip_info {
>   	struct task_struct *task;
>   	const struct ina2xx_config *config;
>   	struct mutex state_lock;
> -	unsigned int shunt_resistor;
> +	unsigned int shunt_resistor_uohm;
>   	int avg;
>   	int int_time_vbus; /* Bus voltage integration time uS */
>   	int int_time_vshunt; /* Shunt voltage integration time uS */
> @@ -444,7 +444,7 @@ static ssize_t ina2xx_allow_async_readout_store(struct device *dev,
>   /*
>    * Set current LSB to 1mA, shunt is in uOhms
>    * (equation 13 in datasheet). We hardcode a Current_LSB
> - * of 1.0 x10-6. The only remaining parameter is RShunt.
> + * of 1.0 x10-3. The only remaining parameter is RShunt.
>    * There is no need to expose the CALIBRATION register
>    * to the user for now. But we need to reset this register
>    * if the user updates RShunt after driver init, e.g upon
> @@ -453,7 +453,7 @@ static ssize_t ina2xx_allow_async_readout_store(struct device *dev,
>   static int ina2xx_set_calibration(struct ina2xx_chip_info *chip)
>   {
>   	u16 regval = DIV_ROUND_CLOSEST(chip->config->calibration_factor,
> -				   chip->shunt_resistor);
> +				   chip->shunt_resistor_uohm);
>   
>   	return regmap_write(chip->regmap, INA2XX_CALIBRATION, regval);
>   }
> @@ -463,7 +463,7 @@ static int set_shunt_resistor(struct ina2xx_chip_info *chip, unsigned int val)
>   	if (val <= 0 || val > chip->config->calibration_factor)
>   		return -EINVAL;
>   
> -	chip->shunt_resistor = val;
> +	chip->shunt_resistor_uohm = val;
>   
>   	return 0;
>   }
> @@ -473,8 +473,9 @@ static ssize_t ina2xx_shunt_resistor_show(struct device *dev,
>   					  char *buf)
>   {
>   	struct ina2xx_chip_info *chip = iio_priv(dev_to_iio_dev(dev));
> +	int vals[2] = { chip->shunt_resistor_uohm, 1000000 };
>   
> -	return sprintf(buf, "%d\n", chip->shunt_resistor);
> +	return iio_format_value(buf, IIO_VAL_FRACTIONAL, 1, vals);
>   }
>   
>   static ssize_t ina2xx_shunt_resistor_store(struct device *dev,
> @@ -482,14 +483,13 @@ static ssize_t ina2xx_shunt_resistor_store(struct device *dev,
>   					   const char *buf, size_t len)
>   {
>   	struct ina2xx_chip_info *chip = iio_priv(dev_to_iio_dev(dev));
> -	unsigned long val;
> -	int ret;
> +	int val, val_fract, ret;
>   
> -	ret = kstrtoul((const char *) buf, 10, &val);
> +	ret = iio_str_to_fixpoint(buf, 100000, &val, &val_fract);
>   	if (ret)
>   		return ret;
>   
> -	ret = set_shunt_resistor(chip, val);
> +	ret = set_shunt_resistor(chip, val * 1000000 + val_fract);
>   	if (ret)
>   		return ret;
>   
> 
