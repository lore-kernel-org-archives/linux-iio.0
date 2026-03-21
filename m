Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CCB3246FE
	for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774122314; cv=none; b=KFJjUyCuTWyTH7mLbeacriQk99IUbbFeAqNF4109TM/6S4hLVF6+9SPQtySfsE5SABXZ/XarPgGcqXm44LrhArpyiQcCTOAnl2E6YLD7VkEGrFBcEBz8MGf5+s1QUAVDpdATVuf3m7JdEq2E3VsgfJ0glaZljfuY/4gI38wNo2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774122314; c=relaxed/simple;
	bh=tmBaNlGwlwjkObkVGOa94kVvGpSrx2ovksiEIxx/V+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AkImp9QKTzspmcdipSh6Udb471gwmuo+7vIFHSSSrPTWuXcd3rYc8L5HsQmYdOkm2sXLzJWD/5g3ZU1GBiLmICBoHN3SQFwvHfBCNWslUMT479eE06Z2LScEy5YOtA3zEKTrQg5XEkA3/bmloe4ZlGgFi7qMKZJVhWiGsVsXt8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDwfvxt+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDwfvxt+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDE9C19421;
	Sat, 21 Mar 2026 19:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774122313;
	bh=tmBaNlGwlwjkObkVGOa94kVvGpSrx2ovksiEIxx/V+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KDwfvxt+wBii/kNtGBaRUcWkhSw+essx5HX++sQlswkOksW8G6d/sfHNjqN+UX58t
	 Upi4j8ngZXcc0++jlmBh5cZ/CUivCIL0B568UECu8mAakHYai5to/fgN0PnwSOiirm
	 C3tX3SBjxXNXwYVAydjs5/MiK0EM7Bh2VJM/KeFF1j0s3KZ0ILpjPUXUMWX/H/L9fz
	 UEh3pfQYzicYwBDinV2KeDgfzTb4133pPe15YYSOii2ixH19AqdtI1lzm+KCs5Ej7s
	 Ui2JXM5NEcoeVtx9/6UtXn51jlD5SfLmI4oEEJ8Rn0UNxXr/lBHmzydXVKqTczCpQi
	 R1u0pe5WAAXKw==
Date: Sat, 21 Mar 2026 19:45:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Chuang Zhu <git@chuang.cz>
Cc: linux-iio@vger.kernel.org, Marc Titinger <mtitinger@baylibre.com>,
 Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Subject: Re: [PATCH v3] iio: adc: ina2xx: add INA236 support
Message-ID: <20260321194506.524c27d5@jic23-huawei>
In-Reply-To: <20260315182304.613783-1-git@chuang.cz>
References: <20260315182304.613783-1-git@chuang.cz>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 02:23:04 +0800
Chuang Zhu <git@chuang.cz> wrote:

> The calibration divisor is not directly specified in the datasheet, but can be calculated:
> 
> I = Current_LSB * Current
> Current = ShuntVoltage * CAL / calibration_divisor
> CAL = 0.00512 / (Current_LSB * Rshunt)
> ShuntVoltage = Vshunt / ShuntVoltage_LSB
> 
> => I = (0.00512 / (calibration_divisor*ShuntVoltage_LSB)) * (Vshunt / Rshunt)  
> 
> Ohm's law, I = Vshunt / Rshunt
> => 0.00512 / (calibration_divisor*ShuntVoltage_LSB) = 1  
> 
> ShuntVoltage_LSB = 2.5 uV = 0.0000025 V
> => calibration_divisor = 2048  
> 
> Signed-off-by: Chuang Zhu <git@chuang.cz>
> ---

No change log?  There should be one here so reviewers know what you've updated
without having to go look at earlier versions.

I've picked this up with the following diff merged in:

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 6a4ee833d12c..dd37109a008a 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -748,20 +748,22 @@ static int ina2xx_conversion_ready(struct iio_dev *indio_dev)
        case ina236:
                ret = regmap_read(chip->regmap,
                                  INA226_MASK_ENABLE, &alert);
+               if (ret < 0)
+                       return ret;
+
                alert &= INA226_CVRF;
                break;
        case ina219:
                ret = regmap_read(chip->regmap,
                                  INA2XX_BUS_VOLTAGE, &alert);
+               if (ret < 0)
+                       return ret;
                alert &= INA219_CNVR;
                break;
        default:
-               ret = -EINVAL;
+               return -EINVAL;
        }
 
-       if (ret < 0)
-               return ret;
-
        return !!alert;
 }

See below for why.  Pushed out as the testing branch of iio.git.
Please give it a quick look to check I didn't mess this up!

Thanks,

J


>  drivers/iio/adc/ina2xx-adc.c | 57 ++++++++++++++++++++++++++++++------
>  1 file changed, 48 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index 857e1b69d6cd..6a4ee833d12c 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -121,7 +121,7 @@ static const struct regmap_config ina2xx_regmap_config = {
>  	.volatile_reg = ina2xx_is_volatile_reg,
>  };
>  
> -enum ina2xx_ids { ina219, ina226 };
> +enum ina2xx_ids { ina219, ina226, ina236 };
>  
>  struct ina2xx_config {
>  	const char *name;
> @@ -175,6 +175,16 @@ static const struct ina2xx_config ina2xx_config[] = {
>  		.power_lsb_factor = 25,
>  		.chip_id = ina226,
>  	},
> +	[ina236] = {
> +		.name = "ina236",
> +		.config_default = INA226_CONFIG_DEFAULT,
> +		.calibration_value = 2048,
> +		.shunt_voltage_lsb = 2500,
> +		.bus_voltage_shift = 0,
> +		.bus_voltage_lsb = 1600,
> +		.power_lsb_factor = 32,
> +		.chip_id = ina236,
> +	},
>  };
>  
>  static int ina2xx_read_raw(struct iio_dev *indio_dev,
> @@ -499,20 +509,26 @@ static int ina2xx_write_raw(struct iio_dev *indio_dev,
>  		break;

Side note for follow up patches is this function would benefit a lot
from use of guard()

>  
>  	case IIO_CHAN_INFO_INT_TIME:
> -		if (chip->config->chip_id == ina226) {
> +		switch (chip->config->chip_id) {
> +		case ina226:
> +		case ina236:
>  			if (chan->address == INA2XX_SHUNT_VOLTAGE)
>  				ret = ina226_set_int_time_vshunt(chip, val2,
>  								 &tmp);
>  			else
>  				ret = ina226_set_int_time_vbus(chip, val2,
>  							       &tmp);
> -		} else {
> +			break;
> +		case ina219:
>  			if (chan->address == INA2XX_SHUNT_VOLTAGE)
>  				ret = ina219_set_int_time_vshunt(chip, val2,
>  								 &tmp);
>  			else
>  				ret = ina219_set_int_time_vbus(chip, val2,
>  							       &tmp);
> +			break;
> +		default:
> +			ret = -EINVAL;
>  		}
>  		break;
>  
> @@ -727,14 +743,20 @@ static int ina2xx_conversion_ready(struct iio_dev *indio_dev)
>  	 * For now, we do an extra read of the MASK_ENABLE register (INA226)
>  	 * resp. the BUS_VOLTAGE register (INA219).
>  	 */
> -	if (chip->config->chip_id == ina226) {
> +	switch (chip->config->chip_id) {
> +	case ina226:
> +	case ina236:
>  		ret = regmap_read(chip->regmap,
>  				  INA226_MASK_ENABLE, &alert);
>  		alert &= INA226_CVRF;
Not caused by your patch as it's existing code but it's really
ugly to check for an error only after modifying data that, if
there is an error would be uninitialized.

Can we clean that up whilst here by bringing duplicating the if (ret < 0)
and pulling it into these case blocks?

> -	} else {
> +		break;
> +	case ina219:
>  		ret = regmap_read(chip->regmap,
>  				  INA2XX_BUS_VOLTAGE, &alert);
>  		alert &= INA219_CNVR;
> +		break;
> +	default:
> +		ret = -EINVAL;
This might as well return after moving if (ret < 0) into the other two.

(as noted above, i just did this whilst applying your patch).

>  	}
>  
>  	if (ret < 0)


