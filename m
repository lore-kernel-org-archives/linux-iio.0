Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D0F1DFF0
	for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 12:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773577000; cv=none; b=kMwI1TiFXvtzpv7zoF13WK1cpGbYj1HNBJ4uLcOZ0q/HrLzbyF36fgtwAnH/qavpL+FzzzhY1sCIiyrWattQpxErJRYGjNlIhTwh6PqYYlnkSHbStMlMHFpyjNlIVgi03gtCU3fyn7yStHPgqG5enbiHw+zoi6/JePFYNGXfZ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773577000; c=relaxed/simple;
	bh=/WpYLgizg5PQRAAAe+hwsKaNwTfC1D7H79Fz6XPKdJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mhq5hi36Dle1Ry5HuRdvAYnegBwsw/KsBzDRjdtBOjS3dWBrcBCaM6ujsq63uVEWImxbIvBddOuc9FM37w+VhaB8fXR+nIzOr/BqyTwbJ+pt29IsDaUcgUx6VZWE+Z+bRAOSrzoKlgdTjVDU6wINL1XoFHAE4MQmoqVOzJ1ZTak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpPFd4sb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpPFd4sb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABC3C4CEF7;
	Sun, 15 Mar 2026 12:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773576999;
	bh=/WpYLgizg5PQRAAAe+hwsKaNwTfC1D7H79Fz6XPKdJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BpPFd4sbTuS3K5MYsABblcUtBPdJjENbArPCPtzFixhgAegF8dDrZ2hM5e21T42nM
	 tpRYteHdyOEf5qJgqYJqxCkzu4uOxlThd4daY9qDKEmSA39CytC06ChZ999YmwuobZ
	 w1AQA3vLv1PcWrvZhgSlei8dDMpoHOmBG5iV9ABAJS080dI8o4JxSKyPexx3kabh0z
	 66uaGky9u6m7H8gi3ep/FNFuLF6dlDRE0hL8/JnKcsf7EFTNAdsdB+XJsjUcFXh0+5
	 O4C9K3wT+7xxcCFjjQfIfZKjuqQE+WNgoMIZX5lBi93uK8yGa7NIBIWPgt8nfvfU3Z
	 zEcaK6AyZcnJg==
Date: Sun, 15 Mar 2026 12:16:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Chuang Zhu <git@chuang.cz>
Cc: linux-iio@vger.kernel.org, Marc Titinger <mtitinger@baylibre.com>,
 Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Subject: Re: [PATCH v2] iio: adc: ina2xx: add INA236 support
Message-ID: <20260315121626.5fd2273c@jic23-huawei>
In-Reply-To: <20260309193742.479883-1-git@chuang.cz>
References: <20260309193742.479883-1-git@chuang.cz>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Mar 2026 03:37:42 +0800
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
Hi.

Ideally I'd like this driver to move away from using an enum
for device identification and towards encapsulating all the
differences between devices in a chip specific structure
instance.  However, that's obviously a more significant
change and I don't feel it's fair to land that on you!
If you want to do it though it would be appreciated.
Just look for other drivers that use separate structures
rather than indexing into an array.

Having said that, if we are going to stick to the enum for now
I would prefer a few changes to how we do it. See inline.
> ---
>  drivers/iio/adc/ina2xx-adc.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index 857e1b69d6cd4..4e421f91f707f 100644
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
> @@ -499,7 +509,7 @@ static int ina2xx_write_raw(struct iio_dev *indio_dev,
>  		break;
>  
>  	case IIO_CHAN_INFO_INT_TIME:
> -		if (chip->config->chip_id == ina226) {
> +		if (chip->config->chip_id != ina219) {

I would prefer explicit matching. Probably best done via
a switch on the chip_id. Same applies in all the other similar changes.



>  			if (chan->address == INA2XX_SHUNT_VOLTAGE)
>  				ret = ina226_set_int_time_vshunt(chip, val2,
>  								 &tmp);
> @@ -727,7 +737,7 @@ static int ina2xx_conversion_ready(struct iio_dev *indio_dev)
>  	 * For now, we do an extra read of the MASK_ENABLE register (INA226)
>  	 * resp. the BUS_VOLTAGE register (INA219).
>  	 */
