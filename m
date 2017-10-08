Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751463AbdJHKDI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Oct 2017 06:03:08 -0400
Date: Sun, 8 Oct 2017 11:03:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc: <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>,
        "Javier Martinez Canillas" <javier@osg.samsung.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH 2/3] iio: adc: ina2xx: Adhere to documented ABI, use Ohm
 instead of uOhm
Message-ID: <20171008110303.0b453c28@archlinux>
In-Reply-To: <7ee955b2-a58f-45e0-985d-1f7508d41ae7@rwthex-w2-a.rwth-ad.de>
References: <20171001194818.26017-1-stefan.bruens@rwth-aachen.de>
        <7ee955b2-a58f-45e0-985d-1f7508d41ae7@rwthex-w2-a.rwth-ad.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 1 Oct 2017 21:48:17 +0200
Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:

> According to the ABI documentation, the shunt resistor value should be
> specificied in Ohm. As this is also used/documented for the MAX9611,
> use the same for the INA2xx driver.
> 
> This poses an ABI break for anyone actually altering the shunt value
> through the sysfs interface, it does not alter the default value nor
> a value set from the devicetree.

Yeah, I messed up on this an missed that we had a number of different
drivers with different scaling on this..  Sorry about that.

So I think we need to apply this to get consistency - changing shunt
resistance from userspace does seem fairly unusual though so fingers
crossed that no one is doing it.

I'm going to do this the slow way though so hopefully we get shouts
before breaking too many people.  Hence I'm routing this through
the next merge window.   After it's been in mainline all the way
to release, if no-one complains we can request it is added to
stable.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> 
> Minor change: Fix comment, 1mA is 10^-3A.
> 
> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
> ---
> 
>  drivers/iio/adc/ina2xx-adc.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index 361fb4e459d5..1930f853e8c5 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -127,7 +127,7 @@ struct ina2xx_chip_info {
>  	struct task_struct *task;
>  	const struct ina2xx_config *config;
>  	struct mutex state_lock;
> -	unsigned int shunt_resistor;
> +	unsigned int shunt_resistor_uohm;
>  	int avg;
>  	int int_time_vbus; /* Bus voltage integration time uS */
>  	int int_time_vshunt; /* Shunt voltage integration time uS */
> @@ -444,7 +444,7 @@ static ssize_t ina2xx_allow_async_readout_store(struct device *dev,
>  /*
>   * Set current LSB to 1mA, shunt is in uOhms
>   * (equation 13 in datasheet). We hardcode a Current_LSB
> - * of 1.0 x10-6. The only remaining parameter is RShunt.
> + * of 1.0 x10-3. The only remaining parameter is RShunt.
>   * There is no need to expose the CALIBRATION register
>   * to the user for now. But we need to reset this register
>   * if the user updates RShunt after driver init, e.g upon
> @@ -453,7 +453,7 @@ static ssize_t ina2xx_allow_async_readout_store(struct device *dev,
>  static int ina2xx_set_calibration(struct ina2xx_chip_info *chip)
>  {
>  	u16 regval = DIV_ROUND_CLOSEST(chip->config->calibration_factor,
> -				   chip->shunt_resistor);
> +				   chip->shunt_resistor_uohm);
>  
>  	return regmap_write(chip->regmap, INA2XX_CALIBRATION, regval);
>  }
> @@ -463,7 +463,7 @@ static int set_shunt_resistor(struct ina2xx_chip_info *chip, unsigned int val)
>  	if (val <= 0 || val > chip->config->calibration_factor)
>  		return -EINVAL;
>  
> -	chip->shunt_resistor = val;
> +	chip->shunt_resistor_uohm = val;
>  
>  	return 0;
>  }
> @@ -473,8 +473,9 @@ static ssize_t ina2xx_shunt_resistor_show(struct device *dev,
>  					  char *buf)
>  {
>  	struct ina2xx_chip_info *chip = iio_priv(dev_to_iio_dev(dev));
> +	int vals[2] = { chip->shunt_resistor_uohm, 1000000 };
>  
> -	return sprintf(buf, "%d\n", chip->shunt_resistor);
> +	return iio_format_value(buf, IIO_VAL_FRACTIONAL, 1, vals);
>  }
>  
>  static ssize_t ina2xx_shunt_resistor_store(struct device *dev,
> @@ -482,14 +483,13 @@ static ssize_t ina2xx_shunt_resistor_store(struct device *dev,
>  					   const char *buf, size_t len)
>  {
>  	struct ina2xx_chip_info *chip = iio_priv(dev_to_iio_dev(dev));
> -	unsigned long val;
> -	int ret;
> +	int val, val_fract, ret;
>  
> -	ret = kstrtoul((const char *) buf, 10, &val);
> +	ret = iio_str_to_fixpoint(buf, 100000, &val, &val_fract);
>  	if (ret)
>  		return ret;
>  
> -	ret = set_shunt_resistor(chip, val);
> +	ret = set_shunt_resistor(chip, val * 1000000 + val_fract);
>  	if (ret)
>  		return ret;
>  

